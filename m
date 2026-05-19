Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A165740962E
	for <git@vger.kernel.org>; Tue, 19 May 2026 16:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779207900; cv=none; b=EU6JGor57iv40iENQq3u3bw+5ChuBsUqMUBQ3b+FveD2G90W0uAKEvvtx1fL8I+SaTEpya7G4QlYfjFB2avh/m32GoKRLJ3S0Qy1WW6yzUw1tBhz7aykW6lSmS/Mi6A7D5ZB6LlJbX5Io8C+BLsr+RlPV2ukiFejVhU/r0KEJVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779207900; c=relaxed/simple;
	bh=c2TleBxgtJvpBjPEgrVrbyEMC1eTDekdUnn2Ny/BHu4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=aTskUpxNQAuLCT4fXfc76f5tAwK71q24vmemE6r+4XjpBQ9OyfWbBenTbq0l08J0cpS9PV4aVik1RBnck29mPTBWoQcUqvFRNBNrPXVcsSKoHPYSh4PhXfl8PEv0PCCUnP0FFr5+rb0eR/Ea31aqUbSta7Ce8+w7kXiJlXUJoas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R0PhiilE; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0PhiilE"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-132d1b2519eso9546823c88.0
        for <git@vger.kernel.org>; Tue, 19 May 2026 09:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779207898; x=1779812698; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=31blJbMt0YTHzHRZWfISuJuRD4APcA8Ezux5tOLStLg=;
        b=R0PhiilEiZaYUTDe7UXCdSliKyqWvKr6zNWshtWw6mWC6IOGy+2MPRN6JZXHRBzHaV
         DM1CIq9uZOZHeoNRNjKVyNGj/uSKZWRN8M59oAS/67VBERp562XvhKWDWjUKpjXD61uY
         pW7NsINcAPGrJrdQMgBT0CgUskgrQUcSoYsR+U30LCIdgv14PUzyGG2zZD9t95qkU16b
         c0grzh3VcKYL0NOd2inhgqnXf6DojMTXNh2kEC3kQ8QXLCBNymaDL/jIC49z4Sc7UrLS
         ttQ2u9FzUyYGKSAGgTj863+sDUFdYKKx0WpeGlx+71btIHuAzS6yA/QHtU2sjQ2bG452
         2DvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779207898; x=1779812698;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=31blJbMt0YTHzHRZWfISuJuRD4APcA8Ezux5tOLStLg=;
        b=eq2S7k79LPzs4sw3cNOAoAKKk6RnisZKm3sDm7hjLus89AvAgQ6tc5lJhkPD4oPoNE
         4qFqZehL1wSjlOa9eVVBS4nAF1aOqVt+wFw7Yg7KeAlMv8P4dzsKkvIYMzJBXjWm3Sio
         Ng2g+4SV9POMi3wJeQL+JPcja5xTai1d6BPyQtf5nq1ZAGr46Eca2fG1UmIIIUaSWXIe
         HA2XdPOpM+mChdykLb2/Hv15vUTupivooTz4FL/Oq1AWvVt/GUB9Yt7v+Yi2Ypax3l/3
         TBtO4tQM0+v1Px/qmH88+scnsXWjpgHfyRvw4lTx1pbw3uz5siH54htNuvwE1sO664I4
         62tA==
X-Gm-Message-State: AOJu0YxV0PFTzJnVmhcCWYaYFccApe4J8DoYqP5WAeZAP13YHBmaj9Cp
	gyho2SOavVI2J/iLoi8X62obbsSWCOKjWuMtMkK0W2aCUM5Jzl1EwA/BnjoCTg==
