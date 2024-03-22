Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131DA134C8
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 07:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711092705; cv=none; b=bV19T/o9B2mhVYQyfRHqzkLcTJlb2PGuZO4KtFoFbJVJgIisq8/Cdu73w4/BWm5n8s683jlj4f0jTsQcXalYZtw61IBeZj3Rx/OrxfhyGy67ZUXFDBl03J7vbXt2wrqxLUZ+ZuWmMon8hvimpX/l1l7G87exymcg7DwksCXEmw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711092705; c=relaxed/simple;
	bh=/Uuu8yjkx8lhZ8uXs5qGVNitCJSIhukjtZatmMbqioU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=kgTHXQEcRur1YC0EbRdRq12yC3whaXj4Ll7i7Z4yES0xdcqcFN/Bih5+WdzXW5cUGmprLAlQrp3eybIqOHdxyyIO0b2qDOvzU9cmVP08SJdrI5DsUS88u4BG8IQUQ2NWX558RSt+q9/JRdbIoCY+v2T5GQCKlx/JvS4EFy2OcAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=kEu+M6J9; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="kEu+M6J9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1711092691; x=1711697491;
	i=johannes.schindelin@gmx.de;
	bh=AIm8u6oQMXxuwLA+S04idvKDn/0YCd4QhGsC/sAlq3E=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:
	 References;
	b=kEu+M6J9NNc9x9fFLjfJCeCCzwhG57Yc7JU9y42YoczD9KKfYE6kK9vjgVJj+hSW
	 QEsv0OkWuiS2t8KKqVqv2j+X4WUYJFsP2Gu737KxmzEs0URhyq9WYVBpXvlOrSeLp
	 ahBzOst+CUxgz2mLR5ns1mjQqPoC2bLiYo5mKCIRhjypt/D4JrzQvLCxIpUzGC9q0
	 5L4njvtEUQrFo1scksY0qoPb7mtKJxnpKP9f7JwVzWqKe3MUPyI2PPVR9JiU7dXjD
	 G8VSi3/1r4Z3m7Kve9dPRRkCloVTREN9kjK2hn9sOs90jfoNs0M4g3+K5tNm+w0wb
	 5JgkOru+K3XpjvqEhw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([167.220.196.11]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N95eJ-1qiu6H3jM7-016B0n; Fri, 22
 Mar 2024 08:31:31 +0100
Date: Fri, 22 Mar 2024 08:31:28 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jeff King <peff@peff.net>, Matthew Rollings <admin@stealthcopter.com>, 
    Stelian Pop <stelian@popies.net>
cc: git@vger.kernel.org
Subject: Re: [PATCH] contrib: drop hg-to-git script
In-Reply-To: <20240320094824.GA2445978@coredump.intra.peff.net>
Message-ID: <01de5e16-a4ee-47df-03e6-67f5f0d601a7@gmx.de>
References: <20240320094824.GA2445978@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:rMnFHGFeuxo7+8RrvuPT8RU7IU0PJyiqMegwt5gcZB+WOx4F9HA
 CJrSF4gwvtafL4UVVTk5BbVq0XdjIryY1ymdXoWzqn8JVAY0UTLshHyX9gj3odHf9L9iQ8t
 maKiy4yBeh8b2llLMt2WnMwtBSYfiVOehlGv2KsS20GkqsOxbVpL5mqJViz+5OrH1n+5Lsy
 08DCIA0bbDTrVX6+k0+BA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bO0SKbTW62o=;V0fcawyC+g47BmB48mhvadCOYqF
 1E37X0OfS/VIHwH/WSKPgN9YqoYNbeNsKAUptV3QHUlxITau43Pb5L035sh2deGShmjzlUuN0
 hd7Yhk/Mf7/2lSYoXZgVkCr2IyucpitVHLAbVwlctQNSGi6WChNTLPgC8Wpf4XtYESfpHjYjW
 /vR4WNejd2HHHw08pHB/7Sb0+lPwyvdjs2/tYAa0BlGxqp+2nJcfTvcetOrP2+YBgMazEOAe3
 4oCln5YPFFkf/0Sijokg4wD/qcCV1PDtn62m97NIekQIldKiElemIAVjEOhvw1rkxyFp6oKi+
 /kg8SCgS1IFEMKY3MLRpOtUZ/F9Hp5pOaZyXWKVD0l3yH626uUwxCLP3b6+Vw7rXruL+j1LLL
 +r339fxUK0ftSf8P0x0HBt3pgDqekMpv0LLU8+e7YSsyyp55ujl2v7vFGQXl1xb1GOyYNhWCf
 VU8dKFLt9ccU7S8G1ofmHgcTAuQdQRZ8VVf3R0K3tBX7D9bldxL74dG33vA/i1JSMo+wl8jca
 16Ad+1rN4Tp4kuL0tL3WuN3ADf8MBIdbPkhOQQXBOirCjZEEhOp+SON7CjiOnApe/wfAXk7XY
 5dcOlLLMNA8X+ekifYafJTJ+qQF2uOTH/f1MBEPUlFsIDDNWwb0IpZDcy3MNxnVqqL7xH+Y2m
 720i2dzP2rxlAL9ey9jCOYmEQsV87GnjmbDsrrMhRxjirOLTsLrrZazvR1/nFZkJgtOHggalh
 emlxIz2i9OteLdyPoFBMGbLJGiwE30dgqGwwC05x7z9MpvqkPvBIU8Ha5M32Y4/OgQy3fdvZu
 rIJ0V8Ev0b9hI73r86MnZZuCz/fseaWom61g63aOMmzjE=
Content-Transfer-Encoding: quoted-printable

Hi Jeff,

I Cc:ed Mat (who reported the issue) and Stelian (who added this script in
2007 and whose email address hopefully still works).

While I have no objection to dropping this script, I am reluctant to drop
it without leaving anything helpful in place. I am thinking about
something like a `README.md` that would contain helpful information for
any interested reader. I am not good writing such things, so I asked
Copilot, and it came up with this:

	The `hg-to-git` script, which was used to integrate Mercurial
	repositories into Git, has been dropped due to lack of
	maintenance. There have been many past endeavors to integrate
	Mercurial repositories into Git, but not all of them have been
	successful. For those who are interested in this topic, there is
	still an active project called Cinnabar, which can be found on
	GitHub. You can learn more about it by visiting the Cinnabar
	repository at https://github.com/glandium/git-cinnabar.

Ciao,
Johannes

On Wed, 20 Mar 2024, Jeff King wrote:

> The hg-to-git script is full of command injection vulnerabilities
> against malicious branch and tag names. It's also old and largely
> unmaintained; the last commit was over 4 years ago, and the last code
> change before that was from 2013. Users are better off with a modern
> remote-helper tool like cinnabar or remote-hg.
>
> So rather than spending time to fix it, let's just get rid of it.
>
> Reported-by: Matthew Rollings <admin@stealthcopter.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> This was reported to the security list in December. I suggested there
> that we should just get rid of it, but there was no follow-up. Until
> now. ;) Speak now if anybody wants to volunteer to fix the script
> instead.
>
>  contrib/hg-to-git/hg-to-git.py  | 254 --------------------------------
>  contrib/hg-to-git/hg-to-git.txt |  21 ---
>  2 files changed, 275 deletions(-)
>  delete mode 100755 contrib/hg-to-git/hg-to-git.py
>  delete mode 100644 contrib/hg-to-git/hg-to-git.txt
>
> diff --git a/contrib/hg-to-git/hg-to-git.py b/contrib/hg-to-git/hg-to-gi=
t.py
> deleted file mode 100755
> index 7eb1b24cc7..0000000000
> --- a/contrib/hg-to-git/hg-to-git.py
> +++ /dev/null
> @@ -1,254 +0,0 @@
> -#!/usr/bin/env python
> -
> -""" hg-to-git.py - A Mercurial to GIT converter
> -
> -    Copyright (C)2007 Stelian Pop <stelian@popies.net>
> -
> -    This program is free software; you can redistribute it and/or modif=
y
> -    it under the terms of the GNU General Public License as published b=
y
> -    the Free Software Foundation; either version 2, or (at your option)
> -    any later version.
> -
> -    This program is distributed in the hope that it will be useful,
> -    but WITHOUT ANY WARRANTY; without even the implied warranty of
> -    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> -    GNU General Public License for more details.
> -
> -    You should have received a copy of the GNU General Public License
> -    along with this program; if not, see <http://www.gnu.org/licenses/>=
.
> -"""
> -
> -import os, os.path, sys
> -import tempfile, pickle, getopt
> -import re
> -
> -if sys.hexversion < 0x02030000:
> -   # The behavior of the pickle module changed significantly in 2.3
> -   sys.stderr.write("hg-to-git.py: requires Python 2.3 or later.\n")
> -   sys.exit(1)
> -
> -# Maps hg version -> git version
> -hgvers =3D {}
> -# List of children for each hg revision
> -hgchildren =3D {}
> -# List of parents for each hg revision
> -hgparents =3D {}
> -# Current branch for each hg revision
> -hgbranch =3D {}
> -# Number of new changesets converted from hg
> -hgnewcsets =3D 0
> -
> -#----------------------------------------------------------------------=
--------
> -
> -def usage():
> -
> -        print("""\
> -%s: [OPTIONS] <hgprj>
> -
> -options:
> -    -s, --gitstate=3DFILE: name of the state to be saved/read
> -                         for incrementals
> -    -n, --nrepack=3DINT:   number of changesets that will trigger
> -                         a repack (default=3D0, -1 to deactivate)
> -    -v, --verbose:       be verbose
> -
> -required:
> -    hgprj:  name of the HG project to import (directory)
> -""" % sys.argv[0])
> -
> -#----------------------------------------------------------------------=
--------
> -
> -def getgitenv(user, date):
> -    env =3D ''
> -    elems =3D re.compile('(.*?)\s+<(.*)>').match(user)
> -    if elems:
> -        env +=3D 'export GIT_AUTHOR_NAME=3D"%s" ;' % elems.group(1)
> -        env +=3D 'export GIT_COMMITTER_NAME=3D"%s" ;' % elems.group(1)
> -        env +=3D 'export GIT_AUTHOR_EMAIL=3D"%s" ;' % elems.group(2)
> -        env +=3D 'export GIT_COMMITTER_EMAIL=3D"%s" ;' % elems.group(2)
> -    else:
> -        env +=3D 'export GIT_AUTHOR_NAME=3D"%s" ;' % user
> -        env +=3D 'export GIT_COMMITTER_NAME=3D"%s" ;' % user
> -        env +=3D 'export GIT_AUTHOR_EMAIL=3D ;'
> -        env +=3D 'export GIT_COMMITTER_EMAIL=3D ;'
> -
> -    env +=3D 'export GIT_AUTHOR_DATE=3D"%s" ;' % date
> -    env +=3D 'export GIT_COMMITTER_DATE=3D"%s" ;' % date
> -    return env
> -
> -#----------------------------------------------------------------------=
--------
> -
> -state =3D ''
> -opt_nrepack =3D 0
> -verbose =3D False
> -
> -try:
> -    opts, args =3D getopt.getopt(sys.argv[1:], 's:t:n:v', ['gitstate=3D=
', 'tempdir=3D', 'nrepack=3D', 'verbose'])
> -    for o, a in opts:
> -        if o in ('-s', '--gitstate'):
> -            state =3D a
> -            state =3D os.path.abspath(state)
> -        if o in ('-n', '--nrepack'):
> -            opt_nrepack =3D int(a)
> -        if o in ('-v', '--verbose'):
> -            verbose =3D True
> -    if len(args) !=3D 1:
> -        raise Exception('params')
> -except:
> -    usage()
> -    sys.exit(1)
> -
> -hgprj =3D args[0]
> -os.chdir(hgprj)
> -
> -if state:
> -    if os.path.exists(state):
> -        if verbose:
> -            print('State does exist, reading')
> -        f =3D open(state, 'r')
> -        hgvers =3D pickle.load(f)
> -    else:
> -        print('State does not exist, first run')
> -
> -sock =3D os.popen('hg tip --template "{rev}"')
> -tip =3D sock.read()
> -if sock.close():
> -    sys.exit(1)
> -if verbose:
> -    print('tip is', tip)
> -
> -# Calculate the branches
> -if verbose:
> -    print('analysing the branches...')
> -hgchildren["0"] =3D ()
> -hgparents["0"] =3D (None, None)
> -hgbranch["0"] =3D "master"
> -for cset in range(1, int(tip) + 1):
> -    hgchildren[str(cset)] =3D ()
> -    prnts =3D os.popen('hg log -r %d --template "{parents}"' % cset).re=
ad().strip().split(' ')
> -    prnts =3D map(lambda x: x[:x.find(':')], prnts)
> -    if prnts[0] !=3D '':
> -        parent =3D prnts[0].strip()
> -    else:
> -        parent =3D str(cset - 1)
> -    hgchildren[parent] +=3D ( str(cset), )
> -    if len(prnts) > 1:
> -        mparent =3D prnts[1].strip()
> -        hgchildren[mparent] +=3D ( str(cset), )
> -    else:
> -        mparent =3D None
> -
> -    hgparents[str(cset)] =3D (parent, mparent)
> -
> -    if mparent:
> -        # For merge changesets, take either one, preferably the 'master=
' branch
> -        if hgbranch[mparent] =3D=3D 'master':
> -            hgbranch[str(cset)] =3D 'master'
> -        else:
> -            hgbranch[str(cset)] =3D hgbranch[parent]
> -    else:
> -        # Normal changesets
> -        # For first children, take the parent branch, for the others cr=
eate a new branch
> -        if hgchildren[parent][0] =3D=3D str(cset):
> -            hgbranch[str(cset)] =3D hgbranch[parent]
> -        else:
> -            hgbranch[str(cset)] =3D "branch-" + str(cset)
> -
> -if "0" not in hgvers:
> -    print('creating repository')
> -    os.system('git init')
> -
> -# loop through every hg changeset
> -for cset in range(int(tip) + 1):
> -
> -    # incremental, already seen
> -    if str(cset) in hgvers:
> -        continue
> -    hgnewcsets +=3D 1
> -
> -    # get info
> -    log_data =3D os.popen('hg log -r %d --template "{tags}\n{date|date}=
\n{author}\n"' % cset).readlines()
> -    tag =3D log_data[0].strip()
> -    date =3D log_data[1].strip()
> -    user =3D log_data[2].strip()
> -    parent =3D hgparents[str(cset)][0]
> -    mparent =3D hgparents[str(cset)][1]
> -
> -    #get comment
> -    (fdcomment, filecomment) =3D tempfile.mkstemp()
> -    csetcomment =3D os.popen('hg log -r %d --template "{desc}"' % cset)=
.read().strip()
> -    os.write(fdcomment, csetcomment)
> -    os.close(fdcomment)
> -
> -    print('-----------------------------------------')
> -    print('cset:', cset)
> -    print('branch:', hgbranch[str(cset)])
> -    print('user:', user)
> -    print('date:', date)
> -    print('comment:', csetcomment)
> -    if parent:
> -        print('parent:', parent)
> -    if mparent:
> -        print('mparent:', mparent)
> -    if tag:
> -        print('tag:', tag)
> -    print('-----------------------------------------')
> -
> -    # checkout the parent if necessary
> -    if cset !=3D 0:
> -        if hgbranch[str(cset)] =3D=3D "branch-" + str(cset):
> -            print('creating new branch', hgbranch[str(cset)])
> -            os.system('git checkout -b %s %s' % (hgbranch[str(cset)], h=
gvers[parent]))
> -        else:
> -            print('checking out branch', hgbranch[str(cset)])
> -            os.system('git checkout %s' % hgbranch[str(cset)])
> -
> -    # merge
> -    if mparent:
> -        if hgbranch[parent] =3D=3D hgbranch[str(cset)]:
> -            otherbranch =3D hgbranch[mparent]
> -        else:
> -            otherbranch =3D hgbranch[parent]
> -        print('merging', otherbranch, 'into', hgbranch[str(cset)])
> -        os.system(getgitenv(user, date) + 'git merge --no-commit -s our=
s "" %s %s' % (hgbranch[str(cset)], otherbranch))
> -
> -    # remove everything except .git and .hg directories
> -    os.system('find . \( -path "./.hg" -o -path "./.git" \) -prune -o !=
 -name "." -print | xargs rm -rf')
> -
> -    # repopulate with checkouted files
> -    os.system('hg update -C %d' % cset)
> -
> -    # add new files
> -    os.system('git ls-files -x .hg --others | git update-index --add --=
stdin')
> -    # delete removed files
> -    os.system('git ls-files -x .hg --deleted | git update-index --remov=
e --stdin')
> -
> -    # commit
> -    os.system(getgitenv(user, date) + 'git commit --allow-empty --allow=
-empty-message -a -F %s' % filecomment)
> -    os.unlink(filecomment)
> -
> -    # tag
> -    if tag and tag !=3D 'tip':
> -        os.system(getgitenv(user, date) + 'git tag %s' % tag)
> -
> -    # delete branch if not used anymore...
> -    if mparent and len(hgchildren[str(cset)]):
> -        print("Deleting unused branch:", otherbranch)
> -        os.system('git branch -d %s' % otherbranch)
> -
> -    # retrieve and record the version
> -    vvv =3D os.popen('git show --quiet --pretty=3Dformat:%H').read()
> -    print('record', cset, '->', vvv)
> -    hgvers[str(cset)] =3D vvv
> -
> -if hgnewcsets >=3D opt_nrepack and opt_nrepack !=3D -1:
> -    os.system('git repack -a -d')
> -
> -# write the state for incrementals
> -if state:
> -    if verbose:
> -        print('Writing state')
> -    f =3D open(state, 'w')
> -    pickle.dump(hgvers, f)
> -
> -# vim: et ts=3D8 sw=3D4 sts=3D4
> diff --git a/contrib/hg-to-git/hg-to-git.txt b/contrib/hg-to-git/hg-to-g=
it.txt
> deleted file mode 100644
> index 91f8fe6410..0000000000
> --- a/contrib/hg-to-git/hg-to-git.txt
> +++ /dev/null
> @@ -1,21 +0,0 @@
> -hg-to-git.py is able to convert a Mercurial repository into a git one,
> -and preserves the branches in the process (unlike tailor)
> -
> -hg-to-git.py can probably be greatly improved (it's a rather crude
> -combination of shell and python) but it does already work quite well fo=
r
> -me. Features:
> -	- supports incremental conversion
> -	  (for keeping a git repo in sync with a hg one)
> -        - supports hg branches
> -        - converts hg tags
> -
> -Note that the git repository will be created 'in place' (at the same
> -location as the source hg repo). You will have to manually remove the
> -'.hg' directory after the conversion.
> -
> -Also note that the incremental conversion uses 'simple' hg changesets
> -identifiers (ordinals, as opposed to SHA-1 ids), and since these ids
> -are not stable across different repositories the hg-to-git.py state fil=
e
> -is forever tied to one hg repository.
> -
> -Stelian Pop <stelian@popies.net>
> --
> 2.44.0.650.g4615f65fe0
>
>
