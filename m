Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CB8E1F6AC
	for <e@80x24.org>; Wed,  4 Jul 2018 11:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933214AbeGDL1O (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Jul 2018 07:27:14 -0400
Received: from mout.gmx.net ([212.227.15.15]:35739 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932594AbeGDL1N (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jul 2018 07:27:13 -0400
Received: from [192.168.0.129] ([37.201.195.74]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LkfdE-1g8dFD1WbM-00aS2D; Wed, 04
 Jul 2018 13:27:11 +0200
Date:   Wed, 4 Jul 2018 13:26:54 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Paul Smith <paul@mad-scientist.net>
cc:     Git mailing list <git@vger.kernel.org>
Subject: Re: RUNTIME_PREFIX references in gitconfig variable paths
In-Reply-To: <e9d5bbec6242e47b1f4141ffd99b276eb6a41347.camel@mad-scientist.net>
Message-ID: <nycvar.QRO.7.76.6.1807041323490.75@tvgsbejvaqbjf.bet>
References: <e9d5bbec6242e47b1f4141ffd99b276eb6a41347.camel@mad-scientist.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:DEnhngFxUU1s25OVH3DALflMJQ8U7dXFiCIZdNrI03ev9n1Ze7i
 B2oiZZ4h4FMsKztVR8JTEf6pidOX61lqsVukjz8/zDhHVgju7HQJCEpBZIMRcLV+/7vwIoq
 ViJ2GrrCAPC/dvDtZspBA0eZecDUBSYgSGNx2dJmHSgtmRsgSTORtEcO6DIM2UuW3jxT1gQ
 MO4rucZ5saucyNManjWww==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9Wxhd4KgKc0=:cW9rEE41r9w0Tu+ZjjOdeY
 8VXbvOhVpREExW6MhKzlvRwZOHBk44fV9o61bWt2VQV93dK0FsvOi3CdK2uVmWxWIuyD/d12w
 zoz0I6fNYmDffwxaAkd5W4DPicqHqmIPvel/5P3jnVJVaKNqJuBGg5fm/aog2l6v8uhZkwc6Z
 2JuY/Dw8nTsciO1Pp5YH0jqi5qON9dLE9h3Div3i+ewJWZ3sNIgsbISLpRTQiBrBppowQ9kGi
 vyya0jwC7fX8E8aoNCIxRhcpuXQuJrgTJVDk/2zvV6oAYX8jZX5+PZJoHnGAq0KO5GHZfGw7d
 ufeeuZstSDsDW9sYL3JZdjLFJjn0U02mFNyqhjCyRDl+d49rhixqCBWljnPhLowXW+7OFqlfp
 ygJRGaFA/CPjEKy348rpgYbU5TsF40wCwzqBWZt/IRIlKC7FS5xSGsNJBNTZ52Y5JZXmz3HlK
 pBi4cwLlV6DDSL13B5dwSM36CMvGhZkabHgq2zhoAA23eRD02zxcOZcFrJzBiL6FL3QlVkzGw
 PTOUM5nYHAymvZQzzgrv3ZjwVLZ7aUEfmRT5l96gJ6onvW4vqFWVJPZgAqzWO1GczR+QmU3+1
 W434Li8/XpuvVj5rIE/Cl43jcT0SUu2olFVivDCorS6NUSfhIhZqg1X4Oqt87JUXdQdykXx4V
 nQcHmY6Ea/Q7zOMmn/UKB7AgcgmmGRCVUhvgDVr/oE5ynNIU8s1SDHlEBqGLqhsmouzsfAABA
 jyglTxkpilT5pmvMpo5fAP8AwkkqAkIB9jApT2zwRGSjW1cYXAQ3WaM1evmINs2DVtk02ispm
 +O8yI5B
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Paul,

On Wed, 4 Jul 2018, Paul Smith wrote:

> One thing I wanted to do was provide a default ca-bundle.crt file along
> with my local build of Git.  I need my installation to be relocatable
> and I'm using RUNTIME_PREFIX with Git 2.18.0 (on GNU/Linux).

Understandable. We do this all the time in Git for Windows. Our config
entry has this form:

	[http]
		sslCAinfo = /ssl/certs/ca-bundle.crt

and in the RUNTIME_PREFIX mode, this will be made relative to the runtime
prefix. It is my understanding that bf9acba (http: treat config options
sslCAPath and sslCAInfo as paths, 2015-11-23) makes this work.

> I can provide a system gitconfig file with a setting for http.sslCAInfo
> but the problem is I can't create a relocatable path here so I don't
> know how to set it:
> 
>   $ cat $prefix/etc/gitconfig
>   [http]
>       sslCAInfo = <prefix>/etc/ca-bundle.crt
> 
> What do I use for <prefix> above since I want it to be relocatable? 
> Basically I want this to be in the same directory as the relocatable
> sysconfdir (I don't actually care much but that seems like a good
> place).
> 
> Is there some way to create a reference to a path relative to the
> installation directory?
> 
> For example "~" is accepted as the users $HOME path; is there some
> syntax which refers to the Git installation directory?
> 
> If not this seems like something that would be very useful.
> 
> 
> I can use a wrapper script and set GIT_SSL_CAINFO, but that will also
> override any user's setting of http.sslCAInfo in their local gitconfig
> which I don't really want.

I think if you simply delete `<prefix>`, it will start working.

Ciao,
Johannes