X-Gm-Gg: Acq92OHLeMyc/cgCE0OGKt41erYz/wlUCYEHggaix9OOjZnpvfzX3R6llsdFgVBPh1x
	iV5degEkH2S1c7L23/ECOLsoUWo8zjZil7yTZuwLWR/NMkknj006cz2mVkhLUd3SAh1K+8EYqUO
	Iz8y4+OGVjjJDJwANsrLIpjuJ7sxG1NXziOdtlO2Q/XvVcoVx54TDQMIHR+taUgG0w/8V56BUsC
	OFK6zlHCT779IvKQ6IYBuUDZPgzDcxCbdacluezkQWhDU3H1IyVZ671QjOOIN3tMnfw/U4Mv56+
	u4GvtexuXd3vsHOfVlj4etqd3uYvd5lQm1wW0dLlk5sR3IDTVsTViHhjsFXNTLZnsfEvRgp83ls
	6513mN1MOskZQybADBJpJbjNtZchPFF/Of/Y1rsHDZ8ABhDPnWzj+SCqnOoSNC2K0VFd69Lp3MD
	keEYwvmKvdhveaOvWK1sZIvx7I0anVbJR6eLZ/0vg=
X-Received: by 2002:a05:7022:2523:b0:123:34e8:aec2 with SMTP id a92af1059eb24-13504313d54mr8448284c88.1.1779207897531;
        Tue, 19 May 2026 09:24:57 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.195.179])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cbcb9ed3sm23690214c88.1.2026.05.19.09.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 09:24:56 -0700 (PDT)
Message-Id: <pull.2085.v6.git.1779207896.gitgitgadget@gmail.com>
In-Reply-To: <pull.2085.v5.git.1779135575.gitgitgadget@gmail.com>
References: <pull.2085.v5.git.1779135575.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 19 May 2026 16:24:47 +0000
Subject: [PATCH v6 0/8] fetch: rework negotiation tip options
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    ps@pks.im,
    Matthew John Cheetham <mjcheetham@outlook.com>,
    Derrick Stolee <stolee@gmail.com>

Fetch negotiation aims to find enough information from haves and wants such
that the server can be reasonably confident that it will send all necessary
objects and not too many "extra" objects that the client already has.
However, this can break down if there are too many references, since Git
truncates the list of haves based on a few factors (a 256 count limit or the
server sending an ACK at the right time).

We already have the --negotiation-tip feature to focus the set of references
that are used in negotiation, but I feel like this is designed backwards.
I'd rather that we have a way to say "this is an important set of refs, but
feel free to add more refs if needed" than "only use these refs for
negotiation".

Here's an example that demonstrates the problem. In an internal monorepo,
developers work off of the 'main' branch so there are thousands of user
branches that each add a few commits different from the 'main' branch.
However, there is also a long-lived 'release' branch. This branch has a
first-parent history that is parallel to 'main' and each of those commits is
a merge whose second parent is a commit from 'main' that had a successful CI
run. There are additional changes in the 'release' branch merge commits that
add some changelog data, so there is a nontrivial set of novel blob content
in that branch and not just a different set of commits.

The problem we had was that our georeplication system was regularly fetching
from the origin and trying to get all data from all reachable branches. When
the 'release' branch updated, the client would run out of haves before
advertising its copy of the 'release' branch, but it would still list the
new 'release' tip as a want. The server would then think that the client had
never fetched that branch before and would send all of the changelog data
from the whole history of the repo. (This led to a lot of downstream
problems; we mitigated by setting a refspec that stopped fetching the
'release' branch, but this is not ideal.)

What I'd like is a mechanism to say "always advertise the client's version
of 'main' and 'release' but also opportunistically include some user
branches".

Based on my understanding, the '--negotiation-tip' option is close but not
quite what I want. I could have the client only advertise 'release' and
'main' and never advertise any user branches. But then we'd download all
content from each user branch every time it updates. Perhaps this would
happen even with opportunistic inclusion of more haves, but I'd like to
explore this area more.

There's also an issue that the '--negotiation-tip' feature doesn't seem to
have a config key that enables it without CLI arguments. This is something
that we could consider independently.

This patch series adds a new '--negotiation-include' option that does what I
want: it makes sure that these references are included as 'have's during
negotiation. In order to help clarify the difference between this and
'--negotiation-tip', I first create a synonym called
'--negotiation-restrict'.

Both of these options get 'remote.*.negotiation(Include|Restrict)' config
options that enable their behavior by default.

During development, I had briefly considered only using config values, but
that required some strange changes to care about the remote name in the
transport layer. This was most different in the 'git push' integration. When
I discovered the '--negotiation-tip' feature during the process, that gave
me a clear pattern to follow with the addition of a config on top.


Updates in v2
=============

