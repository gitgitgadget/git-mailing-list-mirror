Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655242D130B
	for <git@vger.kernel.org>; Tue, 25 Nov 2025 06:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764053720; cv=none; b=B/q5HNVoIowHUa14PWT5dM7hmEEbxedtgmqlqoOHJjmogMQbO7b8R10pSoT/8Sg5AESixlYX1ZruSroSuX5y0xjChcJhyld7QNwllpcn2hbx177ztMjSx/fLiJmJvrs+2cScniEK5jckT6+H3n2IUtJRtzaD9V7jIVHZYjAh7H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764053720; c=relaxed/simple;
	bh=kv/iuSdr4gI7fVs7l7tQKWxuCU314oP4mtzARlPOjEE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uYzkC70o4PDoO6hQHq7/id5aNFyXYvi70aQuxeq/Sz916s8eS9E8kp9IQ+QYjyu8Lm+DM2EyRW2jPaP8DOwZVMyX5ykx1I89J4xeOt5Sx7OdIr5enz4wTQtbpOKmmbSjom6k/y5VFViewAx6ds9JGfZjTXkv28r0t1uh1IJCAi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mhc16dLc; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mhc16dLc"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-43379251ff9so29066805ab.1
        for <git@vger.kernel.org>; Mon, 24 Nov 2025 22:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764053715; x=1764658515; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W5ywSM++3V9ow6xeXFAEI1OpVQQe/4jX8Z25L+rfCXg=;
        b=mhc16dLcsqNk1xqXq1STppu0ZIaNr8LCKIOLzl6yjr1Vw44Ei/Kp0SmhALunRQiRdf
         u5EEplgY64MQgWy01MpTJa5Qc6EE3IRpao8n0oQTAhL67JSm6xgVhG1eO5vYKTe5bGuN
         TjCOFisp2CaUbOEeY54x7RtcuooP/wboqN+UoLJaDTJAi9KPQyltXib3Mtj/5lVuz0kw
         t8b9gZm3eftpNoMfIHm66ziUrwPHQPpnoxi8Up+5jlv2maHNSt+oUUM0bjP7oXSnHm4V
         GINEQnYr8s9U/5lGTzFiOpmcbXdP6zOtu/LVw6atTVzle7ijH558DI+aNwJvVPBIj/TR
         zn1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764053715; x=1764658515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W5ywSM++3V9ow6xeXFAEI1OpVQQe/4jX8Z25L+rfCXg=;
        b=jcFqa4MGNcPGNQA9Ve7+LWCIdl1raWE/YC+p7naaMvOfx7Nu+FLGjYaLhMhKJvBbuZ
         /Lx4FBWYCbVy5i1V434ToXwwJBf4MngWr7c23lSnxJYSjjL2mFWlnbneFAgztNrDjiLv
         g+mV5D6Jzi0m5SF49tQn1qK5DQn48xZ0YNaR/66yGrWfM/oR+2Xf1ntQhqSXN68KTDqc
         D+VxLtRmGMwSGZD4kGzceKFQ8zfXlCsZJ3v4PPvbmtxIJMZcAJgfidY7Yb/jgxUwvI2C
         7MB3o+jENJnJtxPSMQW7G/qES59WAwZYImai4uAa3Bw6ui7NeryDk2v+rIMqJ1e/IVyS
         ufAw==
X-Gm-Message-State: AOJu0YxpJZVBXGUJAfds/re5ZUiqnE/T+ON/AeVjnDVcWq2qG6gb4lh5
	H6EtUoNbFlE+cEo/wpSJS5uek1NN7m3VdjdxRWc0aiSKDTm/Gb44SlQaK8Nz8hShTsWxNKopNXe
	KUquRh6Tji+k6UgqMpOo8xhrF4WzPKX3RXA==
