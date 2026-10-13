Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404C2531605
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 17:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791914247; cv=pass; b=Z6MB9FiyHWnt8cnBcO+Gi16hbDaqmF5JYWOW1oGbbWrk/KZzyeEdO68ayCHUY+lKKJ/QJUfDdeB4FBt5ambQpNKGJ/r0DY21Xt4mg5t31dIYaO418aKcyeUYTKL+O+QnUACbdPTK6Ho8Mio8OkcB2YGr7GOyIaTsCy+hefshq3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791914247; c=relaxed/simple;
	bh=GledCcuHUVS/1fETrJYLfWfF+/acdxiil/m7ew4/04M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lOcfCrtuYyrLC4gqTP+b1CY+M6OTR6fKvLzwhGjne1cBy8pYRe2fvy4iKTW6vttBfx38kjgHhhH8k5oBzYWevXo+3YFxLqWogNDwuO/6FOU3cQK9KDx2yIdFQ/2IGuBxFx5qtNOJbgJWtijeXZ0OfGXHCajh4XNmyRoSBHX3Zmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fLOVWU9N; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLOVWU9N"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5351a226e53so4138041cf.1
        for <git@vger.kernel.org>; Tue, 13 Oct 2026 10:57:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791914245; cv=none;
        d=google.com; s=arc-20260327;
        b=FLCUUHTuArWOisYEkVo+vEK9I6gUamtfB0iDrUx8j7yn0i9pt7C3vLn+a/dtD8Ec3M
         ceGrt/EKXUTvAszJl6bvlClCVMlQS1LIVn14x5kda2gvbO/993O3zs3J6cWNKkfztppy
         XGRDVnkR7YasEcoTSUDUexGXXOgBNtST03wuX/PwGkNSh9EC0ztubIOsQYDoymfSJiDg
         1FMBIeNeipYAwqo+OVkLMcgugMhtWTnHW5ZaCPgR/mbVgtQocYi/VU8hLJFyXIxrx/MW
         cFAxR2a0HrvFBEScKtkLgHck4iM/sJCEa2g0wKKNDLN3mYPa8e55mk7SoAj6NCjQYrGL
         fcGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=lBETs0hqlMCP9gL6qW6dyoLG7KW7UaqkxzmYoMNtEno=;
        fh=gxVv8BpzzChE7N/lOIzY1dyTKxpnp9c2UlqRQ9V/f3M=;
        b=m8fonq/JA4iPIN0WLaVrit3ApnMUG720T+97uttYJ5Z08Cng+vpMegyjUkcJKZBIRQ
         +saoPQhwtV0BSrzCJ4Ib2VUMeUcrTMLUkaLdubWeTcozZaumiT6DYblSqYjtQAhKvlrk
         G3GfgGZv0rj9HPsHr94qR1lo3oGhxrjuJZNXLx7qrgLV7O6coiIpD7y8CiNyDbtuh2Z2
         aRlZ8Lh1Qmff0FixThAtVMD2PaXuUrVhtzpUCtcJcfb3BCFNSymQ5jvM+2VVFB7ouc63
         ge1ZdsveY2Av1eUPqAupnos06mrPSeTIvgJOnHSL3W1dgzIWyM+G+a/FFauHo3kcrkCG
         UvBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791914245; x=1792519045; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lBETs0hqlMCP9gL6qW6dyoLG7KW7UaqkxzmYoMNtEno=;
        b=fLOVWU9NoGO7Fx7SxjfhFVlITGDtir8LHlka8NVpMOBdoHBECyFAdUE6ziNYnSEPoP
         wV0GYqH54AuI7/CUGJM7wOggwhXtMhTn4HYwC5cXpV3oxXqziOAn/6E/LJ1qFMASdimI
         0yHnWmdqbcGwuwYimMnwZ7KwoYvtFRJ459fbox56QmjbCkQYD4vTPcODLsnYDJeY9MWJ
         N0VpoZMnhF/Rgh0d1HxdkgpMVSIifwTZXwgvOLr/SvgNLe+LWLE4rm1Oqwqf+s9TW2Hq
         /D8keV+M50pa4EmSXTB7lsSk0tgPZZudtRtG4DksEvNhdz4kLS4zSgkwB48ZwO6un0sC
         1Baw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791914245; x=1792519045;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lBETs0hqlMCP9gL6qW6dyoLG7KW7UaqkxzmYoMNtEno=;
        b=Hy2ezRn8rBT4wpm/oo5LzB4gDJwT8cWrDhNN/YRgGoAe2IBL+Bahbv1CUcjON80BYl
         r/zjlvUyuMDYQmT03AxQR76hpo37HrCqo/W8DAOtR0CnERWN0PRFAlMIkXzjR9Dj54fx
         CrknuGCc6ixmFNlqOzrM2AcrqEJVKa5m0Vk2MqENmlu23x94IiY2HzAiuFaVr042b/ud
         mwT25FMyilfXjJSfOfZ97GvQSwZRwMC7zHX9CltcWkhSkk4MQIkagkNAMjUzPlG8LZKg
         YFvJCh1uKoUlqHv06vRHRxVv+kYJv+JfE2jlm3n1Rms82VACIKwNDo/V+Q88EU0fiH9M
         9M8Q==
