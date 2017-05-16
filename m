Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50178201A7
	for <e@80x24.org>; Tue, 16 May 2017 03:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751132AbdEPDVk (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 23:21:40 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:34888 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751134AbdEPDVi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 23:21:38 -0400
Received: by mail-pg0-f47.google.com with SMTP id q125so49964500pgq.2
        for <git@vger.kernel.org>; Mon, 15 May 2017 20:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Njau09IcUfFTCmykCTZW5zlD1SZmIwhMBf3ZhYKGZ80=;
        b=n4sMKGhuURx1jBJRRGREKsVtUir+EnHC1QMpRWAqgp0UxGsMXBzz6AkbftT7Mc/wVR
         Pd4n8ob+XjJw/jX8pxz3PdUu41m/fgYUwf60rddyjNBPQnMiECRXdF6zlqLtwGOFmLfI
         +FyW/tYrDNKmlGBf+W1oe0/2TcZQXj8ye+SFlEplkMDEawJ5QDh9ljQ3c9vkARsN6Xuo
         lZlFMTGpX0YHi7dY5IuedbkenzB5KYtqeB13Qf8pJ1tu6jt25w8uE2rirngXgsOHSE7a
         pjHU2eGlmbEWTFblGuIlYlt5jBW+RqjhCee4LjQ+zxTX6VyAU/ofPk+Dnns4AaK8SRlO
         ++hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Njau09IcUfFTCmykCTZW5zlD1SZmIwhMBf3ZhYKGZ80=;
        b=JO26I5K9zE3lOZ4VGcTLdzbMa2GXqn+lBRM78TlSEz9egewfgcSOXdsI6//pJOZoTz
         3bK1haU+D5kx5F6umlxR+nYGfsoB+Wt3DmXbt1/jfqZWacFkvaoeTlgwWq3taGIMreL3
         BZX88uRsWnagnT/XnFzbhSZYzRPMhkGIkoacWv/twraAumS0Yv09/5SRDOv7/JkjpAvO
         IXhf/EOpdhclqo2FdIjqqOGP3wmV3gaIcO4Vg6g/qhMCpf6dGqSY0yL5U3IWtVsbRpw2
         pP888ZPd1CUebn+Oy/5tExkzD22iuAhc08K2mlXQ7XD9lgHRoO23nV/ujlEJY72AQvZI
         rmMw==
X-Gm-Message-State: AODbwcD5BoH8uhFHCqtwDgZT2qzmeiC1sk1n1YcSkJo6CYG0KNZSUkTG
        2jy7PpUPMXgp0g==
X-Received: by 10.84.198.36 with SMTP id o33mr12935750pld.145.1494904897683;
        Mon, 15 May 2017 20:21:37 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:8dc7:ff72:325b:10d7])
        by smtp.gmail.com with ESMTPSA id g23sm14739954pfb.54.2017.05.15.20.21.35
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 15 May 2017 20:21:35 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeffrey Smith <whydoubt@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH v2 00/22] Add blame to libgit
References: <20170505052729.7576-1-whydoubt@gmail.com>
        <20170514031513.9042-1-whydoubt@gmail.com>
        <xmqq7f1iv5fn.fsf@gitster.mtv.corp.google.com>
        <CAPX7N=4jidx5pr3BfFoTL27gbHDT6sdm1q2Z2YxfjsBuN01XaQ@mail.gmail.com>
        <xmqqefvp6458.fsf@gitster.mtv.corp.google.com>
        <CAPX7N=5=M=wjTbKQoctndqrHxYSb86bEwej8ofoOovsYHWFkKA@mail.gmail.com>
Date:   Tue, 16 May 2017 12:21:34 +0900
In-Reply-To: <CAPX7N=5=M=wjTbKQoctndqrHxYSb86bEwej8ofoOovsYHWFkKA@mail.gmail.com>
        (Jeffrey Smith's message of "Mon, 15 May 2017 21:44:58 -0500")
Message-ID: <xmqqd1b94hc1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeffrey Smith <whydoubt@gmail.com> writes:

> On Mon, May 15, 2017 at 7:23 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Jeffrey Smith <whydoubt@gmail.com> writes:
>>
>>> I did try to keep any unnecessary changes out of the big movement
>>> patches (17-19).  Would you prefer I break down 19 further?  I had
>>> been holding back because of the added churn that would introduce from
>>> lots of changing function visibility in blame.h and blame.c.
>>
>> To be honest, the "rename symbols while moving" done starting around
>> 04/22 made the series too noisy to read and I had hard time
>> reviewing the later ones like 17-19.  I think they share exactly the
>> same issue as 04/22, e.g. 17/22 renames origin_decref to
>> blame_origin_decref while moving the function and some of its
>> callers across files.
>
> Hm, I really thought I had split some of those out.  Patches 4, 5, 17, and 19
> could all be reasonably split into rename vs move patches.  Patch 18 only
> does moving.
>
> I do not see much benefit to splitting up the 'move xyz to scoreboard'
> subset (6-12) that way as moving an item to scoreboard is already causing
> each use to change (from xyz to sb->xyz).

Perhaps it would be better to repeat and clarify what I suggested
once more.

 * Keep mechanical changes separate from real changes,
 * Keep each real change separate from each other,
 * Keep the same kind of mechnical changes together, and
 * Keep different kinds of mechanical changes separate.

So, if you are moving some globals into a structure, we want a patch
that does that for a set of related globals and adjust their uses,
and do nothing else.  You'll probably have a handful of them in the
end.  For each of these real changes, it is usually better to have
more and smaller patches than to have fewer and larger patches.

Then if you are remaing a bunch of structure types and/or variable
names, we want a patch that does that mechanical change (i.e. rename
"struct foo" and "struct bar" to "struct blame_foo" and "struct
blame_bar") that does not do anything else (i.e. do not move lines
across files in the same patch).  As I said already, this does not
have to be one per struct type.  We can say "renaming symbols" is
just one kind of mechanical changes, which is different from "moving
lines across files".

Finally, move the lines across files (and again, do nothing else).
Having to turn "static something" into "extern something" is part of
moving the lines across files, and we do want to see that in the
same patch.  But renaming something to blame_something should have
already be done while these lines were in builtin/blame.c in an
earlier step.

Thanks.
