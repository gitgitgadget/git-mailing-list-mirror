Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115B2390CBE
	for <git@vger.kernel.org>; Mon,  6 Apr 2026 17:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775496145; cv=none; b=BotYBa10JykqJXIAPXVCpjjkEgtXTfApPys6WrIYxKJVI+YvA7vyN7i35jSyEmtWKJLH+aVoq8N9Z0cE3jWopWbT5INE4q6p/8GYnOlf+TlrdiITkpANdpHP8gmbg4yabgaOT6L4fNfZFJQnsqaIHxX47U2SbpKKmgnP2xDdObQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775496145; c=relaxed/simple;
	bh=K8bHWS9T2gLN4jAZJJFL58bzx+o1I+WmOLP6AZSDukY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HjUh2WQ5hroHC3nHY9N4E01H92t07CxERKCg56uMI8MaXcktV58PLp9hEhqI/ZGTZQhHXHq8B5egKEWwiuMo/mc9gSePhTkS1hi7Bgj9wyVaAK+JE8uXnMTq9E5LUW3dc90bOO4sun4m+tV1gUlqV5Rd5Uem91DRn9Z8tXDqTVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=r6Ez0TAm; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=STPzaypE; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="r6Ez0TAm";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="STPzaypE"
DKIM-Signature: a=rsa-sha256; b=r6Ez0TAmWeA6avsAgfyOsotlmm5Pj7yUAJq1ZbpPfcqWjvMHwljWVa3lrmkdvksEJ2fUGN3VfCTzqBwtndtZSpFVO6o3HhvjD6wrm9MKvWl1tsVo5fee5wK6HW8dCN7zXwEgVHAzjj3BdeIW+zw5GJWZ2pVM0t7QWOpA09sGSKPlDLQI7pTmMRCwqlod/HI4LftzyXUSF5IAGkSc2dDN3WuYzdsUnZx+yBfIPmB+UquV4IWfJAj1d4X3O22YLmKCosefXgkDHnXosfKXOUj25YijdGUXhSG25NfpMIwDosaf9Jc7nBR7PF7KthCFedvoyASBLjW62O/pHcvojS1r9w==; s=purelymail2; d=malon.dev; v=1; bh=K8bHWS9T2gLN4jAZJJFL58bzx+o1I+WmOLP6AZSDukY=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=STPzaypEUQFER4Gq+8rOd1pVMdGcW88v2x9UE++zpv4JzqBTQcc8maIT2CaKI6fsfMXCuqQd/mXMxOdpZCnz7p4G0IlGTZriVHl+OCLqVEJLJMuDstFeL/dw/h8gvWodWCpNSaeIY+o6vDXrI3Zk6FZr3UJ9/KjybuYX30pA5eTfY25K5qZQj/M3tfTIgN5YuacmHEwQ1pPPWnImLS7S57tUsWh9c+S3ugQRaIJGo1SfNHc4+0Bu9clGwLuMJH9NGDnAiBl7WW2q2dd/UT5QE3MIk6j4OyJAMhhQQZBnXpe2Qi2/Pbxuo/CpcYVXLjd/JaiXXL/O7J5PW6/fquJXug==; s=purelymail2; d=purelymail.com; v=1; bh=K8bHWS9T2gLN4jAZJJFL58bzx+o1I+WmOLP6AZSDukY=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -2075129831;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 06 Apr 2026 17:22:21 +0000 (UTC)
Message-ID: <f2540dc1-fe76-48ec-91a7-82e32ced75fc@malon.dev>
Date: Tue, 7 Apr 2026 01:22:16 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GSoC PATCH v3 2/5] pack-write: add helper to fill promisor file
 after repack
To: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>, git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Patrick Steinhardt <ps@pks.im>,
 Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
 Elijah Newren <newren@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>
References: <cover.1774205661.git.lorenzo.pegorari2002@gmail.com>
 <cover.1775431990.git.lorenzo.pegorari2002@gmail.com>
 <3cd15429194c763727fbfd5981ba38c1dc2cc907.1775431990.git.lorenzo.pegorari2002@gmail.com>
Content-Language: en-US
From: Tian Yuchen <cat@malon.dev>
In-Reply-To: <3cd15429194c763727fbfd5981ba38c1dc2cc907.1775431990.git.lorenzo.pegorari2002@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail

Hi,

On 4/6/26 08:24, LorenzoPegorari wrote:

> +=09=09while (strbuf_getline(&line, source) !=3D EOF) {
> +=09=09=09struct strbuf **parts;
> +=09=09=09struct object_id oid;
> +
> +=09=09=09/* Split line into <oid>, <ref> and <time> (if <time> exists) *=
/
> +=09=09=09parts =3D strbuf_split_max(&line, ' ', 3);
> +
> +=09=09=09/* Ignore the lines where <oid> doesn't appear in the dest_pack=
 */
> +=09=09=09strbuf_rtrim(parts[0]);
> +=09=09=09get_oid_hex_algop(parts[0]->buf, &oid, repo->hash_algo);
> +=09=09=09if (!find_pack_entry_one(&oid, dest_pack))
> +=09=09=09=09continue;

Memory leak here;

> +
> +=09=09=09/* If <time> doesn't exist, retrieve it and add it to line */
> +=09=09=09if (!parts[2]) {
> +=09=09=09=09struct tm tm;
> +=09=09=09=09localtime_r(&source_stat.st_mtim.tv_sec, &tm),

Typo.

> +=09=09=09=09strbuf_addch(&line, ' ');
> +=09=09=09=09strbuf_addftime(&line, "%Y/%m/%d-%H:%M:%S", &tm, 0, 0);
> +=09=09=09}
> +
> +=09=09=09/*
> +=09=09=09 * Add the finalized line to dest_to_write and dest_content if =
it
> +=09=09=09 * wasn't already present inside dest_content
> +=09=09=09 */
> +=09=09=09if (strset_add(&dest_content, line.buf)) {
> +=09=09=09=09strbuf_addbuf(&dest_to_write, &line);
> +=09=09=09=09strbuf_addch(&dest_to_write, '\n');
> +=09=09=09}

It looks good elsewhere, at least in this patch 2/5. (=E3=82=9D=E2=88=80=EF=
=BD=A5)

Regards, Yuchen


