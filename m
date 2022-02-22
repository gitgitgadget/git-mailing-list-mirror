Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC4DC433EF
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 16:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233487AbiBVQ1N (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 11:27:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231831AbiBVQ1M (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 11:27:12 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4BF63B1
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 08:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645547191;
        bh=yVULErIXx8p3ykGsUORQLlLTVxbdiOnyvqdmk+wku7Q=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=GvLlkQic3bDsjoG8F2L4crOa5IDIrPdiURrmCZAhYyHEkm/iXnCvZ//kzNt2z1mV7
         TzSFmYyZWnFNX4pVIvKSozSt30pYKOSLkmCrc0OQzV/F2j6poUD1G78A8aw568XxbJ
         qXy6JItx0SGGChy6YcFQfLMmaJ/h8UkBFBT3oCuU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.212.236]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mlf0K-1o5GOj1MUE-00ijpi; Tue, 22
 Feb 2022 17:26:31 +0100
Date:   Tue, 22 Feb 2022 17:26:29 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v5 12/12] git-merge-tree.txt: add a section on potentional
 usage mistakes
In-Reply-To: <7abf633b6382118a63e983b80186e91dc38eef5f.1645340082.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2202221725430.11118@tvgsbejvaqbjf.bet>
References: <pull.1122.v4.git.1644698093.gitgitgadget@gmail.com>        <pull.1122.v5.git.1645340082.gitgitgadget@gmail.com> <7abf633b6382118a63e983b80186e91dc38eef5f.1645340082.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:M90TqmC0TFiIxwKpZfSpWzEvmHaejCITG98TJ6JFEqcolN+F3Sj
 n3Ol6sHCOX0NrpXx8OeT37i6GaK9BUbRgVOzoX3KYa2GCw3YyZlpU923FfpaOGofuGEWTwc
 T2sUw1G/WA1SnqXfRFMqAZ4Lym1mHfmpjTutZB2BhDul2/9KC9wqST+jADZG+lDGO/TVhxA
 SWTOZG/YcB1E0fTCsE59A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/Wxb8+Vj0Y8=:UKDY460Suz07BTpNc2VsAq
 9yjZXc3zqkC5j6iz44V84MlFgmCELmoM+NUcoQI//Y9leKiqkKFhcT6fzHyzNzZT1ZnHF6kJ2
 TY0rLSDlMQPoaidXau1GLU9s6IniEi5+lSX3Oz7BsNqAsncR3smnHGtqQq+v42VhHjuvlt66V
 pAAJHTRd5uzZSaKjUy0tkGJ4Ap0P0IG/t5JjXC0yUWOcXk8utn6/3Zmn59JG+DSEaTBGM+fA4
 0BJ+SiMicrum3bj/DYRuMPQmoI3leGxYfpi4BWgZ26zgbhJwoBO9o4j8jXKgRHIoSWl/SW/13
 6dKhvof+IAceud538vuheVUyHZ+PdyzrIvBWUreOomwkuzRM0Fes8bYwRmUasrxfzelG1eLl4
 nj8ZO4EMZ2eaqF7xQkuYuk+J+6PN0+v6/3ebDFmPdimfjM5s1itUs0hgNo6jkGm+Qcj4N1T0R
 w5Yoc0hImvMF4F3AN5GqkxzxD6Ko7D27CT6khw/Jceg4sbPC/lodeoqRR9XdDUp60t9Cc2JKN
 zOGETEBG8tmpZivu0a/19xDHALukoNimGCZs2rpQ5HezKeeb0AqQ1G3dTIGHWDsdV8qA6PbG/
 2Dacc1ud4CDQR/zNVxd1ovBc/O+TqrPbYWtKUtZPaekWc43dsiD7G14S7C1o7nWiZD0KQq0Jo
 SNlif6xM1/HVbEe1NeDXI0psoRvs2kBa8RhmS+CeoiEGZEeFfFakBnU3eJ7duB8D5tFAiu5ZX
 6SY/xAqIfsnORsavYxXwyGO43AmTtIkZf9gAPI6B0DHT0tIhsTmO9K5TtEXA0bMqlQWlufpBI
 oenfxY5mLaML7S7iRw6AZpk0EFYYowqOozUKPGtW44/lmt5aY1675KmGZA7elXYBKw3+OU0pX
 jlCN6biK1J0nyy1hg97gyKM3jQbejRPUQwkrP4G3eEOTVL4efXSmdHixjlg+86Fc4a/TFXntj
 rbDjYfp9NY0gQKNOyMdoiSxrtkBF7O/FwKfzMPX7Yg5/2ilwQwv1M+71ruQPwUUdx6r7Nqaxm
 JyERB7uY99ZVnmcPuta/mjxMPbOMCe5Z3wGBYxU+tfiMpN5AIHWRkHX3ngv+rsa1gtz06edLq
 uzjWiR8WfpjazE=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Sun, 20 Feb 2022, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  Documentation/git-merge-tree.txt | 46 ++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)

