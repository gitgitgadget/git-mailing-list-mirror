From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: What's cooking in git.git (Jan 2009, #07; Wed, 28)
Date: Thu, 29 Jan 2009 12:27:23 +0100
Message-ID: <bd6139dc0901290327u572cc30ci9dc719c912fbf875@mail.gmail.com>
References: <7vwscej26i.fsf@gitster.siamese.dyndns.org>
	 <20090129035138.GC11836@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 29 12:28:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSV4s-0000hJ-1u
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 12:28:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754301AbZA2L11 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 06:27:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754196AbZA2L10
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 06:27:26 -0500
Received: from rn-out-0910.google.com ([64.233.170.191]:8591 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754060AbZA2L1Y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 06:27:24 -0500
Received: by rn-out-0910.google.com with SMTP id k40so2857705rnd.17
        for <git@vger.kernel.org>; Thu, 29 Jan 2009 03:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=VOdJiErO7t55/vsTK/73iBINDm/SriwlvjoZb5I1z1M=;
        b=e3XGCK/RSn2oXgjInvo6MhBcgJJYio+AsVs5ZYk+FtSfe4e0Z39uvpqWwLsELxADwo
         ydnwlgNpU47KWanf1yRENqndq39/16cOdFI1fMEPDsEpcb2rboV6+VxUbpUQ/s3fQb3h
         4kljPpMMop2ULp0x5BYFm0ZEWIymFbOTWcmUg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=PfWB50eZf4y9R7BE8taEu/aq72gtwMCJHJaLk0wLnaXpBoG+IL5WpIExinqz2i2KOA
         bnuWVeZ9SMjq3rjbLPaXIjhlp5YRyuIN7+l6Tb9jv3+w4e4IhiNpB0kxF3Y4J7P2w0I5
         MvcLeFiY1FhfRDh5kX8UXKlct37K21Ge8Y/U0=
Received: by 10.150.182.17 with SMTP id e17mr27732ybf.132.1233228443691; Thu, 
	29 Jan 2009 03:27:23 -0800 (PST)
In-Reply-To: <20090129035138.GC11836@coredump.intra.peff.net>
X-Google-Sender-Auth: 061a80d61be9928a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107657>

On Thu, Jan 29, 2009 at 04:51, Jeff King <peff@peff.net> wrote:
>  $ mkdir parent && (cd parent && git init)
>  Initialized empty Git repository in /home/peff/parent/.git/
>
>  $ git clone parent child
>  Initialized empty Git repository in /home/peff/child/.git/
>  warning: You appear to have cloned an empty repository.
>
> So far so good...
>
>  $ (cd parent && echo content >file && git add file && git commit -m one)
>  [normal commit output]
>  $ (cd child && git fetch)
>  [normal fetch output]

I thought instead we wanted to support the following workflow:

$ (cd child && echo content >file && git add file && git commit -m one)
[normal commit output]

Which is what the testcase tests. E.g., we want to support cloning an
empty repo so that the user can then _push_ to that repository to make
it non-empty, no?

-- 
Cheers,

Sverre Rabbelier
