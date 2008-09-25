From: "Bob Hiestand" <bob.hiestand@gmail.com>
Subject: Re: [RFC/PATCH] remove vim syntax highlighting in favor of upstream
Date: Thu, 25 Sep 2008 09:00:49 -0500
Message-ID: <cc29171c0809250700s3efa7601pbdb96d1bd94ab89b@mail.gmail.com>
References: <1222269726-15632-1-git-send-email-szeder@ira.uka.de>
	 <20080924155745.GA3908@coredump.intra.peff.net>
	 <20080924170154.GA6816@neumann>
	 <20080924175315.GA10337@coredump.intra.peff.net>
	 <20080924195658.GB6816@neumann> <20080925124817.GC6816@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Jeff King" <peff@peff.net>, vim@tpope.info,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: "=?ISO-8859-1?Q?SZEDER_G=E1bor?=" <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Sep 25 16:02:08 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KirPs-0002jt-NR
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 16:02:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753546AbYIYOAv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Sep 2008 10:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753011AbYIYOAv
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 10:00:51 -0400
Received: from wf-out-1314.google.com ([209.85.200.170]:59709 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752458AbYIYOAu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Sep 2008 10:00:50 -0400
Received: by wf-out-1314.google.com with SMTP id 27so508439wfd.4
        for <git@vger.kernel.org>; Thu, 25 Sep 2008 07:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=TD9jLpCYQYqKmUbNuorbE8KKAvL+eW+FhRpk3sb9Wec=;
        b=h0CQtAT6Jzbbrr1TeOrDUyP8PWHqoSoM+NQrnNE11jdWdyt4V1VXuAfg0uSrsZ7tAx
         NHgsXkOPpESVmHw7780mf6UfiwsX0YnJYO5MX0XUuCzAIOvZh4aG1no1nDkWPadAcrDP
         0WXSaXesCEAHjJxO3H7hFpTcY0U+wfzcT+Gvw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=bO9zggsanV1ayX/Srd9DSHVF2AXU3NZkKd6rjF8827nEc/PXjLVgV0jMUYlX8imynT
         o2DNM+DDwFL5YVYdNwjsepURDE9AW1/SV8962sEhWqCcfFVaoYLw91G9vVtmbNZYaPJR
         aqdqGzRJfMTu3s/xhpacJeckZR+Lu0GCaYLj8=
Received: by 10.114.81.1 with SMTP id e1mr9481426wab.16.1222351249412;
        Thu, 25 Sep 2008 07:00:49 -0700 (PDT)
Received: by 10.114.123.10 with HTTP; Thu, 25 Sep 2008 07:00:49 -0700 (PDT)
In-Reply-To: <20080925124817.GC6816@neumann>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96765>

On Thu, Sep 25, 2008 at 7:48 AM, SZEDER G=E1bor <szeder@ira.uka.de> wro=
te:
> Hi,
>
> OK, so I'm complaining a bit.
>
> On Wed, Sep 24, 2008 at 09:56:58PM +0200, SZEDER G=E1bor wrote:
>> +To install:
>> +
>> +  1. Copy these files to vim's syntax directory $HOME/.vim/syntax
>> +  2. Auto-detect the editing of various git-related filetypes:
>> +     $ cat >>$HOME/.vimrc <<'EOF'
>> +     autocmd BufNewFile,BufRead *.git/COMMIT_EDITMSG    setf gitcom=
mit
>> +     autocmd BufNewFile,BufRead *.git/config,.gitconfig setf gitcon=
fig
>> +     autocmd BufNewFile,BufRead git-rebase-todo         setf gitreb=
ase
>> +     autocmd BufNewFile,BufRead .msg.[0-9]*
>> +             \ if getline(1) =3D~ '^From.*# This line is ignored.$'=
 |
>> +             \   setf gitsendemail |
>> +             \ endif
>> +     autocmd BufNewFile,BufRead *.git/**
>> +             \ if getline(1) =3D~ '^\x\{40\}\>\|^ref: ' |
>> +             \   setf git |
>> +             \ endif
>> +     EOF
>
> There are issues with this second step.  If I append this code to my
> .vimrc, then vim sometimes overrides the filetype with conf.
>
> vim has a guessing rule for detecting conf files, which triggers if
> one of the first five lines of the file begins with a '#'.  So if I
> start to write a new commit message or I interactively rebase 4 or
> less commits, then this rule triggers and vim overrides the git
> filetype with filetype conf.  If I do a commit --amend with a long
> enough original commit message or an interactive rebase with more tha=
n
> 4 commit, then this rule no more triggers and everything is fine.
>
> But what's really puzzling is that if I insert the above code into
> $VIMRUNTIME/filetype.vim (at the spot where it can be found in vim
> 7.2's filetype.vim), then everything works as expected, git filetypes
> are never overridden.
>
> This is not related to the changes in this patch.  git's original vim
> syntax highlight for commit messages has the exact same behaviour.
>
> The first step is OK: it doesn't matter whether I put git-related
> syntax files under $HOME/.vim/syntax/ or under $VIMRUNTIME/syntax/.

I'd guess that your autocommands defined in .vimrc take effect after
the default file type settings.  When you use ':setf', it
intentionally will not override the existing file type if one has
already been detected.

Use ':help new-filetype' to see the various ways you can interact with
and/or override the default filetype detection.

bob
