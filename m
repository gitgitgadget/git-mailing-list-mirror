From: Jean-Baptiste Quenot <jbq@caraldi.com>
Subject: Re: [ANNOUNCE] tig-1.0
Date: Fri, 7 Sep 2012 15:41:02 +0200
Message-ID: <CAK6bCaz7yPR0QmcOwY0iUP0hyisTf-bz=c0G_1nZkjCLDWDR+A@mail.gmail.com>
References: <20120510134449.GA31836@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Fri Sep 07 15:42:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9yoo-0006HC-1b
	for gcvg-git-2@plane.gmane.org; Fri, 07 Sep 2012 15:41:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756788Ab2IGNlu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Sep 2012 09:41:50 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:34689 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753914Ab2IGNls convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Sep 2012 09:41:48 -0400
Received: by vbbff1 with SMTP id ff1so3300452vbb.19
        for <git@vger.kernel.org>; Fri, 07 Sep 2012 06:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=44e9jlTPUuqgrUmV3YVT7nltzLEJxN951KAEgoc1+DM=;
        b=0MiJlzMfUqq1L9T7iYDbTwW/fcszZkG67fdbr1IcJjFD1eCmo3rFctUpwZuHGSzsAh
         oPvNDKlHViSljBl879Nc/quJrzazdOkaAPcQ0mcIa8OIv60GEmcJ1ZXZeHf/TmMr/1UH
         uhcnkyeh3QVLv0mrlmU6DzFSW30fOH44PaqpaFo2jZKKV/tBMfK3tn4faQrda3iuszMV
         BgPJHamRs9NOj/DLZpD+5zvKryEFx0NRn/ZWmbDRvfrwUK3O/sxLj1PkrFFhn7D7zcde
         po+40gikzQUiCJgXe6E5EAISGeq+ztEiQ0ve9zHJUxMKrLER+VatozhL+TGL6mZX1iD2
         GTQw==
Received: by 10.52.95.69 with SMTP id di5mr5758163vdb.33.1347025303515; Fri,
 07 Sep 2012 06:41:43 -0700 (PDT)
Received: by 10.58.228.71 with HTTP; Fri, 7 Sep 2012 06:41:02 -0700 (PDT)
In-Reply-To: <20120510134449.GA31836@diku.dk>
X-Google-Sender-Auth: agsYQrAME5UR3yZ0hUenZLBK7Oo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204968>

Hi Jonas,

With tig 1.0 how to feed specific revisions to the main view?

The following hack worked until tig 0.17:

[alias]
        tignowalk-helper =3D !git rev-list --pretty=3Draw --no-walk --s=
tdin<

TIG_MAIN_CMD=3D"git tignowalk-helper $tmp" tig </dev/tty

Cheers,

JB

