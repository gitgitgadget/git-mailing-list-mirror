Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B295B1FAF4
	for <e@80x24.org>; Wed, 15 Feb 2017 00:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750902AbdBOANp (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 19:13:45 -0500
Received: from [195.159.176.226] ([195.159.176.226]:33968 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1750812AbdBOANo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 19:13:44 -0500
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
        (envelope-from <gcvg-git-2@m.gmane.org>)
        id 1cdnDz-00087y-0p
        for git@vger.kernel.org; Wed, 15 Feb 2017 01:13:35 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   "Herbert, Marc" <marc.herbert@intel.com>
Subject: =?UTF-8?Q?Re:_Feature_request:_flagging_=e2=80=9cvolatile=e2=80=9d_?=
 =?UTF-8?Q?branches_for_integration/development?=
Date:   Tue, 14 Feb 2017 16:13:32 -0800
Message-ID: <6c7cb3da-714b-87ed-5885-220a433c646f@intel.com>
References: <70ccb8fc-30f2-5b23-a832-9e470787a945@intel.com>
 <CACsJy8A5AXs5jQUQAdb=tuBzWYKNbu5DPnQ88DXott8ht61egA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@blaine.gmane.org
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
Cc:     Josh Triplett <josh@joshtriplett.org>
In-Reply-To: <CACsJy8A5AXs5jQUQAdb=tuBzWYKNbu5DPnQ88DXott8ht61egA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[apologies for the accidental "smart" quotes and the resulting UTF8
encoding of the subject]

On 04/02/2017 06:01, Duy Nguyen wrote:
> 
> But that would be local information only. We don't have ways to
> transfer branch metadata (and we definitely don't want to just share
> .git/config file with everybody). I suppose extending git protocol for
> this is not hard (e.g. appending metadata in the "have" lines).

Thanks Duy. So did you mean:

[ X ] send (big!) patches ?

> The hard part may be policy (e.g. what if the user does not want a branch
> to be treated volatile by various commands even if it receives such
> flag from a git server).

There would be instant, human-readable value in such a new "volatile"
flag. Machine use and policies can be discussed later. These will be
easier to prototype, experiment and refine once the flag exists.

  ----

Interestingly, it was pointed to me (thanks Calvin) that GitLab has
implemented this volatile flag exactly. It's called... "work in progress":
https://docs.gitlab.com/ee/user/project/merge_requests/work_in_progress_merge_requests.html

I'm not familiar with GitHub, however browsing its documentation the
(in)existence of a pull request seems equivalent to a (non-)volatile
flag. Just like a pull request by email without the need to find and search
a mailing-list.

I'm familiar with Gerrit and there's no strict equivalent to a volatile
flag, however it's:
- totally obvious when the commit has been accepted and merged - hence
  its SHA1 final.
- usually fairly clear whether the code is still WIP or near the
  "pull request" stage based on: how the code review is going, approvals
  and other metadata.

Long story short: to integrate code reviews and source control these
systems overload git with a ton of metadata so it's no surprise to
always find in them something that more or less looks like a "volatile"
flag. I guess this leads to the more general question of core git possibly
implementing some generic metadata/property system (key,value pairs?
everything is a ref?) to better support code review and other
git-based software... Now I bet this on the other hand must have been
discussed (and rejected?) before, any pointer?


Marc





