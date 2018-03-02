Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77B9F1F576
	for <e@80x24.org>; Fri,  2 Mar 2018 09:56:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425971AbeCBJ4s (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Mar 2018 04:56:48 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:41992 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424800AbeCBJ4n (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Mar 2018 04:56:43 -0500
Received: by mail-lf0-f65.google.com with SMTP id t204so12473961lff.9
        for <git@vger.kernel.org>; Fri, 02 Mar 2018 01:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ELwqaRKO/XeySf4R8rLzGcZpQEagM/sC330bPfOMYPE=;
        b=YvHsM5cxrSVbuHkWFvIMhjcfkU0HDtjZ8P1UQ8bOvPBXBW8bYuOD8gmFRp90uTbiyy
         pYjwIafJHgRyy+zDlzDDkpvidWz0zBYANKa3png/5z+loeirtk+2dEnIKuEmVeHOXv3n
         33mEF/7tVeMmvhM7D0pPf/y86OU8df1QPX/uNGQYhyYUtpuTLjufyWsbmVjz7p07ntGT
         JhquMQLmIGxAUTZUkOFTRwetXjUVCTjdlMGO+l7/1gbJbu/MYeUmziviCe4EmB7Xr+7G
         WY0dXiKMJtcIUTJ7Gfz7uPSVkBIw5YCgiN5W4r+39L5nzSWI6BjAQpjzAvemAKq9K6iH
         79/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ELwqaRKO/XeySf4R8rLzGcZpQEagM/sC330bPfOMYPE=;
        b=QtnysEBUtQcYkNMYOCEqZX1YRTOBre7bKA75Y3vFk9r6IDE9lI2sySejJCfZ6WQ7ev
         JgyUt/GFgUPyzI2+WzbWvPFOA4WCzN0/Yaw3v8tfqPNTS3g8Ep+FEjolnQTUGDvGsWpH
         cS+QwjG00DDpVblfFG5kGKRjtn1owTgTABXl05VdsR2J86jCV6CX9QROPkN1OLJ1T0oR
         7RsemP2pQa/bJYlIkjJdHZ+01yW7kIpcIfgHGWjRRHGGy1qeljM03qm37QQerZbeHr5J
         5o1Ri3rgYx92AIXAYV7Dz1SJg3uFH3emA/QotEWODtn+INLcdpVgCoGY0+wvreQVQKGt
         0mLg==
X-Gm-Message-State: AElRT7HGQTrMpJfN2k2kjLUw+lhcCbVnwmqMCGYnOHS0uUAN3N2W4ZrI
        WKGpt2NoxTSg1fXkr7L8e2+w3+Mbnr1XRk/0C16RZdLs
X-Google-Smtp-Source: AG47ELuZ8Owc5x5TtNXw61csEHmNsP4lL88j/BzP4oI6zdSHpMeK5we2JDcrt1gKgBWrC9JHcd2YaHUURjE66UzsQWU=
X-Received: by 10.25.29.81 with SMTP id d78mr3732746lfd.18.1519984602003; Fri,
 02 Mar 2018 01:56:42 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.80.67 with HTTP; Fri, 2 Mar 2018 01:56:41 -0800 (PST)
In-Reply-To: <CAPig+cRt+u4yEnFLM3kUB_J54Xvt6V9ceb6rwqfHC3kb=fttGg@mail.gmail.com>
References: <CAGr--=LxMtz5RRP4742u3VsrADRsWARE2SitCSOWATySOn2LcQ@mail.gmail.com>
 <20180301143904.28652-1-birgersp@gmail.com> <CAPig+cRt+u4yEnFLM3kUB_J54Xvt6V9ceb6rwqfHC3kb=fttGg@mail.gmail.com>
From:   Birger Skogeng Pedersen <birgersp@gmail.com>
Date:   Fri, 2 Mar 2018 10:56:41 +0100
X-Google-Sender-Auth: I3B2CxbtsdXMbLDUJNyGF9QAKDI
Message-ID: <CAGr--=JqXhwEtOrs0K3cscVa=LV75ejz=TYKtV7mgrd_96Jk6w@mail.gmail.com>
Subject: Re: [PATCH] git-gui: bind CTRL/CMD+numpad ENTER to do_commit
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry about that. Version 2 coming right up.

On Thu, Mar 1, 2018 at 7:31 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Thu, Mar 1, 2018 at 9:39 AM, Birger Skogeng Pedersen
> <birgersp@gmail.com> wrote:
>> ---
>
> Please sign-off on your patch. See Documentation/SubmittingPatches.
>
> Also, it would be helpful to write at least a short commit message
> justifying the change. The reason you gave in your lead-in email[1]
> might be sufficient:
>
>     In git-gui, we can hit CTRL/CMD+ENTER to create a commit. However,
>     using the numpad ENTER does not invoke the same command.
>
> (assuming people don't argue that numpad ENTER should be saved for
> some other function).
>
> Thanks.
>
> [1]: https://public-inbox.org/git/CAGr--=LxMtz5RRP4742u3VsrADRsWARE2SitCSOWATySOn2LcQ@mail.gmail.com/
>
>> diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
>> index 91c00e648..6de74ce63 100755
>> --- a/git-gui/git-gui.sh
>> +++ b/git-gui/git-gui.sh
>> @@ -3867,6 +3867,7 @@ bind .   <$M1B-Key-equal> {show_more_context;break}
>>  bind .   <$M1B-Key-plus> {show_more_context;break}
>>  bind .   <$M1B-Key-KP_Add> {show_more_context;break}
>>  bind .   <$M1B-Key-Return> do_commit
>> +bind .   <$M1B-Key-KP_Enter> do_commit
>>  foreach i [list $ui_index $ui_workdir] {
>>         bind $i <Button-1>       { toggle_or_diff click %W %x %y; break }
>>         bind $i <$M1B-Button-1>  { add_one_to_selection %W %x %y; break }
