From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH] Make "git reset" a builtin. (incomplete)
Date: Thu, 23 Aug 2007 09:05:37 +0700
Message-ID: <fcaeb9bf0708221905p617c3689m89a838fdcd97dedb@mail.gmail.com>
References: <46CC3090.7080500@gmail.com> <86absjenc3.fsf@lola.quinscape.zz>
	 <46CC3C17.8040901@op5.se> <864pirej6w.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "David Kastrup" <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Aug 23 04:06:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IO25I-0004tm-Ir
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 04:06:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750978AbXHWCFk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 22:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbXHWCFj
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 22:05:39 -0400
Received: from wx-out-0506.google.com ([66.249.82.227]:17233 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750885AbXHWCFj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2007 22:05:39 -0400
Received: by wx-out-0506.google.com with SMTP id h31so330115wxd
        for <git@vger.kernel.org>; Wed, 22 Aug 2007 19:05:38 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iZhodwsq8rRXeJeHR5voAh6P+Am6I5DGhM+1nHfUqQ3UGAxcIkTtMnCcLGkh04aL+skEysTXd0vm5P4Vp5HXJBpILp/ffUFfx5Nev4rZaY/egoaU6El1BC/rqBwrteNHPYrBW7RM1o8PXK8Cxiy1YQCi2ovSFo1P3Yv9WR5hevY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=te+Dx/UPurdIpojqSZBRPZnpQn3yvL8H8aHsKGsYioMNvVbYyTblAaRLKSe/Bz9WzHaSXg7aFnEttwjVUXuSqupYaY84/MylRkahN3LUbVQVX3MDcb4aAoaMi5gBvm4LyI5wPjeKYNDvB6gS88dLa4b9uMkpI+MtnprTxIMGH6Y=
Received: by 10.70.47.19 with SMTP id u19mr2128787wxu.1187834737362;
        Wed, 22 Aug 2007 19:05:37 -0700 (PDT)
Received: by 10.100.127.17 with HTTP; Wed, 22 Aug 2007 19:05:37 -0700 (PDT)
In-Reply-To: <864pirej6w.fsf@lola.quinscape.zz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56448>

On 8/22/07, David Kastrup <dak@gnu.org> wrote:
> Andreas Ericsson <ae@op5.se> writes:
>
> > David Kastrup wrote:
> >> Carlos Rica <jasampler@gmail.com> writes:
> >>
> >>> This is the first version of the program "builtin-reset.c",
> >>> intended for replacing the script "git-reset.sh".
> >>>
> >>> The --mixed option with -- paths is not implemented yet.
> >>>
> >>> The tests I made for it are not finished so they are not included,
> >>> but it seems to pass the rest of the test suite.
> >>
> >> Could you be so kind as to give a one-sentence summary what the
> >> benefits over using a shell script would be?
> >
> > One word: Portability.
> >
> > There's a plethora of various shell syntaxes. Discerning what's
> > correct shell and what's a bash'ism that may or may not be posixly
> > correct (but perhaps not supported on a multitude of out-of-the-box
> > solaris system) has so far taken almost as much time as convincing
> > newcomers to git that there really is no point in tracking file
> > renames explicitly.
> >
> > Otoh, the list of large and renowned projects that have shunned git
> > for its weak windows support grows longer, meaning we potentially
> > lose competent programmers simply because they're forced to use
> > something else.
>
> The problem I see is that C sucks really really bad as a scripting
> language, and tying together plumbing functionality into porcelain is
> one of the most powerful, flexible and hack-friendly features of git.
> Deprecating scripts is making git more opaque.
>
> Personally, I would prefer an approach of using an embedded script
> interpreter: then language incompatibilities become a non-issue.
> git-busybox sounded like a great idea for portability.

Although I have never tested git-box (git-busybox) under Linux, I
believe it would work well because all Unix specific code remains the
same as in busybox. Making git-box part of git would increase git
binary size by ~200kb IIRC.
-- 
Duy