X-Gm-Message-State: AFq9FYLC1Ae440uovMbMfL/4N/yNmFKLfPN+Qjjw12MIGT9eKm8QA7vu
	APKtCa93Rau4QC/Rpm/69Nx5wbIKaLM7DW6n+E0vJE/UrxdXKHTjU3BspnN3pwiE3O87q2nnK/I
	S4eZ/thNLC3WTtD8OFZFr5ObgJnVSCL0=
X-Gm-Gg: AYBFou3bJf3gik5qwgYVFPsfG6Q1+wBOSufHmTmjD/j723KrbYDGh14V6Fm5emA0o9h
	cGD30Yu5TZcvpZk3InNwQOQihyFibeDdRvxEO+dyoz4zwfLCV1DwDQWw6abaIzBAowOgE8O2U3B
	yqiol8e4nLDyfraajsz/Jp2Mdc3DmsmjPGqygWyQ2h/6DIL1vKVXhOs0h4CWKhOofDCpBOcuUDL
	smE2S2wOUhnuua/0tRoPl5B+LGgaVMGQYQ6A04xXETBxMxFA8guGG51KRYqh1IZHVUYUeN8QjxH
	IilK3aAuhA9Q/DXjJReK9Ljohc90P1dvbOcgZIyvd/MV5kk90vTYph5ZBNq9z+AVf8KzxwATmMI
	xMWO7OZ0TspYkYdEtz9FvfusWgALOmsUkSFol8m2fSvE85g==
X-Received: by 2002:a05:620a:2b4e:b0:93e:6d87:4f69 with SMTP id
 af79cd13be357-93ebd1e4d57mr2377417385a.3.1791914244853; Tue, 13 Oct 2026
 10:57:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012175638.3712-1-tboegi@web.de> <20261013065915.879-1-curtis.allen.smith@gmail.com>
 <ede6ef41-df6f-4912-be31-1c4a5c0a550e@gmail.com>
In-Reply-To: <ede6ef41-df6f-4912-be31-1c4a5c0a550e@gmail.com>
From: Curtis Smith <curtis.allen.smith@gmail.com>
Date: Tue, 13 Oct 2026 11:57:13 -0600
X-Gm-Features: AclHuK9JmNKttafULWpsalnS4Mz0Rqx96b104Q21KzLHHiBDKK--OaAh_7ylJSY
Message-ID: <CACnh8rL8gzJ24O905Es=6-TLhfP7ufVnpeREs0vvtBYPawWuOw@mail.gmail.com>
Subject: Re: [PATCH v4] read-cache: do not trust a size change when conversion
 is active
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"

Hi Phillip,

Thanks for looking at this.

On 13/10/2026, Phillip Wood wrote:
> The commit message talks about "git status" but presumably this change
> affects the output of "git diff-files" and "git diff-index" as well.

You are right that the message is too narrow, though the mechanism is
not quite that.  ie_modified() is reached from refresh_cache_ent(),
and from ls-files, mv and submodule.c; that is all four callers.
run_diff_files() and run_diff_index() go through
match_stat_with_submodule(), which calls ie_match_stat() and never
ie_modified().  So diff-files and diff-index are not changed directly.

