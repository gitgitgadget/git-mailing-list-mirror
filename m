Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91686207EC
	for <e@80x24.org>; Wed,  5 Oct 2016 10:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752213AbcJEK0k (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 06:26:40 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:34404 "EHLO
        mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751058AbcJEK0j (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 06:26:39 -0400
Received: by mail-pa0-f47.google.com with SMTP id rz1so28207010pab.1
        for <git@vger.kernel.org>; Wed, 05 Oct 2016 03:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=4mnn/E0KInWUJuxmF2wzuNEBBLy8PVNoygqFX88S4wc=;
        b=g12qlgvu8yg6j/dabZjcK8HLpwPF/pbDBFVKKxzjHy+JtIWwKE7zXF4y0YuPhM0CK1
         F2sp86XubtI95kdW0FiiO8xpGac+HqD7dSS/XgAjtkSPLWEyqS6zAki6Pl6Dvu3cIhvm
         5awxHjHzSuQIkg+9lCBtYGa9OXQ4wK2RBHpceqtllLi+xJ9p0nMcyOvXJxFPDPWkkzCC
         kniFbYvcl8RGbrIeIEG7efAcn+O0Mj1IOA80wugjuLNf0W0vZTy/uVehK9YV6BIhg9JV
         BzX7HfTGloyybEJSrd9Nxv0fBfPGE8rjqr/GDpmiLh+cEZBafNiKT5fmJNmGhoer/Y+I
         9iIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=4mnn/E0KInWUJuxmF2wzuNEBBLy8PVNoygqFX88S4wc=;
        b=Ylfx7SBAIWbNmB8rNrPy8m/rxhkXzfVAurfFELiMFhTbmcAFRwdqfOVIjkOgpGEIIc
         /3y+bIaMT64cTYuNmx8v5tB5OY3wZsk2F0XC8YojFzYWTSIR75MCCdfnfv/R8TUnEwW+
         P37ucKzBYIhOydrBOZDq0rfcgUIevqQ2mD/AoQEcHrikW3QcP54ST1ZRRqzAStmJ9PSx
         0i1W4W5AyDjQxkzt0zdLMJwySgSf4OcFj/LEgUAHFsa0zxJDE1mhqIqpQblP/pOvSXA+
         kyTDTlj5ekcwjuOj5fiPvdbyj9mwxqDaWbki7BY9mUbIXfyDFzh10bHDBTvuxpv1ggGp
         VcDA==
X-Gm-Message-State: AA6/9RmIgxK38Zm8BYegKTEj5J2QpIvhBXUCtz+/XSRqO+8jgg/nwDXiVAi0ZDc5U709nw==
X-Received: by 10.66.180.17 with SMTP id dk17mr11736713pac.212.1475663198827;
        Wed, 05 Oct 2016 03:26:38 -0700 (PDT)
Received: from ash ([115.76.130.63])
        by smtp.gmail.com with ESMTPSA id n88sm53164335pfk.56.2016.10.05.03.26.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Oct 2016 03:26:37 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 05 Oct 2016 17:26:33 +0700
Date:   Wed, 5 Oct 2016 17:26:33 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     Christian Neukirchen <chneukirchen@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: git commit -p with file arguments
Message-ID: <20161005102633.GA9948@ash>
References: <87zinmhx68.fsf@juno.home.vuxu.org>
 <CACsJy8DOqoW8quz-6qSVR2+3aJau2V=qXCx_SoZvBpmU+9+Oxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACsJy8DOqoW8quz-6qSVR2+3aJau2V=qXCx_SoZvBpmU+9+Oxw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 09, 2016 at 05:54:30PM +0700, Duy Nguyen wrote:
> On Tue, Sep 6, 2016 at 4:08 AM, Christian Neukirchen
> <chneukirchen@gmail.com> wrote:
> > Hi,
> >
> > I noticed the following suprising behavior:
> >
> > % git --version
> > git version 2.10.0
> >
> > % git add bar
> > % git status -s
> > A  bar
> >  M foo
> >
> > % git commit -p foo
> > [stage a hunk]
> > ...
> > # Explicit paths specified without -i or -o; assuming --only paths...
> > # On branch master
> > # Changes to be committed:
> > #       new file:   bar
> > #       modified:   foo
> > #
> >
> > So why does it want to commit bar too, when I explicitly wanted to
> > commit foo only?
> >
> > This is not how "git commit files..." works, and the man page says
> >
> >             3.by listing files as arguments to the commit command, in which
> >            case the commit will ignore changes staged in the index, and
> >            instead record the current content of the listed files (which must
> >            already be known to Git);
> >
> > I'd expect "git commit -p files..." to work like
> > "git add -p files... && git commit files...".
> 
> ...
> 
> At the least I think we should clarify this in the document.

How about something like this? Would it help?

-- 8< --
Subject: [PATCH] git-commit.txt: clarify --patch mode with pathspec

How pathspec is used, with and without --interactive/--patch, is
different. But this is not clear from the document. These changes hint
the user to keep reading (to option #5) instead of stopping at #2 and
assuming --patch/--interactive behaves the same way.

And since all the options listed here always mention how the index is
involved (or not) in the final commit, add that bit for #5 as well. This
"on top of the index" is implied when you head over git-add(1), but if
you just go straight to the "Interactive mode" and not read what git-add
is for, you may miss it.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-commit.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index b0a294d..f2ab0ee 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -29,7 +29,8 @@ The content to be added can be specified in several ways:
 2. by using 'git rm' to remove files from the working tree
    and the index, again before using the 'commit' command;
 
-3. by listing files as arguments to the 'commit' command, in which
+3. by listing files as arguments to the 'commit' command
+   (without --interactive or --patch switch), in which
    case the commit will ignore changes staged in the index, and instead
    record the current content of the listed files (which must already
    be known to Git);
@@ -41,7 +42,8 @@ The content to be added can be specified in several ways:
    actual commit;
 
 5. by using the --interactive or --patch switches with the 'commit' command
-   to decide one by one which files or hunks should be part of the commit,
+   to decide one by one which files or hunks should be part of the commit
+   in addition to contents in the index,
    before finalizing the operation. See the ``Interactive Mode'' section of
    linkgit:git-add[1] to learn how to operate these modes.
 
-- 
2.8.2.524.g6ff3d78

-- 8< --
Duy
