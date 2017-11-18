Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAC11201C8
	for <e@80x24.org>; Sat, 18 Nov 2017 20:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423427AbdKRUc1 (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Nov 2017 15:32:27 -0500
Received: from mail-ua0-f175.google.com ([209.85.217.175]:46765 "EHLO
        mail-ua0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423422AbdKRUcZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Nov 2017 15:32:25 -0500
Received: by mail-ua0-f175.google.com with SMTP id 21so3605081uas.13
        for <git@vger.kernel.org>; Sat, 18 Nov 2017 12:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BU8Kg+ArWHkwmFll7Sqcy4rQYXYBBD+ixQS+UIQvJC4=;
        b=Kpq7EU7S0nOLkLBHEEig6mBvyipXCfBB38MLEuprFKKvTELdOvu9Loa2bgpIXD4od9
         nMt/GgtLX5qQVM2Dk0HGRxPUynC5QiKof84vgWNNaC4sjCI6P8to47+M8kFY9AclaRk3
         MXQE0lADtf24mf1hyXHxdmoTP36wPdrI+eb0ln+Laja5D4U+hGBY0rq4W5aSjtfSMcAS
         dmw6FJnVt06wEytV4O8cSu9Vr4bl2IxN2ZR3vicmwxp8QyccfGeW66fTWeV6uqjILG1B
         mqMMAURIpOMbKDgkSXRQjGnwbUBAzpP+XDSjWJOGAMcuCxc/l7/O1k5npWGFmHS2eJGP
         KypQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BU8Kg+ArWHkwmFll7Sqcy4rQYXYBBD+ixQS+UIQvJC4=;
        b=qqOTOcVyeHZJiQUh+UnLt6BDUHxBGD0PrrmE6jimFeCiejD4iBaL3xIDQfnKB/7C10
         X9zghblUq/z3g0zr32ZJoGF7Pk0KN7iAzY9c62MKwcd6fQ/N8roKjIFXlG3jXJucdFHk
         8cJP5HuMYY2S/WqBK2hvIl60rUtlBBNxuECmrEqSU7U0ply61m1SWfKJkAObaRpC8Z29
         QTj6h5+z9OYcRJb3DN2kyRrB6H1qEou55PJTB+NdEQfX2HqcKaROZGY9CYaAs5g+PGSh
         zMV6d4ZcunzwWKWFYSeDMOn84GScu70Rc5cwgVnpIQnCVxekQ9nvSJiUZjHBevxUDGWE
         /wtg==
X-Gm-Message-State: AJaThX57XkeNmFsr1AnrSKQyrIoimyPbto8poKT8N7EMT/mne5HFEdrE
        BoFH+jX5fyo5OpjjAzbI2fJraBiB/mJaGJFHB5Y=
X-Google-Smtp-Source: AGs4zMa8QV/S8bvCKCjPH5Hmqq4e8rKuh+M6l1F0FzaC0u1ShHoBUZcn1oZoAT1u5HRt7pGUlNc6iVzYbnhDLx08YFg=
X-Received: by 10.159.49.234 with SMTP id w39mr7674484uad.133.1511037144871;
 Sat, 18 Nov 2017 12:32:24 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.70.73 with HTTP; Sat, 18 Nov 2017 12:32:24 -0800 (PST)
In-Reply-To: <20171114194718.GY5144@zaya.teonanacatl.net>
References: <20171114093402.29256-1-slandden@gmail.com> <20171114194718.GY5144@zaya.teonanacatl.net>
From:   Shawn Landden <slandden@gmail.com>
Date:   Sat, 18 Nov 2017 12:32:24 -0800
Message-ID: <CA+49okpfdzFwB32VksO4nQJX+enc2MZzg8=xkeFgUEHhGvEBjw@mail.gmail.com>
Subject: Re: [PATCH] sha1: add gnutls as a sha1 provider
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 14, 2017 at 11:47 AM, Todd Zullinger <tmz@pobox.com> wrote:
>
> Hi Shawn,
>
> Shawn Landden wrote:
>>
>> I think this is preferrable to bringing the assembly routines into the g=
it code-base, as a way of getting access to these high-performance routines=
 to a git available in Debian, Ubuntu, or Fedora (which all use BLK_SHA1=3D=
1 due to GPLv2 + OpenSSL license considerations, see Debian Bug #879459).
>
>
> While it seems like it could be useful to have the choice of using the fa=
st SHA1 implementation without concern about licensing issues, there's a fe=
w details I thought were worth mentioning.
>
> Fedora moved from OpenSSL SHA1 to BLK_SHA1 to reduce the size of the bina=
ries and dependencies, not due to licensing issues (Fedora considers OpenSS=
L a system library and allows linking GPLv2 code).
>
> Fedora now uses the default DC_SHA1 (the collision-detecting SHA1 impleme=
ntation).  DC_SHA1 is not, as far as I know, as fast as the OpenSSL/GnuTLS =
SHA1, but it's safer given the increasingly successful attacks against SHA1=
.  I don't envision changing that to gain performance.  (And, of course, th=
e speed of SHA1 should become less of an issue once git moves to a new, str=
onger hash.)
>
> It looks like the Debian packages use the default DC_SHA1 implementation =
as well.  Regardless of the licensing concerns regarding OpenSSL in Debian,=
 I suspect they'll want to use the default, collision-detecting SHA1 implem=
entation.  That doesn't mean a patch to add the option of GnuTLS isn't usef=
ul though.
>
> Fedora does link with OpenSSL's libcrypto and libssl in Fedora for the re=
mote-curl helpers and imap-send.  I believe the remote-curl helpers just li=
nk with curl, which happens to use OpenSSL on Fedora and could use GnuTLS i=
nstead.  The imap-send command might also use curl and whatever crypto libr=
ary curl is built with too, but I'm not terribly familiar with imap-send. (=
I think those are the only uses of libcrypto or libssl in Fedora's packages=
, but I could be mistaken).
>
> That's a lot of text without having anything to say about the actual patc=
h.  Hopefully it's at least mildly useful to you or others. :)
It is all appreciated. I just want to make note that I am still
interested in getting this patch in.