X-Gm-Gg: ASbGncujV90Bk/VYSmqbhPozsNv25F170UZHbWkT8jQzEMz94dVvFltbyap+tjk/Gkj
	IA7DgVv6bTwQriTO78DTmi1cs3RMk7OqEKJ2gRK2Lcfp4mDedJWsp9hn00C9EaX1cPRZkwzFRqL
	aljTHgmQzsJOMC2plQMCuP/THaZ2LzHheQN4uKk+DRrM2Xtf717NJFqqXfFd2mGfrbujJw9tT3P
	KV5eHW31DnFsmrURWKWXngbF3vhNPAtzdhD0sPgE5AY2dxEFqyxV+M8sOFmV51A8YzdozUBiDsM
	EYwsc5FJz7ORkM2PxGfy1I11+AZcEFdlM6q9yA==
X-Google-Smtp-Source: AGHT+IEhHzadlpFnYTNgpjyc37Zn2yJlEfzrLsP/ov39/6tgk9YQeFOCMdIgPfvusLo6Msq/STPz2J5v41vXNwLGpVg=
X-Received: by 2002:a05:6638:a702:b0:5b7:1805:cc4e with SMTP id
 8926c6da1cb9f-5b956744c5amr15759901173.2.1764053715377; Mon, 24 Nov 2025
 22:55:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqq5xb0yqj9.fsf@gitster.g>
