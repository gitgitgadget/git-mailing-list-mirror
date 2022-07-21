Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA99C433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 15:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbiGUP5Y convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 21 Jul 2022 11:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiGUP5X (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 11:57:23 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275A674E3B
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 08:57:22 -0700 (PDT)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [174.119.96.21] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 26LFvFcJ037706
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 21 Jul 2022 11:57:16 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Konstantin Ryabitsev'" <konstantin@linuxfoundation.org>
Cc:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
References: <xmqqilnr1hff.fsf@gitster.g> <xmqq35eumrp8.fsf@gitster.g> <010101d89d16$a97184a0$fc548de0$@nexbridge.com> <20220721153955.lnfqfilri24i2yw6@meerkat.local>
In-Reply-To: <20220721153955.lnfqfilri24i2yw6@meerkat.local>
Subject: RE: On-branch topic description support?
Date:   Thu, 21 Jul 2022 11:57:11 -0400
Organization: Nexbridge Inc.
Message-ID: <010301d89d1a$8cdc54b0$a694fe10$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQEkKUYbAx2+J5zTwv5GK2so27+hNQITrdhNAl+rp5kBXh+q4a7DVd4A
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On July 21, 2022 11:40 AM, Konstantin Ryabitsev wrote:
>On Thu, Jul 21, 2022 at 11:29:20AM -0400, rsbecker@nexbridge.com wrote:
>> I might be missing something here, but could not a description follow
>> similar semantics to how git describe works on tags? Anchor the
>> description on the commit where the branch was spawned, then determine
>> the appropriate description based on things like --first-parent.
>> Again, I'm probably in the weeds.
>
>I think the trouble is that "commit where the branch was spawned" is not reliable
>due to:
>
>- rebasing the work on a different branch
>- reordering commits (including the first commit in the series)
>
>This is the main reason why I actually want to stick the empty commit with the
>cover letter not at the tip of the branch, but at the start of the series, so as to
>clearly demarcate where the series of commits we're interested in starts (at least
>while the author is working on them -- when it sent off upstream that commit can
>get removed/moved).

That process may be more suitable outside the git team where merge --squash is commonplace and the whole series goes into next, main, maint as a single commit as the empty commit will simply vanish. Although, with that said, for the git team's committer process, having a starting point commit in the history also has some obvious advantages, for example, starting and ending points in history for git bisect when things go terribly wrong.
--R

