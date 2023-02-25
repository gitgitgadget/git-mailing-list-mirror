Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E9DC64EC7
	for <git@archiver.kernel.org>; Sat, 25 Feb 2023 21:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjBYVqT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Feb 2023 16:46:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjBYVqS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2023 16:46:18 -0500
Received: from smtp30.i.mail.ru (smtp30.i.mail.ru [95.163.41.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E78C15547
        for <git@vger.kernel.org>; Sat, 25 Feb 2023 13:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Subject:To:Message-ID:Reply-To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=vdTEVKlCVQBgORgRH5SCW7WQZN4sc6309sx63ztE1OY=;
        t=1677361576;x=1677451576; 
        b=rKcILcanwiYMANZJX21OuSwuFFvXSaqfjmf3BqEfBfxlXUGwkK0K1jqI0Q62OWXRSxo7eUNX/OVZTfGz8kuH3/y9KKPWa0a5iZuq4n5DiL0AFrMExMmkKyWKaOwpPGDF2KREf0MakaSJszcy4s5B5OIKelOb9Vx4deCxs/NkBrXyMS3plKNsLoCfszxvWt7GCBjZhukR3LJt/3Te8tGyxIBurE610pNtcHB8F5i+k74IBWYWzL+7fuaxEqvzE2FK595Do3ieeBoaBXUPvHCgk34xX5prN43TyShZxDiRgB215Fmh0WkdCpNvuvm38Beve0PwX5b7OB9pemKNBoMOtw==;
Received: by smtp30.i.mail.ru with esmtpa (envelope-from <andry@inbox.ru>)
        id 1pW2Mv-006sM6-Gk
        for git@vger.kernel.org; Sun, 26 Feb 2023 00:46:13 +0300
Date:   Sun, 26 Feb 2023 00:48:08 +0300
From:   Andry <andry@inbox.ru>
Reply-To: Andry <andry@inbox.ru>
Message-ID: <1212192063.20230226004808@inbox.ru>
To:     git@vger.kernel.org
Subject: Re: Get rid of `warning: refs/remotes/origin/master usually tracks  
  refs/heads/master, not refs/remotes/origin/master`
In-Reply-To: <942870379.20230223062101@inbox.ru>
References: <942870379.20230223062101@inbox.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp30.i.mail.ru; auth=pass smtp.auth=andry@inbox.ru smtp.mailfrom=andry@inbox.ru
X-Mailru-Src: smtp
X-7564579A: EEAE043A70213CC8
X-77F55803: 4F1203BC0FB41BD94A31EA4B0797EF2EE50B5111BED4E5A0F9C3BE6961C3C823182A05F5380850404C228DA9ACA6FE27DD2EA45544DD3DC8C46B6DB6D1ABAC466B8F247CA0C61165C67594D95E288F56
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE728F774C865CF4B07EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637EF59B520676799BC8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D859039F385DCE88C6608F18DCB6C785296F9789CCF6C18C3F8528715B7D10C86878DA827A17800CE75A64D9A1E9CA65708941B15DA834481FA18204E546F3947C36C7B98ACBF5D372F6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F790063776E46105EEFD4098389733CBF5DBD5E9B5C8C57E37DE458BD9DD9810294C998ED8FC6C240DEA76428AA50765F79006370897606EBF572EC9D81D268191BDAD3DBD4B6F7A4D31EC0BEA7A3FFF5B025636D81D268191BDAD3D78DA827A17800CE7A87E5801AFC99F00EC76A7562686271ED91E3A1F190DE8FD2E808ACE2090B5E14AD6D5ED66289B5259CC434672EE63711DD303D21008E298D5E8D9A59859A8B6B372FE9A2E580EFC725E5C173C3A84C35D1D84EF68E022EA35872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D344EF254DC71474AA3ED5042160BB45F970F0F698CED880D2BD539B8C376CBE902A4FDC0986AD573381D7E09C32AA3244C80ABA148A303BB3C5D9CB7AB7BB5970E259227199D06760A3EB3F6AD6EA9203E
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojEITt8lw84mfaF6rFA4zw9g==
X-Mailru-Sender: DC3EB4EBD01594E4BED89F5F1533D14E9A7165082F1B7689C46B6DB6D1ABAC463375B3D8D59482FA58EE59803C9A990DFB559BB5D741EB96FE679880309AA8C36F53C80213D1719C67EA787935ED9F1B
X-Mras: Ok
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Git,



Thursday, February 23, 2023, 6:21:01 AM, you wrote:

A> Found this issue and could find a solution.

A> ...

A> Is there a way to unmirror the remote repository back?

Seems the problem was in the logic of the push algorithm.

There was 2 fors (pseudocode):

```python
for remote in remotes:
  for branch in branches:
    git_push([remote, ':refs/remotes/' + remote + '/' + branch])
```

Instead of 3 fors:

```python
for remote in remotes:
  for ref_remote in remotes:
    for branch in branches:
      git_push([remote, ':refs/remotes/' + ref_remote + '/' + branch])
```

Because each remote has `num(refs) = num(branches) x num(remotes)` after the mirror.

