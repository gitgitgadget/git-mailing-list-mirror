Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBFC81F404
	for <e@80x24.org>; Mon,  2 Apr 2018 20:04:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755451AbeDBUEf (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Apr 2018 16:04:35 -0400
Received: from mail-ot0-f170.google.com ([74.125.82.170]:38983 "EHLO
        mail-ot0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753109AbeDBUEe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Apr 2018 16:04:34 -0400
Received: by mail-ot0-f170.google.com with SMTP id h8-v6so16894323oti.6
        for <git@vger.kernel.org>; Mon, 02 Apr 2018 13:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jDcEqAbT/UJL3BJVs4imhgpXOktJgRFBaQEp7rw26nI=;
        b=BtIg3kFOzhwBlYQ6C8saKakfwUQqFs8DQ1djFnvZGM9uLfptezWAoQ7xgtqx0T4/L3
         msHdTQ+GbrZ7sNgHmT3XPRGmVRtsuY3rmND1dSR8WZqLK++xa2iw9YC1HfEMXSivBD9I
         ne/w1IBLLlNHDRhZKcWm417mkKKcoTzlDIzAvnUU8umUG/i8LHB/Pqi2iAkq4VyPMEqo
         3yS3OzEFaw1BTF6j9KXfCXatOQ40xfnb4GqtLgoGzrGM+RnqXdULiHATnA561TDR4pI7
         qAg5ZFiOv0CShLt1SFeKGUcWmbqu0fXxLpAUlShj8Bem/ahrYPqt0l2kP/nLIkGSJr7s
         IvMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jDcEqAbT/UJL3BJVs4imhgpXOktJgRFBaQEp7rw26nI=;
        b=K+IEOvtwMx7lLgZ8S5Jk/pAlox1U0qD4qu/JkSYhUpa0iTntGBaolafewCsF+jGB12
         QA1x1R1gPCsOy2bVYLuNo2tOj+NiXgdtqjlG9Loml1zCuK5GOF2W26/bIEj/2MJ7NpSk
         tpXVmZqPNlK392p9zWZpfsaeUi4Ss0HxbVjk9lenIAesOzU0gjflminQxL61OZGeBL5C
         b1pHC5OlesedS8GpO/ou6rZVCDQJRrF4offRCVWTrLg4bIHkQYgCuACEys+rwBJzIs3f
         uMfn0afgj+QzVfMgIsRB/R8TKOiQggDCE8fljEcsA8nshDX/B/98/cPlckFTrts8i1rm
         +/Pw==
X-Gm-Message-State: AElRT7HoOaBZLxHiV4xj4vscJd9DzPm70Jdh+hNqWT9G92oQQB3DmVsD
        05YtFCFEHJ78GbBMQ3p8Wqd19Umh8Q6wRoa4344=
X-Google-Smtp-Source: AIpwx49EH+micHdqDaJn5BXMU/0op32WfyBTjtggo+5nGdN9UUKQEJvN87Eu7SiAOyjWoGmmx1DhyjEec4JRGWlWSq4=
X-Received: by 2002:a9d:14ce:: with SMTP id r14-v6mr6071340otr.111.1522699474275;
 Mon, 02 Apr 2018 13:04:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.201.68.194 with HTTP; Mon, 2 Apr 2018 13:03:53 -0700 (PDT)
In-Reply-To: <xmqqbmf1zcfb.fsf@gitster-ct.c.googlers.com>
References: <20180402005248.52418-1-haraldnordgren@gmail.com>
 <87605aw1ue.fsf@evledraar.gmail.com> <xmqqbmf1zcfb.fsf@gitster-ct.c.googlers.com>
From:   Harald Nordgren <haraldnordgren@gmail.com>
Date:   Mon, 2 Apr 2018 22:03:53 +0200
Message-ID: <CAHwyqnV8tB63gQFVJhyNtr304Uv1TwWvYiX+3wuU0fDFhOphgg@mail.gmail.com>
Subject: Re: [PATCH] ls-remote: create option to sort by versions
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for all the discussion!

I think I figured out a way to reuse more ref-filter.c machinery. I
will submit another patchset shortly.

On Mon, Apr 2, 2018 at 8:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> This is a sensible thing to want, but why not follow the UI we have for
>> this with git-tag? I.e. --sort=3D<key> & -i (or --ignore-case)? Of cours=
e
>> ls-remote doesn't just show tags, so maybe we'd want --tag-sort=3D<key>
>> and --ignore-tag-case or something, but the rest should be equivalent,
>> no?
>
> Yeah, and if we can reuse more of ref-filter.c machinery (which was
> factored out of for-each-ref and tag you suggested borrows from),
> that would be even better.  In the context of ls-remote, however, we
> cannot inspect the object (we typically do not have them yet), so it
> may not be practical, but I agree with your suggestion---we should
> match the behaviour at the UI level at least when we can.
>
