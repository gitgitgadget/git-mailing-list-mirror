Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795559480;
	b=bmHc6LeIrFTOLWgF8ODp6tidC+1FTV1NyJ+8Q8XTvYsT7mpyrDOsWDnAx12othHP1UcT
	 oea/LqqXvmOLrYRFrVzmj7HzJNjfbbpzBP+quTQsFpVQFjm/S5VbOb+cs/lahgAtz5JSy
	 hCEyd92ROt2doGieRupml4SZrjC6g1otvSPFsaQ2PSh0YYHGSS35oPpS+Y3X8PV61p4lV
	 yUu6tRZ8l9vl4ApNcvS1QgeDCSglg3xGkGxdnzBBlfDw8FKDMIZZedQ60mFiNWpEDRc6D
	 WUJ1a/JM7v8upp6UDP4piAr7wCuWtJ0OdwsTxwahJdvjT+Wmst9oGnIzuIT3UnU7ASA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795559480;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=g/mhZYdP+i36Wp4l13tYtMk0GG7Ju1bfOMjC9u/ZBx4=;
	b=hQ0Cn63caC1moCOrpJGhfn4hcxyTGp4L7WCaduj7g37hiXTiwRMAB5Lhib9GojZb6PXW
	 8b/DldyzR+y9GbyiztzCEaKTwX4DqwsT9Oy6nl3SaVoUIxOZhNTiJEZL7i52Xn9SH5fyA
	 qOyGftMjh9q3+Nd5FE1msRF9MI+WUv0lARBFDgaaR+RRVkf9E4GFPn0QzStXr6G38fmX+
	 vtWdLgdxAssBnvldey/2IbWnhRbXfkrUltOA23OxmPZj8fa1Hh8R+1//BxrqxBsAdSBIB
	 1KNp3QTdU5+p9lrjGhGBYBBEYBU49+MXPJLxJT7cUWUCwRY3MXlZa1Tg7ewHw1ZhjLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=X0QRr7p+;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="5/NKEoB/";
	arc=none smtp.remote-ip=103.168.172.145
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71B0606A691
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 22:31:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B71B0606A691
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=X0QRr7p+;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=5/NKEoB/
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id EEC43EC0AC4
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 17:31:18 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 24 Nov 2026 17:31:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795559478; x=1795645878; bh=g/mhZYdP+i
	36Wp4l13tYtMk0GG7Ju1bfOMjC9u/ZBx4=; b=X0QRr7p+doLjg50Yq9GUUYwsQZ
	Djs9K0AExxFctRVLbbhfFrvqCw2OqKO76nDlghcimvGjxfDU8SQJhgQv0pk6RM6x
	mBFNZiD3YhBhmUm+xsHkqagKKnZy4uJgyc2Y3suXes8FqsCHXC8CWNDR/g+S37Gi
	uqA2PkdMjziWILt/QBnl0ZHfOqxqErx7/dBUufuE+xGcv2Pt/PxDzijTz0OtgXmz
	UVqKt/PZ1rbKDtkOMbGYTGufCGIsSf8oyVr0BAwzV+cGBUhFyO5PWTTrY71DeyZR
	6N8J5OzqwGBiOeSUE+M7seztH5Q0K+bo6RbYHf0BTxP+vBP5rDjiCa/GMT/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795559478; x=1795645878; bh=g/mhZYdP+i36Wp4l13tYtMk0GG7Ju1bfOMj
	C9u/ZBx4=; b=5/NKEoB/bAYBvCGixiqpuMKmL2SN6nhPST39DSwz1Brdynj8tFY
	03gGY5B42YKVKDv9nlbm4wrMh7eUXUcfoghPMR0eZd19PgM89koQ4kTEkRslghIJ
	VMmL5ok7lTSnxGiBp5MnFh4O9wj1XwsKKH/Zfox4ZICuTOjhAKDp61youBVtNoRf
	E+3Omz4MsaQX6L1S+cS3wq+O3meZ0eihGqk+yF3bIz6BKAf6AFEXqQygj17eqQ3z
	KhrS6LkJEqhWV9J2+eexq75g454xloCK23ctsyfuzmsv0wh0ITAZXj4sTHMeT2jN
	HhFjPDWrwl6oEpzXsuu2S/+HnSn4cI5cvKA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795559478; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:hLVn7mWJrPIwdNTgfOpOnwLsDIBEMH/1U4CuvGLN6XDROQe
	8plIZB1yCgVq13XpMLzpktm/cS4rKmBs5P5RHcko4nOnqqP2EK6zXd6HizTSxVyc
	Zs/ftUoxlJcVMZP9wFzIG7WETGEwbm+3yPbcVu+UUWl/Y83gOf9mM4y1tEFG/h3X
	Nt4A2ypFseBRvCqztjJ07SQn+gbHyRiHwwz6PGVsQrD/NErJrLEvYxK+dtplvTT8
	LXaoSyUWVaH9/cifCHYhd1NNiVysCfdtIZFYTRpwzEYaNh0Z5a5quGioecyG6Tat
	exYScvPPnQMDt+s4QfhoqQi83A5peqq9zK0VxEA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:duv1oix77Z9ZnhLbXRya1aMcuLkRtcYxas3aYF5dLN0=:PqIE5vxVhx5w8Zit+kPd3AF7N6/YewK0JLwrlV7qZpI=;
