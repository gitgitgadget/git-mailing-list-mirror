Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5E96203F3
	for <e@80x24.org>; Fri, 21 Jul 2017 22:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754838AbdGUWRz (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jul 2017 18:17:55 -0400
Received: from mail-qk0-f179.google.com ([209.85.220.179]:33615 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753502AbdGUWRy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2017 18:17:54 -0400
Received: by mail-qk0-f179.google.com with SMTP id f67so5881023qkc.0
        for <git@vger.kernel.org>; Fri, 21 Jul 2017 15:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0tQxAu5xJv+vs1tjnvokq4xB/fZ/pQVMzm0fgUiarrU=;
        b=gPqd5zL76ESrqb1z4KIGbGJOp6KlbJhrIrRa7s5KoKnG6sHWAlmX73Rh4FQCFnC4N9
         spRPv6Q4TiRoRae3cYIayjUuULCWRWxpSihmarQD+E6gAYEElFQcGEln8h9YibdK1fr/
         B/viS51yQjenJotBGJ7RfwcL+TnAeWdEL5dgm9FehfB+pRNXYbwoOdFkIQwSmZyOKjIW
         021hOfueuFJFtUdTf+q3cgowPzs1c0X5CTZlWB1UG+tvb/3fttAzS3uFSTmjjk/jvm6B
         ECo8HfNa/UHj+1YDuQVNKHpF4ETcYeY92rUgcX8yM62bPSHQvYbJF5L+I4lAYdN5eR49
         oYMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0tQxAu5xJv+vs1tjnvokq4xB/fZ/pQVMzm0fgUiarrU=;
        b=JoZo1T5rKUSk8ynA63/BlX5mRIccleI69zNnhChaDkFj3FoArVToVESTiKZyiNii1d
         jGYlYhfHSxlMnnu2Gct46rO83Sz7U20uvFsta4gUykjSHFe9o/90xVS19xD0wUOYGqPG
         aaCxSTGggUmPyHyrY2+1nK7T2dNXmyGaJvUzdth/V8WKfsJd5/sSYJbf2mVEkq2QBEV+
         AiyIyN9rZLEAKu+QNFxXuLJ7FUqJpBL7lR7y9PdpZKk0atzIJ3GapqDnTdGUXlGGeq4e
         AOXOnOZJMNf10uCdMXzLAAZgZgUjPLgIRn8JW+mWRqQEOKx+Db+hDpizjUeGYj5qzrga
         Kqmw==
X-Gm-Message-State: AIVw113LHPr3nbpphLoMp/cgWmxSj6G/BCt9YM10hi7gkzMsDnH0wQiv
        qweyQOBqvQiRXFIfDTaRRY0GqCO6NQ==
X-Received: by 10.55.112.71 with SMTP id l68mr1083938qkc.10.1500675473404;
 Fri, 21 Jul 2017 15:17:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.193.38 with HTTP; Fri, 21 Jul 2017 15:17:52 -0700 (PDT)
In-Reply-To: <xmqqo9sfkm32.fsf@gitster.mtv.corp.google.com>
References: <249ac6f8-af3c-4b20-5bf0-87a82866cc7a@free.fr> <3ccfa2fb49d471f807d77d9a280e4b7cfe56faea.1500304209.git.worldhello.net@gmail.com>
 <xmqq7ez7htvj.fsf@gitster.mtv.corp.google.com> <CANYiYbEcMrriaor9OT4c2qtfh9Ja5NJ9KBSxa3XhPAuoN0t42A@mail.gmail.com>
 <xmqq60epfy27.fsf@gitster.mtv.corp.google.com> <CANYiYbFROuyXso2ZKuJWDp4cSwpBu=bNAbC-yZtEyDwkbUcAhQ@mail.gmail.com>
 <alpine.DEB.2.21.1.1707191456010.4193@virtualbox> <xmqq8tjkm3ly.fsf@gitster.mtv.corp.google.com>
 <xmqqo9sfkm32.fsf@gitster.mtv.corp.google.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Sat, 22 Jul 2017 06:17:52 +0800
Message-ID: <CANYiYbGSaaFOq7iw=ON1Oo87bSA96o=zyzym5RDT32kMae7bsw@mail.gmail.com>
Subject: Re: [PATCH] PRItime: wrap PRItime for better l10n compatibility
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2017-07-21 2:19 GMT+08:00 Junio C Hamano <gitster@pobox.com>:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>
>>> But there may be hope. Since the character sequence "PRItime" is highly
>>> unlikely to occur in Git's source code in any context other than the
>>> format to print/parse timestamp_t, it should be possible to automate a the
>>> string replacement
>>>
>>>      git ls-files -z \*.[ch] |
>>>      xargs -0r sed -i 's/PRItime/PRIuMAX/g'
>>>
>>> (assuming, of course, that you use GNU sed, not BSD sed, for which the
>>> `-i` needs to read `-i ''` instead) as part of the update?
>>
>> I somehow missed this bit.
>>
>> Given that this needs to be done only once every release by only one
>> person (i.e. the l10n coordinator who updates *.pot file), as long
>> as the procedure is automated as much as possible to ease the pain
>> for the l10n coordinator and clearly described in the "Maintaining
>> the po/git.pot file" section of po/README, something along that line
>> does sound like a very tempting approach.  If it works well, it is
>> certainly much easier for normal developers than the other possible
>> alternatives I mentioned in my previous response.
>
> So, I was offline for most of the day yesterday and with this issue
> blocking the release candidate, didn't manage to tag -rc1.
>
> The use of "make pot" from the top-level is already described in
> po/README, so the only thing that we need is something like this
> change.  I'll follow up this message with a sample output from the
> updated process to ask others to sanity check the result (they are
> tiny) in a separate message.
>
> Thanks.
>
>
>  Makefile | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/Makefile b/Makefile
> index ba4359ef8d..7069a12f75 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2216,12 +2216,22 @@ LOCALIZED_SH += t/t0200/test.sh
>  LOCALIZED_PERL += t/t0200/test.perl
>  endif
>
> +## Note that this is only meant to run by the localization coordinator
> +## under a very controlled condition, i.e. (1) it is to be run in a
> +## Git repository (not a tarball extract), (2) any local modifications
> +## will be lost.
>  po/git.pot: $(GENERATED_H) FORCE
> +       @for s in $(LOCALIZED_C) $(LOCALIZED_SH) $(LOCALIZED_PERL); \
> +       do \
> +               sed -e 's|PRItime|PRIuMAX|g' <"$$s" >"$$s+" && \
> +               cat "$$s+" >"$$s" && rm "$$s+"; \
> +       done
>         $(QUIET_XGETTEXT)$(XGETTEXT) -o$@+ $(XGETTEXT_FLAGS_C) $(LOCALIZED_C)
>         $(QUIET_XGETTEXT)$(XGETTEXT) -o$@+ --join-existing $(XGETTEXT_FLAGS_SH) \
>                 $(LOCALIZED_SH)
>         $(QUIET_XGETTEXT)$(XGETTEXT) -o$@+ --join-existing $(XGETTEXT_FLAGS_PERL) \
>                 $(LOCALIZED_PERL)
> +       @git reset --hard
>         mv $@+ $@
>
>  .PHONY: pot

Sorry, I'm late. I want to try a safer way to change PRItime to
PRInMax using a hacked version of gettext.

We can change Makefile like this:

    --- a/Makefile
    +++ b/Makefile
    @@ -2216,7 +2216,14 @@ LOCALIZED_SH += t/t0200/test.sh
     LOCALIZED_PERL += t/t0200/test.perl
     endif

    -po/git.pot: $(GENERATED_H) FORCE
    +check_gettext:
    +       @if ! $(XGETTEXT) --version | grep -q -i PRItime; then \
    +               echo >&2 "Error: must use a hacked xgettext, which
can handle PRItime macro properly."; \
    +               echo >&2 "Error: download the hacked version of
gettext from https://github.com/......" ; \
    +               exit 1; \
    +       fi
    +
    +po/git.pot: check_gettext $(GENERATED_H) FORCE
           $(QUIET_XGETTEXT)$(XGETTEXT) -o$@+ $(XGETTEXT_FLAGS_C) $(LOCALIZED_C)
           $(QUIET_XGETTEXT)$(XGETTEXT) -o$@+ --join-existing
$(XGETTEXT_FLAGS_SH) \
                   $(LOCALIZED_SH)

But I'm not sure I can handle this in this very busy weekend.

-- 
Jiang Xin