This version is a near-complete rewrite based on feedback around the names
of the previous option and config. The --negotiation-restrict option is new
and the ability to set it via config is also new.

I did try to be more careful around translatable error messages, too.


Updates in v3
=============

 * --negotiation-tip is now an alias of --negotiation-restrict.
 * More translatable strings use %s to isolate non-translatable options from
   translatable words.
 * The string_list named negotiation_tip is now renamed to
   negotiation_restrict.
 * The config options now allow an empty value to reset the list.
 * The --negotiation-require option is now called --negotiation-include.
 * Similarly, the config option is renamed and all code references.
 * The included haves now mark their commits as COMMON so commits that they
   can reach are not included in the negotiation walk if they are reached
   from the restricted commits.
 * The ref iterators are more careful about failing on bad references (ref
   exists but object doesn't) and ignoring missing references (perhaps
   config is erroneous?).
 * When sending tips during push negotiation, use the --negotiation-restrict
   option instead of -tip.


Updates in v4
=============

Thanks, Matthew, for the detailed review! There are some big changes in this
version.

 * Expanded commit message to cite the commit that introduced the bug
   (3f763ddf28).
 * Renamed --negotiation-tip to --negotiation-restrict throughout docs/code
   (including send-pack.c, transport-helper.c, builtin/pull.c). Added
   OPT_ALIAS in git-pull.
 * Switched config parsing to use parse_transport_option() helper. Removed
   git push from docs (not implemented yet). Restructured --negotiate-only
   validation flow.
 * NEW Patch 5: Added have_sent() interface to negotiators, so included
   haves can be de-duplicated properly by the negotiation algorithm.
 * Replaced COMMON flag hack with negotiator->have_sent() calls. Moved
   ref-pattern resolution into builtin/fetch.c (add_negotiation_tips()) so
   fetch-pack receives pre-resolved oid_array instead of string_list. Added
   test for --negotiation-tip ignoring missing refs. Added
   duplicate-avoidance test for v0. Accepts commit hashes in addition to ref
   names/globs.
 * Use parse_transport_option() for config. Updated docs to mention commit
   hashes. Removed git push from config docs. Fixed test to use correct
   restrict/include combinations.
 * In the last patch, add doc notes that remote config values also apply
   during git push with push.negotiate, now that they are integrated by that
   change.


Updates in v5
=============

Responded to small comments.


Updates in v6
=============

Corrected reviewed-by annotations in commit messages.

Thanks, -Stolee

Derrick Stolee (8):
  t5516: fix test order flakiness
  fetch: add --negotiation-restrict option
  transport: rename negotiation_tips
  remote: add remote.*.negotiationRestrict config
  negotiator: add have_sent() interface
  fetch: add --negotiation-include option for negotiation
  remote: add remote.*.negotiationInclude config
  send-pack: pass negotiation config in push

 Documentation/config/fetch.adoc  |   2 +-
 Documentation/config/remote.adoc |  49 ++++++++
 Documentation/fetch-options.adoc |  29 ++++-
 builtin/fetch.c                  |  87 +++++++++++---
 builtin/pull.c                   |   6 +-
 fetch-negotiator.h               |   9 ++
 fetch-pack.c                     |  99 +++++++++++++---
 fetch-pack.h                     |  10 +-
 negotiator/default.c             |   8 ++
 negotiator/noop.c                |   7 ++
 negotiator/skipping.c            |   8 ++
 remote.c                         |  10 ++
 remote.h                         |   2 +
 send-pack.c                      |  39 +++++--
 send-pack.h                      |   2 +
 t/t5510-fetch.sh                 | 191 +++++++++++++++++++++++++++++++
 t/t5516-fetch-push.sh            |  32 +++++-
 t/t5702-protocol-v2.sh           |   4 +-
 transport-helper.c               |   5 +-
 transport.c                      |  20 +++-
 transport.h                      |   7 +-
 21 files changed, 564 insertions(+), 62 deletions(-)


base-commit: 6e8d538aab8fe4dd07ba9fb87b5c7edcfa5706ad
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2085%2Fderrickstolee%2Fmust-have-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2085/derrickstolee/must-have-v6
Pull-Request: https://github.com/gitgitgadget/git/pull/2085