X-ME-Sender: <xms:NhAGa9pYv2-UfMsHfsZfKF9ss8bolAbGn-uNPHnbxQl_jQaYcDBwOA>
    <xme:NhAGa2pxc9YGb2UVAM-dj0WYv1m0MU14tWUnT66pmRaKYlZyN8T70of3Pt-iYCdGM
    TpLF_LIf5JRpdj_01cAWdkVUm57bkro4DpTlNdXERWkot5EHx_MP5g>
X-ME-Received: <xmr:NhAGa_OTru5BVwOBLvnAnUD8aT8SpMGMuZQ47bqGKHGB6KmSAkJA6gz2gWvrAFy-SjO6cC1UmkrJo8GEIvksSuwrpdLCQfsLQCj-Yd4>
X-ME-Proxy-Cause: dmFkZTFLC+CgNhjFo3KGulC0rEwwuJ0rrfGcdHzIBpJzIWpJXBfnCHoPjRSruJBKehfvGM
    4vQ7e+/bEq4yfriQh+KwpcP/KUGeDzoY2yzIkgJZCcla+yXVari3yjkp6u+cosIcqaf/CF
    h73kksdbUAvyWHhhvuRnzG1wucl1FRVCJhGYg5llczNAHPUfi3JmSiDx0F5wJx3baGIwp0
    6S6ueunzEr2nGCeKz5ygYs0ag10jimy2niaPHqs2YiwgvQe3F8FdnJ6qbPnziHeGuSjDpP
    q9fi6xFXm2I7HYapLYEBzd3zambeexYHvFFTKSi01Xdv7FkL3VNG7Pypl8DoKBOXRfZPs0
    S/7sTBK1MWd3DHAxEzXUnjhjnKAP7rdIS/chQ0hncyE6mUAkY8rDwzeCSokGjslE3wTykt
    1rWFRdH37uHD2WENtROmHrFhGm2K230VZqe8VUCGq9A+6h5VtHMfCk3XadbxniQxJSe+yo
    y6pMTKuG72QB8L/6exHVGMBtSLPP/byBOrEUr6YJknbM+lKrym/R/SheIVOTmA0OBOxUGV
    2QcLK9OYS5N4jXhhfQphrzMYmLxfB04kVGtqpC5SDjlNiMH8XwlRV4q/ccTcS8rkM48c3c
    o8saEa0HQdkGfkv/X19MX98wX2iXXQJbYDte3xIu+F2m08A3q24x/WjRI5zw
X-ME-Proxy: <xmx:NhAGa3xeZXA19Zkm0v6GJsyPReTzEdCPhctfT6oMAXcTllXGHOpBwQ>
    <xmx:NhAGa4vYnT3k4lRzhDHOcJATklPQIeeQqFM_KrGH_z9QPyUR5hqNMg>
    <xmx:NhAGaw5jfIWIdRG6p_qiT8RqJlWBt6HpzFCv8psyrO3y8hldLgPq7A>
    <xmx:NhAGa3TUx5PeJsPDIzvBs2A7_T8kNPsGuH-uZ5s3K-iAV_qWRT1UbA>
    <xmx:NhAGa9z_VzGGGAG8FuDOeikn_U_dkZaj7dg_QjtzbAfXZfku-40V4YoZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 17:31:18 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Dominik Maier <dmnk@google.com>