Thank you for this. It addresses the concern I had about printing out the
tree object ID in the conflicted case.

Thanks,
Dscho

>
> diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-=
tree.txt
> index d2ff2fa3035..306149fa0e2 100644
> --- a/Documentation/git-merge-tree.txt
> +++ b/Documentation/git-merge-tree.txt
> @@ -158,6 +158,52 @@ that they'd have access to if using `git merge`:
>    * any messages that would have been printed to stdout (the <Informati=
onal
>      messages>)
>
> +MISTAKES TO AVOID
> +-----------------
> +
> +Do NOT look through the resulting toplevel tree to try to find which
> +files conflict; parse the <Conflicted file info> section instead.  Not
> +only would parsing an entire tree be horrendously slow in large
> +repositories, there are numerous types of conflicts not representable b=
y
> +conflict markers (modify/delete, mode conflict, binary file changed on
> +both sides, file/directory conflicts, various rename conflict
> +permutations, etc.)
> +
> +Do NOT interpret an empty <Conflicted file info> list as a clean merge;
> +check the exit status.  A merge can have conflicts without having
> +individual files conflict (there are a few types of directory rename
> +conflicts that fall into this category, and others might also be added
> +in the future).
> +
> +Do NOT attempt to guess or make the user guess the conflict types from
> +the <Conflicted file info> list.  The information there is insufficient
> +to do so.  For example: Rename/rename(1to2) conflicts (both sides
> +renamed the same file differently) will result in three different file
> +having higher order stages (but each only has one higher order stage),
> +with no way (short of the <Informational messages> section) to determin=
e
> +which three files are related.  File/directory conflicts also result in
> +a file with exactly one higher order stage.
> +Possibly-involved-in-directory-rename conflicts (when
> +"merge.directoryRenames" is unset or set to "conflicts") also result in
> +a file with exactly one higher order stage.  In all cases, the
> +<Informational messages> section has the necessary info, though it is
> +not designed to be machine parseable.
> +
> +Do NOT assume all filenames listed in the <Informational messages>
> +section had conflicts.  Messages can be included for files that have no
> +conflicts, such as "Auto-merging <file>".
> +
> +AVOID taking the OIDS from the <Conflicted file info> and re-merging
> +them to present the conflicts to the user.  This will lose information.
> +Instead, look up the version of the file found within the <OID of
> +toplevel tree> and show that instead.  In particular, the latter will
> +have conflict markers annotated with the original branch/commit being
> +merged and, if renames were involved, the original filename.  While you
> +could include the original branch/commit in the conflict marker
> +annotations when re-merging, the original filename is not available fro=
m
> +the <Conflicted file info> and thus you would be losing information tha=
t
> +might help the user resolve the conflict.
> +
>  GIT
>  ---
>  Part of the linkgit:git[1] suite
> --
> gitgitgadget
>
