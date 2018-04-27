Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 767C21F424
	for <e@80x24.org>; Fri, 27 Apr 2018 19:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932604AbeD0TIw (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Apr 2018 15:08:52 -0400
Received: from mail-lf0-f42.google.com ([209.85.215.42]:36002 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932574AbeD0TIu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Apr 2018 15:08:50 -0400
Received: by mail-lf0-f42.google.com with SMTP id w8-v6so4156830lfe.3
        for <git@vger.kernel.org>; Fri, 27 Apr 2018 12:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saville-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=20kY4k/W/l6P2ks10L8BEFk4iErTibak8V4TzcoG/EM=;
        b=YLLweyoa4okcmVzRoso69vToueUs5G+CaLEtDmvi9O/iO/po6rdFG7+F02IAGj/uA4
         URXtYaod9vYUXYArlRBA0gugd4pays7vZSs0ul32jFszYnybGvklt/MI6/FhNvjsmD/H
         4TYIWzbI9U9wQO36neSh3EUKMHYgmwsIS2zOSjpu1D4346TsDd5Ta0Lejq2moCWGPTnJ
         W1+3E3WoYBRR1UiZM8Pv9jzVGle76vqcyam8FP8APOfV5UzW2NKcQ1NlfDObslBI+qwo
         Tqntbdw18XuN+CV1NhOPkmUN7EjH95sBFudcLdA0jEX/UBv01dxC+HPODHLjJOvubTeK
         IpgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=20kY4k/W/l6P2ks10L8BEFk4iErTibak8V4TzcoG/EM=;
        b=SpfsdGzpz/3aKECxTgcdW12F8fpKZXbf1VwzaiA3DysLZUyaIHQw4V9yklUM7v7JLh
         PvhOx9OyDTEgpt/JYClqo9KCK7QznY5SXLcCbRLmZNlsKZ1YNQiN/G4iKYOclmB+1ZRw
         IJ65kP7RIltblfBQ2qDWvMN2p+1097EvNAFaT/mAoUC/pbvu6xfBKbnpEt+sLjO6Rd5q
         F+qU6nHaZBlb+6xpgHnn98YRrunL/yHyzQ4yCXRvl0ygGVhvAlSaBDRnFpYqZHlppgRJ
         4PyCoMPcZ+HrsWMma5bL++6jNSB5ZtXf0ZyR5AAkP+qc1K2VAwynY+iq6tnlmitkr/GO
         D9LA==
X-Gm-Message-State: ALQs6tDLqGe2ARdbXbEQI4n/cnIe0tXXmvhBh+dAKvj7siOriGCu6S23
        Js0VCCf9lU+zsxG0Rc2raYIurqcqIFYzVZ37cEApoiiNDCQ=
X-Google-Smtp-Source: AB8JxZpETxKAK5ZLmoMUdLtrq0HJUW92nMJqiD4S5zZpXm2BDRnhe84f4FCtsvAQ+JO0wBaXSHTXvztpamxdVHb20dc=
X-Received: by 2002:a19:5386:: with SMTP id h6-v6mr1971946lfl.45.1524856128507;
 Fri, 27 Apr 2018 12:08:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:9ecc:0:0:0:0:0 with HTTP; Fri, 27 Apr 2018 12:08:27
 -0700 (PDT)
In-Reply-To: <xmqqbme51rgn.fsf@gitster-ct.c.googlers.com>
References: <CAKk8isrAmWOdioJe2CdY+2F_AzKxcTGwd+kBsrAmGx-U=ZHGgA@mail.gmail.com>
 <xmqqzi1s3y5h.fsf@gitster-ct.c.googlers.com> <CAKk8isr-7bSVqEv8EjF2UgFfw75D2oVZPJFui30pbY6kWfeL_Q@mail.gmail.com>
 <CAKk8ispWBoG7D+u8x+s+iB+wzXUN=7vpxgmz5wjL67P6XUmw9g@mail.gmail.com>
 <xmqqfu3h1t22.fsf@gitster-ct.c.googlers.com> <xmqqbme51rgn.fsf@gitster-ct.c.googlers.com>
From:   Wink Saville <wink@saville.com>
Date:   Fri, 27 Apr 2018 12:08:27 -0700
Message-ID: <CAKk8isqAd11W4DpjNkd9AeMDGi=ESyhVSFXcvwteasTfHMPGLA@mail.gmail.com>
Subject: Re: Fetching tags overwrites existing tags
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 26, 2018 at 4:24 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>
> Hence (1) we should detect and error out when --prefix-tags is used
> with mirror fetch near where we do the same for track used without
> mirror fetch already, (2) detect and error out when --prefix-tags is
> used with track, and (3) add "+refs/tags/*:refs/remote-tags/$name/*"
> just once without paying attention to track here.  We may not even
> want add_remote_tags() helper function if we go that route.
>

I've replied to the thread using format-email/send-email with the
subject: "[RFC PATCH v2] Teach remote add the --prefix-tags option",
but I misspelled Junio's email address :(

I've tried to address the issues pointed out by Junio. But I've choosen
not to do "(2) detect and error out when --prefix-tags is used with track".
My thinking is tags are independent of tracking and it seems reasonable
that they sould be included if requested. If I'm wrong I'll certainly fix it.

The other change was rather than using ""+refs/tags/*:refs/remote-tags/$name/*"
I've changed it to "+refs/tags/*:refs/remote/tags/$name/*" which seems cleaner.
Again, if remote-tags is preferred I'll change it back.

One other question, I'm not sure "--prefix-tags" is the best name for
the option,
maybe "--sub-tags" or "--nested-tags" or ...

-- Wink
