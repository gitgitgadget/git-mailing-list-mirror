Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1ED91F829
	for <e@80x24.org>; Mon,  1 May 2017 03:57:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946067AbdEAD5W (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Apr 2017 23:57:22 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33705 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1425014AbdEAD5U (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Apr 2017 23:57:20 -0400
Received: by mail-pg0-f66.google.com with SMTP id s62so2858597pgc.0
        for <git@vger.kernel.org>; Sun, 30 Apr 2017 20:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=/GoI3dMOlllm+laxtIhhyRJo597KH49i82i7ibdHgAQ=;
        b=XH03vAUL1Cz9/8Lx1eY/Cb9/4r4v9/847MSZvK/JD8Sv3uV+Ucrnz0pZl4AJt22daq
         epFQyTOVUn2Cr96bFhJApPhMIqPPyw2qammR4eC/3g7s0FmfsMN+Zy4aiHUXuIocAk0G
         91Gf/NRDKLiVnMnI3yIWT7qZENfApy3MT026A+3k9IkzPNVys+PfNDXf/3vHKzYAZAW1
         GrNRknGU6ePhdmVY/b6KHO/jmwlthwjCggHx+hhTQThdmejgeaar050RkNwL987o8rQK
         T/IwEP/CRgBdKN5a3HJv1z1RR9IePIr79PN8S8owQrjFvCtJ6cwxZbTx+CNm2sOFrLKz
         Umkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=/GoI3dMOlllm+laxtIhhyRJo597KH49i82i7ibdHgAQ=;
        b=bTj9QoHIXzo2QIYrpZTct19Y5PXfCw5ghyiVQlWMZms6JiXlAyTLuAMVgT1dJMaHvc
         LYUDkVdf3g9AkgcAFxiPHtPQnWj3CF1eo/We8/E1hZEniSxVDlBdDUD/R7EJxkxZzUOt
         z7wab+KR9UeXejN8C/8+tJYb9YJU3+D/yQhbJRYyHMvVndAhflO5uQuyCfPWo1VM46B7
         qMFphMZbIcMdM449LUhp1FDYrvbEc8CjLiZpBTRJ4WRub4OO+CwEZHj0aQCc+nE2lbSt
         6NcFYkKBm5EvqfqZ0hkIqtOqKMj3821aruik9otzdAadyOXjumXrpC2YrdTNTIpHsT16
         JGmQ==
X-Gm-Message-State: AN3rC/5JvAJuwre3gawX6eGXDHJUPnSF4w1er/Ym6+T3fI7shkO4zf5C
        JbHNj+vsO7A8iw==
X-Received: by 10.99.44.9 with SMTP id s9mr982636pgs.132.1493611039918;
        Sun, 30 Apr 2017 20:57:19 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:216d:aa3e:248d:bf63])
        by smtp.gmail.com with ESMTPSA id p62sm21479969pfi.7.2017.04.30.20.57.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 30 Apr 2017 20:57:19 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, markbt@efaref.net, git@jeffhostetler.com,
        kevin.david@microsoft.com
Subject: Re: Proposal for missing blob support in Git repos
References: <20170426221346.25337-1-jonathantanmy@google.com>
Date:   Sun, 30 Apr 2017 20:57:18 -0700
In-Reply-To: <20170426221346.25337-1-jonathantanmy@google.com> (Jonathan Tan's
        message of "Wed, 26 Apr 2017 15:13:46 -0700")
Message-ID: <xmqqinllgrfl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> In order to determine the code changes in sha1_file.c necessary, I
> investigated the following:
>  (1) functions in sha1_file that take in a hash, without the user
>      regarding how the object is stored (loose or packed)
>  (2) functions in sha1_file that operate on packed objects (because I
>      need to check callers that know about the loose/packed distinction
>      and operate on both differently, and ensure that they can handle
>      the concept of objects that are neither loose nor packed)
>
> For (1), I looked through all non-static functions in sha1_file.c that
> take in an unsigned char * parameter. The ones that are relevant, and my
> modifications to them to resolve this problem, are:
>  - sha1_object_info_extended (fixed in this commit)
>  - sha1_object_info (auto-fixed by sha1_object_info_extended)
>  - read_sha1_file_extended (fixed by fixing read_object)
>  - read_object_with_reference (auto-fixed by read_sha1_file_extended)
>  - force_object_loose (only called from builtin/pack-objects.c, which
>    already knows that at least one pack contains this object)
>  - has_sha1_file_with_flags (fixed in this commit)
>  - assert_sha1_type (auto-fixed by sha1_object_info)
>
> As described in the list above, several changes have been included in
> this commit to fix the necessary functions.
>
> For (2), I looked through the same functions as in (1) and also
> for_each_packed_object. The ones that are relevant are:
>  - parse_pack_index
>    - http - indirectly from http_get_info_packs
>  - find_pack_entry_one
>    - this searches a single pack that is provided as an argument; the
>      caller already knows (through other means) that the sought object
>      is in a specific pack
>  - find_sha1_pack
>    - fast-import - appears to be an optimization to not store a
>      file if it is already in a pack
>    - http-walker - to search through a struct alt_base
>    - http-push - to search through remote packs
>  - has_sha1_pack
>    - builtin/fsck - fixed in this commit
>    - builtin/count-objects - informational purposes only (check if loose
>      object is also packed)
>    - builtin/prune-packed - check if object to be pruned is packed (if
>      not, don't prune it)
>    - revision - used to exclude packed objects if requested by user
>    - diff - just for optimization
>  - for_each_packed_object
>    - reachable - only to find recent objects
>    - builtin/fsck - fixed in this commit
>    - builtin/cat-file - see below
>
> As described in the list above, builtin/fsck has been updated. I have
> left builtin/cat-file alone; this means that cat-file
> --batch-all-objects will only operate on objects physically in the repo.

One thing I wonder is what the performance impact of a change like
this to the codepath that wants to see if an object does _not_ exist
in the repository.  When creating a new object by hashing raw data,
we see if an object with the same name already exists before writing
the compressed loose object out (or comparing the payload to detect
hash collision).  With a "missing blob" support, we'd essentially
spawn an extra process every time we want to create a new blob
locally, and most of the time that is done only to hear the external
command to say "no, we've never heard of such an object", with a
possibly large latency.

If we do not have to worry about that (or if it is no use to worry
about it, because we cannot avoid it if we wanted to do the lazy
loading of objects from elsewhere), then the patch presented here
looked like a sensible first step towards the stated goal.

Thanks.
