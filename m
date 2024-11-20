Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7123F2F2A
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 05:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732078934; cv=none; b=ffoGzG23EMQoQTVOzey4xUi8fKtxLk4ZyqPEcB2XBY2275Q6av00rhotBYo94VZCWxtt+5isXzkTK1EUCz4bZ6LUJAKA/8vUDgplucANhL4m+whsZ0FUiE1KecP0/bBL6dhdf8W71owidAfB90hDiDTMT+P9Izx0pxSLxzCrkz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732078934; c=relaxed/simple;
	bh=+wXe7O2rWyaY8OvO4qm5HevctMfqq+6SXGUTIY3pvDo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p57FBL5y/vUmbFWlYtJzLlp0OXLIIgqTdLCh4+YRQlmqISHxXyAd4Aa2JNQ7JGCNPvgTQ6owIcxrVKYWVhelYCyyHEql9nj/gRYCqUsrnObadvk1yPfRvJUG/ZTiyC/eSAl4tihAUI3tSIE3thWrVAJnuzeoTeKtgSwAnEGlStI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=OOtDWI23; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="OOtDWI23"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1732078923; x=1732338123;
	bh=gA4OWA4Y+P6taV8QrFPcPKJMSkHPPZfw30MXURU7u9Y=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=OOtDWI23WPJM+yCJGkHCGnABP6xSFzxrOhgE6C91ASG7hjZqkY89NJNOYZ95klLGE
	 fui7mMr5/Jef5/HWM2dhOxJVGE5EIas3/gEGBmPDcG3dMyHb16I70yFnxMh3z4hmzB
	 ZQ07GZ+ZVC0FE4RizFnc5oq6MKwAdbiwmnPSTFDALqFym82dt74ixo3hjk+lMeP9Zk
	 WuiEGEwOsFWDHTX5VMOdjV1MNKMDYpsgeckirow+SnmI/TXW/iNkSHk5jzdYlmJjxu
	 fimVQvDZ2ye9CzRL3IFC8glBYJeOmEM7rsjIfB5wOLgLqYOdMp+S+IY2MQJv5uGUTt
	 zsUddG3crteIg==
Date: Wed, 20 Nov 2024 05:01:58 +0000
To: phillip.wood@dunelm.org.uk, git@vger.kernel.org
From: Caleb White <cdwhite3@pm.me>
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 5/8] worktree: add relative cli/config options to `add` command
Message-ID: <D5QQQCUL0DR7.31L4W6C4NT6UU@pm.me>
In-Reply-To: <20fdb5ba-075f-48b5-9e92-f85378500710@gmail.com>
References: <20241031-wt_relative_options-v4-0-07a3dc0f02a3@pm.me> <20241031-wt_relative_options-v4-5-07a3dc0f02a3@pm.me> <20fdb5ba-075f-48b5-9e92-f85378500710@gmail.com>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 99db89d1d6b19400a5cce564bcbb7ed6c97fc240
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue Nov 19, 2024 at 9:07 AM CST, Phillip Wood wrote:
> Hi Caleb
>
> This looks good, I've left a couple of comments below - there are a few
> places where the tests could be cleaned up (I've only commented on the
> first instance of each cleanup) but the coverage looks good and the
> implementation looks good to me too. I'll leave it here for today, sorry
> it has taken me so long to get round to looking at these. I should be
> able to look at the rest of the patches this week.

No worries sir, thank you for taking the time to review. I greatly
appreciate it. I'll start implementing the changes on my end, but I'll
wait until you finish reviewing before sending v5.

>> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree=
.txt
>> index 70437c815f13852bd2eb862176b8b933e6de0acf..88d2261012166a929b7f167d=
79720e4d965fd71b 100644
>> --- a/Documentation/git-worktree.txt
>> +++ b/Documentation/git-worktree.txt
>> @@ -216,6 +216,10 @@ To remove a locked worktree, specify `--force` twic=
e.
>>   This can also be set up as the default behaviour by using the
>>   `worktree.guessRemote` config option.
>>
>> +--[no-]relative-paths::
>> +=09Overrides the `worktree.useRelativePaths` config option, see
>> +=09linkgit:git-config[1].
>
> I think it would be helpful to describe what this option does directly,
> rather than in terms of a config setting which is documented elsewhere
> and that may not be set

