Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9295C433F5
	for <git@archiver.kernel.org>; Tue, 24 May 2022 12:16:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235666AbiEXMQd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 08:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234097AbiEXMQc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 08:16:32 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB616C0CE
        for <git@vger.kernel.org>; Tue, 24 May 2022 05:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653394570;
        bh=bkQa0+q7k1JH6xpFzsse2hvMmRE00cm3cvf2U668Zp8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=CEh5rdnDIGVJ2rMlurRfer04fQ+OqolGtr3XfsgTnNyoIu4socTIIQ6D/oNMqPdYr
         99gi60z+XhVT3g0Qrm7TAKoE3faE+fpKC2EnNQG9p87n9LYSdKCuwzy1a8W1OzeyE9
         SXwonXu7T+6zfPOmZ6nHbIPUwPwd70JqcVY5vVLc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.242.215] ([89.1.214.24]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MaJ7v-1oNQYJ2X49-00WCyb; Tue, 24
 May 2022 14:16:10 +0200
Date:   Tue, 24 May 2022 14:16:07 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        rsbecker@nexbridge.com, Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhostetler@github.com>
Subject: Re: [PATCH v7 26/30] t/helper/hexdump: add helper to print hexdump
 of stdin
In-Reply-To: <xmqqk0acosks.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2205241415040.352@tvgsbejvaqbjf.bet>
References: <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com> <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com> <6f2e935f148e826609153378751c04807858e76c.1653336765.git.gitgitgadget@gmail.com> <xmqqk0acosks.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:IravrswbsF4tr9kcvpVuGHgXiQruI6m8NTEdA9j++kwD49B3Y/P
 aicewCbD88viclJqJSiB57sRSbFRSz4Kcmyos8vx0htDjAM1Q9uFoQ6rasHn+aeFYuOXKdj
 3beci6eZZGBfCjEJWtv/UexqR+PO7sXMpOzG00hMvr6z5bKWOwPzU8yB/mUthGcbLvwqm9E
 oaZaNVfjTqxYswVP/Lq8Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KYLVI3K8icQ=:4ohWQjeFG3x8HWQb3pJM9M
 T9JIvU7Q9Dq/G0loXUABQRYqJqO8kC5pU2RfdzUst6YQ0M+R2F9fqCZVKf4ONXzfe/GoLTngn
 OwdLJRILysYExb7HiWiOKMkEB95j9e29DxVye2JwvnuqVtSByls6rCEcwZFcQ6LcqqZkHHIgx
 Hg+EMQzU6extg+yX3QeqX5RIbeEam0tooV9UNLuW3fUGfWs40d0vDd1uxhYfmr+Nzsp90IOhA
 MdgQtcV40ca7G3/bZIy/3Wx2ZqPHw5oe/fXzB2/4syDqkcO93UnT+X+n8LRIK/yBAep/1vPq1
 UhCqgmr8iYA8DwyhpJnhE4cYx5TDdydGVDJk7d6c+A9B6iDaxpbg/Mn24RMnzqhssEiiAaL+Y
 mpHilx2+tmkSb4/piE9SnL28sF2pnXqepvYcsiIa8xFiXL9pKp2rrFei2/LIwh4FVGRlElOf5
 akGAWk1JCMciDd7xqY+hUNXvsDsKWu4FqHZLp0U8WIRO0ReRz+/HaW7rByvuo4cO45Qt3TpZU
 pNYp5fQmQZnVAreyl2af3wOyCYr1wo8ytFqzVoBxMglRgoloo/5iBgwu9kvVscVexPRw0sRxC
 NYs2PHI2+3mAYTaObzqxtbCgieQXZVttnZ3i6R12oFKT3N0NZ4mhek7gXIwfnVM8/RB3inzqt
 u36YAhGaYkBKv+cWXSlDFnYys1/cJbXQfs8IP2fTzKwN1MoahZE6f+j/RmNyaDiWac0fZfZEH
 SNoair/kj2zZWmo3OnmxGSTMU7F2VoL8U89xWBblG5gO5gn4xGSff5e/aCIk27zHTQw6Gn7Bx
 +W5kcuJfTA1MLGR5x/ha7XDRNqSWqgFhJ3xdBbqy7Ibxg41Be8+rnwdu5TibyKItBc1xDCygW
 BIincsLmc7F+FDxbpcZexGmC33wQiM9mFPmSNVEe1x7AMbNshT6iNJCVKrFyVkd+xS2NjzXS/
 s1Se+2D2kvrdxVvZNA+3+OqBvGPlPQe0Tt0k6StAPXRzbodoYaynkN4FZfZBRx6y/8EsHt04O
 J3j74vUr9Nt/fWzCU9zIv7ZIiA6qmVGZhZ/FN/IpS5NK6NNkf0eSZFN16/7f3Gw7bOBcrVRIe
 IuKueXje/QEdNziPrrV7ldJboeK7wQ2lwgjgeJZXKkrNQuB4/y5DWahrg==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 23 May 2022, Junio C Hamano wrote:

> "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > +int cmd__hexdump(int argc, const char **argv)
> > +{
> > +	char buf[1024];
> > +	ssize_t i, len;
> > +
> > +	for (;;) {
> > +		len =3D xread(0, buf, sizeof(buf));
> > +		if (len < 0)
> > +			die_errno("failure reading stdin");
> > +		if (!len)
> > +			break;
> > +
> > +		for (i =3D 0; i < len; i++)
> > +			printf("%02x ", (unsigned char)buf[i]);
> > +	}
> > +
> > +	return 0;
> > +}
>
> It is meant to be consumed by machine, so I do not think we would
> mind too much about a single long line, but given that consumers
> include "grep", it would probably be better to avoid emitting an
> incomplete line, especially since addition of this tool is all about
> portability across platforms.

Do you know of any `grep` implementation that has problems with text
missing the usual trailing newlines?

Ciao,
Dscho
