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
	by dcvr.yhbt.net (Postfix) with ESMTP id 7062B1F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 16:03:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbfJKQDK (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 12:03:10 -0400
Received: from mout.gmx.net ([212.227.15.18]:35695 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbfJKQDK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 12:03:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570809784;
        bh=th4mzwwaKPUSPufUxsYDb8r/F/aNV92b1vttXZa3DnM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Hc9FuT6VjvFSwm9j0VQJSKShOYBpN2Q8dAx7RcH1ww+IUepdZTz1Vch/zyhO3xtcK
         vUQtAbNCQlSCXq8Y0M1Nse3uiyEsxSM4DT4jvw3/tBverGQedRlyB3PmTYspDU7Ztf
         oMQ5XyXX1nQOiFCwuBfeCu4eoxNuqF2tlEO/qMxI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MXXyP-1iaKjH0t2d-00Yxc7; Fri, 11
 Oct 2019 18:03:04 +0200
Date:   Fri, 11 Oct 2019 18:02:48 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Denton Liu <liu.denton@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        James Coglan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, James Coglan <jcoglan@gmail.com>
Subject: Re: [PATCH 01/11] graph: automatically track visible width of
 `strbuf`
In-Reply-To: <20191011050111.GA94866@generichostname>
Message-ID: <nycvar.QRO.7.76.6.1910111800220.46@tvgsbejvaqbjf.bet>
References: <pull.383.git.gitgitgadget@gmail.com> <4bc0a0596164212aa9d29d6dd0d7a0d8ab1b9dd0.1570724021.git.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.1910102303330.46@tvgsbejvaqbjf.bet> <20191010230550.GA42541@generichostname> <xmqq7e5cjbwj.fsf@gitster-ct.c.googlers.com>
 <20191011050111.GA94866@generichostname>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:C8Lxg7tn5yPL6NsrmcwVMJZUgz/sWdkK3N2K5/rQZZfYYVGH02F
 6hSDGlpkAtg1J5fT4cJx5C31SYhAKdorlbXsv2zcThUz+3rPMCALru/HwZzwVGk4AqreJG9
 hjTJlJn8vNWckkn+geErr9uGoaHzqg8CbDfpYjOxJnVZD8HkVgvGsKHChT5Vjsz/rYGXEw3
 OYLxqR/430WEH8QQ5thZg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0/LUGONdGl0=:WPnN5wi8ZrhQIc1u61mFB7
 DD6YDwB5EO2dgr66oe9HsgK8wFarrwWMTNrUytR0tbXn82DZIr53eTqLLmq5CxSzN4sn5KfTB
 KX4sMPp22F7wMNh943DSzyyjdPmL6IN5PbgcwkmFtOpi28DYWAoUC06F5kUJ057kpAAJwYdsw
 LFD9u5gTzA6cvRKKS+4ujYi2diL1KXp1iELO44/Y5yX+CkyMO6pCw+bo1KODaCv+0uVJvi4y4
 3H/FuNVH98suAKL3n59rMe4f0ytcAtdJlQnq+nNxKbNhv5+B1lADXCrtvveApC1+fK4tISUsZ
 OH7dZIdsNlpCKMJhULwBhue5DpTmBA/3g8IYXbNoE7FEBDxXdpuSfOj/EJ4Wyng6kZeRMc31D
 jevUrp4LWWMH25fTJ7xjONn8kIo5Vcn445Z9+ABZxceOGf4HUZHKCp9cf6kavpi0RdhjmbnyW
 rsJAwwZQDBkWQdTdqHspbtRohBhRwzXLDyA1mtIMk7uv/rc2GTNXJh+RJmDk1DGpdxabBBWMH
 xEk06tPtWa2cwFkTitMYoZJ8LYEqhMpL1WZYY8PTMv6S5h8/9TZwzD/QXwTYtOyn/sq5FiJ6e
 vnaPYGEyxP2BJYjVTwtOaPPut/LQNkHO2YfVCdpOn8OZwaimG/tBGh1pTIMdnDj8trDUlSMYu
 V7pCjsG7BWZOHGUG4TVPlrCeB7iCKM5gTc495ZIFNywAlCHDwRtcldh2OBfV7hCLOakPZmKNu
 Vt9br5u707COXOF++2YhsFkT10gs/1QLXHe44dRnQs/NNSIgpH+fbTkwr6t4Vvl5HuBmqn1Yx
 Lj34Il+/ZbhKI+qEg0uIbUoG6fdDiKpMt0sAEAOkn8xXpxJ4Bk6/d8tiI29rZm9wXrb3QVIyx
 fdLZsgCt1j3jaTCf1qBjGfceb2Vk8JTFw6/AWNQ1mJNcYO4Rr+fukrAgXhcG1CyJyDnYdBlUd
 mejpDkjXtEMM7nB2ruboC/PGHAHNEg8x4rF386xTnh9ulnE7iLcItlfDpXB6PmYJy99prLYac
 Of5GY9DS8++EITmd47Ujn98clin3FGddOoiBX+3PCSGJPiyCwrUNqi1o2cXR9kEB7FXGDjNw3
 YnZ4Xik/fJDtTYi/cZ7TuaYiJ3qjYs5z/g4EoAcRNlwtopkq0l2AUUckKNindcpzSeqcuWKvk
 OMILBgbqkPe08LxK7kFEP1QNF0kAsZYp0S2QHofv3xWBfxgpVyZTch2kyKNylJgQiStMKGG34
 TdROrVRNCMAfEHlPM7KYwEC57vCrGY+ce/0byhlnas0tFia+1uTLr3HjyByk=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 10 Oct 2019, Denton Liu wrote:

> On Fri, Oct 11, 2019 at 10:42:20AM +0900, Junio C Hamano wrote:
> > Denton Liu <liu.denton@gmail.com> writes:
> >
> > > 	static int calculate_width(const struct strbuf *row)
> > > 	{
> > > 		int in_termcode =3D 0;
> > > 		int width =3D 0;
> > > 		int i;
> > >
> > > 		for (i =3D 0; i < row.len; i++) {
> > > 			if (row.buf[i] =3D=3D '\033')
> > > 				in_termcode =3D 1;
> > >
> > > 			if (!in_termcode)
> > > 				width++;
> > > 			else if (row.buf[i] =3D=3D 'm')
> > > 				in_termcode =3D 0;
> > > 		}
> > > 	}
> >
> > Not every byte that is outside the escape sequence contributes to
> > one display columns.  You would want to take a look at utf8_width()
> > for inspiration.
> >
>
> Heh, I guess you're right. Looking right below the definition of
> utf8_width, I realised we have the utf8_strnwidth function. We should be
> able to just call
>
> 	utf8_strnwidth(row.buf, row.len, 1);

Correct me if I'm wrong, but don't we want to keep track of the columns
*only* in the part with the actual line graph, i.e. we're not at all
interested in the onelines' widths?

If so, I could imagine that a good idea would be to introduce

	struct graphbuf {
		struct strbuf buf;
		int width;
	};

and then introduce wrappers for `_addch()` and whatever else is used in
`graph.c`, these wrappers will increment the width together with the
`buf.len` field, and one additional helper that adds color sequences to
that graphbuf that leaves `width` unchanged.

Ciao,
Dscho
