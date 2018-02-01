Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9057A1F404
	for <e@80x24.org>; Thu,  1 Feb 2018 00:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753161AbeBAAGQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 19:06:16 -0500
Received: from mail-ot0-f193.google.com ([74.125.82.193]:34189 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753476AbeBAAGP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 19:06:15 -0500
Received: by mail-ot0-f193.google.com with SMTP id x15so15181217ote.1
        for <git@vger.kernel.org>; Wed, 31 Jan 2018 16:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UrYygNY8+62WQZznerbVaH/qkfpAwaw+BqDLRCy6JEE=;
        b=lkQhykHDxLBEUw98j5CYetmfyWE9Fi/e1AdZTQ20iwbcajKl0fiZNaPGdgPOddxyOz
         lIRGIbKi13ZBpcL5KYFodDszvrGNVICvsZKqmXrf6B08chwWPtBYpfRghBA1o3pcn+XG
         hkwXYP+WfPFpm6fqIoME7DMarC2JpfLc1C+WUsjmefZLFoaWhVkd3MJomuYcqOhvyEF+
         MBpQ+amYzcSneWDoWBDslxE+x30jxXv/AXqucVU3iVh511X4GzqsKQGMaAZYJQGgTXng
         x5dCpoIAFjWza51RUtwg+MVhwbR73sPwrAQVzSu4ZHc/ftjXEVwvUkScuahnmFPskbt+
         jLfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UrYygNY8+62WQZznerbVaH/qkfpAwaw+BqDLRCy6JEE=;
        b=DV1A6CxJYlsuEDo0pQ4R1gxhF4i2NB6QQqA0AsnJJXU+WtJlDz1OfaGnwt6/j8dT7s
         dIHqe0OX/VSrqb+y71SY70thqZqFD0BP5becKjVzcRC2ExusKBEaes1K9UlJB0UAEJZG
         agssbnY/7Tup+Qm4mOdm+FhpqanOShWZeVu8lsZMkoiu1yrTcJDjx40LHgfe0AFctRjt
         M0RR1N68U9wtHkuWmXgVyHEad/UuCRf3qUob+wP3XVAKIWsLfB67kTEIVE0w8Sv3v4s0
         fiuwjcYzIP8iiG9JWm7Ej6GN+IW50S+bRXfNnn6M6Upq0ecbbIwobSV1e/jvQ1TxENd2
         jHgA==
X-Gm-Message-State: AKwxytfR0m91nrwaOPJKlK6xnkxn7w1aEtLZBvPu4zbjHd/PstlU4u/o
        cwMAr/cEjckCt9dWgPlSXvVJoCTVAMz1weFB9Hi/TA==
X-Google-Smtp-Source: AH8x225V+w6+4uuXEfymeCO92A9IMDJXeMgtNapf/dJVYF4l55dBjRztGdx3DpyK2iGWlG9rwLRqavAzhMxwSOszr6Q=
X-Received: by 10.157.64.140 with SMTP id n12mr9481082ote.151.1517443574929;
 Wed, 31 Jan 2018 16:06:14 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.102.205 with HTTP; Wed, 31 Jan 2018 16:05:44 -0800 (PST)
In-Reply-To: <CAPig+cT5GkhFJ9XFDSirGjfoji4qUCM8LA6abdRsaT=g3prznQ@mail.gmail.com>
References: <20180131110547.20577-1-pclouds@gmail.com> <20180131110547.20577-2-pclouds@gmail.com>
 <CAPig+cT5GkhFJ9XFDSirGjfoji4qUCM8LA6abdRsaT=g3prznQ@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 1 Feb 2018 07:05:44 +0700
Message-ID: <CACsJy8B0D=u5fGA2QWuG6QG-fmReg=GayC54+pSFjXHDrnKh3w@mail.gmail.com>
Subject: Re: [PATCH v2 01/41] parse-options: support --git-completion-helper
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 1, 2018 at 4:04 AM, Eric Sunshine <sunshine@sunshineco.com> wro=
te:
> On Wed, Jan 31, 2018 at 6:05 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Du=
y <pclouds@gmail.com> wrote:
>> This option is designed to be used by git-completion.bash. For many
>> simple cases, what we do in there is usually
>>
>>     __gitcomp "lots of completion options"
>>
>> which has to be manually updated when a new user-visible option is
>> added. With support from parse-options, we can write
>>
>>     __gitcomp "$(git command --git-completion-helper)"
>>
>> and get that list directly from the parser for free. Dangerous/Unpopular
>> options could be hidden with the new "NOCOMPLETE" flag.
>
> I wonder if this option should be named DANGEROUS rather than
> NOCOMPLETE to better reflect its intention.

It's not only for dangerous options (I forgot to mention this in the
commit message, I will in v3). The --continue|--abort|--skip should
only show up when you are in a middle of rebase/am/cherry-pick.
git-completion.bash handles this case separately and only put them in
the completion list  when appropriate. --git-completion-helper must
not include these or the trick done by git-completion.bash becomes
useless.

> The reason I ask is that
> it is easy to imagine git-completion.bash some day growing a new
> configuration option to allow people to complete these "dangerous"
> options, as well, rather than us imposing, with no escape hatch, our
> idea of what should and should not complete.
>
> It's not uncommon for "bug reports" to be sent to the list stating
> that such-and-such option (say, --force) does not autocomplete. Our
> stock answer is "oh, that's a dangerous option, so you'll have to type
> it manually". If git-completion.bash gains new configuration to allow
> dangerous options, then our answer can become "oh, that's a dangerous
> option, if you really want it to complete, then enable
> GIT_COMPLETION_DANGEROUS" (or whatever).

Interesting. So we now have two classes of "no complete". One can't be
configurable (--continue|--abort|--skip) and one can. I'll use two
separate flags for these, though I'm not adding the configuration
option right now. It's easy to do and can way until someone actually
asks for it.
--=20
Duy
