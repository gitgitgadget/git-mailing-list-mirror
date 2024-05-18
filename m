Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651B2383
	for <git@vger.kernel.org>; Sat, 18 May 2024 00:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715992514; cv=none; b=rTNrHIgU0Cw3CbLYllbabaVqWcxBkT86+489Ckkz3A6Z3Zy7AwV/6UPTmgxdpsNKm0Wcl3NC54vu2OUDb1TURxVusOwIAsqzFPd085QTHjuWVThqFtq5ccHGCR7QHNXZ61X3FxxB7cTK9q7kna7bzFH0n2WW2aAvyN4+4LKQVok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715992514; c=relaxed/simple;
	bh=1n2UmALE04D2MLbfFz5Bcsi1IUB+ZHcfI0jv759MC0U=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=nS0idrrq65E8vmeB+ZOT7x5MJhXyjxe/9+cktZHf/E1EdWmlME8yPHvyzrlmdHfLk4jT84XSE61MvT2XWV15klsb9qg4YfbXZSmW9wvi6P+OmvFPRTdoSHv+5u+LH18oNhPATDtRxDvfr93fxVHkr3NApPE2HROIV1C3qgmEQ7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=f0TifYna; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="f0TifYna"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1715992508; x=1716597308;
	i=johannes.schindelin@gmx.de;
	bh=LDJfPO0blqc5p3Hv6upukwdckJDI02Enw3nZRkavuyI=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:Message-ID:
	 MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=f0TifYnaH9g8hbwLTCQans6F5hUHEJYiutgRs/uamawG4z+co8K+7bqECTzEpAd+
	 XfmMWHqyh+lQt7brnK/Bl0U5NJG3WaO6tyVgyRn1cwFFzTCCV0hWFgVKBSeprLlUy
	 Y7luFtQ00fh3GJW1nr+fA1eDr1qJ8yTy5/hJJ7FTE3a/s7tpiSEBXSVTWS4u6eY8n
	 T6qDi7OebCRI4E3s+yBtjSF6CPn/3vI8Uhf+8elPMsAe8zlvvO5Mxm+9Dw/Y1fW1B
	 SeJD5nyzHoiU4/BjYgFNm/HzO53BuPTaZnKGXCOwz8rPWeg/etlDJgk+/AAniI4dm
	 OMU3lREmaxz930cTJA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.77]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MJE2D-1rrqEx34ot-00KiW9; Sat, 18
 May 2024 02:35:08 +0200
Date: Sat, 18 May 2024 02:35:07 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Elijah Newren <newren@gmail.com>
cc: git@vger.kernel.org
Subject: Replaying merges
Message-ID: <ee35f3b2-bf20-6fcc-2c71-38499aa592fe@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:kDj7P0m4fKOy3+1kAoiuYWy2wA1fUA6RwlS4invacAf72lIWzQ+
 hoVjadfWFkDn4bDlPfJGU7J0jzLPFnrjOUy0XUMW37S6xJZn4c7syAy+dJOdWTVeuuUFNGX
 dcm24dP8DZRFdftyK59/SrI9TwAFmMajuGK9P9T9Xaeksp5ZE/Q8VlSmo7inhuuIF6Lb64W
 zTbWsn4QzhcuL5QyXHPKw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:x91awhqXpJE=;leix50y3D5OQ1CWfaGu3Ap6RZRn
 0bUU9Plf6ZNQSocuq/IxOgB2If29o+EsK4quMKQgPdm4gN+HI5iqiGviXdaxCZ3/NaZP76twX
 N+Fy/gPecvShiDLqyqwiBo8C/o09h6GXkQMGeaxqVV42Bc4gjj6YL0LLmPYwy8x74Sz51tXhs
 oRudwsmkMMiSvCNlRNttWZ7NqMbExR2FVaBbHN/FA5niBrOfY49AgmWU98ddWHVGMOtz3BTbi
 RER/lDarhkLpoarGDHznKusp2XLaV48IkpLffXWauXdLMyYQvjEQoHww4Qbf5eASJPc3cjDGI
 fuw1yPEOyfsy5jS7hvhxWhFgyUa+8ekw8ZFJ/aEAiZtQYK+RLIL0MVMfZ8wflw4v/GR6mac1V
 RoXoCjr0FhGfOgszmW/PB83pVZiY8d29XpsAvTjR4s7Op+9Joo8KeDxX4mlPtFDFmQtgGkXkb
 EC3Rq/07vvGohdUDMgeKSZJssc7bLEHLpE4KNKmlwQDVMB2KWl54smOGilTnpr9XC3cL1vJ4D
 3IdmA7r2wzvLp+HNcUJVp6RCPNrEftL/q6sL+YOqvnCRl/V64/i8Cfrj2YiJMiXUHeO0CMkD7
 PHF/ZCii5siSuy50ZLtVSg1JtYl/BH/8nWOvB2elAE+ufqnTZnhkcjdZQLI8dncKQQuDA8Hbl
 cWhhnKceZO3oGamjJz8/N73D6wCIKALaJFyh/GEEEedVUaB64ERnuu3Eg8k8CSt+NWQk+tbno
 9/g8ivHoCxLVpULbiB4xj387aGV3USXmXROo+fSg5kN18U+2cxaueE42dovrcX0WraDpszWzO
 d6cq5IWtQRzFftIpswa+/kGdgnpJQ2km++VII6oCZzXdg=