What changes is the index refresh.  Stock git can never clear the
stat-dirty mark on such a path: refresh_cache_ent() calls
ie_modified(), ie_modified() returns early on the size change, and the
entry is left alone, so the next refresh repeats the whole thing.
With the patch the refresh resolves the path and writes the new stat
data, and everything downstream of a refreshed index settles.  On the
example in the commit message, stock 6de20f6 against the patch:

                                      stock              patched
  git update-index --refresh          exit 1,            exit 0,
                                      "file.txt:         no output
                                       needs update"
  git ls-files -m (after a refresh)   file.txt           no output
  git status --porcelain -uno          M file.txt        no output
  git diff-files --name-only          file.txt           file.txt
  git diff-files --name-only,
    after anything that refreshes
    and writes the index              file.txt           no output
  git diff-index --name-only HEAD,
    likewise                          file.txt           no output

"git diff" is one of the commands that refreshes, so in practice a
second "git diff-files" in the same tree does change.

So the plumbing answer is: diff-files run against an unrefreshed index
is unchanged, and that is correct, since its contract is to report
what differs by stat.  But stock git leaves these paths permanently
stat-dirty, so the report never settles no matter how many times you
refresh.  The patch is what lets it settle.  "git update-index
--refresh", which is the usual way a script asks "is the working tree
clean", is the plainest case: today it fails on a file that git itself
agrees is unmodified.

The visible cost of that is in the commands that refresh the index
before they will run.  require_clean_work_tree() calls
refresh_index(), so with one CRLF-rewritten file in the tree, stock
git refuses:

    $ git rebase HEAD~1
    error: cannot rebase: You have unstaged changes.
    error: Please commit or stash them.

and then will not let you take its advice:

    $ git add file.txt && git commit -m x
    On branch master
    nothing to commit, working tree clean

The "git add" repairs the stat data as a side effect, so a second
"git rebase" does work; there is just no way for the user to know
that.  With the patch the first one runs.  "git pull --rebase"
without --autostash is the same, since it calls
require_clean_work_tree() as well.  A merging "git pull" does not,
and is unaffected.

> Does this change improve the performance of "git diff" because it
> no-longer tries to diff two blobs that are identical after conversion
> or is the existing implementation smart enough to avoid that already?

Not for a single "git diff": diff-files flags the path on the stat
difference, the diff machinery reads the file, converts it, finds the
result identical to the blob and emits nothing.  That read and
conversion is the only way to know, and it happens in stock git today.
The patch neither adds nor removes it.

The saving is on the runs after the first.  Once a refresh has
recorded the stat data, the path matches on stat and is never opened
again.  Stock git reads and converts it on every single run, forever.
That is the "steady state" row in the numbers below the --- in v4:
21 ms against 5 ms for 10000 files, and it is the same effect.

I will say this in the commit message.  Replacing the last paragraph:

  -For such a path, fall through to ce_modified_check_fs(), as is
  -already done when only the mtime changed.  Paths without conversion
  -return early as before.
  +For such a path, fall through to ce_modified_check_fs(), as is
  +already done when only the mtime changed.  Paths without conversion
  +return early as before.
  +
  +ie_modified() runs when the index is refreshed, so this reaches
  +every command that refreshes it: "git update-index --refresh" now
  +succeeds instead of reporting "needs update", "git ls-files -m"
  +and "git status" stop reporting the path, and "git rebase" and
  +"git pull --rebase" no longer refuse to run.  "git diff" itself is
  +unchanged; it already reads and converts the file and prints
  +nothing.

Happy to make that longer or shorter.

> > A follow-up that skips the conversion and the hash when the length
> > already rules out a match is ready if wanted.
>
> What does that entail? A file that consists of blank lines can double
> or halve its length going from '\n' to '\r\n' and vice-versa. Is that
> range narrow enough to avoid converting a significant number of "real"
> changes?

