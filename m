Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73E7D1FF34
	for <e@80x24.org>; Fri, 12 May 2017 12:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755480AbdELMyy (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 08:54:54 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:12442 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755127AbdELMyx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 08:54:53 -0400
Received: from cayenne.localnet (unknown [IPv6:2a01:e35:2ef1:f910:5006:1621:c385:7777])
        by smtp2-g21.free.fr (Postfix) with ESMTPS id 563162003F5;
        Fri, 12 May 2017 14:54:50 +0200 (CEST)
From:   =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 2/3] read-tree -m: make error message for merging 0 trees less smart aleck
Date:   Fri, 12 May 2017 14:54:50 +0200
Message-ID: <3385764.ta7K6ELq6T@cayenne>
User-Agent: KMail/5.2.3 (Linux/4.9.0-2-amd64; KDE/5.28.0; x86_64; ; )
In-Reply-To: <xmqqtw4q6122.fsf@gitster.mtv.corp.google.com>
References: <20170503162931.30721-1-jn.avila@free.fr> <20170511190809.GB12516@aiede.svl.corp.google.com> <xmqqtw4q6122.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Friday, 12 May 2017, 15:28:53 CEST Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
> 
> >> @@ -226,9 +226,10 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
> >>  		setup_work_tree();
> >>  
> >>  	if (opts.merge) {
> >> -		if (stage < 2)
> >> -			die("just how do you expect me to merge %d trees?", stage-1);
> >>  		switch (stage - 1) {
> >> +		case 0:
> >> +			die(_("you must specify at least one tree to merge"));
> >> +			break;
> >
> > This part looks good.
> 
> Thanks.  Modulo _(""); I do not think other messages from read-tree
> are marked for i18n (yet).
> 

The documentation is already i18n, but not the dying messages. This can take place in a specific patch series.

Thanks. Will reroll. 

