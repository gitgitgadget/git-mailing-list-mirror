From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Jun 2014, #06; Thu, 26)
Date: Sun, 29 Jun 2014 07:33:20 +0700
Message-ID: <CACsJy8CXLO2Tt_poChMkT7CPyUaY4gbF1cdsscDH3LsUaJRxPA@mail.gmail.com>
References: <xmqqvbrn2utv.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 29 02:37:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X137R-0008Ak-3x
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jun 2014 02:37:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464AbaF2Adw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jun 2014 20:33:52 -0400
Received: from mail-qg0-f53.google.com ([209.85.192.53]:42845 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751281AbaF2Adv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jun 2014 20:33:51 -0400
Received: by mail-qg0-f53.google.com with SMTP id i50so783943qgf.40
        for <git@vger.kernel.org>; Sat, 28 Jun 2014 17:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=BjKCP75KCp4ViG5KkYBF0j0C9rqxLFIrUVeLgRlA6XI=;
        b=zVaW6G1jgidCHezmi/CHDRz4IIKPuXtGXy+/0bb5vb4vf93GBy5xs6zsvi8wQyCfJz
         Yhvlu8Rj9C6CMw2HzAK3Pcc2cjkunOeCqDoNTZ8tRXtvBEtkbQ8Kq+bCcHYRD+zS2tA1
         8aJqCLhCxWExrxCk4wv9V1UIgmxq/PpeeO3hDw3ok92j1Hr1qEp3HYAw6wqf1PHNdhP/
         eyZCgNpksJSCTPMmIIoR6OJwU6CQkv8Qwk/fXb9Oy4Pn2ihlG7evsguZSYih261tp9Bl
         jv+70VLKjvObA62n/Qzqf8HjAwrc+SvkXpwnD7SYsaqItKbCUYaj6Lts5n3NQFgHwu/R
         FYYw==
X-Received: by 10.224.2.74 with SMTP id 10mr47311823qai.89.1404002030944; Sat,
 28 Jun 2014 17:33:50 -0700 (PDT)
Received: by 10.96.66.129 with HTTP; Sat, 28 Jun 2014 17:33:20 -0700 (PDT)
In-Reply-To: <xmqqvbrn2utv.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252623>

On Fri, Jun 27, 2014 at 5:02 AM, Junio C Hamano <gitster@pobox.com> wrote:
> * nd/split-index (2014-06-13) 32 commits
>  - t1700: new tests for split-index mode
>  - t2104: make sure split index mode is off for the version test
>  - read-cache: force split index mode with GIT_TEST_SPLIT_INDEX
>  - read-tree: note about dropping split-index mode or index version
>  - read-tree: force split-index mode off on --index-output
>  - rev-parse: add --shared-index-path to get shared index path
>  - update-index --split-index: do not split if $GIT_DIR is read only
>  - update-index: new options to enable/disable split index mode
>  - split-index: strip pathname of on-disk replaced entries
>  - split-index: do not invalidate cache-tree at read time
>  - split-index: the reading part
>  - split-index: the writing part
>  - read-cache: mark updated entries for split index
>  - read-cache: save deleted entries in split index
>  - read-cache: mark new entries for split index
>  - read-cache: split-index mode
>  - read-cache: save index SHA-1 after reading
>  - entry.c: update cache_changed if refresh_cache is set in checkout_entry()
>  - cache-tree: mark istate->cache_changed on prime_cache_tree()
>  - cache-tree: mark istate->cache_changed on cache tree update
>  - cache-tree: mark istate->cache_changed on cache tree invalidation
>  - unpack-trees: be specific what part of the index has changed
>  - resolve-undo: be specific what part of the index has changed
>  - update-index: be specific what part of the index has changed
>  - read-cache: be specific what part of the index has changed
>  - read-cache: be strict about "changed" in remove_marked_cache_entries()
>  - read-cache: store in-memory flags in the first 12 bits of ce_flags
>  - read-cache: relocate and unexport commit_locked_index()
>  - read-cache: new API write_locked_index instead of write_index/write_cache
>  - sequencer: do not update/refresh index if the lock cannot be held
>  - ewah: delete unused ewah_read_mmap_native declaration
>  - ewah: fix constness of ewah_read_mmap
>
>  What's the doneness of this one?

It's done, at least for the extension format and core algorithm. Later
we may want to automatically re-split the index when too many changes
are accumulated in the main index.
-- 
Duy
