Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29658C433EF
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 15:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CD336023D
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 15:14:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbhJZPRO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Oct 2021 11:17:14 -0400
Received: from mout.web.de ([212.227.17.12]:41099 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231531AbhJZPRM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 11:17:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1635261283;
        bh=ILjmfG1HplmgS3h8vyqt9Djv/ubaTe211Q1/GeEAde8=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=kn3EMRzdOiqp+In5bLH9d5AYZZiZQhQaakigXiH5akSpG0dN61XRQlh3JTA1OzhjT
         l4ErTX88boPm06EEDy6yBzl0pJW49y+OowwPOYq18/xEA9YVD0L1NsQvuj8oFfvRS0
         rIFcSTqUV5Hfa1Cwi838pDtZIOmK8BAq5MvBTyB0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MsaRt-1mvo7M1UDr-00thBU; Tue, 26
 Oct 2021 17:14:43 +0200
Date:   Tue, 26 Oct 2021 17:14:42 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Eric Wong <e@80x24.org>
Cc:     Daniel Marschall <info@daniel-marschall.de>, git@vger.kernel.org
Subject: Re: git-svn bug: Output git directory has uncommitted changes
Message-ID: <20211026151442.65rndwsleyitxvvg@tb-raspi4>
References: <77aacb3b44523223c7647bdae1702a31@daniel-marschall.de>
 <20211025094139.GA22377@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025094139.GA22377@dcvr>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:CLpr8bHap2E+bY4rGs9E9mO7ov2idNTFFUeN7APQGQJY+jf726f
 rbnGihaq4YtGWPxQd1fQMpWrdd4zlw3ohZ3X1lnhrJERkaMO7Pr+3c6RGMl2XK9CrKYOudy
 XL+Mqs/iQBqWXjLMul4rNEZsnKfpUZlJdZtvhlPtzUe1VM4ZWyFiA3/zQkNWj9SnH7fLFIX
 Khd4hjOokcXXWLym7MU7Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oo+qe/XamDw=:mZPK0IZyX0DQgKvUcBZcrf
 sMRiM3IzqxfsUALCbBndrJgO1JQIsZqCyajrz6/bTaQ0VbRFLiVoubvoWWpgo7TFkQIuzWaU+
 z8n0QA7FM9WRNpAcaG+5yRnIZe1Hy7PjmUrumDLvyuoSXsEGoN6v/BMU7Lkq8Rxn5WPwRMTVN
 Zig9r3Sm+Ugpa+w7mBpcYFXlpsDR1AiRMti9a80ObS3vPRlZdEPJMkN1UY6EICpqGl6w+JPpb
 weEkhPe9qCxXq9BxpVJmJFPK85ZKXs4bkOC7R4utwxx8I6Jdjz16B22Rtsbj/omfTMoyxijtI
 ePZK69mqB04f4bRgT2Or/yZsnTcKLy8uJZ8YadiGGrrQbGWpZby020ElGmwGr4Pq/ZzR5VW4t
 oUgjmXmZODwqVhZx1YBxVfveNZlO/4ABYdt+PT708yTy1ImqG+ygB0rgZt+Cc0Wu2KrdU3uVY
 goG7VlLQbnWatSDSboLdVXUeJn1+x5/TZxMJMYtyqyaojoiWTyJyHav5vTrix68j4fZOMuwCH
 Nsz6M35w42nZLPJFxrlsYqtNF/4Xn8oQGh112Gsz4487sIGnG/XedO6NtFy9oX6YF9M7RCjbg
 6sqBi2alOXQVr76kvcOMojQdewhvYI722hUAWJUy0MyejhXgk+5Lmb+/svUc99UFmJwjeeH0l
 u99B9tovlCRScEsMk+LjROSbLi8/NN+S+2FYFwRIcWU35rtMxXjZP/4GZmrT5fz+Nhd6pPnEc
 PaKkfNboVDrntpbFW9HTuV37KqDuXMT73nCY9gOxp3wEb00aWdKI9omThdJSx5iYR6lNIrhjw
 xl5rzTp2jlwv/C57QWIoWVRDVRSjBy6FtRguElvLE82W0LhmE9vBlBGZaapzn3FzntnvTKRsS
 UR7V1Vp0zQc32+h1oF1a1EfLBe2b/yHNPbtzC0svdAad14YASinxCfDHbLJC0pjaFEaMMp1YV
 nes5Afw6nRJCjn+mEWeuUHmm+FiD/ubgUOOq6Xs8T2qKkPU6VQwKJJG68RS45Un6j/11wlME+
 31ohUd5XqS0CImfcuGgRDXu87br3qAYh6RRBL/VClRiBzlu1bVpo4hjjLqgzb/l+bqpnMHLJr
 gUP5P+jsdj5v1g=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 25, 2021 at 09:41:39AM +0000, Eric Wong wrote:
> Daniel Marschall <info@daniel-marschall.de> wrote:
> > Hello,
> >
> > I have found following bug in the latest version of git-svn . I have t=
his
> > issue with the old version shipped in Debian stable, as well as with t=
he
> > latest version built from source.
> >
> >
> > What did you do before the bug happened? (Steps to reproduce your issu=
e)
> >
> > Extract the following SVN repository to GIT:
> > https://svn.viathinksoft.com/svn/filter_foundry/
> > The bug ONLY happens with this single SVN repository. All other SVN
> > repositories from my server work perfectly.
> >
> > $ PERL5LIB=3Dperl/ ./git-svn --authors-file=3D"../../authors.txt" clon=
e
> > --trunk=3D"trunk" "https://svn.viathinksoft.com/svn/filter_foundry/" "=
_test"
> > $ cd _test
> > $ git status
> >
> > What did you expect to happen? (Expected behavior)
> >
> > git status should show that nothing needs to be commited.
> >
> > What happened instead? (Actual behavior)
> >
> > You get a long list of files which need to be committed. The list is
> > sometimes longer and sometimes shorter. So, the behavior is not
> > deterministic. I have the feeling that the list often contains all fil=
es in
> > the repo.
>
> It seems like a CRLF vs LF vs CR issue; not something I'm
> familiar with (not even in a git-only environment).
>
> Running `git diff --ignore-space-change` says there aren't
> non-space changes.
>
> The presence of a .gitattributes file in the repo could be
> confusing things, maybe, just a guess, I don't know...
>
> Being a *nix-only person, I've never mucked with eol=3D attributes
> at all.  Maybe somebody else experienced with such issues can
> chime in; but eol stuff seems like a minefield of complexity I
> don't ever want to step into :x
>
> > Anything else you want to add:
> >
> > This SVN repository was cloned from a foreign server to my own server,=
 and
> > then continued there. I think this SVN repository has some specific
> > properties that cause the bugs.
>
> It's been a while since I've looked at SVN stuff.  From what I
> remember, git-svn doesn't check the CRLF property on the SVN side.

Good point, Eric

After cloning the repo with git-svn, we can say that:
The .gitattributes file is in conflict with the files commited under Git
Run
git ls-files --eol
to see what is going on
[lots of output]

To give a simpler example, run it on only one file,
which is changed in my clone:

git ls-files --eol telegraphics_common/tt/wind.c
i/crlf  w/crlf  attr/text eol=3Dcrlf telegraphics_common/tt/wind.c

And what does this mean ?
The file has CRLF in the index, CRLF in the working tree and "text"
These settings are conflicting.
The easiest solution may be to replace
"text" with "text=3Dauto"
in .gitattributes

And, while looking at .gitignore: the "eol=3Dcr" is not supported under Gi=
t:
*.afs text eol=3Dcr
(But Git does not complain)




