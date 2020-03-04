Return-Path: <SRS0=VPsx=4V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF0EEC3F2CD
	for <git@archiver.kernel.org>; Wed,  4 Mar 2020 12:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59E5B20848
	for <git@archiver.kernel.org>; Wed,  4 Mar 2020 12:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="PXV9kvX6";
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="PXV9kvX6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388023AbgCDMnu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Mar 2020 07:43:50 -0500
Received: from fallback21.m.smailru.net ([94.100.176.131]:56158 "EHLO
        fallback21.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728953AbgCDMnu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Mar 2020 07:43:50 -0500
X-Greylist: delayed 4036 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Mar 2020 07:43:49 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=YX2g/xOVnIOg4qrzoohH4COuqm/mrGNemxQnfQ93nqE=;
        b=PXV9kvX6Ilidy0k+xnKUeRoyEhMsCSaxDDCFYG29vhE+83dgyV1lSP9Yd8+3LxiqHvxxvBnLpA72q0e/d2FT0osv6B79dJ04DCJYNGTVHBRFyXZYA4R8ir5Vvz0QP+ubIJJDHkIRrGRios/CP3l/OI/AaD21sCEv5u0B6DwGuOk=;
Received: from [10.161.64.42] (port=44234 helo=smtp34.i.mail.ru)
        by fallback21.m.smailru.net with esmtp (envelope-from <kostix@bswap.ru>)
        id 1j9SKE-0000EG-LC
        for git@vger.kernel.org; Wed, 04 Mar 2020 14:36:30 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=YX2g/xOVnIOg4qrzoohH4COuqm/mrGNemxQnfQ93nqE=;
        b=PXV9kvX6Ilidy0k+xnKUeRoyEhMsCSaxDDCFYG29vhE+83dgyV1lSP9Yd8+3LxiqHvxxvBnLpA72q0e/d2FT0osv6B79dJ04DCJYNGTVHBRFyXZYA4R8ir5Vvz0QP+ubIJJDHkIRrGRios/CP3l/OI/AaD21sCEv5u0B6DwGuOk=;
Received: by smtp34.i.mail.ru with esmtpa (envelope-from <kostix@bswap.ru>)
        id 1j9SKC-0002Bz-Tf; Wed, 04 Mar 2020 14:36:29 +0300
Date:   Wed, 4 Mar 2020 14:36:28 +0300
From:   Konstantin Khomoutov <kostix@bswap.ru>
To:     =?utf-8?B?0KHQtdGA0LPQtdC5INCh0LXRgNCz0LXQtdCy?= 
        <nevercu@yandex.ru>
Cc:     git@vger.kernel.org
Subject: Re: Question git
Message-ID: <20200304113628.fwuw6jigur7pbway@carbon>
References: <3982961582024793@vla1-a6eaa355d163.qloud-c.yandex.net>
 <CABUeae8i-8VTw85XUaC_Lef_HFg5vuH6OkTsEjyu4iEZc7kuGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABUeae8i-8VTw85XUaC_Lef_HFg5vuH6OkTsEjyu4iEZc7kuGQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-7564579A: 646B95376F6C166E
X-77F55803: 0A44E481635329DB0E1AA8A03B392317179C3E6C7981FFF2F94659E4BEF79E71DAF87D557D639D6E556F68EC540A4532C99CFDF78B9C49C50E4BF8CE38220F0C9042720C5EC0CC90A5740B32E62B4674
X-7FA49CB5: 0D63561A33F958A5E50BEB99594D90A1CDF4985F3DFB17E019126C6223208CE48941B15DA834481FA18204E546F3947CEDCF5861DED71B2F389733CBF5DBD5E9C8A9BA7A39EFB7666BA297DBC24807EA117882F44604297287769387670735209ECD01F8117BC8BEA471835C12D1D977C4224003CC8364767815B9869FA544D8D32BA5DBAC0009BE9E8FC8737B5C224937E7452263E0972376E601842F6C81A12EF20D2F80756B5F012D6517FE479FCD76E601842F6C81A127C277FBC8AE2E8BA1EC3898FE79602D3AA81AA40904B5D99449624AB7ADAF37593B4A69AE7113BD725E5C173C3A84C30A3B31C63366F72535872C767BF85DA2F004C906525384306FED454B719173D6462275124DF8B9C9DE2850DD75B2526BE5BFE6E7EFDEDCD789D4C264860C145E
X-D57D3AED: Y8kq8+OzVoxvgW9Op3aR8Fxwo7H2ZNxGP5qz8aO2mjTJzjHGC4ogvVuzB3zfVUBtENeZ6b5av1fnCBE34JUDkaJinJwwHx5ysVv9/YfT9uc/r0hGya2Jbw==
X-Mailru-Internal-Actual: A:0.9435830591144
X-Mailru-Sender: 641179478317D3F0421D0BEF39CFD13874DDF296FBAEE7120E4BF8CE38220F0C8F506C1E8DC51A2113BA5AC085B0DF3CFD8FF98A8691EE7BAAB64A3C2C77197FCA12F3F80FA6A2FFE7D80B0F635B57EC67EA787935ED9F1B
X-Mras: Ok
X-7564579A: EEAE043A70213CC8
X-77F55803: 6AF0DA0BABFA9FDB7F9F52485CB584D7271FD7DF62800FDC07FF192248B0EB3E1452D4F2AE4FCC1EB95DE2AB90B3ADCC5EF0B7F5504288BC
X-7FA49CB5: 0D63561A33F958A5D78194762B02E6E37819290C0B9C717097045A71E5D5FBA08941B15DA834481FA18204E546F3947CEDCF5861DED71B2F389733CBF5DBD5E9C8A9BA7A39EFB7666BA297DBC24807EA117882F44604297287769387670735209ECD01F8117BC8BEA471835C12D1D977C4224003CC8364767815B9869FA544D8D32BA5DBAC0009BE9E8FC8737B5C224937E7452263E0972376E601842F6C81A12EF20D2F80756B5F012D6517FE479FCD76E601842F6C81A127C277FBC8AE2E8B8FA608DA6CD568A33AA81AA40904B5D99449624AB7ADAF3726B9191E2D567F0E725E5C173C3A84C30A3B31C63366F72535872C767BF85DA2F004C906525384306FED454B719173D6462275124DF8B9C9DE2850DD75B2526BE5BFE6E7EFDEDCD789D4C264860C145E
X-D57D3AED: Y8kq8+OzVoxvgW9Op3aR8Fxwo7H2ZNxGP5qz8aO2mjTJzjHGC4ogvVuzB3zfVUBtENeZ6b5av1fnCBE34JUDkaJinJwwHx5ysVv9/YfT9uc13AUx5FK7QQ==
X-Mailru-MI: 800
X-Mailru-Sender: A5480F10D64C90056DE2D996C7A19556A39A0C8F224D383D1452D4F2AE4FCC1EE6EFB8CE34922556FD27B1545737DED76F53C80213D1719CB3360D9C94DE366A1CC4A9B39F20364B73395D515EC5B64AAE208404248635DF
X-Mras: Ok
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 18, 2020 at 01:00:01PM +0100, Mateusz Loskot wrote:

> On Tue, 18 Feb 2020 at 12:26, Сергей Сергеев <nevercu@yandex.ru> wrote:
> >
> > Hello, I have a repo - WORK.git. There are some brunches.
> > Сan i view all commits working repo and all branches at the same time?
> 
> https://git-scm.com/docs/git-log#Documentation/git-log.txt---all
> 
> I must say the --all name itself is clearer than its description
> which makes use of Git lingo unnecessarily for such a simple option :-)
> As a Git newbie, I'd have not linked option to getting log of all branches.

Note that the stock gitk GUI frontend also supports the "--all"
command-line option.

