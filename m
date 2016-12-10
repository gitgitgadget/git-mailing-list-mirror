Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17487203EA
	for <e@80x24.org>; Sat, 10 Dec 2016 10:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752798AbcLJK6Y (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Dec 2016 05:58:24 -0500
Received: from mail-yw0-f176.google.com ([209.85.161.176]:35283 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751981AbcLJK6X (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Dec 2016 05:58:23 -0500
Received: by mail-yw0-f176.google.com with SMTP id i145so32871538ywg.2
        for <git@vger.kernel.org>; Sat, 10 Dec 2016 02:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=86gt/gLroq7TZR2W/j5eSqUmCFu3LSAR5kEaHY2kNJo=;
        b=i00MpUGlOKfCLcT4i8rYuLuMEc6uNmqjizgyHfWbk/e1TR66sTMzpFTP2aMXfYNRlF
         u9eh/JdN6+xtYp6UJ16KoTepV/aWQYIDrv29VYrEHLY0MaUbeh2tR2UnLWbjz0rKk6Ae
         Gf49SeNDwHyd6+21tEfsvpFYwNhQXLH1xK52lHQ7gdKlrTAnRCKa3Yu7PpQZHrRpW3Zs
         7hkgXhus1gp/24qjz3TRx8uqZpNH5NGY1UHb7/pxx2/7jJkieonbMoyD3NEuLxhC3PJ/
         5BcazXsqaEQ5as52uCBUujjwJMLvOHBmrGAQs7+zOWzztnhPRbMrWUoM1RcJK2lxc1xL
         oBoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=86gt/gLroq7TZR2W/j5eSqUmCFu3LSAR5kEaHY2kNJo=;
        b=VF01FJemCTQ1P1Ha4VmRYMbimbl6gih60MMgzirMQXGt18fzlrQE2VOc5wAW/U+nQc
         M7ZDeztL1SPy53Ab6RUCsHhfhtCWPDj3lqCzTel+hXykuLexLMziCtNjOMp4zw6yEkad
         fUkPGrAOVyGhdMvZKYqboMLmzKOYLFXkSETIKYG2DK8c8WnTjaKiA93qVQ3sb+UZIspj
         PV9X4MJd/piIph8iNZu61Y2kIS36S7hXFD29Sn+9z/mh090vy9YDiVPYz5EGY7BaygUi
         9l9SkjspzReOMraJc8UYFuK+v97xH5A7UYxGrypHZbrER1A2x1+NWfPIWmu0cBYVcr2C
         uwKA==
X-Gm-Message-State: AKaTC01aUsIPAlzHzWSHx0gDZHxD8hpWjqx6Ah4MHzXoKECaxGnLulEscoTYReemtDQlP524KW4ffAJcsT25Kg==
X-Received: by 10.129.163.69 with SMTP id a66mr85799095ywh.175.1481367502786;
 Sat, 10 Dec 2016 02:58:22 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.118.87 with HTTP; Sat, 10 Dec 2016 02:58:02 -0800 (PST)
In-Reply-To: <20161210090054.w6qhmszcjkatjhm5@sigill.intra.peff.net>
References: <CAFOYHZDs5rBt5+4D_ViMYfV04foq3h_UrsSMA3FfyMzLh9QdwA@mail.gmail.com>
 <20161209091127.sxxczhfslrqsqs3m@sigill.intra.peff.net> <xmqqshpwrjyz.fsf@gitster.mtv.corp.google.com>
 <CAFOYHZAsU_gNb=_K=iMFKFdt60SJ4Wm=Ag5=XMXuQgxNxCqWLA@mail.gmail.com> <20161210090054.w6qhmszcjkatjhm5@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Sat, 10 Dec 2016 02:58:02 -0800
Message-ID: <CA+P7+xpwzrbuOb_YzyCatvkhHxEAhP1LVWrnP-yDX=-zmL5uhQ@mail.gmail.com>
Subject: Re: Any interest in 'git merge --continue' as a command
To:     Jeff King <peff@peff.net>
Cc:     Chris Packham <judge.packham@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, GIT <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 10, 2016 at 1:00 AM, Jeff King <peff@peff.net> wrote:
> On Sat, Dec 10, 2016 at 09:49:13PM +1300, Chris Packham wrote:
>
>> > There is nothing to "continue" in a stopped merge where Git asked
>> > for help from the user, and because of that, I view the final "git
>> > commit" as "concluding the merge", not "continuing".  "continue"
>> > makes quite a lot of sense with rebase and cherry-pick A..B that
>> > stopped; it concludes the current step and let it continue to
>> > process the remainder.  So from that point of view, it somewhat
>> > feels strange to call it "merge --continue", but it probably is just
>> > me.
>>
>> Yeah I did think that --continue wasn't quite the right word. git
>> merge --conclude would probably be the most accurate.
>
> I'd be against giving it a subtly-different name. It's just going to
> frustrate people who cannot remember when to use "--conclude" and when
> it is "--continue". The strength of the proposal, IMHO, is that it
> abstracts the idea of "go on to the next thing or finish" across many
> commands.
>
> -Peff

Agreed. I think "continue" makes sense as the command had to "stop"
the merge so you could give input, and then you tell git to "continue"
which also happens to mean "finish the merge" and yes it may not be
100% accurate, but the point of adding "git merge --continue" is that
it simplifies the mental model between rebase, cherry-pick, and merge,
all of which stop and ask the user to resolve a conflict before
"continue"ing and finalizing that resolution.

Thanks,
Jake
