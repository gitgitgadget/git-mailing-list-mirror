Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5EC3B198
	for <git@vger.kernel.org>; Tue, 19 Dec 2023 20:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="fk7iaf2z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703018773; x=1703623573; i=tboegi@web.de;
	bh=VenFuZKY9AZcZFSukWXCK2lCs0qOKf3R5RPTpQqlGMM=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:
	 In-Reply-To;
	b=fk7iaf2ztZwOAqYFdc5Wrji7NObai/FHofo/G1nlzNRTUz5OVvoukhoR7gngeXVA
	 vYPJeuuuNHC00hXnFoSZNyYHdXCzXN3uG2CpbXu1MRk4TYUmpGsvGmEqn7GroSVQU
	 X9bIdp1xIIvAdvyOCW9LOk1e267P9szAezd17cKdZVca34oSGhdrQnxQkFjzed9zH
	 DG5voLpqp6ASpP9o/zye3UtY3NJZc0dr77dYxX0UdhXS70aosBkZ08HJ4H8bJ7/vs
	 LWgbQ5cPJsiplzqmcHsfZheFjXU4/NpSvLh2cByBN0nHoGbjTg8fkUZcsO8EiN7ue
	 zjRUT/PPsFIrof8gtA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([195.198.253.159]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MC0LH-1rS73I06TF-00CKmc; Tue, 19
 Dec 2023 21:46:13 +0100
Date: Tue, 19 Dec 2023 21:46:12 +0100
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Chandra Pratap via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Chandra Pratap <chandrapratap376@gmail.com>,
	Chandra Pratap <chandrapratap3519@gmail.com>
Subject: Re: [PATCH v2] Teach git apply to respect core.fileMode settings
Message-ID: <20231219204612.GA26266@tb-raspi4>
References: <pull.1620.git.1702908568890.gitgitgadget@gmail.com>
 <pull.1620.v2.git.1703010646036.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1620.v2.git.1703010646036.gitgitgadget@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:r9FbgveWff/4LLme+9enYMsx6obhtrJ5ngAV3FzzjGXIuLm1aSa
 PxkqJuH4dOXw7mKoyN5PNwK166zurlv8hTRkuOR8bLznH7ckhfBkiletVVn5HxCY6OGOQB5
 ul7X3WWULTUpTuZStgx5V0zlKPFJFk7o9y4EZENGnfUoXQH8vovm5kCSXlm7/cfkeERM0Uo
 S1LnTq464NdF2+WW7W4cg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:I+e+rEoC/7k=;KQmlVEkzP48/qzgb/OnsnXG+0qx
 sxz2mEqKwgm3z7OO9H2MPQwkEZcQaR4c13CXtW87FphsCsCZ97JfF350xkZhGwrGKYvOdANed
 uJBMJIdm7pWpHqYNJvK4r9BwEEkfF/spM/VqDHs/i8pPP58vBUcK4jtVRkpoLtcuRtM2YO+Ye
 gYwDMRgHV1o8HH5+Ru34ngcZDPyIJvMjXdVMEbdPsaTkFBjK0v6HT7G0B/oj5DAauHsdeaMqb
 DmfnPSvO7h/Z2KjnlyjvcZRC1UEWPGqPG5tZijBVQInTn1jgUHeFLEPpdX/dmqI3jvMV864ln
 VbWyq68798z4RddlW2ji9QqQ5cgx29+hjftnokRDpqIbreMUdQdKfM6pRu1zzqwL1nLBLsJHN
 /OIux+2airI8/3CLW5t+91f844hSwIqBwqIS81FFP6DJ9UxXeUMMYBLP/c5VvlQ+7wCICnMa2
 5zm4yjOLl+wl8AoxJfQwrwjkVi8otsRxyyCU5hdKmdPoco/w2TwywwAibztuQVrtqVIb40Gdt
 YEjoSjcShmvZ1uAINqsKe4g6enRpM7njcgn2wmvbKL3QdLVPhvlbA6UVBT9dpJmvrzPO4ziU0
 xSbKvc2HTiXLB39jeGYiyVzBVyAVuRldtOFDoTu1Mrn55EJ50lDS76N11xp54niFtspBzR7yQ
 33UrOAUx9RrlZIebSjIebcI0ZYWEXwbY1vBzhdBaGljWgBz4gjebX6Dii882eAe+qhG4uOPHJ
 XyaiOU22CcFeP2yww3l8MuCU8u6rjzjc3TR0TVoVw/8FB/nBhWqWUFt8U8L9KZ/X9NM3zuHPP
 FavwF5rI22RxrMWdjroP9FQm15oWK6Isf+iEtkW/B+YVsijbmi1PnDUKtPaHjDvJQxGOpCdKX
 L8da1BN9ELXOXhcFzEAvOkdGWvB8dI7Fpy6OegRodbaLCzUH9ZLDrkmO0QLbeY/J2Ifmrc2f1
 mSPybh7mt7LoupV3qS/EOAV4XyI=
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 06:30:45PM +0000, Chandra Pratap via GitGitGadget =
wrote:
> From: Chandra Pratap <chandrapratap3519@gmail.com>
>

Thanks for working on this, some small nit-picks inline.

> When applying a patch that adds an executable file, git apply
> ignores the core.fileMode setting (core.fileMode in git config
> specifies whether the executable bit on files in the working tree
> should be honored or not) resulting in warnings like:
>
> warning: script.sh has type 100644, expected 100755
>
> even when core.fileMode is set to false, which is undesired. This
> is extra true for systems like Windows, which don't rely on "lsat()".

Small typo here: lsat() should be lstat(). But being nit-picking (and simp=
lifying):
Windows does not provide an implementation, so Git for Windows does it's o=
wn,
which currently does not implement the x-bit(s).
In short: The ', which don't rely on "lsat()' could probably just removed.

>
> Fix this by inferring the correct file mode from the existing
> index entry when core.filemode is set to false. The added
> test case helps verify the change and prevents future regression.

Another nit-pick, sorry for that, I try to convince everybody to not
use "added".
So may be
Add a test case that verifies the change and prevents future regression.

>
> Reviewed-by: Johannes Schindelin <johannes.schindelin@gmail.com>
> Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
> ---
>     apply: make git apply respect core.fileMode settings
>
>     Closes issue #1555 on GitHub.
>

[]
>
>
>  apply.c                   |  8 ++++++--
>  t/t4129-apply-samemode.sh | 25 +++++++++++++++++++++++++
>  2 files changed, 31 insertions(+), 2 deletions(-)
>
> diff --git a/apply.c b/apply.c
> index 3d69fec836d..58f26c40413 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -3778,8 +3778,12 @@ static int check_preimage(struct apply_state *sta=
te,
>  		return error_errno("%s", old_name);
>  	}
>
> -	if (!state->cached && !previous)
> -		st_mode =3D ce_mode_from_stat(*ce, st->st_mode);

> +	if (!state->cached && !previous) {
> +		if (!trust_executable_bit)
> +			st_mode =3D *ce ? (*ce)->ce_mode : patch->old_mode;
> +		else
> +			st_mode =3D ce_mode_from_stat(*ce, st->st_mode);
> +	}
>
>  	if (patch->is_new < 0)
>  		patch->is_new =3D 0;
> diff --git a/t/t4129-apply-samemode.sh b/t/t4129-apply-samemode.sh
> index e7a7295f1b6..73fc472b246 100755
> --- a/t/t4129-apply-samemode.sh
> +++ b/t/t4129-apply-samemode.sh
> @@ -101,4 +101,29 @@ test_expect_success POSIXPERM 'do not use core.shar=
edRepository for working tree
>  	)
>  '
>
> +test_expect_success 'ensure git apply respects core.fileMode' '

Small nit-pick:
The "ensure" is probably not needed, all tests ensure something.

> +	test_config core.fileMode false &&
> +	echo true >script.sh &&
> +	git add --chmod=3D+x script.sh &&
> +	git ls-files -s script.sh | grep "^100755" &&
> +	test_tick && git commit -m "Add script" &&
> +	git ls-tree -r HEAD script.sh | grep "^100755" &&
> +
> +	echo true >>script.sh &&
> +	test_tick && git commit -m "Modify script" script.sh &&
> +	git format-patch -1 --stdout >patch &&
> +	grep "index.*100755" patch &&
> +
> +	git switch -c branch HEAD^ &&
> +	git apply --index patch 2>err &&
> +	! grep "has type 100644, expected 100755" err &&

This feels somewhat volatile against future changes.
grep-ing for things that are not there, without verifying
that they are there, without this patch.

On my test system, there is no message at all, so a

test_must_be_empty err &&

feels more "stable".

> +	git restore -S script.sh && git restore script.sh &&
> +
> +	git apply patch 2>err &&
> +	! grep "has type 100644, expected 100755" err &&
> +
> +	git apply --cached patch 2>err &&
> +	! grep "has type 100644, expected 100755" err
> +'
> +
>  test_done
