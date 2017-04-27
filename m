Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B619D207D6
	for <e@80x24.org>; Thu, 27 Apr 2017 21:17:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423082AbdD0VR6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Apr 2017 17:17:58 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:36832 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755451AbdD0VR4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2017 17:17:56 -0400
Received: by mail-pf0-f177.google.com with SMTP id 194so38079749pfv.3
        for <git@vger.kernel.org>; Thu, 27 Apr 2017 14:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=J3Tue15Lbqs4AD2/FnkPopeSCe/ou1ACfmhM2fjZ908=;
        b=WEi4l/dcPXyg8l5ix5/Yhgr0f0ESjOaysRJ8gEyaXQ1IvwLdyvhnCfVPHlmxS4COaS
         Dalnu2UYTHCFbHyyM1rZUV9hNDLJgjFUHI1Q/hgbNcbi7C7a8JC4ZTUA4DhFO8G6OsYl
         QBbStVjPK8qHNBbNMinikwlKvl/eXZoTdkECL+tGssEB+5JzGt+/mLf8Ttlon6/jrgdM
         3XHx59dzer4UyBx+PPL4RNjzxS9wfnoj/k6BRwAl7/PUvtOrksmJZVjBUaLv17ffUSIO
         q1nbFqF/m2uOKPZM6EDGPydy7E/IdOeuo6YP1j/bcuC9SRrvZgrROwRQcU/kjU2TC8KQ
         LQPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=J3Tue15Lbqs4AD2/FnkPopeSCe/ou1ACfmhM2fjZ908=;
        b=Yvl7e1SUVBOzUogE2l2UmwGYrQjsIWRt8LcplcaYE2KHeAM47B1hT2QdCfPfOQ1YUK
         KnsrmyE9SUasFMjbLRf1JFQOYsHjz7qKAo31EkNIXLfDFWyVtZ2IhcKEb/Ln4T9SZE6l
         ERbjhRan7Egu/Or8zG2WP2yLPwRfboqafur0dI2yyC11ZySZrgardTJFIVCdhpQV5IcW
         W8gCayTSmwOV1taIZYZhebVDvQhqmG27zX+trt6taApqBDqKRakHCUe7KjeiLIkr3DIN
         toKWnNsJOLDpLCp9aYwJ81qWEr299WrvacjmmJrBeino3oVDYqnBKIg6qrYh7tq0Aluz
         Jwkw==
X-Gm-Message-State: AN3rC/6P90UUTwHOq8uioWwmVdFihxM3IPCj7Monr7krr4n8B1RuZrys
        PYLQ2c+mvMx0Em8teOwPOx6a7vya6vZO
X-Received: by 10.98.24.195 with SMTP id 186mr8140210pfy.35.1493327875605;
 Thu, 27 Apr 2017 14:17:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.153.156 with HTTP; Thu, 27 Apr 2017 14:17:55 -0700 (PDT)
In-Reply-To: <653b67e6-9dba-d331-c396-932a59cdb4da@alum.mit.edu>
References: <20161217005442.5866-1-jacob.e.keller@intel.com>
 <xmqq7f6zqr3i.fsf@gitster.mtv.corp.google.com> <CA+P7+xp=7h7oATwO6vunqO+nfGhvQgiRkwG0P44hC4YLW2MRhA@mail.gmail.com>
 <xmqqinqbfz2r.fsf@gitster.mtv.corp.google.com> <20161223072201.zw2lwkdcs6qmb4rp@sigill.intra.peff.net>
 <CA+P7+xrWsCkABzpSkYJ4fb2_JijmUx=Sf4Hgsr6Z+k=_GogE_Q@mail.gmail.com>
 <20161223161917.4a352c2wzerj5uyz@sigill.intra.peff.net> <xmqqh95uedzu.fsf@gitster.mtv.corp.google.com>
 <xmqq8tr6e46o.fsf@gitster.mtv.corp.google.com> <653b67e6-9dba-d331-c396-932a59cdb4da@alum.mit.edu>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 27 Apr 2017 14:17:55 -0700
Message-ID: <CAGZ79kY2Yu=B+75D6DpNjdriAZnJ5pZSmYAUiYtF2aUK47_HPw@mail.gmail.com>
Subject: Re: [PATCH] diff: prefer indent heuristic over compaction heuristic
To:     Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?Martin_Li=C5=A1ka?= <mliska@suse.cz>,
        Marc Branchaud <marcnarc@xiplink.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jacob Keller <jacob.keller@gmail.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>,
        Norbert Kiesel <nkiesel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

picking up this old topic,
with Martin, Marc and SZEDER cc'd,
as we got patch proposals regarding the indent heuristic.

On Sat, Dec 24, 2016 at 4:55 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 12/23/2016 10:17 PM, Junio C Hamano wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> I guess both you and Michael are in favor of just removing compaction
>>> variant without any renames, so let me prepare a reroll and queue
>>> that instead.  We can flip the default perhaps one release later.
>>
>> -- >8 --
>> Subject: [PATCH] diff: retire "compaction" heuristics
>>
>> When a patch inserts a block of lines, whose last lines are the
>> same as the existing lines that appear before the inserted block,
>> "git diff" can choose any place between these existing lines as the
>> boundary between the pre-context and the added lines (adjusting the
>> end of the inserted block as appropriate) to come up with variants
>> of the same patch, and some variants are easier to read than others.
>>
>> We have been trying to improve the choice of this boundary, and Git
>> 2.11 shipped with an experimental "compaction-heuristic".  Since
>> then another attempt to improve the logic further resulted in a new
>> "indent-heuristic" logic.  It is agreed that the latter gives better
>> result overall, and the former outlived its usefulness.
>>
>> Retire "compaction", and keep "indent" as an experimental feature.
>> The latter hopefully will be turned on by default in a future
>> release, but that should be done as a separate step.

Maybe turning on this feature by default is the next step instead of
adding them to bash competition or making them available in plumbing
commands for the upcoming release.

Then in a later release we could even remove the knobs to turn it off.

Thanks,
Stefan
