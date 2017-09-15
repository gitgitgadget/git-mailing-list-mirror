Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFE7F20286
	for <e@80x24.org>; Fri, 15 Sep 2017 11:24:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751269AbdIOLYw (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Sep 2017 07:24:52 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:51497 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751207AbdIOLYv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2017 07:24:51 -0400
Received: by mail-it0-f45.google.com with SMTP id o200so3227349itg.0
        for <git@vger.kernel.org>; Fri, 15 Sep 2017 04:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qF6fGo1e78Waoqr4pdFR/C2HjLg0vQqtkxEhXUfTpcg=;
        b=iMQmORYtGMAUPyCcpi+cckk3p2zxayhog9DJOb8swwGKKgxouOdckgTjfX9uI8KMJe
         jLaYCxB4sAeRe29VKu9fpohLD+ZEu0j02YyLVNAZKfPSuoAkfpXevOHVKQHc2vcNPHMt
         7EmNZsX2VFZ9nf/G3/hGvNgzY+9sjzXg26NRIDbcFtxVR0gF/nBihOTYrusNVOzwufIo
         Mrvj2MT0hcGjOdaKEUpJx8x9lciAcRd6dDkpg2yh+5Ezpkl8ML4FzhmNMAhoKXuaru01
         O2Br+NtDmugwuH7LM2MNdLuhPt8VSeGw3W7eJzjW7D6JEP44rxS/ytlJwyfwz92TNjs+
         vp3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qF6fGo1e78Waoqr4pdFR/C2HjLg0vQqtkxEhXUfTpcg=;
        b=hFIEAQ6exKtouIZH6lGCVf9mgEZiJjvJpAzLWpJpQB9migVWIH3Iya4rnSJlre+GQW
         +5qC0DP4jDspMODxadEvBXQthawmlkv8A9qlrPqhQQn1R0S7KvuWWUkXLIJkVPy+V6+e
         dMnlyqyVSwPsCnB+yo9Yq0IBe1Ep4V8UZjIlyIXQwC9DrUBApaW/aBH1Puv+H1EYjm5a
         TLPAc2Kis4jJxoxWD6a3tNZUrUdaGhab8kVi4f4Wc2qVeV+ryJ7GpMkPx/mj526Mxs8v
         mWwsyGnNiKeySTddw+i81qjCS3tdKsZxf8gWjtghLpGhLT1d2+wCOwwcKQwvMNEx0QVe
         KTXA==
X-Gm-Message-State: AHPjjUhiQsyEJtMVtvDt2+KynELzmDxxoxsBuMynU2x5CCaLuJQc2XrO
        KXhm7GxyE5gI8/4WS8ok4kw/6txBzRwhDMBXPk0=
X-Google-Smtp-Source: AOwi7QDaXkP51qkaKV+qsn2FgUt9RA2uBZJ41FbuSNk6tOEiE3b5Kj3crca3VWZcDU2yBr6/ol6BHzwJnjCM9opkSjc=
X-Received: by 10.36.185.12 with SMTP id w12mr4609274ite.67.1505474690974;
 Fri, 15 Sep 2017 04:24:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.107.136 with HTTP; Fri, 15 Sep 2017 04:24:50 -0700 (PDT)
In-Reply-To: <20170914111945.62741763@twelve2.svl.corp.google.com>
References: <20170803091926.1755-1-chriscool@tuxfamily.org>
 <20170803091926.1755-26-chriscool@tuxfamily.org> <xmqq4ltowcrz.fsf@gitster.mtv.corp.google.com>
 <CAP8UFD36yZEU4OM_+u6HkC=Ep1JifXm-ir0+CeJ3=dR44QceoQ@mail.gmail.com> <20170914111945.62741763@twelve2.svl.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 15 Sep 2017 13:24:50 +0200
Message-ID: <CAP8UFD0-myJuhBQhZoBiQ6cE4FEkzzuro-sZeDfCN-HK_LxriQ@mail.gmail.com>
Subject: Re: [PATCH v5 25/40] external-odb: add 'get_direct' support
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 14, 2017 at 8:19 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> On Thu, 14 Sep 2017 10:39:35 +0200
> Christian Couder <christian.couder@gmail.com> wrote:
>
>> From the following email:
>>
>> https://public-inbox.org/git/20170804145113.5ceafafa@twelve2.svl.corp.google.com/
>>
>> it looks like his work is fundamentally about changing the rules of
>> connectivity checks. Objects are split between "homegrown" objects and
>> "imported" objects which are in separate pack files. Then references
>> to imported objects are not checked during connectivity check.
>>
>> I think changing connectivity rules is not necessary to make something
>> like external odb work. For example when fetching a pack that refers
>> to objects that are in an external odb, if access this external odb
>> has been configured, then the connectivity check will pass as the
>> missing objects in the pack will be seen as already part of the repo.
>
> There are still some nuances. For example, if an external ODB provides
> both a tree and a blob that the tree references, do we fetch the tree in
> order to call "have" on all its blobs, or do we trust the ODB that if it
> has the tree, it has all the other objects? In my design, I do the
> latter, but in the general case where we have multiple ODBs, we might
> have to do the former. (And if we do the former, it seems to me that the
> connectivity check must be performed "online" - that is, with the ODBs
> being able to provide "get".)

Yeah, I agree that the problem is more complex if there can be trees
or all kind of objects in the external odb.
But as I explain in the following email to Junio, I don't think
storing other kind of objects is one of the most interesting use case:

https://public-inbox.org/git/CAP8UFD3=nuTRF24CLSoK4HSGm3nxGh8SbZVpMCg7cNcHj2zkBA@mail.gmail.com/

> (Also, my work extends all the way to fetch/clone [1], but admittedly I
> have been taking it a step at a time and recently have only been
> discussing how the local repo should handle the missing object
> situation.)
>
> [1] https://public-inbox.org/git/cover.1499800530.git.jonathantanmy@google.com/

Yeah, I think your work is interesting and could perhaps be useful for
external odbs as there could be situations that would be handled
better using your work or something similar.
