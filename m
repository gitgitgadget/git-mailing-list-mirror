From: "Leo Razoumov" <slonik.az@gmail.com>
Subject: Re: [RFC PATCH 0/4] deny push to current branch of non-bare repo
Date: Mon, 1 Dec 2008 22:08:01 -0500
Message-ID: <ee2a733e0812011908p3310cda4h46815264efee2588@mail.gmail.com>
References: <20081107220730.GA15942@coredump.intra.peff.net>
	 <7v3ai3f7oa.fsf@gitster.siamese.dyndns.org>
	 <20081108142756.GC17100@coredump.intra.peff.net>
	 <ee2a733e0812011822r4cef6a44ra68d6e84f9e30a90@mail.gmail.com>
	 <20081202024837.GB6804@coredump.intra.peff.net>
Reply-To: SLONIK.AZ@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	"Sam Vilain" <sam@vilain.net>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 02 04:16:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7LkZ-0005H4-EK
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 04:16:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753993AbYLBDOw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 22:14:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753981AbYLBDOw
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 22:14:52 -0500
Received: from mu-out-0910.google.com ([209.85.134.185]:49301 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751870AbYLBDOv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 22:14:51 -0500
Received: by mu-out-0910.google.com with SMTP id g7so2390202muf.1
        for <git@vger.kernel.org>; Mon, 01 Dec 2008 19:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=tLMdN9tBZ6L1uqKxJGy3Rmj6eQ1cWIwBIj+d7h0GVoU=;
        b=iquu0kXOfwB+ASP5ADLLvR6e/pZdG7xWfRML6/M1XF9DuN+rsjSig1SmX1RpS5o5a6
         uZqwtYBW2l/33AWMjiWa98M2nb7utlPH9BdBspZRvrvi/2yFpW3KrBSmuaf5nb7arm68
         2ein13nMtEHjv7LHMKQKstAIuLXKsRBjkEjL0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=Iq5GXnlpw8U3YeKGDKY2Y934zoE/xLLu1F2Yx4mV9SlfYwjJFEmajUjxP7ucwDCfiC
         ucxZrkiJyCHFf1uUmRC3KSzNUk0MZtPbyfk+x6XrmzCCfOovl9h0lJNOdDaAaurSGZjc
         e0KR5LeAeNlqRArh1lukuzcUqQqFkeM/xAL5U=
Received: by 10.181.25.10 with SMTP id c10mr4127600bkj.181.1228187281786;
        Mon, 01 Dec 2008 19:08:01 -0800 (PST)
Received: by 10.181.7.8 with HTTP; Mon, 1 Dec 2008 19:08:01 -0800 (PST)
In-Reply-To: <20081202024837.GB6804@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102119>

On 12/1/08, Jeff King <peff@peff.net> wrote:
> [..snip..]
>  >
> Er, what? git-fetch takes a refspec very similar to the ones used by
>  git-push. The real reason that (2) is not an acceptable solution is that
>  you can't necessarily connect to the source repo (e.g., it is on your
>  workstation with no ssh or git server running).
>
>  -Peff

I am sorry, I had to be more accurate in my wording. "git fetch" with
no explicit refspecs fetches everything in. It is quite cumbersome to
form a refspec for git-fetch operation if you are  not logged in into
the "source repo" machine. git-fetch does not have a --dry-run option
to help discover all the branch/tag names on the source side needed
for a meaningful refspec. "git-push -v --dry-run" allows one to
experiment and see what branches/tags exist at the destination and
form refspecs selectively. To the best of my knowledge, git-fetch does
not provide such discovery tools.

--Leo--
