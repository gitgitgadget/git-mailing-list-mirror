Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7024BC0015E
	for <git@archiver.kernel.org>; Thu, 27 Jul 2023 17:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbjG0ROX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jul 2023 13:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232798AbjG0RNu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jul 2023 13:13:50 -0400
Received: from fallback2.i.mail.ru (fallback2.i.mail.ru [79.137.243.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED2B3C01
        for <git@vger.kernel.org>; Thu, 27 Jul 2023 10:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=9z9yTBUraCtYdUznQqiK4mZoGx0+HmupeNkLo+C6DrU=;
        t=1690478022;x=1690568022; 
        b=U0OSc+ojnRueGD2mMmfT9sHBEyoYDf39UB9URPOOJz8ojfnh5WiKNECgjmmbt7WSPyPBvyzr/OjPZUVyklesExOmzIeO7ZG16jhVPEAen5ZrHG8LQxsktbYpH8Q2s31KOCEQIwPpKEspSZYW+QMO/hUAogJO1W2fYytMYv15yK4=;
Received: from [10.12.4.2] (port=38628 helo=smtp29.i.mail.ru)
        by fallback2.i.mail.ru with esmtp (envelope-from <kostix@bswap.ru>)
        id 1qP4YV-00Di90-BN
        for git@vger.kernel.org; Thu, 27 Jul 2023 20:13:39 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru;
        s=mailru; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:To:Cc:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive:X-Cloud-Ids:Disposition-Notification-To;
        bh=9z9yTBUraCtYdUznQqiK4mZoGx0+HmupeNkLo+C6DrU=; t=1690478019; x=1690568019; 
        b=XQZSsADLOnSJz/g9xsmt7/DtcQvEeTAhbAy0CvEwwbfHsRQ2iucy0JYzmTgd+qi91jw+J0bePIT
        lFsXwyovFHgVS6YjaPCWFvnvZ/Khhk21JqsDGLtz9ZRm6IHMiyEpiu0jyoBS8wMw18Ay14/N9Paip
        hPBsUOH1N6saJmMi5vE=;
Received: by smtp29.i.mail.ru with esmtpa (envelope-from <kostix@bswap.ru>)
        id 1qP4YR-003M7n-1a; Thu, 27 Jul 2023 20:13:36 +0300
Date:   Thu, 27 Jul 2023 20:13:34 +0300
From:   Konstantin Khomoutov <kostix@bswap.ru>
To:     Git List <git@vger.kernel.org>
Cc:     ZheNing Hu <adlternative@gmail.com>
Subject: Re: [QUESTION] how to diff one blob with nothing
Message-ID: <20230727171334.6qg2xtecvmplg3or@carbon>
Mail-Followup-To: Git List <git@vger.kernel.org>,
        ZheNing Hu <adlternative@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOLTT8R84Zrtpd=j6o2V=Y_uD54XAS5EA7NWHsdfL+XCkD5cqA@mail.gmail.com>
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD9F4F4431F26286E46E0D21A45EF1364E0ECF8B7538A790AE0182A05F538085040385A0D2A052A9F2EDC39667AF829841E02ECF9F314648160E02FB3A2559B9CF0
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE781307CBDB76B677BEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637AAEFEF2B38A4D0058638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D86CE8FEFBA33387095A25630501A96182117882F4460429724CE54428C33FAD305F5C1EE8F4F765FC2EE5AD8F952D28FBA471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F44604297287769387670735209647ADFADE5905B1F04B652EEC242312D2E47CDBA5A96583BA9C0B312567BB2376E601842F6C81A19E625A9149C048EEB28585415E75ADA91B780A39BCC1DD35D8FC6C240DEA76429C9F4D5AE37F343AA9539A8B242431040A6AB1C7CE11FEE3AD74539164518AE5302FCEF25BFAB345C4224003CC836476E2F48590F00D11D6E2021AF6380DFAD1A18204E546F3947C989FD0BDF65E50FB35872C767BF85DA227C277FBC8AE2E8B9F5955FECEF5819E75ECD9A6C639B01B4E70A05D1297E1BBCB5012B2E24CD356
X-C1DE0DAB: 0D63561A33F958A5C9C4D4504C8A060BD2843BB3EDDCFE256316C517E94E872BF87CCE6106E1FC07E67D4AC08A07B9B05E3BF8C76DC23F74CB5012B2E24CD356
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF8404562CCAE594F1D3AA43CCDCAB2639F5B56020782B51A134CAE01C461B0DD2A0D894938C2B729C8B1A62728B433156EE9E4CB6AA6B7137C29D45F0C3C7C8A140B08DDBC5CE87D002C26D483E81D6BE3E087B8B9210330542E373430245901FCC2E138FFB4ACBED
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojbL9S8ysBdXjyD5GaiyWWCZyQq1qaH9Ew
X-Mailru-Sender: 641179478317D3F0421D0BEF39CFD1388480FC2FCBE489CBAB9024A077B7BB4A0090337874FE1BEF13BA5AC085B0DF3CFD8FF98A8691EE7BAAB64A3C2C77197FCA12F3F80FA6A2FFE7D80B0F635B57EC5FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: B8F34718100C35BD
X-77F55803: 6242723A09DB00B4A84B4964F946E17E6426000ECA17D54D35D8F2C7E4284F3A68F3CF0E9FE49B69F7B62D22137510054A9B959648E38FB69B74DA80AC4223A524CB0844F53612C6
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5xhPKz0ZEsZ5k6NOOPWz5QAiZSCXKGQRq3/7KxbCLSB2ESzQkaOXqCBFZPLWFrEGlV1shfWe2EVcxl5toh0c/aCGOghz/frdRhzMe95NxDFd+XxdZzrZy25guBcJEsdz8A==
X-Mailru-MI: C000000000000800
X-Mras: Ok
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>> If you haven't created one, of course it would fail.  It should help
>> to do
>>
>>     $ git hash-object -w --stdin </dev/null
>>
>> before running
>>
>>     $ git diff 00750edc e69de29bb
>>
>
> This is a viable solution, but it's a bit ugly since a read-only "diff"
> requires ”write“ an empty blob.

You could probably just do

  git cat-file -s e69de29bb

to figure out whether a blob is empty.

What is your end goal? Do you indeed want to produce a "trivial patch" which
merely "adds" all the lines of the blob you'd like to compare to an empty one
(assuming the blob conains text)?

