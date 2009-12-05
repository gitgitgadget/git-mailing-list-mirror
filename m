From: "James P. Howard\, II" <jh@jameshoward.us>
Subject: Re: [PATCH] Add commit.infodisplay option to give message editor
 empty file
Date: Sat, 5 Dec 2009 10:47:53 -0500
Message-ID: <20091205154753.GA3717@thermopylae.local>
References: <1259967879-65517-1-git-send-email-jh@jameshoward.us>
 <7vpr6t6fnz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 05 16:48:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGwre-0004lS-1h
	for gcvg-git-2@lo.gmane.org; Sat, 05 Dec 2009 16:48:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756756AbZLEPrw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Dec 2009 10:47:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756538AbZLEPrv
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Dec 2009 10:47:51 -0500
Received: from mail-qy0-f192.google.com ([209.85.221.192]:45161 "EHLO
	mail-qy0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756059AbZLEPrv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Dec 2009 10:47:51 -0500
Received: by qyk30 with SMTP id 30so1452480qyk.33
        for <git@vger.kernel.org>; Sat, 05 Dec 2009 07:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=Rjx37GpQstiy+1TsdRK6rH8pQ1EWa9ps0ASyynp6qik=;
        b=cAoLh90ENvDX7S1NH1Kh6PqK6LjZJHzeaTrkw0tT9jLn/SaL+EeZCHFMTvbRQu7yW6
         rX2iEcQ/FH5HbfooLRYrU/vzGqogksZkAcvXkS2ckEpJEjOOSxu2gJy3AukMYDE2odlR
         6YB22Y/ZMBcCNFuC4MojFlkuzNq+5E/xuJZI0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=lbtpihQeagN9UIYoE4UkL7YQjdu4DHnqhrKkb4VJTGsmjwAsMPiOq/YBmubLfEGik4
         pRWqxsFYOVoZXg7vj+20vFfo2xn6GrC3ZyGVYqYjLVY7eBVBmfrvtxHv1XcTgjV8T1ua
         ps4rWGcMKzL5uwrIQjKnC8Lh102Ios2zU2zdc=
Received: by 10.224.66.136 with SMTP id n8mr2435336qai.328.1260028076618;
        Sat, 05 Dec 2009 07:47:56 -0800 (PST)
Received: from thermopylae.local (c-68-57-75-220.hsd1.va.comcast.net [68.57.75.220])
        by mx.google.com with ESMTPS id 20sm2441147qyk.13.2009.12.05.07.47.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 05 Dec 2009 07:47:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vpr6t6fnz.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134607>

On Fri, Dec 04, 2009 at 11:30:56PM -0800, Junio C Hamano wrote:

> Two points and a half:
> 
>  - Why does info_display need to be visible to everybody else by being in
>    cache.h and environment.c?  Shouldn't its scope be similar to that of
>    template_file, that is static to builtin-commit.c?
> 
>  - A configuration variable that does not allow the users to override from
>    the command line is a no-no.  We usually do command line option first
>    and then (or at the same time) configuration variable as a typesaver.

I can make these changes in the next few days.
 
>  - While the amount of change necessary for this change doesn't look too
>    bad, is it really worth it?  What is wrong with "1,$p" while using ed
>    as your editor?

I tried a few variants of this, and shell script wrappers for ex (and
gate, which is a specizalized text editor that actually works kind of
well for commit message editing), and it worked fairly well.

The real motivation is that this feature ditches all assumptions about
the capabilities of the text editor.  I am not sure where that leads
yet, but I'd rather make it possible.

James

-- 
James P. Howard, II, MPA MBCS
jh@jameshoward.us
