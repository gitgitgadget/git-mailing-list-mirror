From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] blame: Add option to show author email instead of name
Date: Thu, 21 Oct 2010 15:32:10 -0500
Message-ID: <20101021203210.GA12685@burratino>
References: <7vsk02ypj5.fsf@alter.siamese.dyndns.org>
 <1287535323-20347-1-git-send-email-kevin@sb.org>
 <20101021180525.GA11501@burratino>
 <79AB0864-E151-468E-9C86-EBCAD929938B@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Thu Oct 21 22:36:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P91ro-0004z8-4A
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 22:36:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756789Ab0JUUf6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 16:35:58 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48513 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752967Ab0JUUf6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 16:35:58 -0400
Received: by fxm16 with SMTP id 16so30167fxm.19
        for <git@vger.kernel.org>; Thu, 21 Oct 2010 13:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=iodwHV2BzoKjNwv2ZDR2MFWA5hs46LHRsQtjtQiVKsU=;
        b=pmfYgEyLLtN6aapEUepsHRsEofHwR8McH/B9uDVm9qctRx9pZndJCc+/9ez0HgwFt5
         MeHeFZseGzWsBg8V7OEXI4IEOuJsj7ws3WQYbwFa/DNvu+Pj2TUfue0PxXxozMG2vwvZ
         n2fHnloR0CAtJiJ+W118H7UDAwmDmb+MYt+II=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=dblSq0qsvm/Xz+5dMUYiWcht3aKIl6QW7FiLpmZw1hG5q56VvEFSBQPmoiRFA5R1xX
         xXwCN6DixWVvW4trnkVDxoweu28ViCRSbtlSTBy8BChf9nhFWY8eDIHOQxs1r+QVrHtN
         hoxQ/g5eynGRhYN9N+RIvtAY1j39Ywcyk/51I=
Received: by 10.223.103.142 with SMTP id k14mr33473fao.43.1287693356810;
        Thu, 21 Oct 2010 13:35:56 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id k21sm1081951faa.1.2010.10.21.13.35.55
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 21 Oct 2010 13:35:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <79AB0864-E151-468E-9C86-EBCAD929938B@sb.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159560>

Kevin Ballard wrote:
> On Oct 21, 2010, at 11:05 AM, Jonathan Nieder wrote:

>> Bonus nit: does this belong in annotate-tests.sh or does it only apply
>> to "git blame" and not "git annotate"?  If the latter, a note in the
>> commit message would be helpful.
>
> --show-email originally only applied to git-blame. I tweaked the
> patch to make it apply to git-annotate simply because check_count
> can't handle the format of git-blame, but the intention of the
> change wasn't to make it apply to git-annotate in the first place.
> You'll note I also didn't document it in the manpage for
> git-annotate. If you think it's better to move it into
> annotate-tests.sh, I can do that, but that does mean officially
> declaring git-annotate as supporting --show-email.

No preference, since I never use "git annotate" myself.  In fact,
long term, I'd rather see a "git blame --format=<template>" appearing
and "git annotate" replaced with a thin script wrapping "git blame".

Anyway, whatever you decide, it would be nice to document it in the
commit message, no?  e.g.:

	The tests and documentation only affect "git blame",
	because...
