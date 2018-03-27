Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23A221F404
	for <e@80x24.org>; Tue, 27 Mar 2018 15:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752206AbeC0PHW (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 11:07:22 -0400
Received: from mout.gmx.net ([212.227.15.19]:40807 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751068AbeC0PHW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 11:07:22 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MEnX8-1ektkj0VVy-00FxLX; Tue, 27
 Mar 2018 17:07:19 +0200
Date:   Tue, 27 Mar 2018 17:07:18 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Joel Teichroeb <joel@teichroeb.net>
cc:     Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 2/5] stash: convert apply to builtin
In-Reply-To: <20180327054432.26419-3-joel@teichroeb.net>
Message-ID: <nycvar.QRO.7.76.6.1803271705210.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180327054432.26419-1-joel@teichroeb.net> <20180327054432.26419-3-joel@teichroeb.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:IWC3klKrBeHv+8bCx+Dv8Bp2awoIbkf+ZLHatipjWukllgOxVCN
 gKxODazh8hUa9JTH/O+vTExZ5pIHpGMQY5ooGdfD+l0fF75puDwSDboJbpC02v7LyT1yofm
 1XJeg1SCETHCldBRJSx7Ec7q1PTC4012+Y7V39NU8GyFlhq0BzftK7sLYBxsjMYSlZhpT5n
 33BCIGSTnCpG3tZeS3MbQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QHF8r/Zs6iI=:hQ6o3cpNxiGYdsPF7zsWHL
 51Yk/4YDXcZV0hfp6oPNMvB+8RxQa/VjsmKRl0YE6stztwPM59i1zL52cEs7TRkdl0vWYQ9Rv
 ALoaw88NtzgMC/jmyo4h6JvQGXiMvxeEniYapdgcuIDlDLoDZtQdLgMxaoAHwe7BqWBH34MCW
 ZG+R0xgcUrZfAdp7O6p3RjYSWFcd4pZEIRgAjMhFTv2eb35gPgn/iLtmDXQ+ewZT5KqaXNgNs
 3Jt1wjcXJHuIhEiRRUg/RzB7YZIhHRbFP6ivOR0kyZMEZhykuJXv6gYfoPBbQblXpbCey0jHK
 nrVFNJzaF599aCWkKqRkVcoTTxqhVpp2bgvUAUswQeNUaFS1Gq8Nnl/AEieNu6szbO4BgbHlc
 klm+wpHPq0UVftm5zgXSXSCZvyNHBHwvIFfgWxEcI1Xmw9yGFAUSNZUq1QVk+msqeDzlzeZB3
 EHod5JGSTyr5smNInkm1b+BAqctCVF4GMON6ROgMch07NfetgiJPS5JLmoDY89YCLGRoiBY8U
 UpuX/zdquV8oE49S9CVEdFUdId1gagqza93aeLEbBbtNM30C3LPoMANNWxEXJYkqdgunBulx4
 iIG7nisObFTdI9lD3tTIweob7Jea4SGUITN9bGZunxwxod81wxK1MXTtCya+BxIceTXVpd2q1
 rJZbO04XoJ5NAP85WJwSqhRJfH72xFd5ZkoEwFqDPbeH5STBspQHN3c2jdTubZaSg3r5etyh1
 D7nwJ3QOtfUkRjeHYxIRpb9JjVT74smt2G9CcLs3jPPjCkUf2RIZjQ68+5TN0F3NG8HbqJM49
 zKSUUvTle/+PdPvjGFTgUz1GiTc6jNXOolka3YlC45rQyg5wPDPiX18rjUtgMRNeALSDtku
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Joel,

On Mon, 26 Mar 2018, Joel Teichroeb wrote:

> Add a bulitin helper for performing stash commands. Converting
> all at once proved hard to review, so starting with just apply
> let conversion get started without the other command being
> finished.
> 
> The helper is being implemented as a drop in replacement for
> stash so that when it is complete it can simply be renamed and
> the shell script deleted.
> 
> Delete the contents of the apply_stash shell function and replace
> it with a call to stash--helper apply until pop is also
> converted.
> 
> Signed-off-by: Joel Teichroeb <joel@teichroeb.net>

Very good!

In the interest of as incremental a change as possible, I would wager a
bet that this is the best way we can go about it, later replacing the
parts that still spawn Git processes (such as get_symbolic_name and
have_stash) with direct calls into libgit.a, one by one.

Thank you!
Dscho
