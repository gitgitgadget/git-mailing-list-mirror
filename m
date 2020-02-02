Return-Path: <SRS0=xuSa=3W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 960BFC3524A
	for <git@archiver.kernel.org>; Sun,  2 Feb 2020 14:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2656220643
	for <git@archiver.kernel.org>; Sun,  2 Feb 2020 14:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="faXVZSLe";
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="faXVZSLe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgBBOMp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Feb 2020 09:12:45 -0500
Received: from fallback18.mail.ru ([185.5.136.250]:57212 "EHLO
        fallback18.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbgBBOMp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Feb 2020 09:12:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=y9DbmQNMOp+BRlB/EKt8lgp1+1L+j/5sk5tyK7ztrOw=;
        b=faXVZSLeeqP8cr7iY+H3DJ7xJqg7SwI8jFJfbReE2uMyCc6+tycNiwl5aabwmfgzYjSDKag1EKQHuona3hMOqTY2whJYP0HXH1Xhg72gF7+C0GoyrpW5N4eeA5uOQ+2jyQw8BueADyglpdERchrFQMmAQYBO/b1E40xp8fleR/Q=;
Received: from [10.161.25.35] (port=44636 helo=smtp58.i.mail.ru)
        by fallback18.m.smailru.net with esmtp (envelope-from <kostix@bswap.ru>)
        id 1iyFzO-0007qH-Tc
        for git@vger.kernel.org; Sun, 02 Feb 2020 17:12:43 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=y9DbmQNMOp+BRlB/EKt8lgp1+1L+j/5sk5tyK7ztrOw=;
        b=faXVZSLeeqP8cr7iY+H3DJ7xJqg7SwI8jFJfbReE2uMyCc6+tycNiwl5aabwmfgzYjSDKag1EKQHuona3hMOqTY2whJYP0HXH1Xhg72gF7+C0GoyrpW5N4eeA5uOQ+2jyQw8BueADyglpdERchrFQMmAQYBO/b1E40xp8fleR/Q=;
Received: by smtp58.i.mail.ru with esmtpa (envelope-from <kostix@bswap.ru>)
        id 1iyFzM-0007Nk-G2; Sun, 02 Feb 2020 17:12:40 +0300
Date:   Sun, 2 Feb 2020 17:12:40 +0300
From:   Konstantin Khomoutov <kostix@bswap.ru>
To:     Manav Agarwal <dpsman13016@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Need help to start contributing
Message-ID: <20200202141240.juzwhpdcjrsduiqy@carbon>
References: <CACbxD0AG_eX4kH3SyY7FWZLcd4FymuOQ6Kii0czHFJ8SPyEdcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CACbxD0AG_eX4kH3SyY7FWZLcd4FymuOQ6Kii0czHFJ8SPyEdcw@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-7564579A: B8F34718100C35BD
X-77F55803: 0A44E481635329DB0E1AA8A03B392317179C3E6C7981FFF28A80C3A0DBD6ACACCFD79B27E17499B7F688BCB05C26794D77178619A29E3C9C1DED7DA57C921CF3E6CE816213CE8D0FC33B8B3A8B8962AF
X-7FA49CB5: 0D63561A33F958A5BB10BA8F8A0D2C173C96383ED259DD70AFBCB1A3F7E670498941B15DA834481FA18204E546F3947CEDCF5861DED71B2F389733CBF5DBD5E9C8A9BA7A39EFB7666BA297DBC24807EA117882F44604297287769387670735209ECD01F8117BC8BEA471835C12D1D977C4224003CC8364767815B9869FA544D8D32BA5DBAC0009BE9E8FC8737B5C224937E7452263E0972376E601842F6C81A12EF20D2F80756B5F012D6517FE479FCD76E601842F6C81A127C277FBC8AE2E8B6D01232022BF41B73AA81AA40904B5D99449624AB7ADAF37F910319684D6E05D725E5C173C3A84C3045DD857D6FE754135872C767BF85DA2F004C906525384306FED454B719173D6462275124DF8B9C9DE2850DD75B2526BE5BFE6E7EFDEDCD789D4C264860C145E
X-Mailru-Sender: 641179478317D3F0421D0BEF39CFD1382C027698C543D78392FC74525D568F82A96F51CF8A3FC75013BA5AC085B0DF3CFD8FF98A8691EE7BAAB64A3C2C77197FCA12F3F80FA6A2FFE7D80B0F635B57EC67EA787935ED9F1B
X-Mras: OK
X-7564579A: EEAE043A70213CC8
X-77F55803: 5241C2F38277A35D7F9F52485CB584D7271FD7DF62800FDC0F5BB53137D87BDC647379EE6AF6FFC3F16AFDB48C324EDC94E1E1F2DDB2EC4B
X-7FA49CB5: 0D63561A33F958A574158F6AD5DB45F4D1A4A5E952EFABAA79AB476A5B52DF078941B15DA834481FA18204E546F3947CEDCF5861DED71B2F389733CBF5DBD5E9C8A9BA7A39EFB7666BA297DBC24807EA117882F44604297287769387670735209ECD01F8117BC8BEA471835C12D1D977C4224003CC8364767815B9869FA544D8D32BA5DBAC0009BE9E8FC8737B5C224937E7452263E0972376E601842F6C81A12EF20D2F80756B5F012D6517FE479FCD76E601842F6C81A127C277FBC8AE2E8B6D01232022BF41B73AA81AA40904B5D99449624AB7ADAF37F910319684D6E05D725E5C173C3A84C3045DD857D6FE754135872C767BF85DA2F004C906525384306FED454B719173D6462275124DF8B9C9DE2850DD75B2526BE5BFE6E7EFDEDCD789D4C264860C145E
X-Mailru-MI: 800
X-Mailru-Sender: A5480F10D64C9005C4B9C964EF46FD64ABC9777E5BB190D3647379EE6AF6FFC315C3726575FFF916FD27B1545737DED76F53C80213D1719CB3360D9C94DE366A1CC4A9B39F20364B73395D515EC5B64AAE208404248635DF
X-Mras: OK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 02, 2020 at 05:56:55PM +0530, Manav Agarwal wrote:

> Hey there! I am a shell script and Linux kernel programmer and looking
> forward to making contributions to Git. May you please help me out
> with some getting started links. I would be very thankful to you if
> you could help me out with that.

This recent thread on the git-users mailing list [1] should have you
covered on this topic.

To maybe add to what's written there, I'd also suggest looking under the
"Documentation" directory of your local Git clone [2] - as it contains
all the relevant material.

1. https://groups.google.com/d/topic/git-users/89WqodvcEUE/discussion
2. https://github.com/git/git/tree/master/Documentation

