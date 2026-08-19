Received: from smtp-1a.his.com (dc-17.his.net [108.56.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D85544A409
	for <git@vger.kernel.org>; Wed, 19 Aug 2026 11:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=108.56.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787138293; cv=none; b=e/BVlg+WD18PuYxRkV+BRTysFDPWDbNQmXvSY5de6xB45a1fJx4OvfxPrPwJRoUTo2OZh7lprlYuI6aJQDqrs0gSDTtEWRLy27d0JoCn+IJP1rDpSDMJRZ4HElVAe0AAS9yKa2wPIVRSw84535o+Ke6qXpEdcr/zv+97pWhgSj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787138293; c=relaxed/simple;
	bh=E22VbsWEtENZntlDCiASkkYWAurKOg9utesEDcWWBNQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=QlkTTe6nhi9p/HQBTKn3eExH+EiYKFX434fTcVgMK4CNoh5/f+kNhQ1ogacXp64t+bZwSKhwOZ95buvfh2CMnPlo1KZqnlpZ7nMJWhHk+wNiQemXu9AW+RYvy6cEG5vvaDmutKNWtJWtTFSPb78Y3kNV3dW2woG6vPMGmzrzaS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=his.com; spf=pass smtp.mailfrom=his.com; arc=none smtp.client-ip=108.56.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=his.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=his.com
Received: from proxmail102.his.com (dc-15.his.net [108.56.65.15])
	by smtp-1a.his.com (Postfix) with ESMTPS id 1EA8B773;
	Wed, 19 Aug 2026 07:18:04 -0400 (EDT)
Received: from proxmail102.his.com (localhost.localdomain [127.0.0.1])
	by proxmail102.his.com (Proxmox) with ESMTP id F3DD5A84555;
	Wed, 19 Aug 2026 07:18:03 -0400 (EDT)
Received: from smtp-4a.his.com (dc-25.his.net [108.56.65.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by proxmail102.his.com (Proxmox) with ESMTPS id 01FB4A84566;
	Wed, 19 Aug 2026 07:18:00 -0400 (EDT)
Received: from mail2.his.com (ec2-3-149-70-92.us-east-2.compute.amazonaws.com [3.149.70.92])
	by smtp-4a.his.com (Postfix) with ESMTPS id B4D1F1CC4;
	Wed, 19 Aug 2026 07:17:57 -0400 (EDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail2.his.com (Postfix) with ESMTP id 982133C12B0;
	Wed, 19 Aug 2026 11:17:57 +0000 (UTC)
Received: from mail2.his.com ([127.0.0.1])
 by localhost (mail2.his.com [127.0.0.1]) (amavis, port 10032) with ESMTP
 id FNJWaq98ybm7; Wed, 19 Aug 2026 11:17:57 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail2.his.com (Postfix) with ESMTP id 5B98C3C12B3;
	Wed, 19 Aug 2026 11:17:57 +0000 (UTC)
X-Virus-Scanned: amavis at his.com
Received: from mail2.his.com ([127.0.0.1])
 by localhost (mail2.his.com [127.0.0.1]) (amavis, port 10026) with ESMTP
 id VzmldAvRQj8v; Wed, 19 Aug 2026 11:17:57 +0000 (UTC)
Received: from smtpclient.apple (unknown [69.53.104.42])
	by mail2.his.com (Postfix) with ESMTPSA id 17E603C12B0;
	Wed, 19 Aug 2026 11:17:57 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [RFC PATCH 1/1] config: surface editor failure in exit code
From: Kenneth Lorber <keni@his.com>
In-Reply-To: <CAOLa=ZQLgxhq2TVS1AYpRoAc_8AkWVtv_VhEm2HovgEX_cFvWg@mail.gmail.com>
Date: Wed, 19 Aug 2026 07:17:56 -0400
Cc: git@vger.kernel.org,
 Patrick Steinhardt <ps@pks.im>,
 Junio C Hamano <gitster@pobox.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <30A43EB3-6B97-4476-BF48-4820AAE39AFA@his.com>
References: <20260817211936.2943278-1-keni@his.com>
 <20260817211936.2943278-2-keni@his.com>
 <CAOLa=ZQLgxhq2TVS1AYpRoAc_8AkWVtv_VhEm2HovgEX_cFvWg@mail.gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: Apple Mail (2.3826.700.81.1.8)
X-SPAM-LEVEL: Spam detection results:  0
	AWL                     0.543 Adjusted score from AWL reputation of From: address
	BAYES_00                 -1.9 Bayes spam probability is 0 to 1%
	DMARC_PASS               -0.1 DMARC pass policy
	KAM_DMARC_STATUS         0.01 Test Rule for DKIM or SPF Failure with Strict Alignment
	SPF_HELO_NONE           0.001 SPF: HELO does not publish an SPF Record
	SPF_PASS               -0.001 SPF: sender matches SPF record


> On Aug 18, 2026, at 4:42=E2=80=AFAM, Karthik Nayak =
<karthik.188@gmail.com> wrote:
>=20
> Kenneth Lorber <keni@his.com> writes:
>=20
>> Teach git config --edit to show editor failure to the
>> parent process.
>>=20
>> Add 2 tests to t1300 to check editor exiting successfully
>> or failing.
>>=20
>> Signed-off-by: Kenneth Lorber <keni@his.com>
>> ---
>> builtin/config.c  |  5 +++--
>> t/t1300-config.sh | 18 ++++++++++++++++++
>> 2 files changed, 21 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/builtin/config.c b/builtin/config.c
>> index 0882899c3f..a166b2131e 100644
>> --- a/builtin/config.c
>> +++ b/builtin/config.c
>> @@ -1291,6 +1291,7 @@ static int cmd_config_remove_section(int argc, =
const char **argv, const char *pr
>> static int show_editor(struct config_location_options *opts)
>> {
>> 	char *config_file;
>> +	int ret;
>>=20
>> 	if (!opts->source.file && !startup_info->have_repository)
>> 		die(_("not in a git directory"));
>> @@ -1313,10 +1314,10 @@ static int show_editor(struct =
config_location_options *opts)
>> 		else if (errno !=3D EEXIST)
>> 			die_errno(_("cannot create configuration file =
%s"), config_file);
>> 	}
>> -	launch_editor(config_file, NULL, NULL);
>> +	ret =3D launch_editor(config_file, NULL, NULL);
>> 	free(config_file);
>>=20
>> -	return 0;
>> +	return ret;
>> }
>>=20
>> static int cmd_config_edit(int argc, const char **argv, const char =
*prefix,
>> diff --git a/t/t1300-config.sh b/t/t1300-config.sh
>> index e3f8064889..9a8f852a86 100755
>> --- a/t/t1300-config.sh
>> +++ b/t/t1300-config.sh
>> @@ -1823,6 +1823,24 @@ test_expect_success 'command line overrides =
environment config' '
>> 	test_cmp expect actual
>> '
>>=20
>> +test_expect_success 'git config --edit successful exit' '
>> +	test_when_finished "rm -rf repo" &&
>> +	git init repo &&
>> +	GIT_EDITOR=3Dtrue &&
>> +	export GIT_EDITOR &&
>> +	git -C repo config -e &&
>> +	unset GIT_EDITOR
>> +'
>=20
> Nit: couldn't this be simply `test_env GIT_EDITOR=3Dtrue git -C repo
> config -e` and avoid the set, export and unset?

Thank you, this is exactly the cleanup I was looking for.

>=20
>> +
>> +test_expect_success 'git config --edit failure exit' '
>> +	test_when_finished "rm -rf repo" &&
>> +	git init repo &&
>> +	GIT_EDITOR=3Dfalse &&
>> +	export GIT_EDITOR &&
>> +	test_must_fail git -C repo config -e &&
>> +	unset GIT_EDITOR
>> +'
>=20
> Same here..
>=20
>> +
>> test_expect_success 'git config --edit works' '
>> 	git config -f tmp test.value no &&
>> 	echo test.value=3Dyes >expect &&
>> --
>> 2.43.0
>=20
> The patch looks good to me otherwise :)

Thank you.