2012/5/10 Jonas Fonseca <fonseca@diku.dk>:
> Hello,
>
> Version 1.0 of tig is now available. This release brings many smaller
> tweaks and improvements as well as a number of fixes and compatibilit=
y
> changes to work with the newer versions of git. See the release notes
> below for a detailed list of changes.
>
> Note that the master repository has been moved to:
>
>         git://github.com/jonas/tig.git.
>
> So if you were tracking the old master repository, please update your
> .git/config or run:
>
>         $ git remote set-url origin git://github.com/jonas/tig.git
>
> What is tig?
> ------------
> Tig is an ncurses-based text-mode interface for git. It functions mai=
nly
> as a git repository browser, but can also assist in staging changes f=
or
> commit at chunk level and act as a pager for output from various git
> commands.
>
>  - Homepage:    http://jonas.nitro.dk/tig/
>  - Manual:      http://jonas.nitro.dk/tig/manual.html
>  - Tarballs:    http://jonas.nitro.dk/tig/releases/
>  - Git URL:     git://github.com/jonas/tig.git
>  - Gitweb:      http://repo.or.cz/w/tig.git
>
> Release notes
> -------------
> The master repository is git://github.com/jonas/tig.git, and the old
> master repository (http://jonas.nitro.dk/tig/tig.git) will be retired=
=2E
>
> Improvements:
>
>  - Use git-log(1)s default commit ordering. The old behavior can be
>    restored by adding `set commit-order =3D topo` to ~/.tigrc.
>  - Support staging of single lines. Bound to '1' default. (GH #21)
>  - Use +<lineno> to open the initial view at an arbitrary line. (GH #=
20)
>  - Add show-notes ~/.tigrc option. Notes are displayed by default.
>  - Support jumping to specific SHAs in the main view.
>  - Decorate replaced commits.
>  - Display line numbers in main view.
>  - Colorize binary diff stats. (GH #17)
>  - Custom colorization of lines matching a string prefix (GH #16).
>    Example configuration: color "Reported-by:" green default
>  - Use git's color settings for the main, status and diff views.
>    Put `set read-git-colors =3D no` in ~/.tigrc to disable.
>  - Handle editor options with multiple arguments. (GH #12)
>  - Show filename when running tig blame with copy detection. (GH #19)
>  - Use 'source <path>' command to load additional files from ~/.tigrc
>  - User-defined commands prefixed with '@' are run with no console
>    output, e.g.
>
>         bind generic 3 !@rm sys$command
>
>  - Make display of space changes togglable in the diff and stage view=
=2E
>    Bound to 'W' by default.
>  - Use per-file encoding specified in gitattributes(5) for blobs and
>    unstaged files.
>  - Obsolete commit-encoding option and pass --encoding=3DUTF-8 to rev=
ision
>    commands.
>  - Main view: show uncommitted changes as staged/unstaged commits.
>    Can be disabled by putting `set show-changes =3D no` in ~/.tigrc.
>  - Add %(prompt) external command variable, which will prompt for the
>    argument value.
>  - Log information about git commands when the TIG_TRACE environment
>    variable is set. Example: `TIG_TRACE=3D/tmp/tig.log tig`
>  - Branch view: Show the title of the last commit.
>  - Increase the author auto-abbreviation threshold to 10. (GH #49)
>  - For old commits show number of years in relative dates. (GH #50)
>
> Bug fixes:
>
>  - Fix navigation behavior when going from branch to main view. (GH #=
38)
>  - Fix segfault when sorting the tree view by author name.
>  - Fix diff stat navigation for unmodified files with stat changes.
>  - Show branches/refs which names are a substring of the current bran=
ch.
>  - Stage view: fix off-by-one error when jumping to a file in a diff
>    with only one file.
>  - Fix diff-header colorization. (GH #15)
>
> Change summary
> --------------
> The diffstat and log summary for changes made in this release.
>
>  BUGS                        |    6 +-
>  INSTALL                     |    5 +-
>  Makefile                    |   29 +-
>  NEWS                        |   56 +
>  SITES                       |    4 +-
>  TODO                        |   41 -
>  VERSION                     |    1 -
>  asciidoc.conf               |    3 +
>  contrib/aspell.dict         |   17 +-
>  contrib/release.sh          |    4 +-
>  contrib/tig-completion.bash |    4 +-
>  contrib/tig.spec.in         |    2 +-
>  contrib/tigrc               |    1 -
>  git.h                       |   55 +
>  io.c                        |  167 +++-
>  io.h                        |   14 +-
>  manual.txt                  |   13 +-
>  refs.c                      |  242 ++++
>  refs.h                      |   41 +
>  tig.1.txt                   |   15 +-
>  tig.c                       | 2514 ++++++++++++++++++++++-----------=
--
>  tig.h                       |  107 ++-
>  tigmanual.7.txt             |    2 +-
>  tigrc.5.txt                 |   99 ++-
>  24 files changed, 2368 insertions(+), 1074 deletions(-)
>
>      4  Giuseppe Bilotta
>      6  Heiko Schlichting
>    108  Jonas Fonseca
>      3  Jonathan Neusch=E4fer
>      1  Kumar Appaiah
>      1  Michael J Gruber
>      1  P. Sadik
>      1  Pierre Habouzit
>      1  Robert Clausecker
>      1  Romain Francoise
>      9  Thomas Sibley
>      1  Vivien Didelot
>      2  zomfg
>
> --
> Jonas Fonseca
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Jean-Baptiste Quenot
