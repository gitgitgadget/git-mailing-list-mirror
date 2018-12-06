Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 089E1211B3
	for <e@80x24.org>; Thu,  6 Dec 2018 14:51:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbeLFOv2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Dec 2018 09:51:28 -0500
Received: from smtpoutz10.laposte.net ([194.117.213.175]:39900 "EHLO
        smtp.laposte.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725862AbeLFOv1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Dec 2018 09:51:27 -0500
X-Greylist: delayed 369 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Dec 2018 09:51:25 EST
Received: from smtp.laposte.net (localhost [127.0.0.1])
        by lpn-prd-vrout004 (Postfix) with ESMTP id 28330617CC5
        for <git@vger.kernel.org>; Thu,  6 Dec 2018 15:45:15 +0100 (CET)
Received: from smtp.laposte.net (localhost [127.0.0.1])
        by lpn-prd-vrout004 (Postfix) with ESMTP id 09EEA617D5B
        for <git@vger.kernel.org>; Thu,  6 Dec 2018 15:45:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=laposte.net; s=mail0;
        t=1544107515; bh=152CArwE94fUXnzPZdlPD0uS1Z2iyE013CAUDW1IaB0=;
        h=Date:From:To:In-Reply-To:Subject;
        b=VyKxkQYNrSrFlYjCqDIJ5rMOsjWr4AwG4qfiMocNhjTcbsu6kFOC3G722XvoveJ8i
         boLb75dfAvjZ/30XyIuCl5wwd+nj1JYG0oZAIugQNiQJjWIghE3y1R29OvD1VXWTIp
         iRpRrHtJYSYvIkKkaAQGsHIJiip4E+SAt8czJ/YXLj3dyiV7VNqce6tp7iKTN58Ez7
         rZi3gE6jxP/sdTVAhNVXTpzyYCrvDY+SBuNJI//9ZQkz3lLgH4hlzJ5XZYWmZTxA03
         Oaeo3QfiVHfwyQk3jwRLCFwXv5Y2WaPDVBHG6yS6hVH0seYcyi9nqHcgzEVPA52jiu
         PNjleoYcM5NJA==
Received: from lpn-prd-mstr003.laposte (lpn-prd-mstr003.laposte [10.128.59.4])
        by lpn-prd-vrout004 (Postfix) with ESMTP id DE3D9617CC5;
        Thu,  6 Dec 2018 15:45:14 +0100 (CET)
Date:   Thu, 6 Dec 2018 15:45:14 +0100 (CET)
From:   fan2linux@laposte.net
To:     git@vger.kernel.org
Message-ID: <843920843.53747.1544107514822.JavaMail.zimbra@laposte.net>
In-Reply-To: <2070302649.44051.1544107334387.JavaMail.zimbra@laposte.net>
Subject: How to investigate further a seemingly 'ghost' commit (after a
 merge)?
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [195.25.125.139]
X-Mailer: Zimbra 8.0.6_GA_5922 (ZimbraWebClient - FF63 (Linux)/La Poste)
Thread-Topic: How to investigate further a seemingly 'ghost' commit (after a merge)?
Thread-Index: zkgxMYwiiFRQZL48LxUHKrGuZFNJkg==
X-VR-FullState: 0
X-VR-Score: 0
X-VR-Cause-1: gggruggvucftvghtrhhoucdtuddrgedtkedrudefjedgieejucetufdoteggodetrfdotffvucfrrhho
X-VR-Cause-2: fhhilhgvmecunfetrffquffvgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpeffhffvkfgj
X-VR-Cause-3: ufggtgfgihfothesthhqtgdtredtjeenucfhrhhomhepfhgrnhdvlhhinhhugieslhgrphhoshhtvgdr
X-VR-Cause-4: nhgvthenucfkphepuddtrdduvdekrdehledrgedpudelhedrvdehrdduvdehrddufeelnecurfgrrhgr
X-VR-Cause-5: mhepmhhouggvpehsmhhtphhouhhtpdhinhgvthepuddtrdduvdekrdehledrgedphhgvlhhopehlphhn
X-VR-Cause-6: qdhprhguqdhmshhtrhdttdefrdhprhhoshhoughivgdpmhgrihhlfhhrohhmpehfrghnvdhlihhnuhig
X-VR-Cause-7: sehlrghpohhsthgvrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
X-VR-Cause-8: rhgtphhtthhopegslhhonhguvggvlhdrrghlthgvnhesghhmrghilhdrtghomhenucevlhhushhtvghr
X-VR-Cause-9: ufhiiigvpedt
X-VR-AvState: No
X-VR-State: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,=20

I am trying to understand how a fix from a bug-correction branch vanished a=
nd=20
the bug found its way back into the main branch after two merges.=20

I am using git version 2.19.2.=20

Checkouting tag 18.40.1 and checking its graph:=20

> $ git checkout 18.40.1=20
>=20
> $ git log --oneline --graph=20
> * ee4721a1 (HEAD, tag: 18.40.1) Merge branch 'suppressionNumAdhCTP' into =
'homol2'=20
> |\=20
> | * 52aeaf64 Retire le num=C3=A9ro de contrat et le num=C3=A9ro d'adh=C3=
=A9rent qui =C3=A9taient affich=C3=A9s en haut de la page et empi=C3=A9taie=
nt sur le pr=C3=A9imprim=C3=A9.=20
> |/=20
> * 9f68ec4b (tag: 18.40.0) Merge branch 'cherry-pick-7c956b5f' into 'homol=
2'=20

For the record, here is the git log excerpt on the file in question:=20

> $ git log app/CTPCB-AC001/CTPCB-AC001.tex=20
> commit 52aeaf64c808c1e3ee8c5cbf5f0221d4e8a7699d=20
> Author: Guillaume Ballin < guillaume.ballin@mnt.fr >=20
> Date: Tue Nov 13 11:52:03 2018 +0100=20
>=20
> Retire le num=C3=A9ro de contrat et le num=C3=A9ro d'adh=C3=A9rent qui =
=C3=A9taient affich=C3=A9s en haut de la page et empi=C3=A9taient sur le pr=
=C3=A9imprim=C3=A9.=20
>=20
> commit 9336db5c25bb0f3af19183fe1db2fb05ce28b9f3=20
> Author: arnavander < arnavander@mnt.fr >=20
> Date: Mon Nov 5 14:46:27 2018 +0000=20
>=20
> Correction retour anomalie de Carte TP=20
>=20
> Signed-off-by: arnavander < arnavander@mnt.fr >=20
>=20
>=20
> (cherry picked from commit 7c956b5f29bf23c624684c9300a13abecfb451c5)=20

Checkouting commit 25ca67a9 and checking its graph:=20

> $ git checkout 25ca67a9=20
>=20
> $ git log --oneline --graph=20
> * 25ca67a9 (HEAD) Merge branch 'homol2' into 'homol'=20
> |\=20
> | * ee4721a1 (tag: 18.40.1) Merge branch 'suppressionNumAdhCTP' into 'hom=
ol2'=20
> | |\=20
> | | * 52aeaf64 Retire le num=C3=A9ro de contrat et le num=C3=A9ro d'adh=
=C3=A9rent qui =C3=A9taient affich=C3=A9s en haut de la page et empi=C3=A9t=
aient sur le pr=C3=A9imprim=C3=A9.=20
> | |/=20
> | * 9f68ec4b (tag: 18.40.0) Merge branch 'cherry-pick-7c956b5f' into 'hom=
ol2'=20

Checking the log of that file again:=20

> $ git log app/CTPCB-AC001/CTPCB-AC001.tex=20
> commit 7c956b5f29bf23c624684c9300a13abecfb451c5=20
> Author: arnavander < arnavander@mnt.fr >=20
> Date: Mon Nov 5 15:46:27 2018 +0100=20
>=20
> Correction retour anomalie de Carte TP=20
>=20
> Signed-off-by: arnavander < arnavander@mnt.fr >=20

Commit 52aeaf64c808c1e3ee8c5cbf5f0221d4e8a7699d does not show up any more i=
n=20
the pointed to by commit 25ca67a9!=20

The fix only deleted a block of lines:=20

> $ git diff 9f68ec4b 52aeaf64=20
> diff --git a/app/CTPCB-AC001/CTPCB-AC001.tex b/app/CTPCB-AC001/CTPCB-AC00=
1.tex=20
> index 148b3ed2..741d3dff 100644=20
> --- a/app/CTPCB-AC001/CTPCB-AC001.tex=20
> +++ b/app/CTPCB-AC001/CTPCB-AC001.tex=20
> @@ -122,12 +122,6 @@=20
> }=20
>=20
> \newcommand{\CarteTP}{=20
> - \begin{textblock*}{200pt}(50pt,225pt)%=20
> - \No contrat : \NUMADH\\=20
> - \ifdefined\NUMABA=20
> - \No adh=C3=A9rent : \NUMABA\\=20
> - \fi=20
> - \end{textblock*}%=20
> \edToAddrList{DADDR}=20
>=20
> %PREMIERE CARTE=20

How a commit can disapear like that from the log of a file and of course no=
t=20
patching the file while staying visible in the git log of the branch?=20
It's just like if grandchildren forgetted grandparent commit while staying =
connected=20
to parents...=20

--
Fan2linux - G. Ballin
