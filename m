Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAD_ENC_HEADER,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2525C2BA19
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 00:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E8B92087E
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 00:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sorrel.sh header.i=@sorrel.sh header.b="m6iyny0r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbgDXAFZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 20:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727913AbgDXAFY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 20:05:24 -0400
X-Greylist: delayed 1952 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 23 Apr 2020 17:05:24 PDT
Received: from haggis.mythic-beasts.com (haggis.mythic-beasts.com [IPv6:2a00:1098:0:86:1000:0:2:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82EF5C09B042
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 17:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sorrel.sh;
         s=mythic-beasts-k1; h=Subject:To:From:Date;
        bh=94Nih8tiP2gR/yRIoRf9BQP1mgdBRaGyGdgldpPpJys=; b=m6iyny0rMCfJIalaGKWv6l8Oai
        3penwrth6Jk2oiG1e4o2zad8gnLMeMzcY0hbCzB2qke5X5+adWygilK6fYPN1kQEH+abDOvc5S76j
        +H9F99MSyaw4GJw8xdkP64U9hqPZcaYv49S4DDy2hsrn8lWbqkfl7j5/UXvYaBr3FaJvPJVXxYdHa
        pS3MJw8mnQpHMDdUS9TwzwdwTBxmraIT2uGFEMTZ1nOyxXLT1/ErwWMrOWw/X2VkdIVpMlHGJpq4S
        nDyZOVGD40nCqhjv8uUBkXp3Jr4Is22DiIsdao4Oao242QQMzCoakflkMgsc8C06vJ2SmNpSx+3Wh
        vGJNBJMw==;
Received: from [212.56.100.202] (port=62434 helo=localhost)
        by haggis.mythic-beasts.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <ash@sorrel.sh>)
        id 1jRlKr-0003YC-TL; Fri, 24 Apr 2020 00:32:50 +0100
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Originaldate: Tue Apr 21, 2020 at 2:22 AM
Originalfrom: "Emma Brooks" <me@pluvano.com>
Original: =?utf-8?q?On_2020-04-21_02:00:35+0100,_Ash_Holland_wrote:
 =0D=0A>_I_would_?=
 =?utf-8?q?also_appreciate_feedback_on_the_word-diff_pattern_here,_I_have?=
 =?utf-8?q?=0D=0A>_no_real_idea_what_should_constitute_a_word_in_a_Markdow?=
 =?utf-8?q?n_document,_apart=0D=0A>_from_that_it_should_probably_be_simila?=
 =?utf-8?q?r_to_the_definition_given_for=0D=0A>_Fountain,_given_that_Fount?=
 =?utf-8?q?ain_appears_to_have_somewhat_similar_inline=0D=0A>_syntax_to_Ma?=
 =?utf-8?q?rkdown.=0D=0A=0D=0ASince_Markdown_can_have_raw_HTML_tags_in_man?=
 =?utf-8?q?y_variants,_it_may_make=0D=0Asense_to_extend_the_word_pattern_t?=
 =?utf-8?q?o_"[^<>=3D_\t]+"_like_HTML's_pattern_so=0D=0Atags_starting/endi?=
 =?utf-8?q?ng_will_not_be_considered_part_of_a_word.=0D=0A?=
In-Reply-To: <20200421022256.GA29071@pluvano.com>
Date:   Fri, 24 Apr 2020 00:32:46 +0100
From:   "Ash Holland" <ash@sorrel.sh>
To:     "Emma Brooks" <me@pluvano.com>
Cc:     <git@vger.kernel.org>, "Junio C Hamano" <gitster@pobox.com>,
        "Boxuan Li" <liboxuan@connect.hku.hk>,
        "Alban Gruin" <alban.gruin@gmail.com>
Subject: Re: [PATCH] userdiff: support Markdown
Message-Id: <C28ZA0MZKHK6.2CCZPZF15D32W@what>
X-BlackCat-Spam-Score: 39
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue Apr 21, 2020 at 2:22 AM, Emma Brooks wrote:
> Since Markdown can have raw HTML tags in many variants, it may make
> sense to extend the word pattern to "[^<>=3D \t]+" like HTML's pattern so
> tags starting/ending will not be considered part of a word.

Good point, I'll update the pattern to that, thanks!
