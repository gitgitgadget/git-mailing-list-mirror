Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5185C43460
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 15:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B508960FE4
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 15:38:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233657AbhDIPic (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 11:38:32 -0400
Received: from mout.web.de ([217.72.192.78]:41513 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233038AbhDIPib (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 11:38:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1617982696;
        bh=hmnu9eU0NkzsYJm7tyaClSYlVxKLHaGGH5FDq7PayzE=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=pZZ9BiiEbvSAQBswt50+POYWRaYNdepCRez+6BPApJgRsNWxX8QQusAApWGcmQ5yI
         xCY8cDL66UzzCR/n9uNWrcNbBd0H/wuD7lVbo4xCy77XiCtVd2YcHbCrt24YRZ8PV6
         2GoooSXH3bzXmFKwtqNgk7ObgIouC787QD4WfT5M=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LgHLE-1ls4LM1nCG-00nkuZ; Fri, 09
 Apr 2021 17:38:16 +0200
Date:   Fri, 9 Apr 2021 17:38:16 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git-p4 crashes on non UTF-8 output from p4
Message-ID: <20210409153815.7joohvmlnh6itczc@tb-raspi4>
References: <CAKu1iLXtwuCQTS0s7_LEm0OJF-4s0UhPhDW1r5Zb7=GsSPfpdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKu1iLXtwuCQTS0s7_LEm0OJF-4s0UhPhDW1r5Zb7=GsSPfpdQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:2we5MOoV277nTv5nbItivAlWneL+FOVcwHI0O1zhJHaXcL20lFx
 n4gmR43XVfR1VaiDlQwgCPGuuNFP8mNePG3OCARlJ5HTH2RG+0tQ5smBLOgYTNBI/gx98sX
 hw/Z/3WGG/afTEZ4R4/w3pqcfuCR4yYmel22Cn6W4GflXX+YU++4gzMAaMlmaWMcb+MFM4u
 xkoDUV1294jVyc8OH3jBg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5BrL18UAjtA=:f/JkHD/hnz/S3B1j1RTfEM
 7Tr2AfQUeQIbvrzlB1ncRS6PswUJG9C+x9Wmm22N90mgb7K9KhMIyAMiNW7wp+F/b7ccUR8sp
 m43XXdhQlpPOGgNGq4nSJL7DtCiFhTIyJksYwjsyBpR0YjBHHYyEJCVC+C594Xdqb65MA2noM
 8rZBTLiNeJymlc3aWGmTCLWWMNEhFOq/kFAeHy4ocJNmVJVjnJZvIHkEFS0DrUBPWfTgxeucv
 TV65smaH9Jzk+4Sd9sE2AF763jQoHvL3dTX/1OeouPX9p3TvpRuAjVQk2wlc1gXmD72bCOaAs
 uZcgua1ihwbJzmbu7luHJr2RtWse1TW7kwPEB8Lbq54jlFDpqXND2KZjGLihkYlJIMw6OQS4v
 gbf1nb2Q/su2j093tHnizLtoMlTouqz/VK0vWMNdinjRLcRQuAV6FMiRVsjnOYYnOWYfT9kfi
 E+1CgdA7tAchba8bXlcQalqfusmSX3WB/6aH+M8w7S0CD+esTr4QXzxH5r3/Z8r6YA6YRQMDW
 adbfJ2FavNGsWZ9H4qiWb/nOo7URo+EX6U25If39NvOyBqNvFtvWNJyBUfPsvp1AVuwngHRDY
 4gTYrEtpWeBF5bqY6NY44ZeXGNri4P7Bb0AVrU/fcgi1ncTHhZ/mTZTpK/eciT9wPID5CvH8E
 PHhOiJ0lZLPujmJMLwamiahhPy14GXW0KGVd8VLHKwWaFD0EaI1Hm8ExqmZCl+yb6tnZm9Xbs
 VodORmo6vFCoN5wLvodTVttSH9jb/YLcEq3tYyoSV8jV1cM8sbQDlM+X/RGrT0tVgGHM1QJpH
 StNScWJFQ4hvNgfJw0pP7kyOdTZPBQBGRRtXl8ZfRvvvSMaRAGCdgRZ0eeM6vhNamXhD+OneL
 ZTYgXN8bdNFt/Tu+2iTE+1t0UouaF5ViJJDUwgnscshIOONLfsiD+70xM5vM1JjKwVFIdWjty
 vPEVaCuoSxaymGsdFhaOVhTjFYkdGlyt6K0jp0H8dJ9XVUQ0FbS+qEtJoIvG6U64BrZnNXMAI
 C0tjAsRHL/DU9/H/JBfQLuf3ykntP4rYb6RkA5QKaCaoXBXmrngFWcxbDUG1TrJ/uFKp93+y0
 sejNKWCfm1u+RBnMA5o8+ls+kPoSbVoJbCpiXNv7BiS9HDyMj77+4yTIrV+ORL89VewhJHqkH
 m5YxWpYHXShkZNc9DrJi1gD7Sf+mrlJkpuMvjiksW1RELryxl9n7JPJeBGNWzTOVCRExM=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 08, 2021 at 12:28:25PM -0700, Tzadik Vanderhoof wrote:
> When git-p4 reads the output from a p4 command, it assumes it will be
> 100% UTF-8. If even one character in the output of one p4 command is
> not UTF-8, git-p4 crashes with:
>
> File "C:/Program Files/Git/bin/git-p4.py", line 774, in p4CmdList
>     value =3D value.decode() UnicodeDecodeError: 'utf-8' codec can't
> decode byte Ox93 in position 42: invalid start byte
>
> I'd like to make a pull request to have it try another encoding (eg
> cp1252) and/or use the Unicode replacement character, to prevent the
> whole program from crashing on such a minor problem.
>
> This is especially a problem on the "git p4 clone" command with @all,
> where git-p4 needs to read thousands of changeset descriptions, one of
> which may have a stray smart quote, causing the whole clone operation
> to fail.
>
> Sound ok?

Welcome to the Git community.
To start with: I am not a git-p4 expert as such, but seeing that a program=
 is crashing
is never a good thing.
All efforts to prevent the crash are a step forward.

As you mention cp1252 (which is more used under Windows), there are probab=
ly lots of
system out there which use ISO-8859-15 (or ISO-8859-1) we may have the fir=
st whish:

Make the encoding/fallback configurable.
Let people choose if they want a crash (if things are broken),
fallback to cp1252 or one of the other ISO-ISO-8859-x encodings.

In that sense: we look forward to a pull-request.
