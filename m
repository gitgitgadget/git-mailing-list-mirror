Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E76F20966
	for <e@80x24.org>; Sun,  9 Apr 2017 08:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752075AbdDIIqZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Apr 2017 04:46:25 -0400
Received: from mail-lf0-f45.google.com ([209.85.215.45]:33000 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751814AbdDIIqX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Apr 2017 04:46:23 -0400
Received: by mail-lf0-f45.google.com with SMTP id h125so58153033lfe.0
        for <git@vger.kernel.org>; Sun, 09 Apr 2017 01:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=etAfwLnt01l2+83OqKO7jlRngw8wdEQOR64xamMENvE=;
        b=pESnc0773vB/EbycTtWG02zdeDd7PvPu7qh3ibCUd+UfEsBhaBxJz73pZTZGE8mHSv
         O+bZlb9Ot6rmbVMEeAqhwjk7M8nelvJ/h1JO53HqLUXRM0AAmY1CS7s6lQuHFt5BYqEQ
         bA+t3l+Ljn/HSZRvyraw4dZ41k8VN+h23T77XOw1xtpNuv7gTAlZVqEboBnMtZtZdDNg
         MeQaVb4g2ImcgnYUzKDC93GDuNHUg+Evx+B/m5hXdsiAY7znW0y0TdibMJfLR1c76tKe
         3u9TPc3JTLW0LW8Lj/T7k2Uz6RScENNtjSHrFiFrQlpsRKSLO6+9bvBmOlfwaG/R96Fm
         X7uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=etAfwLnt01l2+83OqKO7jlRngw8wdEQOR64xamMENvE=;
        b=SM/DfpBPTOEVRqdkxXsCS7B+/eQWWpxIS3LzgJ+Y8IdsZgzjsuAGllXte1RriQHWbg
         k4yoiElTWWr73ulQN5PSkuQ/idR4MxoJ1oSdUSNsSxM+3Bq+vjhT8xOLEBysR2e7Q2aI
         pC9W8hB4gtpLk9XAfQkz7VZVi51AoEimmX0MiRPTx0YbOooDOi1xvYfMV08kmmUCLZr0
         1v+2dvqzEmy9dWj/u91rVg7OjMRoaBbBNGsZ4SvIfl225aRZrPG1++RWbJxVGYMVKjwY
         dcmDAq06qvH6zRx2RTcUFTOjusJ49pnqLrF2Z6o501LTqNR2x5Dps8VhR2bC1Lw4zH0k
         DqVA==
X-Gm-Message-State: AFeK/H1ZaPTiMFOydF5l+04gEusrWEBxVbXuPaRU2taMKLkjEimK8wJs82TmullmqASqvlUibk0B6HXMCHuTfg==
X-Received: by 10.25.196.207 with SMTP id u198mr17399605lff.88.1491727581910;
 Sun, 09 Apr 2017 01:46:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.145.30 with HTTP; Sun, 9 Apr 2017 01:46:01 -0700 (PDT)
In-Reply-To: <1n47l28.1xcy707zz3evtM%lists@haller-berlin.de>
References: <CA+P7+xqfHDVKpVKVYbB-4kjb9ja+u4GVMwkTFrj0f0n_OXZfvQ@mail.gmail.com>
 <1n47l28.1xcy707zz3evtM%lists@haller-berlin.de>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Sun, 9 Apr 2017 01:46:01 -0700
Message-ID: <CA+P7+xrxH2kDSt02TTYyiKB2PgQr33j=-=ewATmvp2mJKTMMAA@mail.gmail.com>
Subject: Re: Tools that do an automatic fetch defeat "git push --force-with-lease"
To:     Stefan Haller <lists@haller-berlin.de>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=3F_Bjarmason?= <avarab@gmail.com>,
        Matt McCutchen <matt@mattmccutchen.net>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 9, 2017 at 1:38 AM, Stefan Haller <lists@haller-berlin.de> wrote:
> Jacob Keller <jacob.keller@gmail.com> wrote:
>
>> What if we added a separate command something like:
>>
>> git create-lease
>>
>> which you're expected to run at the start of a rewind-y operation and
>> it creates a tag (or some other ref like a tag but in a different
>> namespace) which is used by force-with-lease?
>
> The problem with this is that it doesn't help to use "git create-lease"
> right before you start your rewind-y operation, because by that time you
> may already have fetched. You'd have to use "git create-lease" right
> after you pull or push. But at the time I pull I don't know yet whether
> I will later want to rewrite the branch, so to be sure I have to do this
> every time I pull or push, and then I'd prefer git to do it for me.
>

No, you don't set the sha1 as the tip of "origin/master" you set it as
the tip of "master" after you've performed all the integration and are
about to rewind history somehow.

>> However, I think using origin/master works fine as long as you don't auto-fetch.
>>
>> If you're doing it right, you can handle origin/master updates by
>> checking that your rewind-y stuff is correct for the new origin/master
>> RIGHT before you push.
>
> I'm not sure I understand what you mean by "checking that your rewind-y
> stuff is correct for the new origin/master"; does that mean manually
> inspecting origin/master to convince youself that you are not
> overwriting something new? If so, I don't think this is acceptable. It
> is probably ok to work this way if the other party only pushed commits
> on top; it's reasonable to expect that you will recognize new commits as
> ones that you haven't seen before. But what if the other party has
> rewritten the branch and squashed improvements into commits in the
> middle of it? The head commit will then look the same as before, and the
> only way to tell whether you are overwriting something new is by
> comparing the old and new hashes. So then we're back at having to
> remember what the old hash was.
>

You can do a diff rather than a check of the log.

Thanks,
Jake

>
> --
> Stefan Haller
> Berlin, Germany
> http://www.haller-berlin.de/
