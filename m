From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC PATCH] git.txt: document limitations on non-typical repos
 (and hints)
Date: Wed, 6 Oct 2010 06:52:54 +0700
Message-ID: <AANLkTimb2n4oaEBBr8RJnv4C5xoD-shP7DiDFf+Tcfde@mail.gmail.com>
References: <1286283653-22616-1-git-send-email-pclouds@gmail.com> <4CAB4FC4.4030002@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, weigelt@metux.de, spearce@spearce.org,
	jrnieder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	raa.lkml@gmail.com, Junio C Hamano <gitster@pobox.com>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 06 01:53:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3HK2-0007jj-Ah
	for gcvg-git-2@lo.gmane.org; Wed, 06 Oct 2010 01:53:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756611Ab0JEXxU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Oct 2010 19:53:20 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:61032 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756520Ab0JEXxT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Oct 2010 19:53:19 -0400
Received: by wyb28 with SMTP id 28so6639979wyb.19
        for <git@vger.kernel.org>; Tue, 05 Oct 2010 16:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=buAXN4bv6DKAPbdJkJq1gWxCEeTWqY9QFZoGA0TnP48=;
        b=BGhjwP7FYqSted7YuprwRxs5k43NQ2Zta6qcv8cKzfO46b8wfOKxgBoH7oJC8RfREU
         G50m+mzV4VUvstZNT2kmsJgnOsOoLp3FP7cpbzUbT2UY+OnH+Fcv6RdYORt0c7MxRVt/
         1sF/kYcnY6cESaRbMpCQH1xny8ICeqGoVS2/Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=k2TwmOBh8cDQnovEcg8qZ1GIJFI5gNks8Gi5Mh6VoraPXcIbUFWWk28uYZfA7XEIW4
         nEihMdRvJypaSY+1nxhLy5Jr4egFwhL4gCw8S0WdYAWsrnETKFaF8Fv0ymNq6MG1SHrs
         YxKQdXXgDnuhy5BJES5rYvW3Upvoog4P8nZEE=
Received: by 10.216.19.143 with SMTP id n15mr4174779wen.56.1286322794911; Tue,
 05 Oct 2010 16:53:14 -0700 (PDT)
Received: by 10.216.153.195 with HTTP; Tue, 5 Oct 2010 16:52:54 -0700 (PDT)
In-Reply-To: <4CAB4FC4.4030002@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158259>

2010/10/5 Chris Packham <judge.packham@gmail.com>:
> On 05/10/10 06:00, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>> =C2=A0I wanted to make a more detailed description, per command. It =
would
>> =C2=A0serve as guidance for people on special repos, also as TODOs f=
or Git
>> =C2=A0developers. But that seems a lot of work on analyzing each com=
mands.
>>
>> =C2=A0Instead I made this text to warn users where performance may d=
ecrease,
>> =C2=A0and to hint them features that might help. Do I miss anything?
>>
>> =C2=A0There were discussions in the past on maintaining large files =
out-of-repo,
>> =C2=A0and symlinks to them in-repo. That sounds like a good advice, =
doesn't it?
>>
>> =C2=A0Documentation/git.txt | =C2=A0 46 ++++++++++++++++++++++++++++=
++++++++++++++++++
>> =C2=A01 files changed, 46 insertions(+), 0 deletions(-)
>>
>> diff --git a/Documentation/git.txt b/Documentation/git.txt
>> index dd57bdc..8408923 100644
>> --- a/Documentation/git.txt
>> +++ b/Documentation/git.txt
>> @@ -729,6 +729,52 @@ The index is also capable of storing multiple e=
ntries (called "stages")
>> =C2=A0for a given pathname. =C2=A0These stages are used to hold the =
various
>> =C2=A0unmerged version of a file when a merge is in progress.
>>
>> +Performance concerns
>> +--------------------
>> +
>> +Git is written with performance in mind and it works extremely well
>> +with its typical repositories (i.e. source code repositories, with
>> +a moderate number of small text files, possibly with long history).
>> +Non-typical repositories (huge number of files, or very large
>> +files...) may experience performance degradation. This section desc=
ribes

Probably should have written "experience mild performance degradation"

>> +how Git behaves in such repositories and how to reduce impact.
>
> How huge is "huge" and how large is "large". From previous threads on
> this list I'm guessing "large" is files bigger than physical RAM. I'v=
e

A significant portion of RAM is enough to start swapping. There's also
a hard limit imposed by mmap(): a file cannot be larger than available
address space (2-3G on x86, probably larger on x86_64).

> not really run into a situation where a huge number of files causes
> performance problems.

gentoo-x86 has ~100k files. Cold cache time is definitely long. Even
with hot cache, a full cache refresh may take, I don't remember, half
a second or so. It depends on many factors. I don't think I can draw a
clear limit.

>
> Maybe there should be a distinction of where a user might see
> performance problems e.g. initial clone, subsequent fetches, commit,
> checkout or diff.
>
>> +
>> +For repositories with really long history, you may want to work on
>> +a shallow clone of it (see linkgit:git-clone[1], option '--depth').
>> +A shallow repository does not contain full history, so it may consu=
me
>> +less disk space and network bandwidth. On the other hand, you canno=
t
>> +fetch from it. And obviously you cannot look further back than what
>> +it has in history (you can deepen history though).
>
> You might want to mention git clone --reference and the
> .git/objects/info/alternates for those concerned with disk usage.

Thanks

>
>> +
>> +For repositories with a large number of files, but you only need
>> +a few of them present in working tree, you can use sparse checkout
>> +(see linkgit:git-read-tree[1], section 'Sparse checkout'). Sparse
>> +checkout can be used with either a normal repository, or a shallow
>> +one.
>> +
>> +Git uses lstat(3) to detect changes in working tree. A huge number
>> +of lstat(3) calls may impact performance, especially on systems wit=
h
>> +slow lstat(3). In some cases you can reduce the number of lstat(3)
>> +calls by specifying what directories you are interested in, so no
>> +lstat(3) outside is needed.
>> +
>> +For repositories with a large number of files, you need all of them
>> +present in working tree, but you know in advance only a few of them
>> +may be modified, please consider using assume-unchanged bit (see
>> +linkgit:git-update-index[1]). This helps reduce the number of lstat=
(3)
>> +calls.
>> +
>> +Some Git commands need entire file content in memory to process.
>> +You may want to avoid using them if possible on large files. Those
>> +commands include:
>> +
>> +* All checkout commands (linkgit:git-checkout[1],
>> + =C2=A0linkgit:git-checkout-index[1], linkgit:git-read-tree[1],
>> + =C2=A0linkgit:git-clone[1]...)
>> +* All diff-related commands (linkgit:git-diff[1],
>> + =C2=A0linkgit:git-log[1] with diff, linkgit:git-show[1] on commits=
=2E..)
>> +* All commands that need file conversion processing
>> +
>
> This addresses one of my comments above. It might be worth talking ab=
out
> using git bundles as an alternative to cloning over unreliable connec=
tions.

Thanks.
--=20
Duy
