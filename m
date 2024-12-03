Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A52E22611
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 00:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733187454; cv=none; b=IXkctTPvxEx9LFGrChzEjq+w30oL77XDUTQdQCdedKRfexX0Lk5+0PZecL2/3c4d47sw6nbWqCKoV+BesUyAl3uUPpjZtH3tXa4cKy1ghUqDcGoDhgOfNIKHnT6Giwp8kz2OnxerZoxTeH0fL12XoG3mY+ZSUJ3HRH+cwEzhMR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733187454; c=relaxed/simple;
	bh=synV33Od7i9nvFDz0yaqX315hHJ6RkTOOFLutEoe4cc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A84Cq0E3Fkg/ptYoNuUdjyhjBpuV/lq+vdNIFqWbS/9WkYQQxsYg/v0DCG4ZePccfLQnp2uZi/VYITqng2J0xcfJ94+slqmZBfWerE32rTrM3LFIziTNIOAnrSAZ0wz+0idWOdsucW5sHfpXoGKUfsK6r4fJ0snQUtEj6ejpyyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VzS+RBDl; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VzS+RBDl"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 2218B1140175;
	Mon,  2 Dec 2024 19:57:31 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 02 Dec 2024 19:57:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733187450; x=
	1733273850; bh=xBgfwSRfNQbDnnk+MI1tS1ZjK02lZLU9z1NM4PhRtG4=; b=V
	zS+RBDljzlw+Dsyjhn7K9X4skiCzygE9IpDDO7J9Rikilmf/7bXudhxJ9D+GDIl8
	LhOVOAtNuz84EF+e//eOYPzKB6LzTUVMonhUZmLpf8SuZCeU5nQ/sgpgsexiOLTf
	diZtZcxUPTBkECgD5BHtKb4udCnju6NEDqjDSG07UXoXBiCQssrEyU4eqNF2/inn
	iRgEt/BPrOZ4fMDl5i/kkcoGmVn9m4fHJ1QZDg50lUydbD8Ysl4TLT+fRdX/6w6+
	067OTwphP96MmUPZ0PvHJpaKxBGdQGVptlXcKvnxTrOr97+CFolJkeCg5Z3rfe33
	liK3fGQJZ2tX/FlcqnSsg==
X-ME-Sender: <xms:eldOZ_IgEx0LuOxWtd4G_YDv37HOaYqZ0QpEhGFP2NFvXBHvVv2QJg>
    <xme:eldOZzKPzBMfi2RRoEYeLfF5vWNf5SMN1VZXkUZYlfwKQu2d4UHMzD7uvEUe5pxHz
    NdzLa3qrPAfJyMP4w>
X-ME-Received: <xmr:eldOZ3s8OIzTrFJWUH4YEnUhDJLTP1w507UeRh3NN5KPPmSRxKXN54_e7BL1Ewcua8k_tYQavbWGTw90yE3W1Bt07d-1lWq77Cy3io0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddriedtgddvjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeen
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuveelgfekfeeh
    iefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghhrhhishdrthhorh
    gvkhesghhmrghilhdrtghomhdprhgtphhtthhopehthhgvsghoohhkohhfuhhnkhhnohif
    rggslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:eldOZ4auj-q0-_6NNENRDwKtK8KGylCDCEv2JJKxkQYY0mDNL64k-Q>
    <xmx:eldOZ2Z3xUkuu6CK-nTLRD3vKEQJUSShkmKMmKzqoKl7sL6dCXjKZQ>
    <xmx:eldOZ8AWSNnFIN6IsOpHqmExeNhdOvBnXS_5YkOZCii53fm6NyWpAA>
    <xmx:eldOZ0bBvzNGAteDDqj94PORP20wvj83J3SB3nM4Y7iZ7dqBdhHAzg>
    <xmx:eldOZ9Xy0YIM_zqsLT8Mmo4GMUZ6L_I2EqSYqKXwdo0cax1iqZL_FbpG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Dec 2024 19:57:30 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Chris Torek <chris.torek@gmail.com>
Cc: tao lv <thebookofunknowable@gmail.com>,  git@vger.kernel.org
Subject: Re: How to revert to a specific commit?
In-Reply-To: <CAPx1Gve_dCRux9_cF7NTspomS4K=Hp_y74d94S-Hm0amuovUqQ@mail.gmail.com>
	(Chris Torek's message of "Mon, 2 Dec 2024 04:39:13 -0800")
References: <CAFePT4zytyuLB0TgyJ+mbrNvz=Xt1x+gJv4e-2j07YK7Cg1bzw@mail.gmail.com>
	<CAPx1Gve_dCRux9_cF7NTspomS4K=Hp_y74d94S-Hm0amuovUqQ@mail.gmail.com>
Date: Tue, 03 Dec 2024 09:57:29 +0900
Message-ID: <xmqqser5h9c6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Chris Torek <chris.torek@gmail.com> writes:

> On Mon, Dec 2, 2024 at 4:15 AM tao lv <thebookofunknowable@gmail.com> wrote:
>> I want to revert the code to a specific commit. ...
>
> OK, first some background:
>
>  * A commit _is_ a full snapshot of every file, as of the state
>    it had at the time you (or whoever) made that particular
>    commit. Hence, if you want the particular files from a
>    particular commit, you simply check out that (historical)
>    commit.
>
> Now:
>
>> I don't want to revert each individual commit; I just want to restore
>> the code to this specific commit while retaining all the current
>> history commits.
>>
>> How can I achieve this? Is there a better way than using the revert function?
>
>     git checkout [--detach] <hash>   # or git switch --detach <hash>
>     git reset --soft <branch-name>
>
>     git restore --no-overlay -S -W <hash>

While that would _work_ in the sense that you can revert the effect
of what the discarded commits did, I would not recommend any of the
above since it does not leave any record of what you discarded.

Imagine that I regret doing everything since we tagged, say, v2.47.0
release and want to discard everythig on 'master' newer than that
commit.  If I want to "keep" the history of failed commits that I
regret having made since v2.47.0, here is a way to do it:

 $ git checkout master
 $ git reset --hard v2.47.0
 $ git merge -s ours --no-ff -m 'Discard everything since v2.47.0' master@{1}

The first two steps just discard the unwanted commits.  The third
step is a trick to

 - Keep the tree contents of the current commit (i.e. -s ours) as
   the result,

 - Make sure the result is recorded as a merge commit (i.e.
   --no-ff), not "fast-forward" to the tip of the history I am
   discarding, and

 - Record the discarded history (i.e. master@{1}) as the side branch
   of the resulting history.

The last part would help if I later need to merge changes that were
based on 'master' I am discarding.  The presense of the side branch
makes sure that only the effects from the new work done on the
discarded history, and not from the commits such a new work was
based on (which are the commits I regret having made and I am
discarding), are taken into account when computing further merges.
