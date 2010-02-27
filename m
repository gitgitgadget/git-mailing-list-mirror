From: Mark Lodato <lodatom@gmail.com>
Subject: Re: Meta-variable naming convention in documentation
Date: Fri, 26 Feb 2010 21:41:22 -0500
Message-ID: <ca433831002261841i2b0edab6nf1a6e9170c3ba3c@mail.gmail.com>
References: <ca433831002252055l37292cf6v868cc407f0be7250@mail.gmail.com> 
	<7vfx4oeeol.fsf@alter.siamese.dyndns.org> <ca433831002261451k3164d413y77d4989239862f30@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 27 03:41:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlCcm-0005L3-DW
	for gcvg-git-2@lo.gmane.org; Sat, 27 Feb 2010 03:41:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759557Ab0B0Cln (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2010 21:41:43 -0500
Received: from mail-gx0-f227.google.com ([209.85.217.227]:55177 "EHLO
	mail-gx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759532Ab0B0Clm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2010 21:41:42 -0500
Received: by gxk27 with SMTP id 27so478779gxk.1
        for <git@vger.kernel.org>; Fri, 26 Feb 2010 18:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=kBHsYBo2rmh3ksCc+vh6/lx9t5IJP0ZgLiQe2vFVFIk=;
        b=A/Yjr9Ix2HJrOvI+hCrXSe94/N+juf02tYkhXeEqNtLEggiAd/dAnDtlBpEEYq+5uU
         CEbIrA+90IYVgVJs3KA8BZaNu9Zr8GwAL6Q/KuRdTRx546PhArpo1okq3LfzpNsJcPNQ
         DwDXYjA2gER3XJ9yi+/O4Pm/COg0FjX263UYU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=DljnHOJwjnBYMsPbBYXy32ZYTWG/nQQdHl2kYSHu47Kd/UPnV8A3WA+8kAjnAEyhoF
         Ti3rZ7IAQoh0KTYWYa7VE+Ml27DOE0H3D6VHLO2M/pMxu8FefJJPZ4V6geBnho4iTdTO
         r9rQVI/g567PTQBciE5h/lgh6vZbadguxZQDY=
Received: by 10.91.19.17 with SMTP id w17mr1239594agi.54.1267238502103; Fri, 
	26 Feb 2010 18:41:42 -0800 (PST)
In-Reply-To: <ca433831002261451k3164d413y77d4989239862f30@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141166>

On a similar note, what do you think about dropping the term
<tree-ish> and just using <tree> everywhere?  The only command that
only accepts a <tree>, and not a <tree-ish>, is git-commit-tree.  For
example, `git commit-tree master' fails, but `git commit-tree
master^{tree}' works.  This can easily be written in the
documentation, or the program can be fixed so it also accepts a
<tree-ish> like everything else.  (git-grep(1) uses the term <tree>,
but this should be <tree-ish>.)

I imagine a similar thing can be done with <commit> vs <commit-ish> vs
<committish>, but I haven't verified this.  <commit-ish> is only used
in git(1) and builtin-revert.c, and <committish> is only used in
git-describe(1), git-fast-import(1), git-name-rev(1), git-shortlog(1),
gitcli(1), and builtin-describe.c.  I would guess that all the other
commands that say <commit> really accept a <commit-ish>, but perhaps
this is not true.

I also think <rev> should be replaced with <commit>, unless this means
something different.

If you give the go-ahead, I'll work on a patch to do this.

Cheers,
Mark
