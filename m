Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 028D11F600
	for <e@80x24.org>; Thu, 20 Jul 2017 21:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936319AbdGTVNs (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jul 2017 17:13:48 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:33865 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933285AbdGTVNr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2017 17:13:47 -0400
Received: by mail-pg0-f54.google.com with SMTP id 123so19770635pgj.1
        for <git@vger.kernel.org>; Thu, 20 Jul 2017 14:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jKDZu0/xbUwZEhXAhuHVuXUYqpSYsiMfkihzD+C9qhE=;
        b=CosaViLbp56yFSKp/XMU1jKUoLke+/4WASStDeEEAQNF2xfUgyPJgW11PBShbl30Es
         R6a43wj8M1G9sVqZ8LFBJhkuO4tCE+pOoNdgrRbdVTMC9PdUxB2THKqiiqhgjUSdMj5d
         Bpoi/bgcs0pUW7XtOM6mSKMzfl1jcXkyCZq7dEogIf0VJQktZDErVZDNZo+5lsutDecQ
         dWp/8leujNsaKXNbDDQYYMMq/9Z/wgOdcWjowhIdoBNAOiTAWdy0oyrkOrnFHtm7piE1
         tZqQwzucNNXYmBA1wz1OvUtBf15GLjMgGfSChSLpFPXh0fM7J9fhzsfJkfHjM5A5v2bB
         ukag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jKDZu0/xbUwZEhXAhuHVuXUYqpSYsiMfkihzD+C9qhE=;
        b=rtVgbquVRnbds2bOz5YAIahLhTCxvM2ZNt8eq/qsUOjgjwCbUrpOn0YTCb7CUmEEhv
         ++t1bssCizUFXlKa5PCJ1T7gAdeFNLZKTuwV81+YNfKLrMpaBo24tsh8L4kJNjHdr3B6
         Oh43su8flll9B1D0esUjs2OllaMR2mvUbR/DQl/MfV56LRsgTWO5gUn+qB6KY1BiGdRy
         Ym9g7odnqlrYQJL4B8HMKzph0yQKIvhH26qYowXBNAYFp3hP845qdIsonsB/Tr95CzRE
         P7fd/Eqaaw7wixJmhj8XDyve51Cbg88EkLMMk1nEivh4GNJSS+b6RzPEgbOnYulW0/LH
         NxhA==
X-Gm-Message-State: AIVw110/hHLrSEa7AOCjg62pfcr/SfGwovP41s66+upVpYyA8vrM1O9i
        yn+pJzzeqyeAr71PO1Zz4w==
X-Received: by 10.99.44.205 with SMTP id s196mr522333pgs.450.1500585226960;
        Thu, 20 Jul 2017 14:13:46 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:e9ae:e35a:1cee:5424])
        by smtp.gmail.com with ESMTPSA id m8sm5495716pgs.24.2017.07.20.14.13.46
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 20 Jul 2017 14:13:46 -0700 (PDT)
Date:   Thu, 20 Jul 2017 14:13:42 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, sbeller@google.com,
        git@jeffhostetler.com, philipoakley@iee.org
Subject: Re: [RFC PATCH v2 2/4] promised-object, fsck: introduce promised
 objects
Message-ID: <20170720141342.6a89aace@twelve2.svl.corp.google.com>
In-Reply-To: <d8beb406-6d03-d893-4f37-83a7bdd6b9ac@gmail.com>
References: <cover.1500508695.git.jonathantanmy@google.com>
        <3420d9ae9ef86b78af1abe721891233e3f5865a2.1500508695.git.jonathantanmy@google.com>
        <d8beb406-6d03-d893-4f37-83a7bdd6b9ac@gmail.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 20 Jul 2017 15:58:51 -0400
Ben Peart <peartben@gmail.com> wrote:

> On 7/19/2017 8:21 PM, Jonathan Tan wrote:
> > Currently, Git does not support repos with very large numbers of objects
> > or repos that wish to minimize manipulation of certain blobs (for
> > example, because they are very large) very well, even if the user
> > operates mostly on part of the repo, because Git is designed on the
> > assumption that every referenced object is available somewhere in the
> > repo storage.
> > 
> 
> Great to see this idea making progress. Making git able to gracefully 
> handle partial clones (beyond the existing shallow clone support) is a 
> key piece of dealing with very large objects and repos.

Thanks.

> > As a first step to reducing this problem, introduce the concept of
> > promised objects. Each Git repo can contain a list of promised objects
> > and their sizes (if blobs) at $GIT_DIR/objects/promised. This patch
> > contains functions to query them; functions for creating and modifying
> > that file will be introduced in later patches.
> 
> If I'm reading this patch correctly, for a repo to successfully pass 
> "git fsck" either the object or a promise must exist for everything fsck 
> checks.  From the documentation for fsck it says "git fsck defaults to 
> using the index file, all SHA-1 references in refs namespace, and all 
> reflogs (unless --no-reflogs is given) as heads." Doesn't this then 
> imply objects or promises must exist for all objects referenced by any 
> of these locations?
> 
> We're currently in the hundreds of millions of objects on some of our 
> repos so even downloading the promises for all the objects in the index 
> is unreasonable as it is gigabytes of data and growing.

For the index to contain all the files, the repo must already have
downloaded all the trees for HEAD (at least). The trees collectively
contain entries for all the relevant blobs. We need one promise for each
blob, and the size of a promise is comparable to the size of a tree
entry, so the size (of download and storage) needed would be just double
of what we would need if we didn't need promises. This is still only
linear growth, unless you have found that the absolute numbers are too
large?

Also, if the index is ever changed to not have one entry for every file,
we also wouldn't need one promise for every file.

> I think we should have a flag (off by default) that enables someone to 
> say that promised objects are optional. If the flag is set, 
> "is_promised_object" will return success and pass the OBJ_ANY type and a 
> size of -1.
> 
> Nothing today is using the size and in the two places where the object 
> type is being checked for consistency (fsck_cache_tree and 
> fsck_handle_ref) the test can add a test for OBJ_ANY as well.
> 
> This will enable very large numbers of objects to be omitted from the 
> clone without triggering a download of the corresponding number of 
> promised objects.

Eventually I plan to use the size when implementing parameters for
history-searching commands (e.g. "git log -S"), but it's true that
that's in the future.

Allowing promised objects to be optional would indeed solve the issue of
downloading too many promises. It would make the code more complicated,
but I'm not sure by how much.

For example, in this fsck patch, the easiest way I could think of to
have promised objects was to introduce a 3rd state, called "promised",
of "struct object" - one in which the type is known, but we don't have
access to the full "struct commit" or equivalent. And thus fsck could
assume that if the "struct object" is "parsed" or "promised", the type
is known. Having optional promised objects would require that we let
this "promised" state have a type of OBJ_UNKNOWN (or something like
that) - maybe that would be fine, but I haven't looked into this in
detail.

> > A repository that is missing an object but has that object promised is not
> > considered to be in error, so also teach fsck this. As part of doing
> > this, object.{h,c} has been modified to generate "struct object" based
> > on only the information available to promised objects, without requiring
> > the object itself.
> 
> In your work on this, did you investigate if there are other commands 
> (ie repack/gc) that will need to learn about promised objects? Have you 
> had a chance (or have plans) to hack up the test suite so that it runs 
> all tests with promised objects and see what (if anything) breaks?

In one of the subsequent patches, I tried to ensure that all
object-reading functions in sha1_file.c somewhat works (albeit slowly)
in the presence of promised objects - that would cover the functionality
of the other commands. As for hacking up the test suite to run with
promised objects, that would be ideal, but I haven't figured out how to
do that yet.
