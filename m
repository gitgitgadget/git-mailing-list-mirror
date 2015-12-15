From: Stefan Beller <sbeller@google.com>
Subject: Re: What's cooking in git.git (Dec 2015, #05; Tue, 15)
Date: Tue, 15 Dec 2015 15:16:39 -0800
Message-ID: <CAGZ79kaeixm3ACrUCuMD8eL_tuniKk5Y5Ote1n=75ExxhTL62g@mail.gmail.com>
References: <xmqq8u4ve3at.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 16 00:16:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8ypo-00054T-Va
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 00:16:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933804AbbLOXQl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2015 18:16:41 -0500
Received: from mail-ig0-f171.google.com ([209.85.213.171]:37721 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932428AbbLOXQk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2015 18:16:40 -0500
Received: by mail-ig0-f171.google.com with SMTP id to18so25866751igc.0
        for <git@vger.kernel.org>; Tue, 15 Dec 2015 15:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=9AFFpfzPLuH4qXvYhEJpSFqM4+B+tBADXIvmrVhqUoI=;
        b=mhZfcw7NEHsAK73mYzC30VEa6jEM4Y+WWRLJWbtvp7d3BZf6QigCcVOFfhNtpNPfYC
         QzXc/e7FDcYtDKOvAbYwjbMk6YPxV/qHY2UowEZ9j7JHvY17K0vAbNrkySnngqIfiFxQ
         DrCSUwFoVOnfLr4K9wHO5BYFFJXO+USWXEdmKyKf1x7WxkyaAwXCgKKXZf9YK6565iVZ
         Htt6l6Api23eD0Ss2k8gEXEpf+JKg4eZpcbx6Q+0y938vD8VYJjdFzkwITFjyW2k1Wd1
         k05pIsDOawey8YRgP/HIEHD9wQY9ZxgXwYb0Jv0qUfYLmESAKLVqkJksDSj+PtDvt8On
         kt0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=9AFFpfzPLuH4qXvYhEJpSFqM4+B+tBADXIvmrVhqUoI=;
        b=FzdipzIqEDjezC+gJKYZUSvm355bYBHLM7dZ2egL0icqzDE4cx8WIg9EbqIpaHBMi5
         sImd0hOoKnNH8ZQTOIj2r0UzEvryiaboita5VsUtpt0m6ayT73QNb0nZ5AO2SOb0cWi5
         qjZPY5ZuK7NJHCnrBQR8uMnuDGbeyRAN1LLnPL6gBAv5jete4//bews8o6KlYjkpzIjo
         kh/PM37a7rS6zV/0B+Sx3qBD4jt8uRh1gbk3HlX68fQKoLR0wOVyKFhLRUCIedv4fUy5
         FOFHqzcBEoWXz+7Vhg82zRc43khyNyMvSK69D1/Y3XL4rOmJPlRyX20Gbd7baQj7Ixrr
         dwkA==
X-Gm-Message-State: ALoCoQlf4Qc2So7YNw3xVSZbz2TSe33VUb9pCFZTLCTxWTAZu+UGMSj2w8jBhQbw1gNaIVnIJ7APjNG0ySfH2KMQnBtnM20adFv3Db4kqn0H69LTwSGxNxo=
X-Received: by 10.50.57.7 with SMTP id e7mr3577932igq.93.1450221399677; Tue,
 15 Dec 2015 15:16:39 -0800 (PST)
Received: by 10.107.8.84 with HTTP; Tue, 15 Dec 2015 15:16:39 -0800 (PST)
In-Reply-To: <xmqq8u4ve3at.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282506>

On Tue, Dec 15, 2015 at 2:48 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> * sb/submodule-parallel-fetch (2015-12-14) 8 commits
>  - submodules: allow parallel fetching, add tests and documentation
>  - fetch_populated_submodules: use new parallel job processing
>  - run-command: add an asynchronous parallel child processor
>  - sigchain: add command to pop all common signals
>  - strbuf: add strbuf_read_once to read without blocking
>  - xread_nonblock: add functionality to read from fds without blocking
>  - xread: poll on non blocking fds
>  - submodule.c: write "Fetching submodule <foo>" to stderr
>  (this branch is used by sb/submodule-parallel-update.)
>
>  Add a framework to spawn a group of processes in parallel, and use
>  it to run "git fetch --recurse-submodules" in parallel.
>
>  Rerolled and this seems to be a lot cleaner.  The merge of the
>  earlier one to 'next' has been reverted.
>
>  Will merge to 'next' after a few days.

I plan on resending after the recent discussion, dropping xread_nonblock
and only have strbuf_read_once in there.

>
> * sb/submodule-parallel-update (2015-12-14) 8 commits
>  - clone: allow an explicit argument for parallel submodule clones
>  - submodule update: expose parallelism to the user
>  - git submodule update: have a dedicated helper for cloning
>  - fetching submodules: respect `submodule.fetchJobs` config option
>  - submodule-config: introduce parse_generic_submodule_config
>  - submodule-config: remove name_and_item_from_var
>  - submodule-config: drop check against NULL
>  - submodule-config: keep update strategy around
>  (this branch uses sb/submodule-parallel-fetch.)
>
>  Builds on top of the "fetch --recurse-submodules" work to introduce
>  parallel downloading into multiple submodules for "submodule update".
>
>  Needs review.

A while ago it had some review (specially bike shedding on the option name),
I did not change it substantially. I hope we don't get into bike
shedding the option
name again.
