Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20D63202A0
	for <e@80x24.org>; Sun, 19 Nov 2017 19:11:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751015AbdKSTLe (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Nov 2017 14:11:34 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:33632 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750952AbdKSTLd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Nov 2017 14:11:33 -0500
Received: by mail-qk0-f194.google.com with SMTP id 78so5096441qkz.0
        for <git@vger.kernel.org>; Sun, 19 Nov 2017 11:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Bkc4NatNMIaN4uN8mfNSIZ57zfiy53VMO3PGqeyxBgI=;
        b=aa2G908Fob7jeYDmbfELOe2e7Zee87XUS3KUJ46+oCCvxHVOKBImZl+hbV9Q34999Q
         O2TpOLoDaXfTwIBpUIzrSx4bNJpugRZj1I0/9hnqs+E8wn/bMDwMnkI46U1PVqH9taCh
         vmOyZp4giIM5WPYHpdq6FD3CCFKhg/G1Svh/4ObjAEDM6ldmfb4qf3ZwnDWyeAa/NO/f
         FPUwlysIyIzKiFfyQN4gxjuYJgRqKg67hfUkPj9s265PQ5xMtbGi1nkcP2jx2U9kazc0
         NhFz8h4cpCa6PagdVAw3cJ9cjDNADarVhTdwpoO4vraMtf3HzkfnXMQAFYhnZzBuAT3J
         /v7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Bkc4NatNMIaN4uN8mfNSIZ57zfiy53VMO3PGqeyxBgI=;
        b=WjIRrurl9jfWdIWzzGL18jmCwXgZwDHmvAblEF3dTu/DyxhZDZuWcaAIj8RPjdB4+s
         iwQEjDp+9R3g9ZHR6cmLS3WE2naMoU+hgTiIOxCCgxYdwW/62q8YGRCHQdjZbxuuHpsP
         1wRFp8KqlbzzPv1dMCJOdfJK1pHtHzdPnI+QCa/yG8sHhv1iXND+HUDGi8He+KBLPbJP
         GkOtuZZPOufGfYeMxjdvf3grboaagn93OAvsZioeg4Tkm0Zntwaod1p+dzknyVTe0THc
         OtKK1aPGEMWwP8bYA68sSH/mEt5RiUcKSvqntmnhh2G264S/LjPNAbDLTbTl/8Ky41Ef
         lBCA==
X-Gm-Message-State: AJaThX6/ZvzHf35JIQ8GYRiZ5vtUQ54ElTMZIpYDPB4R6LbK2tmyKcZb
        cSFh5TuN/U7TXKWeJxWbkeW/GDJlI6bLjvB8bEU=
X-Google-Smtp-Source: AGs4zMbUSi09wiIrF6SkA39hyS72fy63xq1BbzgEqhdIoM/2pQzEd7qWSDWM7tvKOuQQVzC1QL/433sWZ/8mqk2kEuM=
X-Received: by 10.55.58.14 with SMTP id h14mr16555800qka.132.1511118692649;
 Sun, 19 Nov 2017 11:11:32 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.155.209 with HTTP; Sun, 19 Nov 2017 11:11:32 -0800 (PST)
In-Reply-To: <20171119184113.16630-2-bedhanger@gmx.de>
References: <20171113223654.27732-1-bedhanger@gmx.de> <83D263E58ABD46188756D41FE311E469@PhilipOakley>
 <xmqqfu9pmsx3.fsf@gitster.mtv.corp.google.com> <20171113223654.27732-3-bedhanger@gmx.de>
 <xmqq1sl17e1u.fsf@gitster.mtv.corp.google.com> <20171119184113.16630-1-bedhanger@gmx.de>
 <20171119184113.16630-2-bedhanger@gmx.de>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 19 Nov 2017 14:11:32 -0500
X-Google-Sender-Auth: n1zDv8Um0KStzvgc4zf5GlB-Om4
Message-ID: <CAPig+cT-r0uLLv_GyTRddPe=ATX883S1jt-8gc=ANZW21S81Mg@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] diff: diff_aligned_abbrev: remove ellipsis after
 abbreviated SHA-1 value
To:     Ann T Ropea <bedhanger@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        Git Mailing List <git@vger.kernel.org>,
        Daniel Barkalow <barkalow@iabervon.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 19, 2017 at 1:41 PM, Ann T Ropea <bedhanger@gmx.de> wrote:
> Neither Git nor the user are in need of this (visual) aid anymore, but
> we must offer a transition period.
>
> Also, fix a typo: "abbbreviated" ---> "abbreviated".
>
> Signed-off-by: Ann T Ropea <bedhanger@gmx.de>
> ---
> diff --git a/diff.c b/diff.c
> @@ -4901,15 +4901,22 @@ const char *diff_aligned_abbrev(const struct object_id *oid, int len)
>  {
>         int abblen;
>         const char *abbrev;
> +       const char *env_printsha1ellipsis = getenv("PRINT_SHA1_ELLIPSIS");

Can you move the getenv() call down to the point where the result is
actually used so we don't have to worry about its value going stale[1]
by some intervening call to getenv(), setenv(), unsetenv() or
putenv()? Alternately, move the check against "yes" up here and assign
it to a boolean (int) which you consult later.

Ditto for the other patches. Thanks.

[1]: http://pubs.opengroup.org/onlinepubs/9699919799/functions/getenv.html

> +       /* Do we want all 40 hex characters? */
>         if (len == GIT_SHA1_HEXSZ)
>                 return oid_to_hex(oid);
>
> +       /* An abbreviated value is fine, possibly followed by an ellipsis. */
>         abbrev = diff_abbrev_oid(oid, len);
> +
> +       if (!(env_printsha1ellipsis && !strcasecmp(env_printsha1ellipsis, "yes")))
> +               return abbrev;
> +
>         abblen = strlen(abbrev);
