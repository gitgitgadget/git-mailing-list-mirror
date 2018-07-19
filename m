Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16D421F597
	for <e@80x24.org>; Thu, 19 Jul 2018 09:23:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730440AbeGSKFW (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 06:05:22 -0400
Received: from fallback9.mail.ru ([94.100.178.49]:56855 "EHLO
        fallback9.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbeGSKFV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 06:05:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=3+ZjsMINKe7eVM7enWDFl44ip4dM1h31CRG7mQ+m+Mo=;
        b=vXWBo8otWI5koYHwxs7xbuICHgM2wlwV59iwWzpBY09JnoStraUEyObzpESq/ztpeX2I6U7+cXyDGr/jLQnIE3nBgWc/izZfSkxnHYuVq/YP/imf6bBG401/xXjnUVKpgJUcoHfE03TbZfEI8qLmXDBlgA5zjFkaPTvRqs8aiDE=;
Received: from [10.161.64.57] (port=57368 helo=smtp49.i.mail.ru)
        by fallback9.m.smailru.net with esmtp (envelope-from <kostix@bswap.ru>)
        id 1fg59K-0001k1-T7; Thu, 19 Jul 2018 12:23:03 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=3+ZjsMINKe7eVM7enWDFl44ip4dM1h31CRG7mQ+m+Mo=;
        b=vXWBo8otWI5koYHwxs7xbuICHgM2wlwV59iwWzpBY09JnoStraUEyObzpESq/ztpeX2I6U7+cXyDGr/jLQnIE3nBgWc/izZfSkxnHYuVq/YP/imf6bBG401/xXjnUVKpgJUcoHfE03TbZfEI8qLmXDBlgA5zjFkaPTvRqs8aiDE=;
Received: by smtp49.i.mail.ru with esmtpa (envelope-from <kostix@bswap.ru>)
        id 1fg59A-0001Jc-8u; Thu, 19 Jul 2018 12:22:52 +0300
Date:   Thu, 19 Jul 2018 12:22:46 +0300
From:   Konstantin Khomoutov <kostix@bswap.ru>
To:     Timothy Rice <timothy.rice@unimelb.edu.au>
Cc:     =?iso-8859-1?Q?3=C6var_Arnfj=F6r=F0?= Bjarmason 
        <avarab@gmail.com>,
        Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>,
        git@vger.kernel.org
Subject: Re: Q: Ignore ./foo, but not script/foo
Message-ID: <20180719092246.vtwfludt7gmk6gdz@tigra>
References: <5B503FF0020000A10002C6B5@gwsmtp1.uni-regensburg.de>
 <8736wfd579.fsf@evledraar.gmail.com>
 <20180719090656.GA18624@sleipnir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180719090656.GA18624@sleipnir>
User-Agent: NeoMutt/20170306 (1.8.0)
X-7FA49CB5: 0D63561A33F958A511E43B854D8350E4E28542B5DD9A3D18E99B2672D5AFDE3C0A6AB1C7CE11FEE3B2DECCBDF547A30576E601842F6C81A1F004C906525384306FED454B719173D6725E5C173C3A84C30A3B31C63366F725F6EC68623D42D9C8B58781B77DE60D36C4224003CC836476C0CAF46E325F83A50BF2EBBBDD9D6B0F05F538519369F3743B503F486389A921A5CC5B56E945C8DA
X-Mailru-Sender: 3EA917A0E6524472E50B252446CEFEA4E8E4D330BE7EE41C4F3795587E7FFF3ACA1B0AE468EAC1C9FD27B1545737DED76F53C80213D1719CB3360D9C94DE366A1CC4A9B39F20364B73395D515EC5B64AAE208404248635DF
X-Mras: OK
X-7FA49CB5: 0D63561A33F958A5DE435CA34E60485A704D4FD47899C52FEFBAB37DE9B6F9B2462275124DF8B9C9DE2850DD75B2526BE5BFE6E7EFDEDCD789D4C264860C145E
X-Mailru-Sender: A5480F10D64C9005989B929F85CCF0950046F413CEBE08AE2333BE36D32142C3A5946156EE097900FD27B1545737DED76F53C80213D1719CB3360D9C94DE366A1CC4A9B39F20364B73395D515EC5B64AAE208404248635DF
X-Mras: OK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 19, 2018 at 07:06:57PM +1000, Timothy Rice wrote:

[...]
> Most people do put "." in their PATH for convenience
[...]

IMO this is a gross overstatement: personally, I know of no person using
a Unix-like operation system who does this.

