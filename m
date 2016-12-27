Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB47D200E0
	for <e@80x24.org>; Tue, 27 Dec 2016 18:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753020AbcL0SSR (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Dec 2016 13:18:17 -0500
Received: from mail-qt0-f169.google.com ([209.85.216.169]:34307 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753749AbcL0SSP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2016 13:18:15 -0500
Received: by mail-qt0-f169.google.com with SMTP id d45so111063680qta.1
        for <git@vger.kernel.org>; Tue, 27 Dec 2016 10:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=C37F7Hd75u/+GtEy+szo5dU2GMAcFzlYaxH0HcAiSU4=;
        b=apHXYq4A40WODT/GZqmFR7W77FrfkRwuJvVcVmvKItl2Cb2SWyDEwaL633AbkoWgLb
         YBhrHSbZEvtZcygeYLedqwFdqdvZlE6p3oak5xp4XrHhVuLb7j86I4k8qf3YHErJNF41
         o21/n1hAjoooECAYj9miEoL8wuyR92DN4giYBcYJonvkLAtzahHdlne9pkajhcc+kT2e
         FdvKrfrYJjLW/q0IIaIfFcQj/vdWqMd6LJfLZ3jrODd96w/nhElb69WpDXsfEcKTPWgK
         rMr5z3sYO+48LSl2Ne1vo9yFa6grMXEX+L96zp2TQCqqQhdnxCGxURDh4slq4E6ZR52k
         gXdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=C37F7Hd75u/+GtEy+szo5dU2GMAcFzlYaxH0HcAiSU4=;
        b=BlKA5ux0x0GN3KJ8V++IKATswXVdbGsjNGhejpWiadxUJWH260roApX9DrZ+zlUCNq
         V/QKCYmhzD6Bp/kAUem53EgZIqoTTEOXyZyEqk2v4aQ3MnK1c/55n+QTSuh4pVUC49Cg
         LSmJn4au4DJYqkTmT3F/yh+fIRBT9WjLa1ewzoryZ72RjhngNmEMJdRierx8+2haZ0+S
         5/2a6jlq6sw0pkdWnnSkCIBUooU1bCHr0y02jGdQkXGkUR+iWb80fdGHjbb6A8e74UTf
         KsnsvXHzf2I2bBpEZOHQvljl1DIGOCndNoAFvdSGefDaAgzfMYN5hdcgRG8LgsJocO3Z
         Xhrg==
X-Gm-Message-State: AIkVDXKkKUNW6rFHpmFpVeILow6nt8x1n9pA2/NbTgyhielZeBJN23Zkli+y4UbyWN91rlpkpFc2uz3wBHpoT0Oj
X-Received: by 10.200.50.147 with SMTP id z19mr25801466qta.207.1482862654212;
 Tue, 27 Dec 2016 10:17:34 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.146.7 with HTTP; Tue, 27 Dec 2016 10:17:33 -0800 (PST)
In-Reply-To: <xmqqmvfich2e.fsf@gitster.mtv.corp.google.com>
References: <20161220232012.15997-1-sbeller@google.com> <20161220232012.15997-5-sbeller@google.com>
 <xmqqmvfich2e.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 27 Dec 2016 10:17:33 -0800
Message-ID: <CAGZ79kaRY0x+31-UiiBU1iBXGKAgeTRSSjvN0isd7jdg-Y7_rQ@mail.gmail.com>
Subject: Re: [PATCHv5 4/4] rm: absorb a submodules git dir before deletion
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        David Turner <David.Turner@twosigma.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 26, 2016 at 5:10 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> @@ -342,6 +313,8 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
>>                       exit(0);
>>       }
>>
>> +     submodules_absorb_gitdir_if_needed(prefix);
>> +
>>       /*
>>        * If not forced, the file, the index and the HEAD (if exists)
>>        * must match; but the file can already been removed, since
>> @@ -358,9 +331,6 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
>>                       oidclr(&oid);
>>               if (check_local_mod(&oid, index_only))
>>                       exit(1);
>> -     } else if (!index_only) {
>> -             if (check_submodules_use_gitfiles())
>> -                     exit(1);
>>       }
>>
>
> Hmph.  It may be a bit strange to see an "index-only" remove to
> touch working tree, no?  Yet submodules_absorb_gitdir_if_needed() is
> unconditionally called above, which feels somewhat unexpected.

I agree. In a reroll I'll protect the call with

    if (!index_only)
        submodules_absorb_gitdir_if_needed(prefix);

>
>> @@ -389,32 +359,20 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
>>        */
>>       if (!index_only) {
>>               int removed = 0, gitmodules_modified = 0;
>>               for (i = 0; i < list.nr; i++) {
>>                       const char *path = list.entry[i].name;
>>                       if (list.entry[i].is_submodule) {
>> +                             struct strbuf buf = STRBUF_INIT;
>> +
>> +                             strbuf_addstr(&buf, path);
>> +                             if (remove_dir_recursively(&buf, 0))
>> +                                     die(_("could not remove '%s'"), path);
>> +                             strbuf_release(&buf);
>> +
>> +                             removed = 1;
>> +                             if (!remove_path_from_gitmodules(path))
>> +                                     gitmodules_modified = 1;
>> +                             continue;
>>                       }
>
> I do not see any behaviour change from the original (not quoted
> here), but it is somewhat surprising that "git rm ./submodule" does
> not really check if the submodule has local modifications and files
> that are not even added before remove_dir_recursively() is called.
>
> Or perhaps I am reading the code incorrectly and such a check is
> done elsewhere?

When determining if the entry is a submodule (i.e. setting
the is_submodule bit) we have

    list.entry[list.nr].is_submodule = S_ISGITLINK(ce->ce_mode);
    if (list.entry[list.nr++].is_submodule &&
      !is_staging_gitmodules_ok())
        die (_("Please stage ..."));

I think for clarity we could drop the is_submodule bit and only
and directly do

    if (S_ISGITLINK(ce->ce_mode) &&
      !is_staging_gitmodules_ok())
        die (_("Please stage ..."));

and below (the code that you quoted) also just check via
    S_ISGITLINK(ce->ce_mode)

Thanks,
Stefan
