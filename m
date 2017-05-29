Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C0152027C
	for <e@80x24.org>; Mon, 29 May 2017 10:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750891AbdE2K4M (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 May 2017 06:56:12 -0400
Received: from mout.gmx.net ([212.227.17.20]:59586 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750871AbdE2K4M (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 May 2017 06:56:12 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MPZuP-1dJP513jA9-004fyM; Mon, 29
 May 2017 12:56:03 +0200
Date:   Mon, 29 May 2017 12:56:01 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Liam Beguin <liambeguin@gmail.com>
cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        philipoakley@iee.org, phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 00/10] The final building block for a faster rebase
 -i
In-Reply-To: <20170526031508.24838-1-liambeguin@gmail.com>
Message-ID: <alpine.DEB.2.21.1.1705291254400.3610@virtualbox>
References: <cover.1493414945.git.johannes.schindelin@gmx.de> <20170526031508.24838-1-liambeguin@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:1RHtRr7K7zWbsxzy4IpGH5w5qnnsVGc26fJeTSoMirIhzaKX8uZ
 WbdC6rLSbPsJAJCsmcVdfBZXLgdzUyORNwAIWzzfVpZ+J+LC19UTW2RpPqDW2owDac/IhRp
 3ERC0pW7sil2X04NUND1Gj3PxHzbuQll8qAvkrMHuwJtuf+VIeV0JS17I7xApde1SkGf5UM
 s0BwDgQoQACSaI7BYYE9w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:w6Lx3v0jTkY=:dbJWXShPShL7W4OimJS7uy
 /Z/7955QvsDWAM2v/P49ARTPT59gLyyywfaox+YnS5JU/DFpBRjXAwekGq8HGcuwQOIdHZMeg
 0V/uAcOFAxynL45GoUoIKhGQH6lnzoqUowQyM62uJhtEqYghgpDqLyq2PgKkm9ss56S0oOmR+
 z8w053w9SJymbMTnRIkjhEBbmW2RQprOa2F/czsUMCHeohq13M/EWUqmiNzTSGkVe2tRWSSYp
 ZqGC3UqLfY0EbZoe/S+12g6NUjjuicnunLHd7h+4j3BV+ZnnJDNmg7Zr8uht+CPEf1OX/GZlv
 GxO0RSCiZuLW71+ZfQXjxiIKaz1CZ0cg8bmst3p5DSmUkL7iV3ENG5TefCUjzupiOcK2I3Wbk
 wkKahcC78AADqYY+bYB20AnCrXHZX3Q24THhCmA2OtJIIys8XnYpC8KcnGurywHeMH6Fw16cU
 Fef8K3Z1Qx+sf1pdRmjTb4mRYaqIa5vTQTIvuWFIqcEg+hRWX8YPwmu/+S7s+fyYQNmQuj/CU
 a0nZKCLiEp1V9veTCeQvF/D9OD49uptaR7p2W10SzyCYmMCINSEJOSJIUZtgnYIjqr4ox1QcO
 DihG0dl2ZpC8WG6pJV5jm57LZnDs93Rh7s0HMldF1JO7a6AhSrq3Sr94GsL8RBy4eFktGKNOh
 u5a8Rzactdcic/9j0HkqOrzt0ihTG8iLfZE9WuOhSq7OhQ3XnLuyr+saA1OC07CaMgnRVLdQW
 afHLCf5w8dZru7kvCk6/EfMPpdTEE1DZmoQkdkFTAotzmvoUj94+j80o1vw3iOK8F2RFwOSCL
 uYmyKp0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Liam,

On Thu, 25 May 2017, Liam Beguin wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> > This patch series reimplements the expensive pre- and post-processing of
> > the todo script in C.
> >
> > [...]

I see that you used git-send-email to send this. It did look a bit funny
not to have "Re: " prefixed subjects, so at first I thought you simply
re-sent my patch series. But I guess we have no convenient way to perform
patch review, therefore I don't fault you...

Thanks for reviewing!
Johannes
