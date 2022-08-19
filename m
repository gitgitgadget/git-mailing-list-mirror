Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC63C32771
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 11:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348632AbiHSLJA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 07:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348484AbiHSLI6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 07:08:58 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F61C2764
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 04:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660907333;
        bh=3b4rUebnI3MYXK9h/Tw5xZg6bD8XCBbdlP6kNq9ZVy0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=e9pQF3pOkzkbGqByGfbqagXHl4EWOkgwHpLM217Rg41E4Kedt4d6T2Q8CeG0egEeM
         Z6s3L1sYu0YMHjcg0+/gYcGNcLx4J3klR8R80KFj73C7lSs/8A26uLBp31P5xQvxMc
         wJHutESLe1UqQ7q5mhuYyDfd77uYBSc9RqFv0IWE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.25.183.122] ([89.1.212.11]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MrQEx-1namxO3Rl1-00oSif; Fri, 19
 Aug 2022 13:08:53 +0200
Date:   Fri, 19 Aug 2022 13:09:00 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
cc:     git@vger.kernel.org, entwicklung@pengutronix.de
Subject: Re: Bug in rebase --autosquash
In-Reply-To: <20220817094909.v2ev4rpsmxjnii4x@pengutronix.de>
Message-ID: <8p78q4p9-9ro4-p5s4-r738-7sno17rqr414@tzk.qr>
References: <20220817094909.v2ev4rpsmxjnii4x@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-374883385-1660907342=:241"
X-Provags-ID: V03:K1:7MNhI1HK3nOENqbBgYEJYojHftPaPgNjQ/0b7iEEF6eLkZqbjym
 CAaXEI8N/aTTgQz4SPg+yfLqrgoIdg4JCu7uC+R5MZpc4AgGoN0l0wMHi6nUTdfUnta9QBh
 McI3ykc83/SFWFc7Ppa07v7rvUNfeuQ01X5pLabMLJJeSyyWpXd2fYpww9JtbHeup0IM63W
 HKqQ5hNT3zwU4e8cTEJUw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YzdlxhL22kQ=:+8iiiDiidOkzh4lAp6UJwo
 mQP0zP0ceAKWqaxmMF1xmyM5oB67ae60lA3lYii6tRuSPesVkIVyWxKrFOe0NOiXeT/goRlyv
 wpn3arnZiFiJSVs8ZiGQXkwZ6f8IQJSyc7XDm8fPuFqGu1W1TdT1GVPDOhTv/CA8ybKze5fzN
 Nzr22hBJoKKoLFojGQDLhQdPqBlIVStA1vSA/43Y3diTN5hPxrD3SlEd1siODFymwhIrFXxd1
 Lsdu0orPDGAwH2uPr+W3efg+xAky5OOqQl+F4aBw7T8zVK1S1C4Qw04XqfLJC0wCLWZBcXNw6
 v4WGdNwJ5OMbfS+VYlqCH0jmu6Z/Cx9KZ6IPuhx3dwDFYLQI30xTdWJt/WFgiyZJ1ibzl1MiA
 VYNQ62F8QemLPZYv6uLNcXLQlY2+0s18hVL5EgW1BPpVuZ5J49Ja0ZDkn+Rf+Mb+h8MZh+3HP
 H3DvgzhynpDHYfnGCWf9gSuYS9FNRB1vW7aj57ERtNALngtylNLX0woNPciDmnSM9+mUs/9dC
 1texngRJxvs+WBfMiiWDkYZY56Q8u7T23b5rnCjl93qbD6XVf4wg35tMV8DkEThfPCqQkzq22
 OahiV1pEc40r9TgtjrA9MUhurLuRk+U782rLJMfpL7pRxdlHQsj9q53ySBbHguEMDeHhmbeAG
 IVLwaZQLi44aj2lnFBXbBgW22uY+fXkIWb8IGf1GhhNBHqumdTnzARlv0Z/MpoUs0G+ST/OEC
 OFbgCajF47zVU+bNVyI3JxW7xY9496463I/dqA2LsNl8HPykjytifLyhCoukkijd9HfpPoFWh
 QE729GlN9hjvFV0I6WOFhi+UDfTa8djwFN030JNgL6z3rtX5s9BX2b0pA7Luxubsj5GW4SHXa
 0QB8KYtGeXzUcMOzLQeLqzjvX9NKtJL/ECWylLkRLVoisGWkT0gWLDg9QpoBYls0xTO6fgde1
 2HiQ4ujYgciaRnSeB+FgLw8yQR5fW9DXwXVNiDgOnM4MbJlbSxmvq0KyCu/h8P4V4BqRAx5Xw
 1kEmfDxwEy9cX2z/o1/Gxw+NDDCahQo6UlnA0Vb0uayGBO56JV/gWnLGyfsV+zxDCvZa9m3eV
 YaDPKxGeyUCaEAdAyIbQLVykNSvhCA8XNI9ntIrMfEvpRGFQPxtra2HXQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-374883385-1660907342=:241
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Uwe,

On Wed, 17 Aug 2022, Uwe Kleine-K=C3=B6nig wrote:

> after:
>
> 	uwe@taurus:~/tmp/git$ git version
> 	git version 2.37.2
> 	uwe@taurus:~/tmp/git$ git init
> 	Initialized empty Git repository in /home/uwe/tmp/git/.git/
> 	uwe@taurus:~/tmp/git$ echo contnt > file
> 	uwe@taurus:~/tmp/git$ git add file
> 	uwe@taurus:~/tmp/git$ git commit -m 'file with content'
> 	...
> 	uwe@taurus:~/tmp/git$ echo 'content' > file
> 	uwe@taurus:~/tmp/git$ git commit --fixup=3D@ file
> 	[main ef8f0bd27a56] fixup! file with content
> 	uwe@taurus:~/tmp/git$ echo 'more content' >> file
> 	uwe@taurus:~/tmp/git$ git commit --fixup=3D@ file
> 	[main b40a214bf5fb] fixup! fixup! file with content
> 	 1 file changed, 1 insertion(+)
>
> running
>
> 	git rebase -i --autosquash @~2
>
> my editor presents me with:
>
> 	pick ef8f0bd27a56 fixup! file with content
> 	pick b40a214bf5fb fixup! fixup! file with content
>
> However I would have expected
>
> 	pick ef8f0bd27a56 fixup! file with content
> 	fixup b40a214bf5fb fixup! fixup! file with content
>
> instead.
>
> Is this a feature I don't understand?

This demonstrates a somewhat obscure feature where the `fixup!` of a
`fixup!` magically targets the original commit.

I understand that it is somewhat unintuitive that `fixup! fixup! abc` does
not target `fixup! abc` but instead `abc`, but that's how the tool has
been behaving forever.

Ciao,
Dscho

--8323328-374883385-1660907342=:241--
