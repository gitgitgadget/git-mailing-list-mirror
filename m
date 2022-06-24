Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03250C43334
	for <git@archiver.kernel.org>; Fri, 24 Jun 2022 09:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbiFXJ4V (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jun 2022 05:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiFXJ4T (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jun 2022 05:56:19 -0400
Received: from fallback10.mail.ru (fallback10.mail.ru [94.100.178.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2E47A188
        for <git@vger.kernel.org>; Fri, 24 Jun 2022 02:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=jIO3h5pA4uwz95o9l2cdsMEbIrxMJyRGQb2p4zjTs34=;
        t=1656064576;x=1656669976; 
        b=YN34okQU63BHRLiWQWmrzWAUnoReaKQ9DXUx+V3L2aO/TBmyhdEC6ErB3Rs5D7yqqQM8e2Ju5qWQuVzeGE+t4yaXgme/QASsouvbUEr1RGeu/3slCJrq5MBHJ6OnLH2u8lg+jPgNWImK6FAvDAUZTuXhpiL5ebb9bY0yvUjbLJg=;
Received: from [10.161.64.1] (port=56408 helo=smtp30.i.mail.ru)
        by fallback10.m.smailru.net with esmtp (envelope-from <kostix@bswap.ru>)
        id 1o4g2v-0000tP-Ur
        for git@vger.kernel.org; Fri, 24 Jun 2022 12:56:14 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=jIO3h5pA4uwz95o9l2cdsMEbIrxMJyRGQb2p4zjTs34=;
        t=1656064573;x=1656669973; 
        b=iy8lAxUOt8ACB7hxodvxvWvd8+IK+T5YLUiHSRGdU/T4S2FC2dsU09Pz5lvJvFakMnVxptj3N696klRF1NW8RoJqEan5ty5RIlubp0MDjqBdNpMXAcftajjAqJ6QRFa/3+NAZsipeAF1yTIn0H/xCOrwVx/cCkjZlDeOg11jPro=;
Received: by smtp30.i.mail.ru with esmtpa (envelope-from <kostix@bswap.ru>)
        id 1o4g2h-0005vB-7R; Fri, 24 Jun 2022 12:55:59 +0300
Date:   Fri, 24 Jun 2022 12:55:58 +0300
From:   Konstantin Khomoutov <kostix@bswap.ru>
To:     Tim Chase <git@tim.thechases.com>
Cc:     git@vger.kernel.org
Subject: Re: stashing only unstaged changes?
Message-ID: <20220624095558.hegsfj4e4nbqyooo@carbon>
References: <20220621142618.239b02cd@bigbox.attlocal.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621142618.239b02cd@bigbox.attlocal.net>
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD9EAB0F1B3E0C6ABD3C7CFBE7CBF6438BC9F562BEF79E3C4D9182A05F5380850406B9443FE1CF710D11E0846D19C5D2CBEB915CDB394906107ED63E94A470BA62A
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE79EDB57D1FB735487EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637AC20F58FBAB79054EA1F7E6F0F101C6723150C8DA25C47586E58E00D9D99D84E1BDDB23E98D2D38B8859CA687ABA27BA0A6346077905A692603DE4BD94D10216CC7F00164DA146DA9985D098DBDEAEC8C6602A96AF88C695F6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947CEB7D890E3377C531302FCEF25BFAB3454AD6D5ED66289B52698AB9A7B718F8C46E0066C2D8992A16725E5C173C3A84C3776FEBA3834A766EBA3038C0950A5D36B5C8C57E37DE458B0BC6067A898B09E46D1867E19FE14079C09775C1D3CA48CF3D321E7403792E342EB15956EA79C166A417C69337E82CC275ECD9A6C639B01B78DA827A17800CE7B2B7C64F398C7410731C566533BA786AA5CC5B56E945C8DA
X-8FC586DF: 6EFBBC1D9D64D975
X-C1DE0DAB: 9604B64F49C60606AD91A466A1DEF99B296C473AB1E14218AB90C9657ABB7B6A7866D6147AF826D8CF79D4C980A0524DDF9B65C6F3804218F972CCD2F8FE1EF1CFC4036BBF6A4EA9B11811A4A51E3B0915E2725BA614EAEA1EF972C1F679AE1C
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D34B5900AD87B4159A46C871361E79489D255266C4E106BA3A50797C0C76246A19D2B5ECB41297D9D351D7E09C32AA3244CFFD582BA8A02B61C264DE54C60C5D9D9A95CA90A1D8AC565729B2BEF169E0186
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2bioj0at9oz1ZZJ+8Ol+Jm2KPwQ==
X-Mailru-Sender: 641179478317D3F0421D0BEF39CFD13872555BE08B374573A063991B31614C1C42AB7DCDE6D2297013BA5AC085B0DF3CFD8FF98A8691EE7BAAB64A3C2C77197FCA12F3F80FA6A2FFE7D80B0F635B57EC5FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4BDF5E74846557DC3CAE16748E613E3C6C969570AAC23ED9E68F3CF0E9FE49B6998681B48DFE74FB7ECABA94A80EE097CC0F5664BD082840548A82C7497C04E42
X-7FA49CB5: 0D63561A33F958A52B01E93DD65C2AE84CDCC4A8DF370F4E256E1DE19D4B1FD18941B15DA834481F8AA50765F79006370A2DD59B67EFEE27389733CBF5DBD5E9B5C8C57E37DE458BD9DD9810294C998ED8FC6C240DEA76428AA50765F790063776C4598447C51BFFD81D268191BDAD3DBD4B6F7A4D31EC0BEA7A3FFF5B025636AAAE862A0553A39223F8577A6DFFEA7C5351985B4A98E2A443847C11F186F3C59DAA53EE0834AAEE
X-C1DE0DAB: 9604B64F49C60606AD91A466A1DEF99B296C473AB1E142185CC3A6ABCA23326F7866D6147AF826D89CD03451529C043E258E2A179D1F906BF972CCD2F8FE1EF1CFC4036BBF6A4EA9B11811A4A51E3B0915E2725BA614EAEA1EF972C1F679AE1C
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2bioj0at9oz1ZZJ+NkI+HyUrJyA==
X-Mailru-MI: 8000000000000800
X-Mras: Ok
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 21, 2022 at 02:26:18PM -0500, Tim Chase wrote:

> I recently had composed a commit with some `git add -p` leaving some
> portions unstaged. I wanted to stash the unstaged changes to make
> sure that the staged code ran as expected, so I did  a `git stash`
> only to find that it unstaged my staged changes and stashed
> *everything*.

I tend to rely on reflogs for this.
Basically, I roll like this:

 1. Stage the necessary changes, commit.
 
 2. Stage the remaining changes - what you've left unstaged in your case, -
    commit.
 
 3. Go to the commit I need to test; in this simple case that'd be

      $ git checkout HEAD~

    Then test the changes.

 4. Go back to the previous state using the HEAD's reflog:

     $ git checkout HEAD@{1}

If you now need to have the situation where the changes committed on step 2
are left only in the work tree, run

  $ git reset HEAD~

so that you have the HEAD and the index reset to the commit recorded on step 1
with the changes from the commit 2 left in the work tree.


Having said that, I'd note that I tend to do work on the detached HEAD
but you could apply the same logic to working on a a branch.

