Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07AD51F4F8
	for <e@80x24.org>; Thu,  6 Oct 2016 00:43:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751581AbcJFAlC (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 20:41:02 -0400
Received: from mail-yw0-f172.google.com ([209.85.161.172]:34068 "EHLO
        mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750873AbcJFAlB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 20:41:01 -0400
Received: by mail-yw0-f172.google.com with SMTP id g192so3793467ywh.1
        for <git@vger.kernel.org>; Wed, 05 Oct 2016 17:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9TeDrfkY48akXViwdStjjGlGLUcabhydteMA+0y6bKY=;
        b=bATstC8XM+BFUoBXedYOODjt5/6Ft1vnKCC7SxkLVDbS8MjZAjM4I6MwroCwB1Ec/A
         XsKf3l+GP5P0fmBh5Hoa7FOixeo8p9sFsgCbPMkLanM5cKM9MlBfNX+1h62ipKrgpDXI
         CYZeb20nG18O2lIuYnpP2/8LsgGY/jduWKBk4tZbQWuMU5k90U1IaSR55OxArAOREkTS
         cUEeZzq4xt9TPB+uSDijuafKeW+LceMTYJYs7o0gN2NWlraJhEMVCE4FQEC9QSxK+GVc
         5xbynXp8DRxSRiWJf+ZVuPSnamWGxnEk5/vYP4g/UinFvTb7YmtE1rotuPXtVmfY6Z6c
         u6aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9TeDrfkY48akXViwdStjjGlGLUcabhydteMA+0y6bKY=;
        b=Mz+WyhBDQHF5NAKUHfZsLX3CqB7ZjK7DipDQn9I2PDV4iAcT+C7znoizDraHv/1mpP
         ed+a2QHJTuzjqba92gPbGkcHlD+YiwWj3HvfXRLPiy2VrnKJAw4pqg60fQpzWKq0VlsP
         +7OYeC58BwzIUP/n21z+kSbTF/Rsq4yiAi3pMBS2J/G3JvIBmD5O2KmmQ/mQQk+yGDJO
         nH/ih64VRvs8i5NG3FCjU8bc+08+9Rtt29rDlptTVpWYb5f/L/ho/E8ZukvQ/pLR1OQE
         WZiz664Rt+WSxlATBEZUcwxRb/q2ZJ+I9hCnf2+D0Nh1Zx+XM7SgwqHqFyJj+/FOAMGz
         w/dA==
X-Gm-Message-State: AA6/9RmWIKTVSEBo+CU1IeWxXJMg6AshxYuvGipq+u1XAwCfjxMs7ERT+b0LHgzkOUd+V7ewKN8LNAvdMv9XRA==
X-Received: by 10.129.76.194 with SMTP id z185mr9643875ywa.257.1475714460374;
 Wed, 05 Oct 2016 17:41:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.96.195 with HTTP; Wed, 5 Oct 2016 17:40:39 -0700 (PDT)
In-Reply-To: <xmqqwphmmoi6.fsf@gitster.mtv.corp.google.com>
References: <20160906214550.Horde.ducOghtmsQb9pQ6lixxddVz@webmail.informatik.kit.edu>
 <20160907151251.30978-1-szeder@ira.uka.de> <20160907151251.30978-6-szeder@ira.uka.de>
 <20160907174841.Horde.Ru1LBEeLKomznlWVG-ZnS-Q@webmail.informatik.kit.edu>
 <20161005033353.Horde.33pf2naqnF4HgwPWSy9DaHV@webmail.informatik.kit.edu>
 <xmqq4m4qrapv.fsf@gitster.mtv.corp.google.com> <20161005232609.Horde.VetzEIKHDJUdcaOod9sHxuK@webmail.informatik.kit.edu>
 <xmqqwphmmoi6.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 5 Oct 2016 17:40:39 -0700
Message-ID: <CA+P7+xr4tYG6xoq4jTSxWyoQBwJSfZp7z=2BstTgaBSsgrs5+A@mail.gmail.com>
Subject: Re: [PATCH 5/5] versioncmp: cope with common leading parts in versionsort.prereleaseSuffix
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
        Jeff King <peff@peff.net>,
        Leho Kraav <leho@conversionready.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 5, 2016 at 3:15 PM, Junio C Hamano <gitster@pobox.com> wrote:
> SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:
>
>> Gut feeling tells me that I should take this as a subtle
>> encouragement to look into adding 'versionsort.postreleasesuffix',
>> shouldn't I ;)
>
> It is more like "this made me realize that these are merely 'suffix'
> after the real release name, no pre- or post- about them", also
> known as "I think PREreleasesuffix was a mistake and we weren't
> thinking clearly enough when we added it."
>
> To me, this looks like a list of possible suffixes that can include
> an empty suffix to denote "the real thing", e.g.
>
>     versionsort.suffix =3D "-alpha" "-beta" "" "-gamma" "-delta"
>
> and that position in the list determines the order of things inside
> the same family of versions that share the same "non-suffix" part.

This is what makes sense to me. Perhaps migrade to "releasesuffix" and
deprecate "prereleasesuffix"? I don't think that's too painful
especially if git accepts the old value and warns about it's
deprecation? That or we can just stick with calling it pre-release and
they sort based on order with '' being the empty value?

Thanks,
Jake
