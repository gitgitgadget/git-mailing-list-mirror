Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A1C1F7092
	for <git@vger.kernel.org>; Tue, 12 Nov 2024 09:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731402299; cv=none; b=Z5WTTWJGhggoatwPnvC/24f7cE9Cnug82XX3nlBYC1h5P5LFSQndEFg8yPFEnCR2cu1Qe+nQQ7F6g82q/ZdxCSJGHy/o9JluCmzOLujY2LTS7N2wH6GDAxVi6SjpNTyVuN4APLfENyEJSDFwL5BLdNx8p0Mi3RtSe8oWkSP+KdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731402299; c=relaxed/simple;
	bh=4UOBcvAlVqfbELyKNhuqkDXvMqYokuYfsk3BwET7yqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aSd1JMaBXlPoq+4mGXAf9+lmkUtTDXrLF59C/BAb3Uacx95uClWDHdmGGUGYX7PDKw7kfuD/tjwoYIZMJmxgfNY44bbgPVNi9j9KsflEq4BtHE6PIN5V4VO5QF7U+6aWbKuf63WkiBaYIkGUoS9KUoyCSaqJtaegxZu35kXv8ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=MYI8HIrq; arc=none smtp.client-ip=212.27.42.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="MYI8HIrq"
Received: from [192.168.3.191] (unknown [92.173.128.58])
	(Authenticated sender: jn.avila@free.fr)
	by smtp5-g21.free.fr (Postfix) with ESMTPSA id 8AF6560137;
	Tue, 12 Nov 2024 10:04:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1731402295;
	bh=4UOBcvAlVqfbELyKNhuqkDXvMqYokuYfsk3BwET7yqU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MYI8HIrqTwTddCojhs8Q/nE4eKs5rUfNLvO1OxukuDoUxi/WA+1DuTljhC2ipotxT
	 n0z8H4Z5WwnqzoNDhInShDArAoHGFPIEVAlSyidocFBxo2o9TvpcChSBWGgqqFlYCH
	 kNQqgu0RpGLh/MN7MDouDm7DCOMEz6qczH3dht4ZN/R9+jTb8DUXhRhvt7kEXlQP1q
	 vgaKze1ah0XeA8yPqaPm+P3rz9B/cTBCE4lFJYbCQsax3fzShjT0XbE+njJS7VLsEP
	 nnRvGKFXfqAhf9+4vsJwUn5SNDDtt0/k+VQC5bI+AYUx8XNNd/u36mG9l+RagWaCXo
	 DZ+++kfBa8O0g==
Message-ID: <b0a894fc-911d-49f5-a10c-19d441dc7133@free.fr>
Date: Tue, 12 Nov 2024 10:04:50 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] doc: git-diff: apply format changes to
 diff-options
To: Junio C Hamano <gitster@pobox.com>,
 =?UTF-8?Q?Jean-No=C3=ABl_Avila_via_GitGitGadget?= <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
 Patrick Steinhardt <ps@pks.im>
References: <pull.1769.git.1722801936.gitgitgadget@gmail.com>
 <pull.1769.v2.git.1731343985.gitgitgadget@gmail.com>
 <129763c2aaefd92bddaa59601c5a3275b9defa36.1731343985.git.gitgitgadget@gmail.com>
 <xmqqh68d8e9h.fsf@gitster.g>
From: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>
Content-Language: fr, en-US
In-Reply-To: <xmqqh68d8e9h.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 12/11/2024 à 01:52, Junio C Hamano a écrit :
> "Jean-Noël Avila via GitGitGadget" <gitgitgadget@gmail.com> writes:
>  
>> @@ -39,28 +39,28 @@ endif::git-format-patch[]
>>  ifdef::git-log[]
>>  -m::
> 
> Shouldn't this and all others like -c/--cc be also quoted as
> `literal` options?

As stated in the commit message, only the parts of the files which
appear in git-diff man page are converted (like was done for git-clone
and git-init)

Thinking again about it, I don't find it wise, because other man pages
will be half-converted anyway, at least for the common parts of the
included files, and we are going to introduce several commits for the
same file.

So, better convert all the file in on run.

> 
>> @@ -73,33 +73,33 @@ The following formats are supported:
>>  off, none::
> 
> Shouldn't this and other option values like on, first-parent, etc.,
> that are literals be marked-up specially?

This is to be converted, and will be with the conversion of the full file.

> 
>> --U<n>::
>> ---unified=<n>::
>> -	Generate diffs with <n> lines of context instead of
>> +`-U<n>`::
>> +`--unified=<n>`::
>> +	Generate diffs with _<n>_ lines of context instead of
> 
> Understandable.  Shouldn't <n> part be italicised?

No need: the processing of back tick quotes already treats each part
according to its semantics and applies the corresponding format.