In-Reply-To: <xmqq5xb0yqj9.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 24 Nov 2025 22:55:04 -0800
X-Gm-Features: AWmQ_bmuI84Ephk2SrTbqNM3A9g-47HHxDdE-DvT7OEFKbVzNd7XuMyh3ruGjro
Message-ID: <CABPp-BGEg0PFoXWQYQZ2GpdxxBvz1KdgenLDsvb3bdrhALEd-A@mail.gmail.com>
Subject: Re: What's cooking in git.git (Nov 2025, #07; Sun, 23)
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I tried to take a look at some of the series whose status you were
asking for feedback on (and just threw an extra comment on one that
you didn't ask about).  Comments below...

On Sun, Nov 23, 2025 at 8:59=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> * jc/optional-path (2025-11-20) 3 commits
>  - config: really treat missing optional path as not configured
>  - config: really pretend missing :(optional) value is not there
>  - config: mark otherwise unused function as file-scope static
>
>  "git config get --path" segfaulted on an ":(optional)path" that
>  does not exist, which has been corrected.
>
>  Will merge to 'next'?
>  source: <xmqqikf47ajk.fsf@gitster.g>

This topic seems to be missing a squashed-in fix from
xmqqy0o05nuy.fsf@gitster.g; should that be squashed in and then merge
down to next?

> * kh/doc-committer-date-is-author-date (2025-11-20) 1 commit
>  - doc: warn against --committer-date-is-author-date
>
>  The "--committer-date-is-author-date" option of "git am/rebase" is
>  a misguided one.  The documentation is updated to discourage its
>  use.
>
>  Will merge to 'next'?
>  source: <V2_committer-date-is-author-date.1@msgid.xyz>

I think merging down makes sense.  It's a simple enough change, that
just gives helpful documentation warnings.  (As a side note, I found
it illuminating to read from that commit message about the reason that
flag was added; it never made any sense to me, but I didn't dig
further.  I'm glad Johannes and Kristoffer did.)

> * js/ci-show-breakage-in-dockerized-jobs (2025-11-17) 1 commit
>  - ci(dockerized): do show the result of failing tests again
>
>  Dockerised jobs at the GitHub Actions CI have been taught to show
>  more details of failed tests.
>
>  Will merge to 'next' after amending?
>  cf. <xmqqpl9gike6.fsf@gitster.g>
>  source: <pull.2003.git.1763399064983.gitgitgadget@gmail.com>

I had a slight tweak for the wording of the first paragraph, which I
just left as a comment on the patch.  Not sure that needs to hold it
up, but maybe worth considering to include in your amending if
Johannes is fine with it?

> * js/strip-scalar-too (2025-11-17) 1 commit
>  - make strip: include `scalar`
>
>  "make strip" has been taught to strip "scalar" as well as "git".
>
>  Will merge to 'next'?
>  cf. <xmqq7bvoiadg.fsf@gitster.g>
>  source: <pull.2004.git.1763409086322.gitgitgadget@gmail.com>

I'd kind of like to see a response to your suggested alternative.

> * dw/config-global-list (2025-10-09) 4 commits
>  - config: keep bailing on unreadable global files
>  - config: read global scope via config_sequence
>  - config: test home and xdg files in `list --global`
>  - cleanup_path: force forward slashes on Windows
>
>  "git config --list --global", unlike "git config --list", did not
>  consult both of the two possible per-user sources of the
>  configuration files, i.e. $HOME/.gitconfig and the XDG one, which
>  has been corrected.
>
>  Comments?
>  source: <pull.1938.git.1760058849.gitgitgadget@gmail.com>

Perhaps mark this topic as expecting a re-roll?  (c.f.
20251122020047.GB3947@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal=
.cloudapp.net)

> * jc/submodule-add (2025-11-15) 1 commit
>  - submodule add: sanity check existing .gitmodules
>
>  "git submodule add" to add a submodule under <name> segfaulted,
>  when a submodule.<name>.something is already in .gitmodules file
>  without defining where its submodule.<name>.path is, which has been
>  corrected.
>
>  Comments?
>  source: <xmqqv7jacvdq.fsf@gitster.g>

Left a couple minor wording suggestions.

> * en/ort-rename-another-fix (2025-11-03) 3 commits
>   (merged to 'next' on 2025-11-19 at 53d94af6b4)
>  + merge-ort: fix failing merges in special corner case
>  + merge-ort: remove debugging crud
>  + t6429: update comment to mention correct tool
>
>  Yet another corner case fix around renames in the "ort" merge
>  strategy.
>
>  Will merge to 'master'.
>  source: <pull.1992.git.1762192908.gitgitgadget@gmail.com>

A sidenote that probably doesn't matter since you've already marked it
for merging down: this topic has been deployed at GitHub for just over
a month without incident (whereas there were some problems prior to
deploying these fixes, and those problems cleared up the minute that
these changes were deployed).

> * cc/fast-import-strip-if-invalid (2025-11-16) 3 commits
>  - fast-import: add 'strip-if-invalid' mode to --signed-commits=3D<mode>
>  - commit: refactor verify_commit_buffer()
>  - fast-import: refactor finalize_commit_buffer()
>
>  "git fast-import" learns "--strip-if-invalid" option to drop
>  invalid cryptographic signature from objects.
>
>  Comments?
>  source: <20251117043450.322644-1-christian.couder@gmail.com>

I think this one is ready to merge down.

> * en/xdiff-cleanup-2 (2025-11-18) 10 commits
>  - xdiff: rename rindex -> reference_index
>  - xdiff: change rindex from long to size_t in xdfile_t
>  - xdiff: make xdfile_t.nreff a size_t instead of long
>  - xdiff: make xdfile_t.nrec a size_t instead of long
>  - xdiff: split xrecord_t.ha into line_hash and minimal_perfect_hash
>  - xdiff: use unambiguous types in xdl_hash_record()
>  - xdiff: use size_t for xrecord_t.size
>  - xdiff: make xrecord_t.ptr a uint8_t instead of char
>  - xdiff: use ptrdiff_t for dstart/dend
>  - doc: define unambiguous type mappings across C and Rust
>
>  Code clean-up.
>
>  Will merge to 'next'?
>  source: <pull.2070.v5.git.git.1763505262.gitgitgadget@gmail.com>

I think so.  There are certainly additional cleanups needed, as this
series makes clear, but that's clearly a bigger problem and the author
has stated he plans to work on those but just needed to limit the
series to some initial cleanup that wasn't too big to send to the
list.  The series has gotten reviews from lots of folks, and I just
looked over v5 and couldn't spot anything to call out.
