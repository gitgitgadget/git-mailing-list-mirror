Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DCC81F576
	for <e@80x24.org>; Wed,  7 Feb 2018 11:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753679AbeBGLtE (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 06:49:04 -0500
Received: from mail-oi0-f48.google.com ([209.85.218.48]:38151 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753535AbeBGLtD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 06:49:03 -0500
Received: by mail-oi0-f48.google.com with SMTP id j15so437851oii.5
        for <git@vger.kernel.org>; Wed, 07 Feb 2018 03:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=07yaSzYDcvFaX46kEiX67/tbf3u6lNXbj+8pHstGhmE=;
        b=DqCzLPUq0yjQVdeJf/XNP9Q2FpCj32SyG0iZTChcgPX9ESMgyRX34qpNZxPWuLdqWr
         S4pPDgMdEtohsyoMxRBv3krmzeqClMDWWVAUNdy1YGU+Lvb7dUYk2WtNFrBWLTuUCZuW
         yIOw2jd0Ci7HlVMM5pVFShM89oOYI3KAscBXIymxxFTBDunXHmzOou/Ntf5PI8PeK2GH
         ahElV/p8BbagUCgkHi9tHywyeCF4GI/uoX5eUq/GnGpS574zb7uAexML3LAv7msonUtV
         jYdZpuJYmQrmnDvGxzXj+KP+jiI4WLXah+A2Lqh8HO4ziLWVV4IdWRfiG0QwNI6OLT59
         Fxxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=07yaSzYDcvFaX46kEiX67/tbf3u6lNXbj+8pHstGhmE=;
        b=OBb6YMeHIX46jBxpyI7UDs47q4wD9gg31jJ5p4RZWXr8QzAH0O0s/338dfQjYpiGJO
         EOG/RwbdTAvopdKUEckR8psjBq3RQRa2eXlv/9so4wlNL85CKSMuKjsHOo7hC2ikZ1F8
         iVyes9FNaOda2mS9E872Bz9bO/pPdCcsbiFV/B55O3wOww3IJSU8IF1FYR6hfmrY4ui0
         Qghun7xdBSq/wmW8sADfOweLHX4lr9KmH1mA2L4KuE0Jm4gkNA9FCLVYdwjFgLAe9Hys
         +Jq4fLR4swxizFcFMojPmgZ+6ekYqKqwAR33MVWMXGec2J2zOwnGpwurtJfzZYIbDjnv
         grNw==
X-Gm-Message-State: APf1xPAGIscyQHV3W8voAvAWnPDDiBBI6e3QiLhlVeAXMF710XwKmqyV
        Qhl2JVjl7y6ps5OVsAw+cyRFpQDJX6niY/EW4SQ=
X-Google-Smtp-Source: AH8x2255VFeU/aA6TI0op3w7L2sCxTzuxSgyADDnDduheusFVRiLbZr00uwMps2qJ7I8p/otUau/LVzEYDZggf+kh00=
X-Received: by 10.202.107.194 with SMTP id g185mr3988378oic.268.1518004142872;
 Wed, 07 Feb 2018 03:49:02 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.102.205 with HTTP; Wed, 7 Feb 2018 03:48:32 -0800 (PST)
In-Reply-To: <20180205235508.216277-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 7 Feb 2018 18:48:32 +0700
Message-ID: <CACsJy8CGgekpX4cZkyyTSPrj87uQVKZSOL7fyT__P2dh_1LmVQ@mail.gmail.com>
Subject: Re: [RFC PATCH 000/194] Moving global state into the repository object
To:     Stefan Beller <sbeller@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 6, 2018 at 6:51 AM, Stefan Beller <sbeller@google.com> wrote:
> This series moves a lot of global state into the repository struct.
> It applies on top of 2512f15446149235156528dafbe75930c712b29e (2.16.0)
> It can be found at https://github.com/stefanbeller/git/tree/object-store
>
> Motivation for this series:
> * Easier to reason about code when all state is stored in one place,
>   for example for multithreading
> * Easier to move to processing submodules in-process instead of
>   calling a processes for the submodule handling.
>   The last patch demonstrates this.

I have a mixed feeling about this. The end game is to keep
"the_repository" references as minimum as possible, right? Like we
only need to mention in in cmd_xxx() and not all over the place. If
so, yay!!

Something else.. maybe "struct repository *" should not be a universal
function argument to avoid global states. Like sha1_file.c is mostly about the
object store, and I see that you added object store struct (nice!).
These sha1 related function should take the object_store* (which
probably is a combination of both packed and loose stores since they
depend on each other), not repository*. This way if a function needs
both access to object store and ref store, we can see the two
dependencies from function arguments.

The alternate object store, if modeled right, could share the same
object store interface. But I don't think we should do anything that
big right now, just put alternate object store inside object_store.

Similarly those functions in blob.c, commit.c, tree.c... should take
object_parser* as argument instead of repository*. Maybe there's a
better name for this than object_parser. parsed_object_store I guess.
Or maybe just object_pool.
-- 
Duy
