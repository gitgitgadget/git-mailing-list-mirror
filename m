Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 292201F404
	for <e@80x24.org>; Mon,  5 Mar 2018 22:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753048AbeCEWWs (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 17:22:48 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:37008 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752910AbeCEWWq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 17:22:46 -0500
Received: by mail-qk0-f195.google.com with SMTP id y137so22630754qka.4
        for <git@vger.kernel.org>; Mon, 05 Mar 2018 14:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=nBpXqXRuB5gygfIwhM07cahvh3EOk88I6ULJfQQYqFA=;
        b=UKYC8sm2g3BKsE+Epr6yI43d0AHagL2EMZB3UpfsBzuCEK4TbGmNH6mqaYQOZh7nTW
         RCd/bt0D8GBEQAUknc05zWl3G1jSuwPAjH67HrizE6MF5guMfCaEOkAU0R/1afmYPkx0
         ovi482ba5YdN6HZEhahFODfynG18rr3fRbCGx1YqLEellvQyAreCAvfUMzgSc/sJBeKM
         tJ04m5TWHIvSc8HpR83ABJhxN1n2KCAwN6U1kwyV804B3MDA7pNAFA1OtZVaB8vCMn0x
         TJK4RSH2X39oM/8xuG7DK1boPi/bdUgh2Pk5oF1TCUvgn9V4g0yFLBR9qsW11oTOISj0
         FMdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=nBpXqXRuB5gygfIwhM07cahvh3EOk88I6ULJfQQYqFA=;
        b=hx9UFYCsKPV6qwmNHR6OyL4RqHktTTVZwPAT5/XDmEj+HwemBGcOZ/cm9R/Zlgu2S/
         ak4ePkYJKlOiRAd3CYp4VMTaXuwPSFyEu90EcjIgUBZBXFO0eqwW1foboytBKMPt531r
         I4yOh+O7xm8AVtN59WafUNr5rhW8LFGLKuAOSQ+H20joeC/V90r/NyaKaG2vSp9mUmcS
         zYDV8wyhxxcoDJ2QgrXAfPvGYebjvLlakm220oxPH0tSZi8/M7ViiSzYFpueeoTnjfam
         20LNuteWD4Bd6zo7o7BBS23qjh/aLRYJ+O88ki2rXZyk4XzuS7as66EAQJ3DgRuS6nJJ
         ZCSg==
X-Gm-Message-State: AElRT7E4Zmws8feWJ61GSRr2xpcOydVG3gEfgV3VUq5rCFxlRq1T/5NV
        9YeKk6Ese3pa3nkXFKMHUejvaeJOyWj6nivVZD8=
X-Google-Smtp-Source: AG47ELsduAFEOENv325V/K4XeLzuBuEVG4qOhOh/Y9LyNzmXC/TTdz3IcaHuJyVycR1Z0tJc7GtOQj1SPJgVWVtNAJA=
X-Received: by 10.55.134.133 with SMTP id i127mr24963875qkd.275.1520288565572;
 Mon, 05 Mar 2018 14:22:45 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.142.14 with HTTP; Mon, 5 Mar 2018 14:22:45 -0800 (PST)
In-Reply-To: <CAFhHFBysKuDO9H4yJtnC6MJ+Jih5q4RsfwHTCsRXhXknapp4xg@mail.gmail.com>
References: <20180304112237.19254-1-asheiduk@gmail.com> <20180304112237.19254-2-asheiduk@gmail.com>
 <CAPig+cQTpbj6q_s_pX2HjmpYF4W+5wKH7YLQQdZTiMPfK4G2Ng@mail.gmail.com> <CAFhHFBysKuDO9H4yJtnC6MJ+Jih5q4RsfwHTCsRXhXknapp4xg@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 5 Mar 2018 17:22:45 -0500
X-Google-Sender-Auth: 4QcXIIby_1mEPLM0e1xE_z_NMsQ
Message-ID: <CAPig+cSRF0g_+rq_Ga-kg+fh2XnUobVKodkR9Z=pVskq7vRU6w@mail.gmail.com>
Subject: Re: [PATCH 2/2] git-svn: allow empty email-address in authors-prog
 and authors-file
To:     Andreas Heiduk <asheiduk@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Eric Wong <e@80x24.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 5, 2018 at 4:37 AM, Andreas Heiduk <asheiduk@gmail.com> wrote:
> 2018-03-05 2:42 GMT+01:00 Eric Sunshine <sunshine@sunshineco.com>:
>> On Sun, Mar 4, 2018 at 6:22 AM, Andreas Heiduk <asheiduk@gmail.com> wrote:
>>> The email address in --authors-file and --authors-prog can be empty but
>>> git-svn translated it into a syntethic email address in the form
>>> $USERNAME@$REPO_UUID. Now git-svn behaves like git-commit: If the email
>>> is explicitly set to the empty string, the commit does not contain
>>> an email address.
>>
>> Falling back to "$name@$uuid" was clearly an intentional choice, so
>> this seems like a rather significant change of behavior. How likely is
>> it that users or scripts relying upon the existing behavior will break
>> with this change? If the likelihood is high, should this behavior be
>> opt-in?
>
> I don't know nor understand the intial choice. Didn' git-commit support
> empty emails once upon a time? Or is the SVN-UID important for some
> SVK/SVM workflows?

I don't know the answer to either question. As I've only ever used
git-svn a few times many years ago, I can't speak of the reason behind
the name@uuid fallback, but that it was intentional suggests that
there may have been a good reason for it.

> My reasoning was: If authors-prog is NOT used, the behaviour
> is unchanged - the UUID will be generated. If a Script IS used, then I
> assume that a valid email was generated and this change will not
> break these scripts. Only scripts intentionally not generating emails
> will break. But again - was would be the purpose of such a script?
> And such a script can be easily changed to add the UUID again.

As I'm not the author of every script in the wild, I can't answer as
to the purpose of a script working in such a way, but that there may
be such scripts makes me cautious. We don't know how easy it would be
for a script to be "fixed" for this new behavior or even how soon the
"breakage" would be noticed for scripts which have been working
properly and quietly in the background for years.

> So I think adding an explicit opt-in does not pay off.

I defer judgment to Eric W.'s area expertise.

>>>         if ($author =~ /^\s*(.+?)\s*<(.*)>\s*$/) {
>>>                 my ($name, $email) = ($1, $2);
>>> -               $email = undef if length $2 == 0;
>>>                 return [$name, $email];
>>
>> Mental note: existing behavior intentionally makes $email undefined if
>> not present in $author; revised behavior leaves it defined.
>
> But only if the data comes from authors-prog. authors-file is unaffected.
>
>>
>>>         } else {
>>>                 die "Author: $orig_author: $::_authors_prog returned "
>>> @@ -2020,8 +2019,8 @@ sub make_log_entry {
>>> -               $email ||= "$author\@$uuid";
>>> -               $commit_email ||= "$author\@$uuid";
>>> +               $email //= "$author\@$uuid";
>>> +               $commit_email //= "$author\@$uuid";
>>
>> With the revised behavior (above), $email is unconditionally defined,
>> so these //= expressions will _never_ assign "$author\@$uuid" to
>> $email. Am I reading that correctly? If so, then isn't this now just
>> dead code? Wouldn't it be clearer to remove these lines altogether?
>
> The olf behaviour still kicks in if
>  - neither authors-file nor authors-prog is used
>  - only authors-file is used

Okay.

>> (However, there has lately been some talk[1] about bumping the minimum
>> Perl version to 5.10.)
>>
>> [1]: https://public-inbox.org/git/20171223174400.26668-1-avarab@gmail.com/
>
> Did the thread result in some actual action?

Not to my knowledge. Scanning the thread, it looks like the issue is
still hanging.
