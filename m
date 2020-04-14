Return-Path: <SRS0=cd4n=56=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC61C2BA19
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 14:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB77C206D5
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 14:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="PJ72qb2N";
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="PJ72qb2N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389736AbgDNOU1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Apr 2020 10:20:27 -0400
Received: from fallback20.mail.ru ([185.5.136.252]:37998 "EHLO
        fallback20.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389712AbgDNOUY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Apr 2020 10:20:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=DX/khzL1BkFdQbsUBKSsuxPECIJBVkND3G9HOMLQwMM=;
        b=PJ72qb2NT86i3s9Z4EUTORBjN3nMQbXm3qBkeOyjbELcR3tkycCNVhdOY5p2Q4/cQQXt5vMiuAIJfVuLGU/WnLhehHr6qknTpf1KfgtbmPX1a93H86UJesQKQNAlAgqSAFCxVMDtJWHA1KvcOOpNbkxCmt86GPjCMglgXkTtYE8=;
Received: from [10.161.22.25] (port=54522 helo=smtp55.i.mail.ru)
        by fallback20.m.smailru.net with esmtp (envelope-from <kostix@bswap.ru>)
        id 1jOMQI-0002xv-0k
        for git@vger.kernel.org; Tue, 14 Apr 2020 17:20:22 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=DX/khzL1BkFdQbsUBKSsuxPECIJBVkND3G9HOMLQwMM=;
        b=PJ72qb2NT86i3s9Z4EUTORBjN3nMQbXm3qBkeOyjbELcR3tkycCNVhdOY5p2Q4/cQQXt5vMiuAIJfVuLGU/WnLhehHr6qknTpf1KfgtbmPX1a93H86UJesQKQNAlAgqSAFCxVMDtJWHA1KvcOOpNbkxCmt86GPjCMglgXkTtYE8=;
Received: by smtp55.i.mail.ru with esmtpa (envelope-from <kostix@bswap.ru>)
        id 1jOMQD-00089c-RV; Tue, 14 Apr 2020 17:20:18 +0300
Date:   Tue, 14 Apr 2020 17:20:17 +0300
From:   Konstantin Khomoutov <kostix@bswap.ru>
To:     Anton Petrunin =
         =?utf-8?B?0JDQvdGC0L7QvSDQn9C10YLRgNGD0L3QuNC9?= 
        <anton-petrunin@tuta.io>
Cc:     git@vger.kernel.org
Subject: Re: wrong encoding in send-window
Message-ID: <20200414142017.3zdjo4tiebdhhvm7@carbon>
References: <M4qEecR--7-2@tuta.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <M4qEecR--7-2@tuta.io>
User-Agent: NeoMutt/20180716
X-7564579A: 646B95376F6C166E
X-77F55803: 0A44E481635329DB0E1AA8A03B392317D32E5E48865217369133EF8E37521108988A8C67AE60C645F688BCB05C26794DFB6D45A5407C2EF0A1ADA19CCB298B732EA89EBE2DC0A119C1E40E529E94B2A5
X-7FA49CB5: 0D63561A33F958A534F3391B1D0CC34B20898BB9782C6BB166CB8C0C277CF9948941B15DA834481FA18204E546F3947CB861051D4BA689FCF6B57BC7E64490618DEB871D839B7333395957E7521B51C2545D4CF71C94A83E9FA2833FD35BB23D27C277FBC8AE2E8B3A703B70628EAD7BA471835C12D1D977C4224003CC8364767815B9869FA544D8D32BA5DBAC0009BE9E8FC8737B5C22491CFB5EB31733C4B376E601842F6C81A12EF20D2F80756B5FDA63EEEA5E5E9D6576E601842F6C81A127C277FBC8AE2E8B8FA608DA6CD568A33AA81AA40904B5D99449624AB7ADAF3726B9191E2D567F0E725E5C173C3A84C3CD42BCEBB57B85E635872C767BF85DA2F004C906525384306FED454B719173D6462275124DF8B9C9DE2850DD75B2526BE5BFE6E7EFDEDCD789D4C264860C145E
X-D57D3AED: Y8kq8+OzVozcFQziTi/Zi1xwo7H2ZNxGP5qz8aO2mjTJzjHGC4ogvVuzB3zfVUBtENeZ6b5av1fnCBE34JUDkWdM6QxE+Ga5d8voMtmXfSqX7LbxVpFaAQD/ql6jfy+t
X-Mailru-Internal-Actual: A:0.91060524009111
X-Mailru-Sender: 641179478317D3F0421D0BEF39CFD138F044D5C297BB6E822A4FA8D52016066FAE66FB262F053E3013BA5AC085B0DF3CFD8FF98A8691EE7BAAB64A3C2C77197FCA12F3F80FA6A2FFE7D80B0F635B57EC67EA787935ED9F1B
X-Mras: Ok
X-7564579A: EEAE043A70213CC8
X-77F55803: E8DB3678F13EF3E07F9F52485CB584D7271FD7DF62800FDCAF625A2050746782D942B26779CD49CFDEDEE099F11567C1880291233E43B411
X-7FA49CB5: 0D63561A33F958A5ECED3D32BACC72B54CFBCFA021834B9ACF6848CBE4FD71F08941B15DA834481FA18204E546F3947CD2DCF9CF1F528DBCF6B57BC7E64490618DEB871D839B7333395957E7521B51C2545D4CF71C94A83E9FA2833FD35BB23D27C277FBC8AE2E8B974A882099E279BDA471835C12D1D977C4224003CC8364767815B9869FA544D8D32BA5DBAC0009BE9E8FC8737B5C224937E7452263E0972376E601842F6C81A12EF20D2F80756B5FDA63EEEA5E5E9D6576E601842F6C81A127C277FBC8AE2E8B8FA608DA6CD568A33AA81AA40904B5D99449624AB7ADAF3726B9191E2D567F0E725E5C173C3A84C3CD42BCEBB57B85E635872C767BF85DA2F004C906525384306FED454B719173D6462275124DF8B9C9DE2850DD75B2526BE5BFE6E7EFDEDCD789D4C264860C145E
X-D57D3AED: Y8kq8+OzVozcFQziTi/Zi1xwo7H2ZNxGP5qz8aO2mjTJzjHGC4ogvVuzB3zfVUBtENeZ6b5av1fnCBE34JUDkWdM6QxE+Ga5d8voMtmXfSo2/QOxX0MI1QyxHfUpwjuv
X-Mailru-MI: 800
X-Mailru-Sender: A5480F10D64C9005EBA3FDA8F7473FBDF5F18C97EAD6B231D942B26779CD49CF3AC45910FB9EB2A7FD27B1545737DED76F53C80213D1719CB3360D9C94DE366A1CC4A9B39F20364B73395D515EC5B64AAE208404248635DF
X-Mras: Ok
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 14, 2020 at 03:12:32AM +0200, Anton Petrunin = Антон Петрунин wrote:

> In the send-window it has wrong encoding --- does not work for Russian;
>  see the attached screenshot.

What OS is this? What version of Git? How was it installed (from a stock
package provided by the OS / from the source / some other way)?

What is the output of running the `locale` program in a terminal window
in the same X session (please copy and paste the text).

