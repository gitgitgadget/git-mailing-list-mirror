Received: from aib29agh126.zrh1.oracleemaildelivery.com (aib29agh126.zrh1.oracleemaildelivery.com [192.29.178.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE071C9B89
	for <git@vger.kernel.org>; Tue, 22 Oct 2024 18:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.126
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729622048; cv=none; b=YSJIYzvHc/V69CD7VuC/1hUsOx+OGW4XFVYnSweDJPWHGRVXIUaoPPpvel/PeQJkZV9Y47THFIfnr4b0KAXTYtAf6GzZ4h8GrFAaH/NrAzTUE/AT06RQgxl9Xe6ddQtgBrqXAO2vhZtMqiHISEVVwuaRxBcCX8Hh8lOwEyKSr3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729622048; c=relaxed/simple;
	bh=kfgpNGighHTdiISY9P7or823+m0yQ8mt0nD/CVGShRA=;
	h=MIME-version:Content-type:Date:Message-id:Subject:Cc:To:From:
	 References:In-reply-to; b=Q3WEcn4C3Qg1MGLIvsmRXM5wGEeFsbKlU4sai5hBo4zZXoYLAr/8RaCmm8VM10zCGPO9TrqjqS7XB+5zkwsn6EANCILMf7F/JOZ/NOukLWjiNDnCuJ20R/q01GVbi9/VdDodizusX4ZympHxr/lV0EEBVwxbCEYd8Z4QXecaxno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=Mj8sN/Yc; arc=none smtp.client-ip=192.29.178.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="Mj8sN/Yc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=7feC4o0I5+HDauzNc/9uG0HOlOdTge1Mc3cHpIOfIOM=;
 b=Mj8sN/Ycgo64FdnN39MCsbPn2xMPF54qzqMMu3euGbjm4OEVAyZ6kec81dpMPtxuO9/8HvaTHKpH
   aWBbbNJyQugaVR0IFyIXaB/Q66DoXUqOvh77SBNFLeM5g/YaQ3xo5NrQ/7EnadmMDtaY+P/zDHAw
   7rOgz2HrNwGODBcuwwcHjlaTuuFYBZ79olFpbdSNK3PCmIvaPLzR8t0XDQ0i6BodkewBGv0VEDcy
   1LFko0UONe8v4tKbVTMRwVTdmm947MzVFJ0fGUML1hWwygRQSyVkD38BB4rsAFM0jquOZp99vzxB
   2mnWjJilUE5ENJLcQQ146YZePy1Yqdifa/Zsrg==
Received: by omta-ad1-fd3-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SLR00IQ8SWQ2320@omta-ad1-fd3-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Tue, 22 Oct 2024 18:34:02 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Tue, 22 Oct 2024 20:33:28 +0200
Message-id: <D52JTXM32QOS.16IVFGPEJ4AKN@ferdinandy.com>
Subject: Re: [PATCH v10 0/8] set-head/fetch remote/HEAD updates
Cc: <git@vger.kernel.org>, =?utf-8?b?RsWRdsOhcm9zaSBWw616bcWxdmVrIFpydC4=?=
 <noreply@vizmuvek.hu>
To: "Taylor Blau" <me@ttaylorr.com>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
References: <1088915169.629942.1729445083543@FVRT-HAMMYAS-P.vizmuvek.hu>
 <20241021134354.705636-1-bence@ferdinandy.com> <ZxfjWnZF4EbtVH12@nand.local>
In-reply-to: <ZxfjWnZF4EbtVH12@nand.local>
Reporting-Meta:
 AAH0GBIvbBjQQgLDpakqBOePt5o+1Ijq7Dw6SnM9XeA9VFpIDlxfCPOEd/DGQZyE
 LASWzUEWmGJ9K6ipILGZE2cQIwZbQxkmS5OL0efYU5JWM6SNFw43k0858cbtnBOj
 5a1HdoXFfzSxcRmvGui7GTLdmecHbuCfjy2N9Ddk4ggxjCNXKf1ohHjm6JusH8cF
 5911MYNzROkusrBI6H61tl1NtlymomJ7HbhaO5gjwVEJ+tvi2fDUHVVi6nXvrXmn
 IcTGCxYrmlpqO2z4zaIQpZVv14NxQuswkiu7eIaHDF2cHCB9+HZaQ3x8oIa4W4e9
 UiHMSyku4XCrQt6jT0TfwrXEe6ey2HbQNDTf2n7YwmDnrPhTifu4sMIZhtLdh/2W
 kDsn5BebpSwLPJwUMespD2jURMQltS9eAHLzDxHdrHELhwhzJAl3lVoxj7vhyxko
 E6Jys7gbVuPeG5bkIQ63EH0NSprZD7WR0LmVdntk5h33xVrOIrQfKZc=


On Tue Oct 22, 2024 at 19:39, Taylor Blau <me@ttaylorr.com> wrote:
> On Mon, Oct 21, 2024 at 03:36:57PM +0200, Bence Ferdinandy wrote:
>> Bence Ferdinandy (8):
>>   t/t5505-remote: set default branch to main
>>   refs: atomically record overwritten ref in update_symref
>>   remote set-head: refactor for readability
>>   remote set-head: better output for --auto
>>   refs: add TRANSACTION_CREATE_EXISTS error
>>   refs: add create_only option to refs_update_symref_extended
>>   fetch: set remote/HEAD if it does not exist
>>   fetch set_head: handle mirrored bare repositories
>
> After applying this topic to 'seen', I noticed some new CI breakage that
> appears to be caused by this topic:
>
>     https://github.com/git/git/actions/runs/11449483611/job/31855171514#s=
tep:4:2506
>
> After dropping the topic locally and building with 'make SANITIZE=3Dleak'
> and then running t0410-partial-clone.sh, I was able to resolve the
> failures.
>
> Would you mind building with 'SANITIZE=3Dleak' and running that script to
> see if you can address the issue? Thanks.

Thanks, I can reproduce the issue. I'm hoping there are no more tricks to
testing things :D

Let's see how fast I can handle this ...

Best,
Bence

--=20
bence.ferdinandy.com

