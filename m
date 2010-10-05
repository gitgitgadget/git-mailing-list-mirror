From: Chris Packham <judge.packham@gmail.com>
Subject: Re: [RFC PATCH] git.txt: document limitations on non-typical repos
 (and hints)
Date: Tue, 05 Oct 2010 09:18:12 -0700
Message-ID: <4CAB4FC4.4030002@gmail.com>
References: <1286283653-22616-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, weigelt@metux.de, spearce@spearce.org,
	jrnieder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	raa.lkml@gmail.com, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 05 18:18:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3ADJ-0008J9-DH
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 18:18:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755300Ab0JEQR4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Oct 2010 12:17:56 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:45177 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752083Ab0JEQR4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Oct 2010 12:17:56 -0400
Received: by pxi10 with SMTP id 10so1683893pxi.19
        for <git@vger.kernel.org>; Tue, 05 Oct 2010 09:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=GmpKsG1u9DIYkE4QkMGTHUpZXs2t7SDm7oJ9GfTkJuQ=;
        b=UcaiuuxwdNSvWeXqNMK+42y90jO+f5OON7wskipcz7jDkf+we3JjlKk9lo0iIsXoVe
         /yhaIOhFvf02YCefD3Wenrl2Gz0H6sFadOJz3+GZswSzTdk50oxLubYLtq/g2FmZhh5x
         2i/BcI4dTd2iAf9DSjSBe1CUfl1lJBFwH5Fmk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=eILgLwzXcF6B+39BIm9jwcPnwgGVCH/PavKEzUiznehQTAr6aCmGkIbDO/S++b2rfC
         zfQDMjdNg14GrCHRLjoPGY1Yo/tjqtP5MgwqGwcJPV6BXIw5ed6QDQl6Auv8YSKVeagq
         Iqa3/djbveCiumxpft+KpKRYD7zDM4rEGQhdA=
Received: by 10.142.157.7 with SMTP id f7mr3564921wfe.335.1286295473984;
        Tue, 05 Oct 2010 09:17:53 -0700 (PDT)
Received: from laptop.site (209-234-175-66.static.twtelecom.net [209.234.175.66])
        by mx.google.com with ESMTPS id 33sm11670558wad.6.2010.10.05.09.17.51
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 05 Oct 2010 09:17:51 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.9.1.11) Gecko/20100714 SUSE/3.0.6 Thunderbird/3.0.6
In-Reply-To: <1286283653-22616-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158212>

On 05/10/10 06:00, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>=20
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  I wanted to make a more detailed description, per command. It would
>  serve as guidance for people on special repos, also as TODOs for Git
>  developers. But that seems a lot of work on analyzing each commands.
>=20
>  Instead I made this text to warn users where performance may decreas=
e,
>  and to hint them features that might help. Do I miss anything?
>=20
>  There were discussions in the past on maintaining large files out-of=
-repo,
>  and symlinks to them in-repo. That sounds like a good advice, doesn'=
t it?
>=20
>  Documentation/git.txt |   46 +++++++++++++++++++++++++++++++++++++++=
+++++++
>  1 files changed, 46 insertions(+), 0 deletions(-)
>=20
> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index dd57bdc..8408923 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -729,6 +729,52 @@ The index is also capable of storing multiple en=
tries (called "stages")
>  for a given pathname.  These stages are used to hold the various
>  unmerged version of a file when a merge is in progress.
> =20
> +Performance concerns
> +--------------------
> +
> +Git is written with performance in mind and it works extremely well
> +with its typical repositories (i.e. source code repositories, with
> +a moderate number of small text files, possibly with long history).
> +Non-typical repositories (huge number of files, or very large
> +files...) may experience performance degradation. This section descr=
ibes
> +how Git behaves in such repositories and how to reduce impact.

How huge is "huge" and how large is "large". From previous threads on
this list I'm guessing "large" is files bigger than physical RAM. I've
not really run into a situation where a huge number of files causes
performance problems.

Maybe there should be a distinction of where a user might see
performance problems e.g. initial clone, subsequent fetches, commit,
checkout or diff.

> +
> +For repositories with really long history, you may want to work on
> +a shallow clone of it (see linkgit:git-clone[1], option '--depth').
> +A shallow repository does not contain full history, so it may consum=
e
> +less disk space and network bandwidth. On the other hand, you cannot
> +fetch from it. And obviously you cannot look further back than what
> +it has in history (you can deepen history though).

You might want to mention git clone --reference and the
=2Egit/objects/info/alternates for those concerned with disk usage.

> +
> +For repositories with a large number of files, but you only need
> +a few of them present in working tree, you can use sparse checkout
> +(see linkgit:git-read-tree[1], section 'Sparse checkout'). Sparse
> +checkout can be used with either a normal repository, or a shallow
> +one.
> +
> +Git uses lstat(3) to detect changes in working tree. A huge number
> +of lstat(3) calls may impact performance, especially on systems with
> +slow lstat(3). In some cases you can reduce the number of lstat(3)
> +calls by specifying what directories you are interested in, so no
> +lstat(3) outside is needed.
> +
> +For repositories with a large number of files, you need all of them
> +present in working tree, but you know in advance only a few of them
> +may be modified, please consider using assume-unchanged bit (see
> +linkgit:git-update-index[1]). This helps reduce the number of lstat(=
3)
> +calls.
> +
> +Some Git commands need entire file content in memory to process.
> +You may want to avoid using them if possible on large files. Those
> +commands include:
> +
> +* All checkout commands (linkgit:git-checkout[1],
> +  linkgit:git-checkout-index[1], linkgit:git-read-tree[1],
> +  linkgit:git-clone[1]...)
> +* All diff-related commands (linkgit:git-diff[1],
> +  linkgit:git-log[1] with diff, linkgit:git-show[1] on commits...)
> +* All commands that need file conversion processing
> +

This addresses one of my comments above. It might be worth talking abou=
t
using git bundles as an alternative to cloning over unreliable connecti=
ons.

>  Authors
>  -------
>  * git's founding father is Linus Torvalds <torvalds@osdl.org>.
