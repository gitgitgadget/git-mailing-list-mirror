Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5CB62022A
	for <e@80x24.org>; Tue, 25 Oct 2016 08:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754667AbcJYIUV (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Oct 2016 04:20:21 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:34804 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753155AbcJYIUS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2016 04:20:18 -0400
Received: by mail-ua0-f196.google.com with SMTP id 6so2013024uat.1
        for <git@vger.kernel.org>; Tue, 25 Oct 2016 01:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HThuqO4bY0X43c+yfvKpDJ5izJ9TjMoZHAA4PuTuP5U=;
        b=j15uhGd/XH6iFEG3RFyb8+IEBQ8+6oP+3UooFzVL2mkj/U4C9BEqmCVSl8YoYi171J
         tt/0Ec3gNf06HxEAP/Q+v6APpQ0BUEsN/HvXGeN9A8bzdNRRQGoT49B1iY4IbwYC1bxx
         BiU9P92B0dPWO4ALLWuwi5N2jhWNyEysrcEElyqX2nRH6SxrmNM8Z6zTqfrg+K/Vfh/D
         2Xir0hRqQAvXz6Zu4sP+AXEgMfg02dxbDTcLf8M4rWcuzc+BGxr9YIcsgVxwbmSbdztX
         z6IBFu6bf830dXfipCDHZZzbBDHV3zy1fb9UieVcAiuotpv6W3iwCuPP/Bgk9JoCuZeV
         3OYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HThuqO4bY0X43c+yfvKpDJ5izJ9TjMoZHAA4PuTuP5U=;
        b=ZsegwzH6I9Ps6VGLa9CRl7icSwBbERLnNB5OodQAQcp/VruEuDk5OxH+dPwK9s/bHr
         bhwg//yMOR0MDDiPxQdIHj1q2hk4fe06pMWR48Eq9Fl21toZpfOttYQHn/dDb3ct1USl
         JGsnRft00gXpueHMCyeU0OCzGh6LargW/b+DSpHz9FBJ005qbHOWpuLooIeOfE6603eB
         MLvXEYOEYzRBMrh/XTlbklrltKxxqliCg8lhMCLV160lHpUiaJZ4rFSro4It/V61GVCg
         6nHBP6w/so5OJPqgblCxkl/kn6gKQnUnj0uhZvt5cl6HG+hGdDXtXPhEI3B9xpLNs5U/
         w0Uw==
X-Gm-Message-State: ABUngvdFATHyLMvMhEEEVerGDIRsw0C5t7KWzHS/aCQjbxPbB/wAjR0fkF6FS7IV3HrAqtBiz7vs+FSFVNvFJw==
X-Received: by 10.176.3.183 with SMTP id 52mr11305732uau.10.1477383617486;
 Tue, 25 Oct 2016 01:20:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.31.200.133 with HTTP; Tue, 25 Oct 2016 01:20:17 -0700 (PDT)
In-Reply-To: <20161025081149.x5l5zcupva546ssf@sigill.intra.peff.net>
References: <1473378397-22453-1-git-send-email-watsona4@gmail.com>
 <1477352413-4628-1-git-send-email-watsona4@gmail.com> <20161025081149.x5l5zcupva546ssf@sigill.intra.peff.net>
From:   Aaron and Ashley Watson <watsona4@gmail.com>
Date:   Tue, 25 Oct 2016 04:20:17 -0400
Message-ID: <CAB0+k9KWLo-cBGceJ5fzU41ZKbbii5dbxy5TYUbOhybivKcWGg@mail.gmail.com>
Subject: Re: [PATCH] Allow stashes to be referenced by index only
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Jon Seymour <jon.seymour@gmail.com>,
        David Caldwell <david@porkrind.org>,
        =?UTF-8?Q?=C3=98ystein_Walle?= <oystwa@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        David Aguilar <davvid@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 25, 2016 at 4:11 AM, Jeff King <peff@peff.net> wrote:
> On Mon, Oct 24, 2016 at 07:40:13PM -0400, Aaron M Watson wrote:
>
>> Instead of referencing "stash@{n}" explicitly, it can simply be
>> referenced as "n".  Most users only reference stashes by their position
>> in the stash stask (what I refer to as the "index"). The syntax for the
>> typical stash (stash@{n}) is slightly annoying and easy to forget, and
>> sometimes difficult to escape properly in a script. Because of this the
>> capability to do things with the stash by simply referencing the index
>> is desirable.
>>
>> This patch includes the superior implementation provided by =C3=98sse Wa=
lle
>> (thanks for that), with a slight change to fix a broken test in the test
>> suite. I also merged the test scripts as suggested by Jeff King, and
>> un-wrapped the documentation as suggested by Junio Hamano.
>>
>> Signed-off-by: Aaron M Watson <watsona4@gmail.com>
>> ---
>
> Thanks, this version looks good to me.
>
> Oddly, it does not seem to apply. I get:
>
>   $ git am -3 ~/patch
>   Applying: Allow stashes to be referenced by index only
>   Using index info to reconstruct a base tree...
>   M       git-stash.sh
>   error: patch failed: t/t3903-stash.sh:604
>   error: t/t3903-stash.sh: patch does not apply
>   error: Did you hand edit your patch?
>   It does not apply to blobs recorded in its index.
>   Patch failed at 0001 Allow stashes to be referenced by index only
>
> The culprit seems to be the final hunk header:
>
>> @@ -604,7 +624,21 @@ test_expect_success 'invalid ref of the form stash@=
{n}, n >=3D N' '
>
> This should be "604,6", as there are 6 context lines, and your patch
> does not remove any lines.
>
> I suspect the maintainer can fix it up while applying, but for my
> curiosity: did you hand-edit it, or is there a potential bug in git's
> diff code?

I did indeed edit the patch by hand (I forgot to remove the spaces
after the > in the test file), but
the bug appears to be in emacs's diff-mode, not in git.

>
> -Peff



--=20
Aaron and Ashley Watson
