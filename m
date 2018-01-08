Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F9511FADF
	for <e@80x24.org>; Mon,  8 Jan 2018 21:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753986AbeAHVud (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 16:50:33 -0500
Received: from mout.web.de ([212.227.17.12]:64920 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754507AbeAHVuc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 16:50:32 -0500
Received: from [192.168.178.36] ([91.20.48.24]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Mgwhg-1eCcDr3uZE-00M6ca; Mon, 08
 Jan 2018 22:50:28 +0100
Subject: Re: [PATCH] bisect: avoid NULL pointer dereference
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <07a8cdae-8f8c-8560-c450-c6089a942c96@web.de>
 <nycvar.QRO.7.76.6.1801082145140.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <4806374d-144e-5260-b4bf-34c699a980a3@web.de>
Date:   Mon, 8 Jan 2018 22:50:25 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1801082145140.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:9gY4lAVHAYKNdtM+mIXnism3OwWydxa5lXQz13dtCiF/Lhf0B7l
 Dfb6ZZHM7DdJeaFQ1VSETHRn+mhQTIdKrkbCHUA3gGeLe8jMjQR55xYVl5mTnbw+pYEBiHy
 IR5jwDwU9DBA/sTiEBGvC26ZfHKL390/bPU78Z5rKlCXawA+IsqEtZatcRGydIyHnhDCREa
 A5ePHGhfArtx/3HrqdHmQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MZK595q8CrY=:0nosobdgP3KtBNUtJ/vByT
 5Xtc+CoTNIUZf1xPZ5A+uYRUr7ZQPm2nW1I+M6ZB7++GE/qh4LWsn0Oin76SFAszYxJLuLjJY
 QP6NLf+tI+tBwJQShCazp4QU6vvOR6yL0nKNxvupYnNmGrx/vfV1GwPp1kyYLf2XP4uIhW3fA
 dOV5fp7di0VZxHgAOpdmR1c5xY+YxdRvYMlBRRsSyaHuTlPLH6uEFyvZIrNvTqEYK1oE/CVVv
 fpxFFOWSojr3iGgW+XEUchOpBGL9LXfJ3eAr4FwBJQhPe9BY74GEcIy9jcWNNBWp/qSUZefL9
 R6b3wIFm7t08mZPmtL8D/D92qrD3mT8GO+T9/HvsWCawhERyMSx6jVDoNJIPfOSaLmq7uqHiM
 cMqaXInddaICloKdFKbd8UxifmpDf7pG9MVvdOmJSth3MHIy//kELHXNDIBsw9SuMzHXfStsN
 5LdnxGo41r5FRkGCDY9ZziHbpcRHLHIAk5/HK4eRwEWsYD5KqTYLVOduBGMFbIIBv0VcCiZ/Q
 ntrBeZJizWAvqXbmsIVQeCbEN77HJy+cM2kasCE3qv1Hr9Zf6nl5FFdPJkIG0DbsgTHVvvmOU
 yjsJgkMg6XeSHKJ4JuT/xSBxtI/zZRgDOQWqBhJL3T68ZQ6EHvmhD1rvm7HtjLRclqSTsjb1Y
 T4RU+YXSz6qsOUQ6Afp94tjD7LixFenpdp6Ia04B9L+HqnSnzf0pVn4eP9q5bmKubNGQPf2i8
 csZYr9ULq8bw/CwxMNQ/zIFiCFecrssL/lJi4jRQ00QWZnLNS+r2QWDyD+6bwq//N1TdwlRsF
 Rkp3JDe3y2iqpe3tPnLsB8UFMJN4EENtGT2gd3bSMPveZ0Mopg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Dscho,

Am 08.01.2018 um 21:45 schrieb Johannes Schindelin:
> Isn't this identical to
> https://public-inbox.org/git/20180103184852.27271-1-avarab@gmail.com/ ?

yes, indeed, thanks.  So here's an upvote for Ævar's patch then. :)

(I should have sent it earlier, but was not fully convinced it could be
triggered in the wild.)

René
