Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2244720A78
	for <e@80x24.org>; Thu,  2 Feb 2017 02:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750954AbdBBCAL (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Feb 2017 21:00:11 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34187 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750774AbdBBCAK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2017 21:00:10 -0500
Received: by mail-wm0-f66.google.com with SMTP id c85so715069wmi.1
        for <git@vger.kernel.org>; Wed, 01 Feb 2017 18:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/MZu4gtGBeuFZGAT9JOmaCKAYxOaZGP7bjdEtYgFT5E=;
        b=G9QYaUikB9L5+GSBNeQKCohSaBbtii9NOmJpySassR98vHWfCmcIHnEPlxS4D6YTeH
         0z+KsNKDniCt6O5huwx9Kl9rXbcklmf0nrr9iFdLvUjFFovu8HtyKuAkreK87lX9i0s7
         kfvz8ulAz3KlnhUnaDWKfT2h+NBcQRiaCa4TCPVz+4KQJjueTaXlKu2wHKWSdqcyJ61N
         4AHqUnO9j1iEA6bX3waIkVwsSP8a75ykXJ+cHeA9RZTiSyTG/3KpryWzkDwxkqXGtkqY
         P8BPxcWJkp61b5KJDd9XW/HtW7JYvFH7bzFG21Qp5SWXEryDBdsdmhrXa09nlTdVdAb8
         73TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/MZu4gtGBeuFZGAT9JOmaCKAYxOaZGP7bjdEtYgFT5E=;
        b=HN2wGn63JnK7p9P81R7HiPJ+F7G9ptrk5PbMyA8dAZEtsOi99OCvAInrQhld4wKLUa
         DBO9WMD8IBL3tv7V5WnQYnGpE3kY4P6nYEhMWLpjW+VatJ/ivDDCTD8kqvXVj8YB3u0Z
         bXNrK3Pwb5IW37gmAYK88JoJCuGiouZQfayVPM4sK/2lYj+KvZLudiyIJnbJ9jnh2Qqb
         cKiuj/UVK0Ygj9Uj91hisJnEIcth/U23zE+knG2LhH2+rj31oyHbM5/z8AmBQnTLqBin
         GrHZF5EHju6yysbVDMZlDgytiDxtBn4m7g+sZ5DYlLuJDDRlK4zDsFpcprYW12GawRja
         q8nw==
X-Gm-Message-State: AIkVDXIVjh30SI+fJ9U+acvvsJ3GzEgJmpNcgYh7Ba0GDiOeDMkEcRWfYQuS7zZTXuaasBU3cni6up+OvSxslA==
X-Received: by 10.223.134.218 with SMTP id 26mr4969529wry.104.1486000808541;
 Wed, 01 Feb 2017 18:00:08 -0800 (PST)
MIME-Version: 1.0
Received: by 10.194.249.8 with HTTP; Wed, 1 Feb 2017 18:00:08 -0800 (PST)
In-Reply-To: <2841d2de-32ad-eae8-6039-9251a40bb00e@tngtech.com>
References: <74ecd09c-55da-3858-5187-52c286a6bf62@kdbg.org>
 <20170127211703.24910-1-cornelius.weig@tngtech.com> <20170127211703.24910-2-cornelius.weig@tngtech.com>
 <CAM0VKj=Ein4yrKG2aZnN7JU80ctZBQromcR6BEu-TyMLenLFCg@mail.gmail.com> <2841d2de-32ad-eae8-6039-9251a40bb00e@tngtech.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Thu, 2 Feb 2017 03:00:08 +0100
Message-ID: <CAM0VKjkAnsT_LE4OZRkLPuiEZW88P7_OBbOw0XovHhLYfBhbwg@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] completion: recognize more long-options
To:     Cornelius Weig <cornelius.weig@tngtech.com>
Cc:     j6t@kdbg.org, Shawn Pearce <spearce@spearce.org>,
        git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 1, 2017 at 5:49 PM, Cornelius Weig
<cornelius.weig@tngtech.com> wrote:
> Hi Gabor,
>
>  thanks for taking a look at these commits.
>
> On 01/31/2017 11:17 PM, SZEDER G=C3=A1bor wrote:
>> On Fri, Jan 27, 2017 at 10:17 PM,  <cornelius.weig@tngtech.com> wrote:
>>> From: Cornelius Weig <cornelius.weig@tngtech.com>
>>>
>>> Recognize several new long-options for bash completion in the following
>>> commands:
>>
>> Adding more long options that git commands learn along the way is
>> always an improvement.  However, seeing "_several_ new long options"
>> (or "some long options" in one of the other patches in the series)
>> makes the reader wonder: are these the only new long options missing
>> or are there more?  If there are more, why only these are added?  If
>> there aren't any more missing long options left, then please say so,
>> e.g. "Add all missing long options, except the potentially
>> desctructive ones, for the following commands: ...."
>
> Personally, I agree with you that
>> Adding more long options that git commands learn along the way is
>> always an improvement.
> However, people may start complaining that their terminal becomes too
> cluttered when doing a double-Tab. In my cover letter, I go to length
> about this. My assumption was that all options that are mentioned in the
> introduction of the command man-page should be important enough to have
> them in the completion list.

But that doesn't mean that the ones not mentioned in the synopsis
section are not worth completing.

The list of options listed by the completion script for several of
these commands fits on a single line.  The command with the most
options among these is 'git pull', and even its options don't fill
more than half of a 80x25 screen.  I see no danger of people coming
complaining.

> I'll change my commit message accordingly.
>
>>>  - rm: --force
>>
>> '--force' is a potentially destructive option, too.
>
> Thanks for spotting this.
>
> Btw, I haven't found that non-destructive options should not be eligible
> for completion. To avoid confusion about this in the future, I suggest
> to also change the documentation:
>
> index 933bb6e..96f1c7f 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -13,7 +13,7 @@
>  #    *) git email aliases for git-send-email
>  #    *) tree paths within 'ref:path/to/file' expressions
>  #    *) file paths within current working directory and index
> -#    *) common --long-options
> +#    *) common non-destructive --long-options

I don't mind such a change, but I don't think that list was ever meant
to be comprehensive or decisive.  It is definitely not the former, as
it's missing several things that the completion script does support.
OTOH, it talks about .git/remotes, which has been considered legacy
for quite some years (though it's right, because the completion script
still supports it).

> I take it you have also looked at the code itself? Then I would gladly
> mention you as reviewer in my sign-off.

Yeah, most of the changes was rather straightforward, except the
completion of 'git remote's subcommands' options, but that looks
good, too.

G=C3=A1bor
