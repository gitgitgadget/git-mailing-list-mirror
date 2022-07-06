Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E0DC433EF
	for <git@archiver.kernel.org>; Wed,  6 Jul 2022 12:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbiGFMiU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jul 2022 08:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbiGFMiS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jul 2022 08:38:18 -0400
Received: from smtp47.i.mail.ru (smtp47.i.mail.ru [94.100.177.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BCC11E3F0
        for <git@vger.kernel.org>; Wed,  6 Jul 2022 05:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:Date:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=NPvPr2bzw59Aou1kYSKwNkOCAAEups+JQhtvGpJAWnY=;
        t=1657111095;x=1657201095; 
        b=1WG431a+4nztuWmxCwR5afq+jRrg3oAVcn8SSzswnPvy7k3IRqQ7Lc58TUikw7O2rzns1wxa6oWDJnL5iSQdQ0GOmhwWOKyTldmDCLehaecPQL6grZz/w9L87zoMByl+77F3lIgDGrE9sMFHNs2LLikG11R2H80KY2YJE3otL84=;
Received: by smtp47.i.mail.ru with esmtpa (envelope-from <kostix@bswap.ru>)
        id 1o94IF-00061g-Tb; Wed, 06 Jul 2022 15:38:12 +0300
From:   kostix@bswap.ru
Date:   Wed, 6 Jul 2022 15:38:11 +0300
To:     git@vger.kernel.org
Cc:     wuzhouhui <wuzhouhui14@mails.ucas.ac.cn>
Subject: Re: How to display "HEAD~*" in "git log"
Message-ID: <20220706123811.dwbuinnbtxftorae@carbon>
References: <17411d88-b27a-2d20-623d-85c49dc7754e@mails.ucas.ac.cn>
 <20220705092514.hsm7cou5bqvajvgq@carbon>
 <20220705093057.5ewqobdjrqr3ul2k@carbon>
 <a1e53e52-cb08-bbff-f58a-391932707fb7@mails.ucas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1e53e52-cb08-bbff-f58a-391932707fb7@mails.ucas.ac.cn>
Authentication-Results: smtp47.i.mail.ru; auth=pass smtp.auth=kostix@bswap.ru smtp.mailfrom=kostix@bswap.ru
X-Mailru-Src: smtp
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD987C0EE6E7F0A597DE8DF41BCBBF099100D095FC9B0989D88CD62213F67905E7AB8FB265928C9147A3C8C70E900462BF3A23417C815B034D1D64C754CAC7C657B
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE72F22E6DC541F75D9EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637A361B53D384D9D40EA1F7E6F0F101C6723150C8DA25C47586E58E00D9D99D84E1BDDB23E98D2D38B8859CA687ABA27BAFEFDC2BA7DABF654653FC193E0FCD135CC7F00164DA146DAFE8445B8C89999728AA50765F79006377C70927E34808485389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC886A7C529F68B8E5CF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947C5D2C5C0A547CD2CB2D242C3BD2E3F4C64AD6D5ED66289B52698AB9A7B718F8C46E0066C2D8992A16725E5C173C3A84C3BDEAB25F016A82BABA3038C0950A5D36B5C8C57E37DE458B0BC6067A898B09E46D1867E19FE14079C09775C1D3CA48CF3D321E7403792E342EB15956EA79C166A417C69337E82CC275ECD9A6C639B01B78DA827A17800CE75A9E79F66F1C28F3731C566533BA786AA5CC5B56E945C8DA
X-8FC586DF: 6EFBBC1D9D64D975
X-C1DE0DAB: 9604B64F49C60606AD91A466A1DEF99B296C473AB1E142185AC9E3593CE4B31AB1881A6453793CE9274300E5CE05BD4401A9E91200F654B014F749A5E30D975C2025898894730043644B0C0FE0D0742B2FC08F1593422B749C2B6934AE262D3EE7EAB7254005DCED8DA55E71E02F9FC08E8E86DC7131B365E7726E8460B7C23C
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D342F9EE325F82A28A8E420FD7D8C4C8A215B4EBC67598C8E4A9B4C833165ABBB727A7D1BC4008F47F31D7E09C32AA3244C45EB50761EBF9F7A109D9DAD888DACE45A1673A01BA68E40729B2BEF169E0186
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojb+SzFQ2YIi9tIaUt24O/NQ==
X-Mailru-Sender: 641179478317D3F0421D0BEF39CFD138A9BAC6694E513C76A890AA0982A736DC0718431E76E8162E13BA5AC085B0DF3CFD8FF98A8691EE7BAAB64A3C2C77197FCA12F3F80FA6A2FFE7D80B0F635B57EC5FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

By the way, you can consider "going more interactive" with the approach which
involves scripting. For instance, you can use any of the "fuzzy finders"
such as the venerable fzf [1] to interactively select a commit to rebase -
something like

  $ git log --oneline -50 | fzf | cut -d ' ' -f 1

would produce the log of the last 50 commits, allow you to interactively
select a commit of interest by typing some of the characters of its message
and/or hash and then print the selected hash.

This can be easily combined with rebasing: for instance, if you have the above
encantation available as an alias named "select" or a custom script named
"git-select", you could do

  $ git rebase -i $(git select)~

to not even copy or memorize anyting.


I, for one, routinely use fzf to pick a branch for checkout.


1. https://github.com/junegunn/fzf

