Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89CDC20954
	for <e@80x24.org>; Wed, 29 Nov 2017 05:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750890AbdK2FTZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Nov 2017 00:19:25 -0500
Received: from p3plsmtpa06-09.prod.phx3.secureserver.net ([173.201.192.110]:41800
        "EHLO p3plsmtpa06-09.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750778AbdK2FTY (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Nov 2017 00:19:24 -0500
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with SMTP
        id JumFeisKusNpzJumHe4fYT; Tue, 28 Nov 2017 22:19:24 -0700
Date:   Wed, 29 Nov 2017 07:19:19 +0200
From:   Max Kirillov <max@max630.net>
To:     Jeff King <peff@peff.net>
Cc:     Max Kirillov <max@max630.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Florian Manschwetus <manschwetus@cs-software-gmbh.de>,
        Chris Packham <judge.packham@gmail.com>,
        Konstantin Khomoutov <kostix+git@007spb.ru>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v6 2/2] t5560-http-backend-noserver.sh: add
 CONTENT_LENGTH cases
Message-ID: <20171129051919.GH26158@jessie.local>
References: <20171126193813.12531-1-max@max630.net>
 <20171126193813.12531-3-max@max630.net>
 <CAPig+cROFS+3Yon2CFr-aPUGzDY4WVbU8kHbBx68O3M8k5eeug@mail.gmail.com>
 <20171126224051.GF26158@jessie.local>
 <20171129032632.GC32345@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171129032632.GC32345@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CMAE-Envelope: MS4wfGGXXWMk3idcPDia7k3Kwo6i+URMNQ0qStFLVzFi06VrekGiLyEOmX8mcuu9pQsv1UxvLlUw+uryxEfqZadFHIdMxBq2yJ92Ja2mx7QFtQukSaKH8SGL
 1HAjkvsyQqh9u73CD16ItX0h8yuFJC/h1abT+V0Vqvsu8rBzcwgIosdbU6meBJjC93uk/PlQuh7h4RNApwoAX1MiRoaeLc5X6wDih8rHa7P3ebQ3RZcJJboj
 +KkS+R/UzuwkaRuopaF3IyXDQQvjocfc7cVWRCfBKdv1/UJDGnryEmujjUfWKsmhV0KyggAlP6330nguUbRYjjO004/2CvAtzviNoCH6erLg+B3busMuUeVi
 f0oI7fvbxAC/NQj4dLtlEjfmnfbQW8npPq8AVHp8o6HNgyheEbk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 28, 2017 at 10:26:33PM -0500, Jeff King wrote:
> On Mon, Nov 27, 2017 at 12:40:51AM +0200, Max Kirillov wrote:
> That said, we already have some precedent in "git version
> --build-options" to report sizes there. Can we do something like the
> patch below instead of adding a new test helper?
> 
> diff --git a/help.c b/help.c
> index 88a3aeaeb9..9590eaba28 100644
> --- a/help.c
> +++ b/help.c
> @@ -413,6 +413,7 @@ int cmd_version(int argc, const char **argv, const char *prefix)
>  
>  	if (build_options) {
>  		printf("sizeof-long: %d\n", (int)sizeof(long));
> +		printf("sizeof-size_t: %d\n", (int)sizeof(size_t));
>  		/* NEEDSWORK: also save and output GIT-BUILD_OPTIONS? */
>  	}
>  	return 0;

Thank you! I knew there should have been something.

If nobody objects changing the user-visible behavior, I'll
consider using this.

PS: I'll respond to your other reply a bit later.
