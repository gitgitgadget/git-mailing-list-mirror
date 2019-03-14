Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21D0320248
	for <e@80x24.org>; Thu, 14 Mar 2019 19:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbfCNTzn (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 15:55:43 -0400
Received: from mout.gmx.net ([212.227.15.15]:53043 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726890AbfCNTzn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 15:55:43 -0400
Received: from [192.168.0.129] ([37.201.195.16]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MEoGY-1hEvle2Ao6-00FzfV; Thu, 14
 Mar 2019 20:55:32 +0100
Date:   Thu, 14 Mar 2019 20:55:16 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 4/4] get_oid(): when an object was not found, try
 harder
In-Reply-To: <20190314185758.GB26250@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1903142054490.41@tvgsbejvaqbjf.bet>
References: <pull.161.git.gitgitgadget@gmail.com> <994446236d05d9d014e12a5102bcf9be222e3b57.1552472189.git.gitgitgadget@gmail.com> <xmqqa7hyckfm.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1903141410360.41@tvgsbejvaqbjf.bet>
 <20190314185758.GB26250@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:i7a7bp8eWhPNnfI3arWA36YTyDh2XI1rx4ZyVNp92TjtCiFfFio
 YY9DG2aUzoCgOPEe7n0/Kp4DbE5H3DbVQrbTblLLng/joAdtsP1clCdU0uVhoxNEBG7/wDV
 t7Gb12wtnyMB7YVyNmmD5fB5tY+blsy5HMhVs2E1xarpYuoF+ZIaS3ubsUVkDTp0GuH/HPt
 zBJ9qx7HQtFysKe7JRd0Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:c3afOGRPMbo=:hjlGV+l62R0Xgh5LYCBfr7
 fNPCZWL15/NxakoSURbgzzjKPTeERhGysHHu8fAD+7yTe8xyW44IGf7Dqnzf92aoCRL7e8yMP
 0PqG+Z1VHOBdbPtKYru13Gr+U5vXpKf6r73TySFHamqY4O+UvxFXQ8PQSzYoPBD+8a1WjrhNp
 INMwc23nbI4eAHoY+TLj69XMzFknCAGbe5KwmRbMDcnb22xVy+9FC/LRu7AzEkbOr5k8HmlKk
 4s4SRTuSGZIMMyqcO7/11GZzjG1MFHhPQGh4luokjb0PHYYSmwSMsWkDuVHn0VXoqrzg5mM+8
 7+bNFxYxAkHTHsyDnmniYkSM3bv82//b+83WGOpvqmf9xU7wskZ+a0pZZDWffPfBq74rrKC2o
 Ybtdx45ezN5FrFdfmjvv6oD4sHdMfIeK8WkKyHci8nHTtiNo4/c31reZw8KDP6gxF4XM0EGZm
 +ly4WaAW3K5LehhPr0ynjs3PmqSQhpEDUhZwW12+F2ME5BdCp1OH0z/J1ne5Qt0opoU64+R5y
 lAbZvpUbJYr8i1lFKzX06azsPvrxnjKbiMJCPuv8z80L4fzh6tb8odv0nUtwxac8hejJjwC02
 qDFOok8fN5SDd1CukvjajJ6U+Jw09u2OYw7tX/+u4nc3Ozmpr3fotH3RNphUsu5Aucuw09QMk
 W7ged/wsAGh5xR9I65cr/AmHV1NhONOeu5k5d+ZcpZHOeINSu68hA+QNReJgW0Vsi71QBbNn5
 lB1qYl4HnEBUpZvLltRs0UZf18DnLFwJzbTO2b76ULY+utW1/smEs/zVAAKyFz98MNidhVjv5
 L/EJCCY3RuD6sPdhwP5CdAB455dZVR8BYHy6KhoTDpZB4UVjniaInt8s/wFYzmff8yZBjjlZm
 EdCqqt1UAHHMMSpk8ESMJh+LC0kEGPzmM4YEex4/r5/yxT1GmCENhR0Iber6mjbsBVtcOL4wU
 7PLseyOWrdg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Thu, 14 Mar 2019, Jeff King wrote:

> On Thu, Mar 14, 2019 at 02:17:18PM +0100, Johannes Schindelin wrote:
> 
> > >  2. is there a way to cleanly avoid the three-line duplicate?
> > [...]
> > Peff tried with a function, but I think that this would actually be a
> > really appropriate occasion for a well-placed `goto`:
> 
> I worried that a goto would be too confusing/ugly. But I am OK with it
> if you are.

I hope that after reading the patch, you will agree with me that it is not
too confusing/ugly... ;-)

Ciao,
Dscho
