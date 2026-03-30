Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC39C3A6F1A
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 17:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774892529; cv=none; b=TgolJg2xXDwt5MjwgdssMdBczOj1HcP0FoF/5dEJLIRgfPrfyvhbVymLcpRCZfPUic2V69Nc6C5lkeV+zG8P+jN2Hp6iO5CzPfQ1QVScTtvORHATy0TCwnw/yXI4sL9BEAbDwwWQSbMHDDebGdHXZxc7CtWWfg7YE/WQO/35AGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774892529; c=relaxed/simple;
	bh=4CgkJKmqKRfsIjOdKN2E2aVZ6X3NeVHOBOrYlgIKCtk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sWte+PvSHBHyIgRQEeGZVfGecEktPVaPUYs3css4eKY9aIo8KNIIp7Nd1NJ88HgVk+fu34AE85bErOUH3wFTB2APF7infZpT2w5A8e4HHlZvdF1AFLDpk6Mw9SMg3Mab7UlxzRGuVz/jvFR/Fmx5EHwpF7oJBi4DekGX/t/L52E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=Wp9uWfTF; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=aYZLquTM; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="Wp9uWfTF";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="aYZLquTM"
DKIM-Signature: a=rsa-sha256; b=Wp9uWfTFNlzb83bDyHhKG0sVMvIiB33U4Q816ptkQU8DvqZnHO07S7jiAU98E6GHOnln6Fl0ZyubWElF0lhFLgLn63+KZrIz+WaUNUlO66usAMTMas46Ja2dIM1MzX50ZxKP9DVGdjer6A1jNISdJuSibaM9Qk9NrYgHKc2fq0YTILrMmcwbQbBH1w2B9u4UWGJYh+PbRNTNCGhDQDTzRwj1V/MtpIJOQWSdNoZvxl3ZiFmgZP30eCDTmm+rIfu6OE9zU0afS/5GGESS0G6E1lMCRaRCdOJ+G5AbLIoQBzllpMfRByzRs+mCvkPtsaSm3lmQxhgDbNALkrhm3KzWXQ==; s=purelymail1; d=malon.dev; v=1; bh=4CgkJKmqKRfsIjOdKN2E2aVZ6X3NeVHOBOrYlgIKCtk=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=aYZLquTMCwmt+UoWkPUVd9g5Po9JiRJRvkBVKliD7CndYTSfuR0CDf1mEgMjgRT/m9KWUNHlVTzdG4PlqZIzKrRwmBLLWLH2mLWAr458Ppq68nJnODQrUVDXER9l/1m2ThAb57CkymPdF6E0Llg1Gcmh5mY4JOru+3CbKjGMW6NIarJrJY94CBidqHPEaSYCATlTlphhJTtm64XVN7lwjwcwU7+ed1eVv2h59pBNbi/IR8UVnpg8m0pHp7OBUR/GkXH2wDIyapcCqboM3PCrXjzVM0+kLGv3qMqfHXu8FDFogytpuxWcDkrts3cIp/VZDjvxPifPJtcID5aiuTuU5g==; s=purelymail1; d=purelymail.com; v=1; bh=4CgkJKmqKRfsIjOdKN2E2aVZ6X3NeVHOBOrYlgIKCtk=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -2073784610;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 30 Mar 2026 17:41:59 +0000 (UTC)
Message-ID: <0af26f29-5643-4ff2-b659-ae0fa234161a@malon.dev>
Date: Tue, 31 Mar 2026 01:41:56 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GSoC PATCH] backfill: error out when HEAD cannot be parsed
To: Trieu Huynh <vikingtc4@gmail.com>, git@vger.kernel.org
References: <20260329183603.538241-1-vikingtc4@gmail.com>
Content-Language: en-US
From: Tian Yuchen <cat@malon.dev>
In-Reply-To: <20260329183603.538241-1-vikingtc4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/30/26 02:36, Trieu Huynh wrote:
> handle_revision_arg() returns non-zero on failure, but do_backfill()
> ignored the return value. On an empty repo with no commits, HEAD is
> unborn and handle_revision_arg() fails, but backfill silently
> continues with an empty revision walk and exits zero, looks like
> success but did nothing.
> 
> Check the return value and propagate the error, consistent with
> how builtin/pack-objects.c handles handle_revision_arg() failures.
> 
> Add a test to verify that backfill on an empty repository fails
> with a clear error message.
> 

Aside from the minor flaws Karthik mentioned, I think this commit 
message is spot on.

> Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
> ---
>   builtin/backfill.c  | 3 ++-
>   t/t5620-backfill.sh | 6 ++++++
>   2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/builtin/backfill.c b/builtin/backfill.c
> index 27a301f9b2..4b2db94173 100644
> --- a/builtin/backfill.c
> +++ b/builtin/backfill.c
> @@ -96,7 +96,8 @@ static int do_backfill(struct backfill_context *ctx)
>   	}
>   
>   	repo_init_revisions(ctx->repo, &revs, "");
> -	handle_revision_arg("HEAD", &revs, 0, 0);
> +	if (handle_revision_arg("HEAD", &revs, 0, 0))
> +		return error(_("unable to parse HEAD revision"));
>  

Looks good to me.

>   	info.blobs = 1;
>   	info.tags = info.commits = info.trees = 0;
> diff --git a/t/t5620-backfill.sh b/t/t5620-backfill.sh
> index ff67e8ecea..91b5115732 100755
> --- a/t/t5620-backfill.sh
> +++ b/t/t5620-backfill.sh
> @@ -101,6 +101,12 @@ test_expect_success 'backfill no flag on non-TTY is silent' '
>   	test_grep ! "Downloading batches" err
>   '
>   
> +test_expect_success 'backfill on empty repo fails gracefully' '
> +	git init empty-repo &&
> +	test_must_fail git -C empty-repo backfill 2>err &&
> +	grep "unable to parse HEAD" err

Remember your last patch? Wouldn't it be better to use 'test_grep' here?
It's easy to see that the original code uses 'test_grep' (a few lines 
above):

	>   	test_grep ! "Downloading batches" err

Wouldn't it be better to maintain consistency? ;)

> +'
> +
>   test_expect_success 'backfill --sparse without sparse-checkout fails' '
>   	git init not-sparse &&
>   	test_must_fail git -C not-sparse backfill --sparse 2>err &&

Regards,

Yuchen

