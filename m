Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5ED51F453
	for <e@80x24.org>; Sun, 10 Feb 2019 05:58:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbfBJF6s (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Feb 2019 00:58:48 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63122 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfBJF6s (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Feb 2019 00:58:48 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5FA1349085;
        Sun, 10 Feb 2019 00:58:44 -0500 (EST)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=HVF1X7mZ6zZA0ISEpdxY0y7WrP8=; b=RKPsusK
        SOvEZUlIFU1tN+4hPd7h+8zbGHf7Le8voyLtgTBebbeURtkY9yQuWZNDXpSjwJmc
        0V6YAsiMAJFW3wJyYUuxgkR97T+Ea+/4is9IcSNZe0NG6VNdwRz1c/Er63Eg/ree
        ExrVRF+bn5mhvb+lVEfh9nSXs7DIi+J/Lxog=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to; q=dns; s=sasl; b=ecLp2wV3QnpXumdqPnVTTK4Dzq+RI4EZC
        3QjCjeFuFKo8OpyZARt+0eTh+UxYOgVHqAqSLx5chtxWcvGgG3QPxvz0ihAV3wN+
        CaJaUgXEfLlcsd9WZhIA4JcH3frY3pJKvjSGPOsXLXz9TWQ74GW7AG6OqLfB3Hgf
        GFftSPMzfA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 594EE49084;
        Sun, 10 Feb 2019 00:58:44 -0500 (EST)
        (envelope-from tmz@pobox.com)
Received: from zaya.teonanacatl.net (unknown [71.173.194.225])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1359749083;
        Sun, 10 Feb 2019 00:58:41 -0500 (EST)
        (envelope-from tmz@pobox.com)
Date:   Sun, 10 Feb 2019 00:58:38 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     Keith Smiley <k@keith.so>
Cc:     Sergey Zolotarev <szolot4rev@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] Add support for 'git remote rm' in Bash completion script
Message-ID: <20190210055838.GJ30548@zaya.teonanacatl.net>
References: <20190209052434.20616-1-szolot4rev@gmail.com>
 <20190209062706.GF30548@zaya.teonanacatl.net>
 <831E8C20-CCB9-4E99-9FFD-DA7CCF825C3D@keith.so>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <831E8C20-CCB9-4E99-9FFD-DA7CCF825C3D@keith.so>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Pobox-Relay-ID: EACE77AA-2CF8-11E9-9A0B-EE24A11ADF13-09356542!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Keith Smiley wrote:
>> On Feb 8, 2019, at 22:27, Todd Zullinger <tmz@pobox.com> wrote:
>> 
>> Hi Sergey,
>> 
>> There was a previous discussion of this in December 2017,
>> which might be useful:
>> 
>> https://public-inbox.org/git/01020160a0004473-277c3d7c-4e3b-4c50-9d44-4a106f37f1d9-000000@eu-west-1.amazonses.com/
>> 
>> It didn't end with a patch applied, but it's likely worth
>> reading to help you make a case for a similar patch.
>> 
>> One of the points in that thread is that the rm subcommand
>> is not shown in completion intentionally, as the preferred
>> subcommand is remove.  But it should be possible to offer
>> completion of the remotes after a user types rm, which I
>> imagine is the more helpful part of the completion.
>> 
>> Also, you'll want to add a signoff to the patch if/when you
>> resend it (refer to Documentation/SubmittingPatches, if you
>> haven't already).
>> 
>> Sergey Zolotarev wrote:
>>> ---
>>> contrib/completion/git-completion.bash | 5 ++++-
>>> 1 file changed, 4 insertions(+), 1 deletion(-)
>>> 
>>> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
>>> index 499e56f83d..fa25d689e2 100644
>>> --- a/contrib/completion/git-completion.bash
>>> +++ b/contrib/completion/git-completion.bash
>>> @@ -2334,7 +2334,7 @@ _git_remote ()
>>> {
>>>    local subcommands="
>>>        add rename remove set-head set-branches
>>> -        get-url set-url show prune update
>>> +        get-url set-url show prune rm update
>>>        "
>>>    local subcommand="$(__git_find_on_cmdline "$subcommands")"
>> 
>> So instead of this change you could adjust the subcommand
>> line, something like:
>> 
>> -    local subcommand="$(__git_find_on_cmdline "$subcommands")"
>> +    # Don't advertise rm by including it in subcommands, but complete
>> +    # remotes if it is used.
>> +    local subcommand="$(__git_find_on_cmdline "$subcommands rm")"
>> 
>> I haven't test that, but the code looks like it hasn't
>> changed since the last time we talked about this -- when I
>> did test the suggestion :).
>> 
>>>    if [ -z "$subcommand" ]; then
>>> @@ -2379,6 +2379,9 @@ _git_remote ()
>>>    prune,--*)
>>>        __gitcomp_builtin remote_prune
>>>        ;;
>>> +    rm,--*)
>>> +        __gitcomp_builtin remote_rm
>>> +        ;;
>>>    *)
>>>        __gitcomp_nl "$(__git_remotes)"
>>>        ;;
>> 
>> I don't think you need this chunk, do you?  I think that's
>> only useful for completing options to the subcommand, which
>> 'git remote rm' lacks.
>> 
>> I believe you can simply skip it and let the case fall
>> through to the last item which simply completes the
>> available remotes, just as 'git remote remove' does.
>> 
>> Hope that helps,
>> 
> It would be great if we could land this. Non of the other
> solutions since I proposed my patch have happened, so in
> the meantime this would be nice to have.

Yeah, it seems like we should either complete the remotes
for 'git remote rm <tab>' or follow up with the removal of
the rm subcommand as Duy and Junio fleshed out in the thread
from July.  If the command were to be removed, doing it
right after the 2.22 cycle begins would be as good a time as
any.

If the command remains, here's a suggestion for how it might
be submitted (perhaps with more details in the commit to
justify why we're completing arguments to a deprecated
subcommand?).

It's really not an itch of mine, so I'm just tossing this
out in case someone that wants it more will push it forward.

---- >8 ----
Subject: [PATCH] completion: complete remotes for 'remote rm'

The remote 'rm' subcommand was removed from the completed subcommands
list in e17dba8fe1 ("remote: prefer subcommand name 'remove' to 'rm'",
2012-09-06).  While we don't advertise it, we can still complete the
list of remotes for users who type 'git remote rm <tab>' as a courtesy.

Reported-by: Keith Smiley <k@keith.so>
Reported-by: Sergey Zolotarev <szolot4rev@gmail.com>
Helped-by: Todd Zullinger <tmz@pobox.com>
Signed-off-by: <whomever polishes as needed>
---
 contrib/completion/git-completion.bash | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 499e56f83d..5d0f8a2077 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2336,7 +2336,9 @@ _git_remote ()
 		add rename remove set-head set-branches
 		get-url set-url show prune update
 		"
-	local subcommand="$(__git_find_on_cmdline "$subcommands")"
+	# We don't advertise rm by including it in subcommands, but if it is
+	# used we want to complete remotes.
+	local subcommand="$(__git_find_on_cmdline "$subcommands rm")"
 	if [ -z "$subcommand" ]; then
 		case "$cur" in
 		--*)

-- 
Todd