Hi Elijah,

I took the suggestion to heart that you explained a couple of times to me:
To replay merge commits (including their merge conflict resolutions) by
using the _remerged_ commit as merge base, the original merge commit as
merge head, and the newly-created merge (with conflicts and all) as HEAD.

I noodled on this idea a bit until I got it into a usable shape that I
applied to great effect when working on the recent embargoed releases.

Here it is, the script [*1*] that I used (basically replacing all the
`merge -C` instances in the rebase script with `replay-merge.sh`):

-- snip --
#!/bin/sh

die () {
	echo "$*" >&2
	exit 1
}

test $# = 2 ||
die "Usage: $0 <original-merge> <rewritten-merge-head>"

original_merge="$(git rev-parse --verify "$1")" ||
die "Not a revision? $1"
test ' ' = "$(git show -s --format=%P "$original_merge" | tr -dc ' ')" ||
die "Not a merge? $1"
rewritten_merge_head="$(git rev-parse --verify "$2" 2>/dev/null)" ||
rewritten_merge_head="$(git rev-parse --verify "refs/rewritten/$2")" ||
die "Not a revision? $2"

# Already merged?
if test 0 -eq $(git rev-list --count HEAD..$rewritten_merge_head)
then
	echo "Already merged: $2" >&2
	exit 0
fi

# Can we fast-forward instead?
if test "$(git rev-parse HEAD $rewritten_merge_head)" = "$(git rev-parse $original_merge^ $original_merge^2)"
then
	echo "Fast-forwarding to $1" >&2
	exec git merge --no-stat --ff-only $original_merge
	die "Could not fast-forward to $original_merge"
fi

# Only Git v2.45 and newer can handle the `--merge-base=<tree>` invocation
validate_git_version () {
	empty_tree=4b825dc642cb6eb9a060e54bf8d69288fbee4904
	git merge-tree --merge-base=$empty_tree $empty_tree $empty_tree >/dev/null 2>&1 ||
	die "Need a Git version that understands --merge-base=<tree-ish>"
}
validate_git_version

do_merge () {
	git update-ref refs/tmp/head $1 &&
	git update-ref refs/tmp/merge_head $2 &&
	{ result="$(git merge-tree refs/tmp/head refs/tmp/merge_head)"; res=$?; } &&
	echo "$result" | head -n 1 &&
	return $res
}

remerge_original=$(do_merge $original_merge^ $original_merge^2)
test -n "$remerge_original" || die "Could not remerge $original_merge"
merge_new=$(do_merge HEAD $rewritten_merge_head)
test -n "$merge_new" || die "Could not merge $rewritten_merge_head"
new_tree=$(git merge-tree --merge-base=$remerge_original $original_merge $merge_new | head -n 1)
test -n "$new_tree" || die "Could not create new merge"

# Even though there might be merge conflicts, the `merge-tree` command might
# succeed with exit code 0! The reason is that the merge conflict may originate
# from one of the previous two merges.

files_with_conflicts="$(git diff $original_merge..$new_tree |
	sed -ne '/^diff --git /{
		# store the first file name in the hold area
		s/^diff --git a\/\(.*\) b\/.*$/\1/
		x
	}' -e '/^+<<<<<<< refs\/tmp\/head$/{
		# found a merge conflict
                :1
                # read all lines until the ==== line
                n
		/^+=======$/b2
                b1
                :2
                # read all lines until the >>>> line
                /+>>>>>>> refs\/tmp\/merge_head$/{
			# print file name
			x
			p
			# skip to next file
			:3
			n
			/^diff --git/{
				# store the first file name in the hold area
				s/^diff --git a\/\(.*\) b\/.*$/\1/
				x
				b
			}
			b3
		}
		n
		b2
	}')"

# Is it a "Sync with <version>" merge? Then regenerate the log
sync_info="$(git cat-file commit $original_merge |
	sed -n '/^$/{N;s/^\n//;/^Sync with 2\./{N;N;s/^\(.*\)\n\n\* \([^:]*\).*/\1,\2/p};q}')"