Cc: git@vger.kernel.org,  dmnk+artist@google.com
Subject: Re: [PATCH] cvsexportcommit: avoid shell in -W git calls
In-Reply-To: <20261119192321.2690660-1-dmnk@google.com> (Dominik Maier's
	message of "Thu, 19 Nov 2026 20:23:21 +0100")
References: <20261119192321.2690660-1-dmnk@google.com>
Date: Tue, 24 Nov 2026 14:31:17 -0800
Message-ID: <xmqqv75lkgju.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Dominik Maier <dmnk@google.com> writes:

> When "-W" is enabled, git-cvsexportcommit reads "$go_back_to" from
> "git symbolic-ref HEAD" and passes it unquoted to single-argument
> system("git checkout $go_back_to") and system("git symbolic-ref HEAD
> $go_back_to"). Valid Git branch names may contain shell metacharacters
> such as ';', causing Perl to invoke "/bin/sh -c" and split or execute
> unintended shell tokens instead of restoring HEAD.

Indeed, Git's refname rules allow characters such as ';' and '$', so a
valid branch name can trigger shell interpretation in single-argument
system() calls.

> diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
> index edf02f9964..ce21d1ac8f 100755
> --- a/git-cvsexportcommit.perl
> +++ b/git-cvsexportcommit.perl
> @@ -142,7 +142,9 @@
>      $opt_v && print "Resetting to $parent\n";
>      $go_back_to = `git symbolic-ref HEAD 2> /dev/null ||
>  	git rev-parse HEAD` || die "Could not determine current branch";
> -    system("git checkout -q $parent^0") && die "Could not check out $parent^0";
> +    chomp $go_back_to;
> +    system('git', 'checkout', '-q', "$parent^0") &&
> +	die "Could not check out $parent^0";
>  }

The rewrite from a single-arg system() to list form is trivially correct
and great safety improvement.

The chomping of $go_back_to in between looks somewhat out of place,
though.

> @@ -331,7 +333,7 @@
>  
>  print "Applying\n";
>  if ($opt_W) {
> -    system("git checkout -q $commit^0") && die "cannot patch";
> +    system('git', 'checkout', '-q', "$commit^0") && die "cannot patch";

We cannot tell where $commit comes from or if it is safe as it gets
prepared far away.  It came from @ARGV and cleansed by passing it to git
rev-parse --verify, so it should be safe.  But as a principle it is good
to retire the single-arg form of system(), and from that perspective,
this is a good change.

> @@ -410,9 +412,10 @@
>  unlink(".cvsexportcommit.diff");
>  
>  if ($opt_W) {
> -    system("git checkout $go_back_to") && die "cannot move back to $go_back_to";
> +    system('git', 'checkout', '--end-of-options', $go_back_to, '--') &&
> +	die "cannot move back to $go_back_to";

To reduce the "what's chomp doing here?" confusion, we could move the
chomp() here, but I think the posted patch as-is is probably better, out
of the principle that we should cleanse the data we obtain from outside
world as early as possible.

>      if (!($go_back_to =~ /^[0-9a-fA-F]{$hexsz}$/)) {
> -	system("git symbolic-ref HEAD $go_back_to") &&
> +	system('git', 'symbolic-ref', 'HEAD', $go_back_to) &&
>  	    die "cannot move back to $go_back_to";

And conversion of these two system() into the list form looks correct.
Even with chomp(), $go_back_to is a refname that can contain ';' and
other characters that the shell pays attention to, and using the list
form is not just nice but is necessary.

Looks good.  Thanks.

> diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcommit.sh
> index 8e0272df20..74058f0128 100755
> --- a/t/t9200-git-cvsexportcommit.sh
> +++ b/t/t9200-git-cvsexportcommit.sh
> @@ -341,4 +341,23 @@ test_expect_success 'use the same checkout for Git and CVS' '
>  
>  '
>  
> +test_expect_success 'cvsexportcommit -W handles shell metacharacters in branch name' '
> +	(
> +		mkdir shared_meta &&
> +		cd shared_meta &&
> +		sane_unset GIT_DIR &&
> +		cvs co . &&
> +		git init &&
> +		git checkout -b "topic;false" &&
> +		echo init >meta_base &&
> +		git add meta_base &&
> +		git commit -m "initial" &&
> +		echo added >meta_new &&
> +		git add meta_new &&
> +		git commit -m "add meta_new" &&
> +		git cvsexportcommit -W -p -u -c HEAD &&
> +		test "$(git symbolic-ref HEAD)" = "refs/heads/topic;false"
> +	)
> +'
> +
>  test_done
