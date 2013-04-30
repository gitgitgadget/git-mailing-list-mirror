From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] Add new @ shortcut for HEAD
Date: Tue, 30 Apr 2013 17:12:08 +0700
Message-ID: <CACsJy8ATWBuvqmjon7-s9KfPcWGHPUFbd6gHR2CqaOwHAgWZrg@mail.gmail.com>
References: <1367264106-2351-1-git-send-email-felipe.contreras@gmail.com>
 <CACsJy8D_gPpprETkAxf+eYp5DMt7uVt6nanCwthZO=vVfBT28Q@mail.gmail.com> <517F6E40.1040606@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Seymour <jon.seymour@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Apr 30 12:12:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UX7YC-000510-EX
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 12:12:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759863Ab3D3KMj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 06:12:39 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:38349 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752680Ab3D3KMi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 06:12:38 -0400
Received: by mail-ob0-f171.google.com with SMTP id er7so281903obc.30
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 03:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=sdFEXAAiLJDeThBfDT7A/0k8CS9baz33o7KN9f55tXw=;
        b=MEJLVU+N+BK6V56cg57X2aaQWQnieNi+u5Jl8NaMnuiX5HSEum4RciyJi307u68+YO
         B6MxjAVQGAytiqD3oQkM9uw+lCenEUe4rrl3n/7BA+i6eJRt9aYjL2uW1f0bz/SZ7JlX
         3MYHSV8bw52L3YIt+udBhBCus1Q0JsmFh1UIvrsETQ0P2bpeFMzeTPYeH5pelGLroCbR
         I/ZsMwJa2wIMvufuRoIxtQ6XGvmyHZMee31ynDeUmBOuBojvJylF6uWOh+/MbYWPubeb
         po6cdzKLX5aEf/GhkweNNjWha05Wu/p0AB/qG+sJ0zCiAH3Fxt+Y/jBT4HtJZD5C8yGm
         +ibQ==
X-Received: by 10.60.84.102 with SMTP id x6mr12979189oey.73.1367316758330;
 Tue, 30 Apr 2013 03:12:38 -0700 (PDT)
Received: by 10.76.180.138 with HTTP; Tue, 30 Apr 2013 03:12:08 -0700 (PDT)
In-Reply-To: <517F6E40.1040606@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222922>

On Tue, Apr 30, 2013 at 2:09 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> According to git-check-ref-format(1), an "@" character is currently
> legal in a reference name as long as it is not followed by "{".  As an
> example, git-svn uses "@" in reference names (e.g.,
> "refs/remotes/svn/tags/foo@56945"), I believe when a Subversion branch
> or tag is deleted then re-created.

Thanks! I was looking for this document but couldn't remember its name.

> Amusingly, it is already possible to define a reference or symbolic
> reference named "@".  So all that you need to do is type
>
>     git symbolic-ref -m "Create @ alias for HEAD" @ HEAD
>
> to get the shortcut that you want :-)

Not so amusingly (and off topic), why reading the code this patch
touches, I think if we have a ref whose last component is exactly 40
chars and contains only [0-9a-fA-F], then we simply consider it sha-1
and return without reading the ref.
--
Duy