merge_msg=
if test -n "$sync_info"
then
	merge_msg="$(printf '%s\t\t%s\n' $rewritten_merge_head "${sync_info#*,}" |
		git fmt-merge-msg --log -m "${sync_info%,*}" |
		grep -v '^#')"
fi

if test -z "$files_with_conflicts"
then
	# No conflicts
	committer="$(git var GIT_COMMITTER_IDENT)" ||
	die "Could not get committer ident"
	new_commit="$(git cat-file commit "$original_merge")" ||
	die "Could not get commit message of $original_merge"
	new_commit="$(echo "$new_commit" |
		sed '1,/^$/{
			s/^tree .*/tree '"$new_tree"'/
			s/^committer .*/committer '"$committer"'/
			/^parent /{
				:1
				N
				s/.*\n//
				/^parent /b1
				i\
parent '"$(git rev-parse HEAD)"'\
parent '"$(git rev-parse $rewritten_merge_head)"'
			}
		}')"
	if test -n "$merge_msg"
	then
		new_commit="$(printf '%s\n\n%s\n' \
			"$(echo "$new_commit" | sed '/^$/q')" \
			"$merge_msg")"
	fi
	new_commit="$(echo "$new_commit" | git hash-object -t commit -w --stdin)" ||
	die "Could not transmogrify commit object"
	git merge --no-stat -q --ff-only "$new_commit"
else
	echo "no-ff" >"$(git rev-parse --git-path MERGE_MODE)"
	git rev-parse "$rewritten_merge_head" >"$(git rev-parse --git-path MERGE_HEAD)"
	if test -n "$merge_msg"
	then
		echo "$merge_msg"
	else
		git cat-file commit "$original_merge" |
		sed '1,/^$/d'
	fi >"$(git rev-parse --git-path MERGE_MSG)"

	git read-tree -u --reset "$new_tree" ||
	die "Could not update to $new_tree"

	echo "$files_with_conflicts" |
	while read file
	do
		echo "Needs merge: $file"
		mode="$(git ls-tree $new_tree "$file" | sed 's/ .*//')" &&
		a=$(git show "$new_tree:$file" |
			sed -e '/^<<<<<<< refs\/tmp\/head$/d' \
			    -e '/^=======$/,/>>>>>>> refs\/tmp\/merge_head$/d' |
			git hash-object -w --stdin) &&
		b=$(git show "$new_tree:$file" |
			sed -e '/^<<<<<<< refs\/tmp\/head$/,/^=======$/d' \
			    -e '/>>>>>>> refs\/tmp\/merge_head$/d' |
			git hash-object -w --stdin) &&
		printf "%s %s %s\t%s\n" \
			0 $a 0 "$file" \
			$mode $(git rev-parse HEAD:"$file") 1 "$file" \
			$mode $a 2 "$file" \
			$mode $b 3 "$file" |
		git update-index --index-info ||
		die "Could not update the index with '$file'"
	done
	die "There were merge conflicts"
fi
-- snap --

For the most part, this worked beautifully.

However. The devil lies in the detail. You will see that the majority of
the script is concerned with recreating the stages that need to be put
into the index. The reason is that the merge conflicts are already part of
the merge base and hence the `merge-tree` arguments do not reflect the
stages.

But it gets even worse. The biggest complication is not even addressed in
this script, when I realized what was going on, I understood immediately
that it was time to abandon the shell script and start implementing this
logic in C (which I can currently only do on my own time, which is
scarce). The biggest complication being the scenario... when a merge
conflict had been addressed in the original merge commit, but in the
replayed merge there is no conflict. In such a scenario, this script _will
create not one, but two merge conflicts, nested ones_!

I still do think that your idea has merit, but I fear that it won't ever
be as easy as performing multiple three-way merges in succession. To
address the observed problem, the code will always have to be aware of
unresolved conflicts in the provided merge base, so that it can handle
them appropriately, and not treat them as plain text, so that no nested
conflicts need to be created.

Unfortunately, I did not document properly in what precise circumstances
those nested conflicts were generated (I was kind of busy trying to
coordinate everything around the security bug-fix releases), but I hope to
find some time soon to do so, and to turn them into a set of test cases
that we can play with.

Ciao,
Johannes

Footnote *1*: You'd think that I'd learn from past experiences _not_ to
prototype in Bash when I want to eventually implement it in C. Honestly, I
thought I could get away with it because I failed to anticipate the many
complications, not the least of which being that there is currently no
_actually_ correct way to generate the stages. So basically I thought that
the script would consist of the part before the code comment starting with
"Even though there might be merge conflicts"...
