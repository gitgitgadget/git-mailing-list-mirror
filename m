Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6717EC433EF
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 05:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233978AbiDFE7w (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 00:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1585650AbiDFAAH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Apr 2022 20:00:07 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B215EDD7
        for <git@vger.kernel.org>; Tue,  5 Apr 2022 15:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1649197338;
        bh=QR1w2KG3H4W7rBfZzLzUPRw4mGnL586qDqxdNAdiQbs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=AKHe4R8PzlK+RYTsmW/gMoDR7+MIbLx93x0Os4inAKLnuEi7TgUoumobQJ5JpFfA9
         252VKPv71A6hgw+At6Wkat27dV2Bcuw3fhoKsc4K5ysnmGImqQqkLPqhIL12nivlI/
         PwtXgkNpjcqyQXuhvthjnoyezuodtdimrlZkt7mQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.21.56.235] ([213.196.213.50]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M3DO3-1nYql522Kz-003dcu; Wed, 06
 Apr 2022 00:22:18 +0200
Date:   Wed, 6 Apr 2022 00:22:16 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Theodore Ts'o <tytso@mit.edu>
cc:     Junio C Hamano <gitster@pobox.com>,
        Markus Vervier <markus.vervier@x41-dsec.de>,
        git@vger.kernel.org
Subject: Re: Covierty Integration / Improvement
In-Reply-To: <Ykoqxx40Fk0DiF9i@mit.edu>
Message-ID: <nycvar.QRO.7.76.6.2204060019300.379@tvgsbejvaqbjf.bet>
References: <10fd679a-eb94-5380-2070-699f1b56a7b1@x41-dsec.de> <xmqqbkxhvoh5.fsf@gitster.g> <Ykoqxx40Fk0DiF9i@mit.edu>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:skj5IASTMpQ8uuBbLqvzdHnUDayUu7EiG/GwnBfdSPsVNXBfA10
 O3Ow182Ki9/dx1F4c1fW/Tg1KQQ3FXfi0tcI7qkJGxGCyYg7eXD3jSTsBq72xE9/N4Ccp4p
 fzBQRdxVeAyAwrQT17QVcyZ3mlMBNRGwz4XSZkF1JVBJuh/S04RgXNea1cYP8Q6tsTxG1si
 TOG5/lZI3Oelz90yZz9pQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:o49c8bpJka4=:2GBnwB1wG7vyuxrWooek0Y
 dutrX6ZeO3EGGEC3J6DIaH6GJG/B2r5IihPZtRMB6yb8z55s1bA3pFeZ6NX6TK2m93zqA0fZD
 HTk5sxD0IEo+H8R9AaIHRCubymEcGOU2YRS5t/Xb+ayaERgmIf0dafxKhAJp5PToWWseWevjI
 3kmYdmtH22S4NSN9qiec50pTZ0oX2uQoudCv93fJb1/3Cytf5CGxrsWwHzu6hoMXmbgho0exF
 MLJg3zTXd2b0hcCJSaGBkvnXQm4E+tPSaXJNT7PZphqeUZZud3mQAvNp9gzEpu09ZhW0jHtSk
 4iAJbvTjhulAMH1pymQOL4TSLdd8cTkvmCMpNdfRryIqdyeY5mBCPQs10izWe5uzxFnhv1nPW
 Sw+HQr9expM0ZxivoPNNSJd2rWLAd9xES+kfV3kYCAmxADKt0GdmaK3cSs0Xlz1o2IObdhXKp
 DYGvZkV7W3HSQOwd54REOpt4SJCM1zfFI0+fWYprJIx1RDVqpo5AT4X8bEFp9CB6tf3J/fNVb
 6TzcO0sTzm+ux+P03nWx+xmYb2VmUJTwSt35dayxbXp4kD1JetEsF0dsExJlPQZcnykQyepJb
 RD5UQjVgL11CGGV51v1RSm3il+V6iKleAfH0D8DhKEyD5E/rc/JihyZYAZDopM3Zz1Hfh1jnC
 VESMt95Q9aBEO1085cWEnf5BzD4+QG72eRQICaCvu/zgX5y7gjag/28ninn18pT+t428b441l
 nFxctGVBcdpeEAFtoNYLrdeGGhFxFZHO4R+I/HORogokHRp9J6OitGhZR1LEqBAyuNiFHojKn
 CAshpQL0/EsSqYB6ZKqeQFhxNZEvyEp3swu2KYJK1IDlM4ArLZdSYTpdzdvXudO72pub12kW7
 ZAWUc0zP3s5PkvA01oUTwVKCUf4TsVgL6laTxELNuINVKpTvhWHJ8Am5U+vjm7lUeDHNMXyI0
 tQmpdM9SbGBEYxgcojEgWTMq51GJ90EDR6HAduDPV+idR5JEF9jXY7tLSU9RwFijydyKUxyBA
 f8lQgaOdyqIqk5fjAOjiKnpZte0aZtnMCTYCcP8Hu7d9O6tqeAfYYP52Azhth39ZV5wo+njtV
 DP7VJd//cWskFo=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Theodore,

On Sun, 3 Apr 2022, Theodore Ts'o wrote:

> You do need to be the project admin, or someone authorized by the
> project admin, to upload new data for Coverity, or to look at the
> analysis of the Coverity results.

To be precise, there are a couple of roles you can have, one being
Maintainer/Owner, another being Contributor/Member, yet another being
Defect Viewer. IIUC contributors can upload new data.

> I have no idea who the project admin is for git, but I'm sure if you, as
> the Git maintainer showed up and requested to be added as one of the
> project admin, the open source ombudsperson (I don't remember the exact
> title, but they do have someone who interfaces with OSS projects), would
> be happy to oblige.

Junio is already a member. In fact, I bumped him up to be admin :-)

Ciao,
Johannes