It is not a range test, so the blank-line file is fine.  When the
end-of-line conversion is the only one that applies (no clean filter,
no "ident", no working-tree-encoding), "git add" either leaves the
file alone or turns every CRLF into LF.  The converted length is
therefore exactly one of two values: the raw length, or the raw length
minus the number of CRLF pairs.  A memchr scan for CR gets that count.
If neither value is the size of the blob, the file is modified, and it
is neither converted nor hashed.  "text=auto" strips every CR rather
than CRLF pairs only, but it refuses to convert a file containing a
lone CR, so those two values still cover it.

Your example comes out right.  N blank lines is N bytes with LF and 2N
with CRLF.  Rewritten to CRLF the raw length is 2N and the CRLF count
is N, so the two candidates are 2N and N.  The blob is N, that
matches, and the file goes on to be converted and hashed as before.
The length test never reports such a file as modified; it only
declines to short-circuit.

Your underlying question still stands, though, so let me answer it
with the losing cases in the table and not just the winning one.
Measured on an i9-14900K under WSL2, warm cache, fastest of 5 runs of
"git status -uno":

  10000 files x 2.6 KB, "* text=auto eol=lf" stock     v4  v4+opt
    length-changing edit                     20 ms 136 ms   57 ms
    same-length edit                        133 ms 135 ms  146 ms
    CRLF-rewritten, 1st run                  20 ms 139 ms  160 ms

  200 files x 1 MB, same attributes
    length-changing edit                      2 ms 506 ms   24 ms
    same-length edit                        509 ms 511 ms  516 ms
    CRLF-rewritten, 1st run                   3 ms 605 ms  623 ms

The length-changing rows are the ones the scan decides: an edit that
adds or removes a character cannot produce the blob's length, so the
file is neither converted nor hashed.

Two cases it does not help, and I would rather say so than let one
row speak for the patch.  The CRLF rewrite this series is about has,
by definition, a converted length equal to the blob's size, so the
scan there is pure overhead: 139 ms against 160 ms.  And a
same-length edit does not change the size at all, so it goes down the
mtime path that stock git already walks; the scan adds about 8
percent to a path that exists today, 133 ms against 146 ms.  Those
rows are also the clearest evidence that the fix by itself adds
nothing to that path: 133 ms against 135 ms.

Which brings me to whether the follow-up is wanted at all.  Those
corpora are deliberately extreme; they exist to make the effect
measurable.  On a tree with a realistic number of modified files the
fix does not show up:

  10000 files x 2.6 KB, "* text=auto eol=lf" stock     v4  v4+opt
    clean tree                                5 ms    4 ms     5 ms
    1 file edited                             5 ms    5 ms     5 ms
    10 files edited                           4 ms    4 ms     4 ms
    100 files edited                          5 ms    8 ms     5 ms
    1000 files edited                         6 ms   20 ms    10 ms
    10000 files edited                       20 ms  136 ms    57 ms

  the same tree, n files CRLF-rewritten, 1st run
    1 file                                    6 ms    8 ms     7 ms
    10 files                                  8 ms    8 ms     8 ms
    100 files                                 8 ms    9 ms     9 ms
    1000 files                                9 ms   18 ms    13 ms

The cost is proportional to the bytes in the files you actually
changed: roughly 12 microseconds per modified 2.6 KB file, and about
2.5 ms per modified 1 MB file.  It takes on the order of a thousand
modified converted paths before it is worth measuring at all.

So I would rather leave the follow-up out for now.  Nothing in the
fix depends on it; it is correct on its own, and this only changes
what it costs.  The fix is one condition and an #include, and it is
free in every case anyone is likely to hit; 124 more lines to speed
up trees far larger than the one in the bug report is a poor trade
unless someone is actually hitting it.  If the fix's cost does bother
people, say so and I will send it.

> Looking at t0020-crlf.sh none of the existing tests use a separate
> repository, so maybe we could avoid that overhead here as well.

Agreed, and both tests now run in t0020's own repository.  One wrinkle
worth noting: "* text eol=lf" makes the existing allcrlf and mixed
files modified, so the attribute is scoped to the file under test.
Both tests pass with the patch and fail on stock 6de20f6, as before.

For what it is worth, the overhead was not measurable: t0020 takes
0.41s either way.  The change is for consistency with the rest of the
file.

That will be in v5.

Thanks,
Curtis
