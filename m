Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCC02DB7B2
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 12:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772110679; cv=pass; b=f1cgPVdbr2ztYD/NE6uIl4auUSpKMp8f8ijby3qjpDgYv4vHIl3XTbDFDPVX6MYHGwpzfo0Tg1X4garbmjkut6l95Zv/jdFWj0v4EtRWhUUiiyqv72apRyyVq/qg6TFWTuGpm3W8381rXUfcvvsYPEHCcyYDUajAO2fhtM8FEhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772110679; c=relaxed/simple;
	bh=ibsX//lCefMPoqLlia806J0JXA6+VKu18l7jMW7sS5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZQSHKMIUjvefeXvNtalaNnbFlPJP1VkeyjGOsE1ZJUUObBuOd5lsIFISZ6nmU7OQJEMouZIN63BsRAQsPpBGfDgX5ign29ef9ajdTB1WTORq7s7BkCh4aTuEiZ5Ad0QSJ+4DFb5tKNkMQTfh0yUsASQVHC0vTYiXOfBKeXfjN2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hzNxSbsf; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hzNxSbsf"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-127380532eeso1340713c88.1
        for <git@vger.kernel.org>; Thu, 26 Feb 2026 04:57:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772110677; cv=none;
        d=google.com; s=arc-20240605;
        b=B7G1iky9pJioXFzzMdE7dMXqwK7gkiHY37vn3/i1PTYsGdZO9Mxz2HNYr3SohaQ9pa
         7EuW5CDtu5KPGfsTiKhOW05XuDihxevUBJ7L7znIKaSTgvbZMw3COjRpu4faw3UenUB9
         /WBX/yeTQ4GOez267dDq1nD56xnQzyc2CqOkMZz9ZHF3b1iIMr91M73JDXXNWKqv2+vm
         gpPkzdSiFkRYPSSsEX2IKWIXO62Gj0oWsDJAT5cQYmAZjYStnd55DuOB73a/fLaJkVNp
         a4Mbchs5vpqbAemppCIR0cBApcmQScHaNludE3YwQPCnZhYvf6Sf5aLt54LYKU33ArBi
         mbJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FfRvcsa/6FtSZgk+ffPCwt3t3PsLGlpSdnNP9MdA4GQ=;
        fh=d1OiLHDdPg0fo3w5ZN4iTzpH9FgWNOi2p7e6HPfuyEk=;
        b=PjmJCQ3e9ZPqqalD+P4rNaNgZTYHguKN6ogguByYI7VRnFTJOh55GVNiRJQVgYwoL7
         KM1CUW2lztLTwUhR1aSXCkpRcVnP4AD2LwnlVYoF0VNdGKJJC0tfB4lhUnPnvS9vbkIu
         HE8B2F6TSaXVPOF0+DOqJAdgFY2Vte8BIZwAn9Hx31xTl7zawWprBxG0IZQgzQdwBanV
         hFiQA9kZbaKXVJ62OmZsjqaxKG6yTFtzvzkKw73DmdWapzMcuJOnlGDBKOa88mM+mAeT
         88q6rCkMIW/X3TN+XeH9smpQM8RWtTjCVbYP57TXqn6IqwB6KxAGVoMe8uPURWgR1T6Y
         DVYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772110677; x=1772715477; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FfRvcsa/6FtSZgk+ffPCwt3t3PsLGlpSdnNP9MdA4GQ=;
        b=hzNxSbsfvnhfUAnFg3eYFZSQ9ejjM8bWHWaEFqfBxMKSPlEF7jw9yMDfcZaP6/6Lt8
         vbARDYqz84WrMXWEAK0z1V+OIYweyzmuLHjEUylV6usqXPXDFnqPbWGyQfNt+ZnRsmKy
         /V795a8+2JECydB38xPdfo6ZZ4+/39IrLB14RC+NDAJkgPKxZBZQcqNnRvHUF77bzqSm
         BF/BeEDTbN49ZgDNawmVNSdKLGeZoItnKn6dYVdOS7kKv8N/uV2OAJpuADF+lWUcJQRj
         sTTMXlXf5ooJ9R61sB0B00HiDt0ZfC3pFfko74jDVbvlVFtoLqp+OIJcawi9NilMYcHR
         JTog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772110677; x=1772715477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FfRvcsa/6FtSZgk+ffPCwt3t3PsLGlpSdnNP9MdA4GQ=;
        b=BMwd1rteXDT95oIzhnGpQOlhsRgnCnXIUHWjO3yzjMbGHfzpeU7tqHNn96p2K6Wfju
         8vo1vaD2GL3s2ftzXznvlTtH0MsL2RkN3pW8hPfdAdf+Ktlq6Yw7tN+1oid0h4JnkeMw
         qEuHeMwNN7H3eILfYhgyACtCwTbMQUS+4H9jy4ofY2FiA80HMBcpWNplO7C4VNjo0tQ5
         KBDhY6rnqe8jV5k0dmHjWDtZy1tpiNQw6DOZukJQFtbzcOS9b5iel+9HAwfOqsSW/BrP
         TMcL25m8bagOQW7PmBWB+5cf4laEEDyb20IaFnq5VXmjKX9Yr/R3DJTi9SMJzWD2+K8R
         jrag==
