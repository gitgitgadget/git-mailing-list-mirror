Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 437181FD09
	for <e@80x24.org>; Sun, 28 May 2017 18:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750814AbdE1ScK (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 May 2017 14:32:10 -0400
Received: from mail-oi0-f51.google.com ([209.85.218.51]:34754 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750794AbdE1ScJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 May 2017 14:32:09 -0400
Received: by mail-oi0-f51.google.com with SMTP id b204so58827457oii.1
        for <git@vger.kernel.org>; Sun, 28 May 2017 11:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=q8ED+aZA/NjH6EhX73KLOdboPecmcWbC3t8qlhT6V7E=;
        b=cM1HEVaOhHRKCDnq2JlSuPCkZLGGyD7+Kv364hKg+xKMo3RPVFjFr9eTnsuGJxKaMP
         fUoA82s77WI3huwElBDObal2EjDQW+IN8XGns6Xz/cZIGDTJKk2SDLkI9F5cePoNExZJ
         /UtXCSLqiVkx0IOVbTnQcOb1tt2URZQM4x77oBsecAw22OA9RKlPQ/vbwMfQBIVJv4cA
         uUaF24lb+80gxHK7Bw9XAgM6wRQhQMJh9WqVlpzGjqz7Jb2Ekv7VsCOKhW3oUSmOKB3d
         JRl1/uawO34OXidz0pOFTK8lOqTIPmT+JM1RH2GuKvW9beae7+XcDEWTL+g5aXk7zeMf
         RCMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=q8ED+aZA/NjH6EhX73KLOdboPecmcWbC3t8qlhT6V7E=;
        b=R4lZTo2pO4xV7BMPOnyb7t62VcIhdO0A3iV2I3zefSkMFgDL+58xQqoBLmJnbnwNil
         rFymmYMhHl/S36w9ahS6IKxM99tB8nbhWq/oKR/yagaCWPFUUeXnnC1tqxHm7rtR2Nm2
         TWTQPmdLxMNiFx/1OFAO7vtQpE+EcRsMMtb4YZ2A41daPpIGrIy4q+JNKD47Ad5auByr
         7NJkEGVy21L5CiTQrm1BS6qo09zcqBtYhNWV/Xi1Zi99qd8su/bhzfmilYiIly95BAVd
         /R5HF8TveA+OcZwafTw/s5bp71HmeHsbDs3PbBGe8qtsd5YADqcrM/RL/HOr3tDZQUA8
         ra+g==
X-Gm-Message-State: AODbwcAeMWS9+UaPDJqa/UDu24SJexEgoNwFQygS5QqWJ+hOMTzZwAex
        2xDxdOiuNvLJ+VE6IbsunWfZcpX8qA==
X-Received: by 10.157.68.199 with SMTP id p7mr6129165otg.15.1495996328532;
 Sun, 28 May 2017 11:32:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.10.202 with HTTP; Sun, 28 May 2017 11:31:48 -0700 (PDT)
In-Reply-To: <CACBZZX5cxkV4C42OwJ077b1XMHCk+uTCbdHV9Ez5EVStR4DWxg@mail.gmail.com>
References: <20170528165642.14699-1-joel@teichroeb.net> <20170528165642.14699-5-joel@teichroeb.net>
 <CACBZZX5cxkV4C42OwJ077b1XMHCk+uTCbdHV9Ez5EVStR4DWxg@mail.gmail.com>
From:   Joel Teichroeb <joel@teichroeb.net>
Date:   Sun, 28 May 2017 11:31:48 -0700
X-Google-Sender-Auth: Wa_4szqxbpRCUWeeHmABqapmhyc
Message-ID: <CA+CzEk8Xx4nh=Bh533DR=Xo_BjQsxAoYNbx3=O=rtWr8+v4xsQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] stash: implement builtin stash
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, t.gummerer@gmail.com,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 28, 2017 at 11:26 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Sun, May 28, 2017 at 6:56 PM, Joel Teichroeb <joel@teichroeb.net> wrot=
e:
>> Implement all git stash functionality as a builtin command
>
> First thanks for working on this, it's great. Applied it locally,
> passes all tests for me. A couple of comments Christian didn't cover
>
>> +       info->has_u =3D get_sha1_with_context(u_commit_rev.buf, 0, info-=
>u_commit.hash, &unused) =3D=3D 0 &&
>> +               get_sha1_with_context(u_tree_rev.buf, 0, info->u_tree.ha=
sh, &unused) =3D=3D 0;
>> +
>> +
>> +       /* TODO: Improve this logic */
>> +       strbuf_addf(&symbolic, "%s", REV);
>> +       str =3D strstr(symbolic.buf, "@");
>
> Could you elaborate on how this should be improved?
>

I just figured there would be a builtin function that could help here,
but hadn't had the chance to look into it. It's something easy to do
in bash, but more complicated in C.

>
>> +static int patch_working_tree(struct stash_info *info, const char *pref=
ix,
>> +               const char **argv)
>> +{
>> +       const char *stash_index_path =3D ".git/foocache2";
>
> This foocache path isn't created by the shell code, if it's a new
> thing that's needed (and I haven't followed this code in detail, don'n
> know what it's for) shouldn't we give it a more descriptive name so
> that if git crashes it's obvious what it is?
>

Opps, I had cleaned that part up locally, but I forgot to push it when
switching computers. It'll be better in the next patch set.

>> +       const char *message =3D NULL;
>> +       const char *commit =3D NULL;
>> +       struct object_id obj;
>> +       struct option options[] =3D {
>> +               OPT_STRING('m', "message", &message, N_("message"),
>> +                        N_("stash commit message")),
>> +               OPT__QUIET(&quiet, N_("be quiet, only report errors")),
>> +               OPT_END()
>> +       };
>> +       argc =3D parse_options(argc, argv, prefix, options,
>> +                                git_stash_store_usage, 0);
>
> Nit: In general in this patch the 2nd line of parse_options doesn't
> align with a tabwidth of 8. Ditto for indenting function arguments
> (e.g. for untracked_files).

I'll fix my tab width. Forgot that long lines would change, haha.
