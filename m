From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] worktree: replace "checkout --to" with "worktree new"
Date: Wed, 01 Jul 2015 11:52:10 -0700
Message-ID: <xmqqfv57aexx.fsf@gitster.dls.corp.google.com>
References: <1435640202-95945-1-git-send-email-sunshine@sunshineco.com>
	<xmqqr3orakex.fsf@gitster.dls.corp.google.com>
	<CAPig+cRLpJK-C7MApH1vigZS=gmHNeo6RL3S2wXv4B-TFfnq4g@mail.gmail.com>
	<CAPig+cQ7yT6mGY=hFC5gKE7GSch-_tL0u8H+haJFr3FPXjjhqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Jul 01 20:52:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAN7i-0000Ur-9P
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 20:52:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755125AbbGASwV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2015 14:52:21 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:35823 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755093AbbGASwN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2015 14:52:13 -0400
Received: by igblr2 with SMTP id lr2so104329675igb.0
        for <git@vger.kernel.org>; Wed, 01 Jul 2015 11:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=oMw6y64rcPXK9bWoGOaongAugaBD79gjY6nbYa+SGzo=;
        b=GZeU8KMCREKVeDKNuWg1krqJM3Mb9q/bLmaOowKJpZg0LGQPaNheQFiNSdqLkLeYJf
         x3Z08FvT7qP0HTalFlfJOSNjOBWT/Iv+DnAFY1ZAnJ6tlKJDVFQokx3dxSg98yv3KkiS
         cl/OAaVfbgbQzXwF8Fhjp9uzADH3TXiJh0OdY886r+iwJ96Dp99cRxPhEf03zKnmrIgN
         YJqMcxkvgZQ1goMbvuTFXR/SOYDePgqlGtngtS56fuhAQLa1+e3Arz5Zq/PWpk7kH7Pt
         itqhTRHCvJSpHY08E+k1B3WlMHIZ6kKU8mODR4wvt9pah0sraELO8Sf98mvd+N1YA/zo
         WLkg==
X-Received: by 10.43.54.20 with SMTP id vs20mr6265137icb.96.1435776732567;
        Wed, 01 Jul 2015 11:52:12 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:64b9:4225:baa1:c97c])
        by mx.google.com with ESMTPSA id w4sm2283468igl.22.2015.07.01.11.52.11
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 01 Jul 2015 11:52:11 -0700 (PDT)
In-Reply-To: <CAPig+cQ7yT6mGY=hFC5gKE7GSch-_tL0u8H+haJFr3FPXjjhqw@mail.gmail.com>
	(Eric Sunshine's message of "Wed, 1 Jul 2015 14:18:53 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273180>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Wed, Jul 1, 2015 at 1:13 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Wed, Jul 1, 2015 at 12:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>  * Duy seems to think "worktree add" is coming, too, so here is a
>>>    trivial tweak of your patch from the last month, with test
>>>    adjustments to 7410 I sent earlier squashed in.
>>
>> Thanks. I was planning on re-rolling to use the new name ("add" rather
>> than "new") and to squash in the t7410 fix. Plus, I think the changes
>> I had to make to prepare_linked_checkout() in order to move it to
>> worktree.c should become separate preparatory patches so that the
>> actual relocation can become pure code movement (as much as possible).
>>
>> Also, I was planning on including Duy's patch in the re-roll since it
>> missed a s/prune --worktrees/worktree prune/ in
>> Documentation/git-checkout.txt.
>
> Hmm, I see that Duy's patch is already in 'next'. Would it be better
> if I fixed the 's/prune --worktrees/worktree prune/' git-checkout.txt
> oversight via an incremental patch rather than including a corrected
> version of his patch with my re-roll?

I may have mistaken what you said; I thought you were planning an
incremental for the existing part, with a more complete reroll of
"worktree add" than what I sent today, as separate patches.

Thanks.