X-Gm-Message-State: AOJu0YyJDlV+ZQZejosIrT4CWFpC5RpiiWbx5QYheXNwQNMx7WhPtXWd
	s4MEjPtRV6j+HFS4nXIFZ6idhrCAupiyC+vaRiulrhx8cCv/ryT+2sE0Q2E6DRYzJecRDFB2h/3
	Fgq9gsh1RIxl8CkjGEhkFcqd/77A+JBs=
X-Gm-Gg: ATEYQzxGm789v8gQ4j7n/SjkI+QtfHgYnVHea7Ur+ITNOxPBefg7TQ9ociZut49r5zF
	QCFwHlqjh7H0CduzHtQD/3rSlw6bTG0gizXkh3DAvE2VrAK7KqwmmSVBySyS3M5s2Gtp+iVoJ0W
	hFJEx6qTtMSaqhC4cDwRSFinQIASD/MqIfN9D6kTU1Perr3AKSijuNuxTxR7qOsXKK7gPt04YK+
	ky5J/hF4NYPHkmS77KcDx28Nn6nnAbZ6O/BdzwtjizMdlPQq3zHKqyQteBwh0HSHMgRNqFLDa5s
	0REIO6ewEtQwmqChZdaHu8TuGDvX7dYvMnk5bqYMlp05KVEb1KCnA2RKtMieT8o/GxNWckY3v6x
	G8o2s0WdrZ74ctTBiXrZGa4aV
X-Received: by 2002:a05:7022:e25:b0:119:e56b:c75b with SMTP id
 a92af1059eb24-12789cc4cc0mr821369c88.32.1772110677366; Thu, 26 Feb 2026
 04:57:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1771258573.git.belkid98@gmail.com> <7d33f1ef0f8182893d63d49b350984025ab757d4.1771258573.git.belkid98@gmail.com>
In-Reply-To: <7d33f1ef0f8182893d63d49b350984025ab757d4.1771258573.git.belkid98@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 26 Feb 2026 13:57:45 +0100
X-Gm-Features: AaiRm53IgdSvHGFiwbZBCsStDsYDrflNSTl6ZpRI2M74Am0QmG1GJLzJ0Cejcik
Message-ID: <CAP8UFD1c5JgpQwMuTPE-VWS=7-1Lw7mWVaGGXCPwaG5=VYhk2A@mail.gmail.com>
Subject: Re: [Outreachy PATCH v7 2/3] environment: stop using
 core.sparseCheckout globally
To: Olamide Caleb Bello <belkid98@gmail.com>
Cc: git@vger.kernel.org, toon@iotcl.com, phillip.wood123@gmail.com, 
	gitster@pobox.com, usmanakinyemi202@gmail.com, kaartic.sivaraam@gmail.com, 
	me@ttaylorr.com, karthik.188@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 16, 2026 at 5:39=E2=80=AFPM Olamide Caleb Bello <belkid98@gmail=
.com> wrote:

> @@ -670,7 +672,8 @@ static void clear_skip_worktree_from_present_files_fu=
ll(struct index_state *ista
>
>  void clear_skip_worktree_from_present_files(struct index_state *istate)
>  {
> -       if (!core_apply_sparse_checkout ||
> +       struct repo_config_values *cfg =3D repo_config_values(the_reposit=
ory);

Nit: it would be better with a blank line here.

> +       if (!cfg->apply_sparse_checkout ||
>             sparse_expect_files_outside_of_patterns)
>                 return;
