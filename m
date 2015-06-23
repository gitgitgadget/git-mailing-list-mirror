From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jun 2015, #05; Mon, 22)
Date: Tue, 23 Jun 2015 13:46:53 -0700
Message-ID: <xmqq616ecfuq.fsf@gitster.dls.corp.google.com>
References: <xmqqzj3re4u5.fsf@gitster.dls.corp.google.com>
	<3fe144b0808827da3efbfcc44ad43524@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jun 23 22:47:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7V5z-0002Ph-BO
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 22:47:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933534AbbFWUq6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2015 16:46:58 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:34181 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932804AbbFWUq5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2015 16:46:57 -0400
Received: by iebmu5 with SMTP id mu5so20207130ieb.1
        for <git@vger.kernel.org>; Tue, 23 Jun 2015 13:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=VJuAKPAKOh3rGhwjLv6zti73RyaAmv3F3qsxXp5FCLQ=;
        b=xulWZI8Gtx6tTxoaAoeAuYeSD75qWKte38qOxq4sLraRsfAyPIwSOZ9/YGZn4kuoab
         lxLwo7vjOd/Xt7j2hAzSE6Kbc/SL/jvQIciUuNjn2EOg9Bqyf8YGxuWPQ3vb/AQ6lQb4
         W0aDi+iGIQnKGxaR/KJ5jpQEl8RLC/YqkCfyMxiWlWzw9WBVGxhpZudP+XJU30RR1kuf
         OBJ+4jM52Y4XeUCggIgcu3xzY8UwjllmOj4UAa2NA4qOZpeWUHIxII92MlmuDBLWIaqA
         T7L3EofJ14f3zrT1aE3hJUY0lbUBB/VxV2gQpNGodNnObX3lKysUB4xWesv4yfqG3Pox
         mlYw==
X-Received: by 10.42.175.74 with SMTP id az10mr34125573icb.55.1435092416974;
        Tue, 23 Jun 2015 13:46:56 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3c90:65f7:f86b:dfda])
        by mx.google.com with ESMTPSA id j20sm514761igt.5.2015.06.23.13.46.54
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 23 Jun 2015 13:46:55 -0700 (PDT)
In-Reply-To: <3fe144b0808827da3efbfcc44ad43524@www.dscho.org> (Johannes
	Schindelin's message of "Tue, 23 Jun 2015 19:24:39 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272516>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Hi Junio,
>
> On 2015-06-23 00:49, Junio C Hamano wrote:
>
>> * js/rebase-i-clean-up-upon-continue-to-skip (2015-06-18) 3 commits
>>  - rebase -i: do not leave a CHERRY_PICK_HEAD file behind
>>  - SQUASH: test_must_fail is a shell function
>>  - t3404: demonstrate CHERRY_PICK_HEAD bug
>> 
>>  Abandoning an already applied change in "git rebase -i" with
>>  "--continue" left CHERRY_PICK_HEAD and confused later steps.
>> 
>>  Expecting a reroll.
>>  ($gmane/271856)
>
> Actually, there had been two re-rolls, and v3 seemed to be okay:
> $gmane/272037. It also looks as if 726a35ebd^..726a35ebd^2 is
> identical with v3... Anything you want me to change in addition?

Thanks for a pointer; I think I updated the topic and then forgot to
update the reference in "whats cooking".  I'll take a look at 272037
and if I have anything further will comment there.

> Also:
>
>> * js/fsck-opt (2015-06-22) 19 commits
>>  - fsck: support ignoring objects in `git fsck` via fsck.skiplist
>>  - fsck: git receive-pack: support excluding objects from fsck'ing
>>  - fsck: introduce `git fsck --connectivity-only`
>>  - fsck: support demoting errors to warnings
>>  - fsck: document the new receive.fsck.<msg-id> options
>>  - fsck: allow upgrading fsck warnings to errors
>>  - fsck: optionally ignore specific fsck issues completely
>>  - fsck: disallow demoting grave fsck errors to warnings
>>  - fsck: add a simple test for receive.fsck.<msg-id>
>>  - fsck: make fsck_tag() warn-friendly
>>  - fsck: handle multiple authors in commits specially
>>  - fsck: make fsck_commit() warn-friendly
>>  - fsck: make fsck_ident() warn-friendly
>>  - fsck: report the ID of the error/warning
>>  - fsck (receive-pack): allow demoting errors to warnings
>>  - fsck: offer a function to demote fsck errors to warnings
>>  - fsck: provide a function to parse fsck message IDs
>>  - fsck: introduce identifiers for fsck messages
>>  - fsck: introduce fsck options
>> 
>>  Rerolled (at v7) and seems more or less ready for 'next'.
>
> I see that you used `downcased` instead of my `lowercased`, which
> makes more sense, but the style of the multi-line `for` loop as per
> pu` is still as *I* wrote it... I also saw that you downcased the
> first letter after `fsck:` in the commit messages, and touched up the
> message of the "report the ID of the error/warning" commit. Do you
> want to touch up the `for` loop style in "offer a function to demote
> fsck errors to warnings" or shall I send a v8 (it is ready to go:
> https://github.com/dscho/git/compare/next...fsck-api)?

I often micro-tweak obvious things as I go over the series and
applying them one by one, but the for-layout was a kind of change
that I usually do not tweak during application (as there are larger
chances of causing unneeded conflicts with later patches, and at the
point of applying an earlier patch, I may not remember what I
learned by skimming later patches in the series) and left there.

If the for-layout is the only thing that is questionable thing to
fix in what I queued, I think I can locally fix-up without an extra
roundtrip.  

Thanks.
