Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 099D81F461
	for <e@80x24.org>; Mon, 20 May 2019 09:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730937AbfETJko (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 May 2019 05:40:44 -0400
Received: from mout.gmx.net ([212.227.17.21]:41101 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbfETJkn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 May 2019 05:40:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1558345238;
        bh=RRf/HnlcivwUHCwrMXIc4auB1A5zmHTu+e3ii/WyA6U=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=JqcskpfkWcK6pJhVom43SxQzJJ7SmVmh+a01UlNdzHdRJv7kPuUmw0acX/A4bOTFA
         wB4moT/L/vXgHXE7eL+i/xyYrZW/6Ed87qk8FaAeP3GDUtn//Xgc+qEVt0SzCuONBE
         IEcUIBt2RoCuBjvv1/U8pyeyOmo9nTgP+A1vsXLk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MaW7Z-1hDTRv0Bjt-00K5od; Mon, 20
 May 2019 11:40:38 +0200
Date:   Mon, 20 May 2019 11:40:21 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, avarab@gmail.com,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Close commit-graph before calling 'gc'
In-Reply-To: <pull.208.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1905201139120.46@tvgsbejvaqbjf.bet>
References: <pull.208.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:0hN6mxz5U1/3b8PD4zyRbI+wkYwhmH2/EWcLVNEvIB8Sou77QDo
 cqS1P38qHNPCRlfhu8x0eX5NYcop6XV3Pv4wFWop0G2WNpQK096/vhKtXI/uuxFGEYpvOyk
 1PZHVN0Xs8oEBWYztqLlhaFC9xdUm9M4crdDRgzuUQJBPMd1Xh3Mlm/FxXfrXQJnNdFASjl
 2IpQyXDsGq7DwMObQ4TaA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CEu8sn3ba1M=:7Gp6X7YAALJKik3FtYVwNL
 51ZurWVRXLgGbPBVca446mIBTBqU/olz6yq0LlgyzXuft9V9jaTQewOQu061g41S3MO1d/D25
 Jh6rk6b4dJc2fPYFQHg//Uj0Jw55AV6ZId6LZCNL9wdmmyJE3AQnmK9rm0FrwPxN8mL4RdSms
 x/wqJBImvgORAm+RhWdm3tVhvWBiiP6VlJxaubMr7zNgQ855h6dC7YDpc/fIk8JhSiBx3Anbp
 LdLyPU4f3Z1gSRgi9XnXGhuKmaD0zUyLHXc+jY3LcoHm+whRagxnH1EJqMiOHEp6RZ2toDEny
 XWscjqqS0e+tJrT9mvh4F7tI1S/jfC1QtwLKyBIGB45XZgv3iVbe4vP0s9GU0CFzGeBeAaRPP
 phk4U0D6RfH8bft4Ia1LJXnv9brHubgjauDQK9Y5WN9g5KaFJXehfwePBUglKuBvm8/LI+ZUj
 BfrloyjiTUlUkZu0ca0y5/u+ab0QMiCpV0rhvIh/MV7pXluL7SpO+Hq1BTwdDxrsK5D9dTpCc
 4Df1+C27+kIQpKtjslQuctxwTZiSpNmVufNB3rrv6puMT/9PDC+4fQp3ThH59Z7KPVKXwGcpd
 9UBgGj2SMFSQ9BUpbMoW6fP3rNZL9wxRF6wHmmSbABHK6pUQHnOel2yi8fb2r8SQsfbzZJIqW
 q2x1OMN71XYpi1XUptzKKp4wbPs5hTfAJKLIGuwiahOwXAxSrrgJPuEVqXQ68/Gp99aNIVNUW
 xr0MkwSlf2pmGZXXLXjEZqRrna9ARE8BwVbywO4EPEA21yXxfzaBNwSIydXcwwyjzJaa8qHps
 iIh+ZEphrG47m9FypdI7mmY9XUY0oM0SZKQn3RDl4LMKXZEXN5AjqJyvK+4EXQf6gScpDH9vd
 yLsOD2yIF2j8TNhUx6JKueFvy0vsuHzRS00vDF1c6THbzs7Jlw5J77YPT46XKeOs8uBCk1OMb
 9ssz8uwF7OBuYO172yaZQneHZNXdpaCdWLorHKYhIOOSM1PCxqk/h
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee,

On Fri, 17 May 2019, Derrick Stolee via GitGitGadget wrote:

> In Windows, the way we rename a lock file to replace the underlying file
> does not work when a process holds a read handle. For this reason, we ca=
ll
> close_all_packs() everywhere before starting a git gc --auto subprocess.=
 We
> also call close_commit_graph() before renaming the commit-graph lock fil=
e.
> But we don't close the commit-graph handles before running gc, which can
> cause an issue when gc.writeCommitGraph is enabled.
>
> This series adds close_commit_graph() to close_all_packs() and then rena=
mes
> close_all_packs() to close_object_store(). This name is more descriptive=
 of
> its larger purpose.
>
> This is based on ds/commit-graph-write-refactor to avoid conflicts.

Thank you so much for jumping on my (off-list, in-team) bug report!

FWIW I integrated this series into Git for Windows v2.22.0-rc1 already.

Thanks,
Dscho
