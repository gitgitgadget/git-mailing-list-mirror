Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8A181F424
	for <e@80x24.org>; Fri, 27 Apr 2018 03:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757299AbeD0D2Q (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Apr 2018 23:28:16 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:36735 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757272AbeD0D2P (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Apr 2018 23:28:15 -0400
Received: by mail-vk0-f65.google.com with SMTP id k67-v6so278932vkd.3
        for <git@vger.kernel.org>; Thu, 26 Apr 2018 20:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dQfn3WvkQRJ9tF5Lr3nxO9kaald666xB7PLtsOsQAvI=;
        b=O15D7lFurF++rOJf2pbxdlavjcnGt5c390QwF1MCnILv5lgcYgKYyl+PSUg7PAb8wG
         nyB19o9u1kytChV9SVvVY/2LExZPPVOxRbd61oaCPlxTLq1+Ii7RcCefT0OfxFOBQa7Q
         biklQ+/R+NPTLgDp8sFis2oPw7TdNH6IyXCIWQxJFqgSGtpNg1z2h5TtHUzODYSJLFuz
         WyEdfMOHwkBbwBqU98SMpcbHjKbVT46w1hL9U3KMndDfiId1ocN2nIOOpRV0aPLX4xa1
         ogv1lFaXCMpaQAUaH5SIDjSD+oPlLb9YZ86ZpyFArG+jiEg6mV0WN5BCEWmJpmsllDq+
         DrOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dQfn3WvkQRJ9tF5Lr3nxO9kaald666xB7PLtsOsQAvI=;
        b=K2gHbm0u9wmXQjgYUKSnqOCxest5wOEIwTdvfl1P3EeobVpmmAGwY1JHCHXtSDPBse
         N1PZX8k9BIyR5awrzTlaj1j1XMc0HOjo4XvMng3T1FWhCxSDchI8fiAbxVGaGPi0YChk
         Y+FKXusIpi6SQ1Et7oAjzMNKipc1obPN1k37d7f4AqbiQBPwwibaSR5IyJpht1+HXnIM
         1v1ViCr79Z32Txq3IKoMnSpTLIofZY0/iwNi+MjKBhWkuQBc3o/aA8dnCAwblaZSBPGl
         W6W7pbf1VQ2U6T21ra39rNM6YlFGShuyCuOIItbYgc0TTpBN18exKFk+hZPiPDV8hr2q
         0LYQ==
X-Gm-Message-State: ALQs6tBE6nB/N2QiZBOLwG4aDGLB9QbMadv2+HKQFDpfNZrM8eWttTbP
        zThqElNIKfzdPX60hTRdIg9eAyxxWTNfmRnEHQ0=
X-Google-Smtp-Source: AB8JxZqnCjfQdK9tS7TEI4zTI8aJ24hH4bBGlzGuD0UTrg+4I8re3F+s0B1Hahd9C+iiZmF0D6LnQAaqv9DantpHo3Y=
X-Received: by 2002:a1f:c155:: with SMTP id r82-v6mr369149vkf.76.1524799694664;
 Thu, 26 Apr 2018 20:28:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.4 with HTTP; Thu, 26 Apr 2018 20:28:13 -0700 (PDT)
In-Reply-To: <xmqqy3h9z8sj.fsf@gitster-ct.c.googlers.com>
References: <20180420133632.17580-1-benpeart@microsoft.com>
 <20180426205202.23056-1-benpeart@microsoft.com> <20180426205202.23056-3-benpeart@microsoft.com>
 <CABPp-BE29rwZCDqFHH-nzrDub6MMdtoiorj0jv3K6B6cmfcaLA@mail.gmail.com>
 <7de8f144-8a37-e471-48e8-0b6f17a7bf29@gmail.com> <xmqqy3h9z8sj.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 26 Apr 2018 20:28:13 -0700
Message-ID: <CABPp-BERgc9EZ=hw4CepgXptO283mW3O30_pHrj4jtz3QSCFjQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] merge: Add merge.renames config setting
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ben Peart <peartben@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "vmiklos@frugalware.org" <vmiklos@frugalware.org>,
        Kevin Willford <kewillf@microsoft.com>,
        "Johannes.Schindelin@gmx.de" <Johannes.Schindelin@gmx.de>,
        "eckhard.s.maass@googlemail.com" <eckhard.s.maass@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 26, 2018 at 7:23 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Ben Peart <peartben@gmail.com> writes:
>
>> Color me puzzled. :)  The consensus was that the default value for
>> merge.renames come from diff.renames.  diff.renames supports copy
>> detection which means that merge.renames will inherit that value.  My
>> assumption was that is what was intended so when I reimplemented it, I
>> fully implemented it that way.
>>
>> Are you now requesting to only use diff.renames as the default if the
>> value is true or false but not if it is copy?  What should happen if
>> diff.renames is actually set to copy?  Should merge silently change
>> that to true, display a warning, error out, or something else?  Do you
>> have some other behavior for how to handle copy being inherited from
>> diff.renames you'd like to see?
>>
>> Can you write the documentation that clearly explains the exact
>> behavior you want?  That would kill two birds with one stone... :)
>
> I think demoting from copy to rename-only is a good idea, at least
> for now, because I do not believe we have figured out what we want
> to happen when we detect copied files are involved in a merge.
>
> But I am not sure if we even want to fail merge.renames=copy as an
> invalid configuration.  So my gut feeling of the best solution to
> the above is to do something like:
>
>  - whether the configuration comes from diff.renames or
>    merge.renames, turn *.renames=copy to true inside the merge
>    recursive machinery.
>
>  - document the fact in "git merge-recursive" documentation (or "git
>    merge" documentation) to say "_currently_ asking for rename
>    detection to find copies and renames will do the same
>    thing---copies are ignored", impliying "this might change in the
>    future", in the BUGS section.

Yes, I agree.  One more thing:

  - It may be best to avoid advertising "copies" as a vaild option for
merge.renames since it doesn't have any current practical use
anywhere.  (Remove the sentence 'If set to "copies" or "copy", Git
will detect copies, as well.' from the documentation)

My rationale for translating "copy" to "true" is a little different
than Junio's, though:

1) The reason we have configuration options around renames and copies
is primarily because they are expensive to compute.  So we let some
users specify that they don't want them, other users are willing to
pay for rename detection, and others are willing to pay for both
rename and copy detection.
2) If rename/copy detection were cheap, every part of git would just
compute whatever level of detection was relevant and use it.
3) The resolve and octopus merge strategies ignores diff.renames and
merge.renames, because they don't have logic to use any rename
information.  diff and log can use both renames and copies.  And the
recursive merge machinery is code which can use renames but not
copies.
4) Therefore, translating from "copy" to "true" inside the merge
recursive machinery is fine and not an error because we are using as
much detection information as is relevant to the algorithm and which
the user is willing to pay for.

To throw one more wrinkle in here, merge.renames could actually be set
to "copy" and make sense, because we compute diffs multiple times.
Twice within the recursive merge machinery (for which we'd want to
translate "copy" to "true"), and once for the diffstat at the end
(which comes from builtin/merge.c, and for which it could make sense
to detect copies).

(Kind of curious whether Junio agrees with my rationale or thinks I'm
out in left field with it...)