Range-diff vs v5:

 1:  538913a327 ! 1:  c8c422f646 t5516: fix test order flakiness
     @@ Commit message
      
          Use 'sort -k 3' to match the actual number of columns in the output.
      
     -    Reviewed-by: Matthew John Cheetham <mcheetham@outlook.com>
     +    Reviewed-by: Matthew John Cheetham <mjcheetham@outlook.com>
          Signed-off-by: Derrick Stolee <stolee@gmail.com>
      
       ## t/t5516-fetch-push.sh ##
 2:  580aa58943 ! 2:  ac3e8f74d9 fetch: add --negotiation-restrict option
     @@ Commit message
          translatable with the option name inserted by formatting. At least one
          of these messages will be reused later for a new option.
      
     -    Reviewed-by: Matthew John Cheetham <mcheetham@outlook.com>
     +    Reviewed-by: Matthew John Cheetham <mjcheetham@outlook.com>
          Signed-off-by: Derrick Stolee <stolee@gmail.com>
      
       ## Documentation/config/fetch.adoc ##
 3:  eee0543647 ! 3:  5206640b8b transport: rename negotiation_tips
     @@ Commit message
          Also update the string_list used to store the inputs from command-line
          options.
      
     -    Reviewed-by: Matthew John Cheetham <mcheetham@outlook.com>
     +    Reviewed-by: Matthew John Cheetham <mjcheetham@outlook.com>
          Signed-off-by: Derrick Stolee <stolee@gmail.com>
      
       ## builtin/fetch.c ##
 4:  63c675e93e ! 4:  eec0f90e02 remote: add remote.*.negotiationRestrict config
     @@ Commit message
          An empty value resets the value list to allow ignoring earlier config
          values, such as those that might be set in system or global config.
      
     -    Reviewed-by: Matthew John Cheetham <mcheetham@outlook.com>
     +    Reviewed-by: Matthew John Cheetham <mjcheetham@outlook.com>
          Signed-off-by: Derrick Stolee <stolee@gmail.com>
      
       ## Documentation/config/remote.adoc ##
 5:  d423c56283 ! 5:  840db1d957 negotiator: add have_sent() interface
     @@ Commit message
          common, so the implementation is quite simple. This logic will be exercised
          in the next change.
      
     -    Reviewed-by: Matthew John Cheetham <mcheetham@outlook.com>
     +    Reviewed-by: Matthew John Cheetham <mjcheetham@outlook.com>
          Signed-off-by: Derrick Stolee <stolee@gmail.com>
      
       ## fetch-negotiator.h ##
 6:  e86c9791e2 ! 6:  62e5ef1a4b fetch: add --negotiation-include option for negotiation
     @@ Commit message
      
          Also add --negotiation-include to 'git pull' passthrough options.
      
     -    Reviewed-by: Matthew John Cheetham <mcheetham@outlook.com>
     +    Reviewed-by: Matthew John Cheetham <mjcheetham@outlook.com>
          Signed-off-by: Derrick Stolee <stolee@gmail.com>
      
       ## Documentation/fetch-options.adoc ##
 7:  e5714115b5 ! 7:  05a4b69b9b remote: add remote.*.negotiationInclude config
     @@ Commit message
          list to allow ignoring earlier config values, such as those that might be
          set in system or global config.
      
     -    Reviewed-by: Matthew John Cheetham <mcheetham@outlook.com>
     +    Reviewed-by: Matthew John Cheetham <mjcheetham@outlook.com>
          Signed-off-by: Derrick Stolee <stolee@gmail.com>
      
       ## Documentation/config/remote.adoc ##
 8:  ed0be32e2c ! 8:  c69ca2e919 send-pack: pass negotiation config in push
     @@ Commit message
          are passed as --negotiation-include to ensure their tips are always
          sent as 'have' lines during push negotiation.
      
     -    Reviewed-by: Matthew John Cheetham <mcheetham@outlook.com>
     +    Reviewed-by: Matthew John Cheetham <mjcheetham@outlook.com>
          Signed-off-by: Derrick Stolee <stolee@gmail.com>
      
       ## Documentation/config/remote.adoc ##

-- 
gitgitgadget
