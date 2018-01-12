Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20E871F406
	for <e@80x24.org>; Fri, 12 Jan 2018 13:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933619AbeALNc6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jan 2018 08:32:58 -0500
Received: from mail-vk0-f48.google.com ([209.85.213.48]:39529 "EHLO
        mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933598AbeALNc4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jan 2018 08:32:56 -0500
Received: by mail-vk0-f48.google.com with SMTP id n4so3573715vkd.6
        for <git@vger.kernel.org>; Fri, 12 Jan 2018 05:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ANiiwBN9XA0FUc8kLxgAx1uopFIHmwtUH188iWx6Gvw=;
        b=RqboaQPAcJl0KRAEmDDuOfJYS+ne+EqUQ+WV8aItyzCqU0o2S1C18APEFeavkIjPZ8
         aJblWvGcvxKHB8cuf2PRLKyotBq8GFjy3O5dk8N/fdFZQ1bAPL8oddboz3ox+R+v+MiM
         jRUAPY8XLYU/OUz406Q9R66IhQEUEiz47gGu2dFtEF9IoWgjiw711k/rdyx1GLPIUnxu
         7IiZr7hNZBguz0eItfqEY1U49Zt+/cLxuRNAQXXORjF93dnEXtjJs1FsluIbBK6z2F8f
         FYMZ6zhwIBygeuW0nAKGB2U0eWbfusso8ZPwr3PjXdPwFJ5EEpAxYmRiejcwHLhBdniA
         jiMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ANiiwBN9XA0FUc8kLxgAx1uopFIHmwtUH188iWx6Gvw=;
        b=O7nJ2+ob98i1iLng8LMjinnxLxw746syWrEY+UcQzTaFzkuUkJhEtzK59CE+HCnYh3
         XGLZGFtmAH9pW+jeIi0lThXsVD8KtiwB8CkA4flaWoc8INHZENX13wvjEgv4PRtyRScZ
         kJUH7fVN3q1IkrzgthUl2ny1vSijm28f4EemwQRlAa/pT1VezGNhYx1L2BAhTg23NQF1
         FUSt6oBaOHtpu0Hs34Btxm+4fcH8vnRbCEV720m3PzOJIu/vez0ieKFf9qjflX7m7fsc
         W3LCPOXZRM2lhYiCAIlIxyYyjBYnPxLyn1La01hV6gG1v1VLos2WIraIFqiptnfvmYt/
         EFEQ==
X-Gm-Message-State: AKwxytf+Aazo4IEWOjDBov2SOjnWi1JUNpKbZbfPnShMdxrLuXbobqIt
        vAye63gSE3y+PxT7bupv2TekJtgDszLZjVM06wM=
X-Google-Smtp-Source: ACJfBouqkmFFXIb+4WguNpOKAV3KNcpJ+N2jabne0ph2+1tNllj7/0F/2NVx7P/CO4JSzgiOV33J0f9Fgskeqs4TzDk=
X-Received: by 10.31.161.215 with SMTP id k206mr22936170vke.82.1515763975315;
 Fri, 12 Jan 2018 05:32:55 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.11.130 with HTTP; Fri, 12 Jan 2018 05:32:54 -0800 (PST)
In-Reply-To: <5DE3FA05-2347-4BE7-8A1A-A6E5FEEC7C2B@gmail.com>
References: <20180108172214.23615-1-szeder.dev@gmail.com> <xmqqvagc6m42.fsf@gitster.mtv.corp.google.com>
 <5DE3FA05-2347-4BE7-8A1A-A6E5FEEC7C2B@gmail.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Fri, 12 Jan 2018 14:32:54 +0100
Message-ID: <CAM0VKjnSzoc+E408ifKCg+qPTaGRNL3e3JVdRN573kdcBSzbHw@mail.gmail.com>
Subject: Re: [PATCH] travis-ci: build Git during the 'script' phase
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 8, 2018 at 11:38 PM, Lars Schneider
<larsxschneider@gmail.com> wrote:
>
>> On 08 Jan 2018, at 23:07, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:
>>
>>> The reason why Travis CI does it this way and why it's a better
>>> approach than ours lies in how unsuccessful build jobs are
>>> categorized.  ...
>>> ...
>>> This makes it easier, both for humans looking at the Travis CI web
>>> interface and for automated tools querying the Travis CI API,...
>>> ...
>>> A verbose commit message for such a change... but I don't know why we
>>> started with building Git in the 'before_script' phase.
>>
>> Thanks for writing it up clearly.  TBH, I didn't even realize that
>> there were meaningful distinctions between the two cases after
>> seeing that sometimes our tests were failing and sometimes erroring
>> ;-)
>
> I understand the reasons for the proposed patch. However, I did this
> intentionally back then. Here is my reason:
>
> If `make` is successful, then I am not interested in its output.

If 'prove' is successful, then I'm not interested in its output ;)

> Look at this run: https://travis-ci.org/szeder/git/jobs/324271623
>
> You have to scroll down 1,406 lines to get to the test result
> output (this is usually the interesting part).

That's the just beginning of a looong list of executed test scripts in
seemingly pseudo-random order.  IMHO that's very rarely the interesting
part; I, for one, am only interested in that list in exceptional cases,
e.g. while tweaking the build dependencies or the 'prove --state=3D...'
options.

These are the really interesting parts of the build job's output, the
parts that do matter most of the time:

  # compiler error
  https://travis-ci.org/git/git/jobs/325252417#L1766
  # which tests failed
  https://travis-ci.org/git/git/jobs/315658238#L2247
  # stray build artifacts
  https://travis-ci.org/szeder/git/jobs/323531220#L2236
  # (no example logs for erroring while installing dependencies, OSX
  # timeout, etc.)

Note that these are all at the very end of the trace log, i.e. they are
easily accessible by one or two keystrokes (depending on whether the
keyboard has a dedicated 'End' key or requires an Fn combo), a vigorous
drag of the scrollbar, or a click on the "Scroll to end of log" circle
in the top right corner.

> If this is a valid argument for you,

I'm unconvinced :)

> would it be an option to
> pipe the verbose `make` output to a file and only print it in case
> of error (we do something similar for the tests already).

It's risky, because the build process would be completely silent for the
duration of building Git.  Travis CI considers a build 'errored' if it
doesn't produce any output for 10 minutes.  While building Git usually
takes much less time, transient slowdowns apparently do occur.

G=C3=A1bor