I originally had a description here, but it was requested by another
reviewer that I remove the duplicate information and simply reference
the config option. I don't mind which direction we go, but we need
some consensus on this.

>> diff --git a/builtin/worktree.c b/builtin/worktree.c
>> index dae63dedf4cac2621f51f95a39aa456b33acd894..e3b4a71ee0bc13d5e817cf7d=
cc398e9e2bd975de 100644
>> --- a/builtin/worktree.c
>> +++ b/builtin/worktree.c
>> @@ -120,12 +120,14 @@ struct add_opts {
>>   =09int quiet;
>>   =09int checkout;
>>   =09int orphan;
>> +=09int relative_paths;
>
> Excellent - thanks for getting rind of the global in /worktree.c

Thanks! I'm happy with how this turned out.

>> diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
>> index cfc4aeb1798c6d023909cec771e5b74e983af5ea..d36d8a4db0e9248777876975=
79544f10f92dc0cf 100755
>> --- a/t/t2400-worktree-add.sh
>> +++ b/t/t2400-worktree-add.sh
>> @@ -1207,4 +1207,58 @@ test_expect_success '"add" with initialized submo=
dule, with submodule.recurse se
>>   =09git -C project-clone -c submodule.recurse worktree add ../project-5
>>   '
>>
>> +test_expect_success 'can create worktrees with relative paths' '
>> +=09test_when_finished "git worktree remove relative" &&
>> +=09git config worktree.useRelativePaths false &&
>
> Using test_config instead of "git config" ensures the setting is cleared
> at the end of the test

Ah, good to know! I'll update.

>> +=09git worktree add --relative-paths ./relative &&
>> +=09cat relative/.git >actual &&
>
> There's no need to copy the file just so we can say "actual" below

Good point. I saw this pattern in other tests and thought it was
standard practice. I'll update.

>> +test_expect_success 'can create worktrees with absolute paths' '
>> +=09git config worktree.useRelativePaths true &&
>> +=09git worktree add ./relative &&
>> +=09cat relative/.git >actual &&
>> +=09echo "gitdir: ../.git/worktrees/relative" >expect &&
>> +=09test_cmp expect actual &&
>> +=09git worktree add --no-relative-paths ./absolute &&
>> +=09cat absolute/.git >actual &&
>> +=09echo "gitdir: $(pwd)/.git/worktrees/absolute" >expect &&
>> +=09test_cmp expect actual
>> +'
>
> We're only checking ".git" here and not the "gitdir" file as well, I
> guess that's ok as the implemntation that writes the files is tested
> above and here we're interesting in testing the config setting.

I can just add a test for the other file to be complete.

>> +test_expect_success 'move repo without breaking relative internal links=
' '
>> +=09test_when_finished rm -rf repo moved &&
>> +=09git init repo &&
>> +=09(
>> +=09=09cd repo &&
>> +=09=09git config worktree.useRelativePaths true &&
>> +=09=09test_commit initial &&
>> +=09=09git worktree add wt1 &&
>> +=09=09cd .. &&
>> +=09=09mv repo moved &&
>> +=09=09cd moved/wt1 &&
>> +=09=09git status >out 2>err &&
>> +=09=09test_must_be_empty err
>
> This relies on "git status" failing if the worktree links are broken. A
> more direct test might be to check the output of "git worktree list" or
> "git rev-parse --git-dir".

All three commands would have the same error message, but I suppose I
could switch to `git worktree list` for a more direct test.

>> +test_expect_success 'relative worktree sets extension config' '
>> +=09test_when_finished "rm -rf repo" &&
>> +=09git init repo &&
>> +=09git -C repo commit --allow-empty -m base &&
>> +=09git -C repo worktree add --relative-paths ./foo &&
>> +=09git -C repo config get core.repositoryformatversion >actual &&
>> +=09echo 1 >expected &&
>> +=09test_cmp expected actual &&
>
> This can be done with
>
> =09test_cmp_config -C repo 1 core.repositoryformatversion

Sweet! I like it.


Best,

Caleb


