From: "Jonathan del Strother" <maillist@steelskies.com>
Subject: Re: [PATCH 4/4] diff.c: convert builtin funcname patterns to extended regular expressions
Date: Thu, 18 Sep 2008 11:53:48 +0100
Message-ID: <57518fd10809180353q2564d873k98e5f6d9041d0a7@mail.gmail.com>
References: <7v3ak06jzj.fsf@gitster.siamese.dyndns.org>
	 <-f-gqL4SkA8Uh7hSuKT-JDY0g26jHn3fDQCE24MB1nKWUMLZWuSseg@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Arjen Laarhoven" <arjen@yaph.org>,
	"Mike Ralphson" <mike.ralphson@gmail.com>,
	"Johannes Sixt" <j.sixt@viscovery.net>,
	"Jeff King" <peff@peff.net>,
	"Boyd Lynn Gerber" <gerberb@zenez.com>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Avery Pennarun" <apenwarr@gmail.com>,
	"Johan Herland" <johan@herland.net>,
	"Andreas Ericsson" <ae@op5.se>, "Kirill Smelkov" <kirr@mns.spb.ru>,
	"Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
To: "Brandon Casey" <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Sep 18 12:55:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgHA4-0005jW-R6
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 12:55:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754039AbYIRKxv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 06:53:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753802AbYIRKxv
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 06:53:51 -0400
Received: from rv-out-0506.google.com ([209.85.198.228]:41491 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753446AbYIRKxt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 06:53:49 -0400
Received: by rv-out-0506.google.com with SMTP id k40so3658914rvb.1
        for <git@vger.kernel.org>; Thu, 18 Sep 2008 03:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=yjm8rEaBJjN+iKbWLX3UZG6Lt9uSROoY3i4mhZStRJg=;
        b=FwKe90PkPTMYiP55sL4sfjGzlEQHTk4uY+shUoBBUrD9yuPXkboCqSOuvDCM+TOAbB
         T4yWD7sNtmPSAJ7WTzdO0jrd034JmFdJBoZ1ZUvKYHWeJ1aOS61xbl6hbqrmi/atRjfm
         yG1pqIu7YTfLrQ0/FeYTjVWzu7REWIrAzaKGI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=qVn1Tl/fVLPgMURLrX3HVDEUmALGo0FuZUy00MRBdkGCPTCiHd4xd26SBwjHKSO5y2
         7GTCm9KtHAeN9O6M2OsFHpdt0I6nh3ufcBBuRywb/Z6rNFkeffX0HxOk0cQkLAlTHFNg
         XeYvFv47oQ574Kl5p0hOHMTf73/Mf7ixlIa1c=
Received: by 10.142.237.20 with SMTP id k20mr1318490wfh.225.1221735228908;
        Thu, 18 Sep 2008 03:53:48 -0700 (PDT)
Received: by 10.143.6.3 with HTTP; Thu, 18 Sep 2008 03:53:48 -0700 (PDT)
In-Reply-To: <-f-gqL4SkA8Uh7hSuKT-JDY0g26jHn3fDQCE24MB1nKWUMLZWuSseg@cipher.nrlssc.navy.mil>
Content-Disposition: inline
X-Google-Sender-Auth: cdb10d04fa8c1548
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96190>

On Thu, Sep 18, 2008 at 1:21 AM, Brandon Casey <casey@nrlssc.navy.mil> wrote:
> Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
> ---
>
>
> This is a blind conversion removing \\ before ( and { etc.
> and adding \\ before naked ( and { etc.
>
> I hope the authors who last touched these patterns will help with testing:


None of the patterns using \\s seem to work for me.  I had to replace
them with [ \t] - is this a problem with the darwin regex
compatibility library or something?  I applied the patches on master
(97d7fee2cb), and am running OS X 10.5.5.
