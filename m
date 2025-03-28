Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B482420FAB1
	for <git@vger.kernel.org>; Fri, 28 Mar 2025 09:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743154744; cv=none; b=Fa7eALzbOY5ApQ0vdoOr9L5WdmoSK3/Q59WTk7q+L0jX8sgVOyUOsbrAqbdtWldC0UOe0hpTccQou/HQFdHCQPFW6HoX3Pu52l7Tuv1bauuRMSRfFd4itOsGUBVmp9vsMx+kTt9RLJQRUsFq7R/WrwRbiFT+SeI0skgKvk30m6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743154744; c=relaxed/simple;
	bh=kvjPjLXFca21LDH6mrojTNt45law2Ct6YlY9B4b2eCI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LtdCTt1nw9CkUsaY5Nxro2US7wtytYFoq1bf7c7So0KWf1cQ0AwLTlzNcMsU0qCuCC2YPFq6bCczC1oXgYSv5uVag9/1I50wEnM6EvDDupzALfy0YZnsP4+ZTr3Qg/k7hsasUUC0TFZ4Spz+LxgsAyjwMz2GcXnoS9FQnVngcOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=ZQg/iwiW; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="ZQg/iwiW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=88J8xksVUccJJCvocXHJUw/wVjwrFuo1yYQkJzyNhgs=; t=1743154740; x=1743759540; 
	b=ZQg/iwiWsEWJwI9QZbDMUfnhxq90dCBC//QXYnpHu1lHG1qYemKIZ0OYjRew5WBZE2z6lYd/4ZN
	mMplVoQ048G4Aie1nDyZy2Oz5up+eXhXFa9piuX2lecVsRIUuPGqouM97/Kkd5J5ikCNgomAQmWqs
	6g1DxV0b0dwM5O9k8UQDIqh3VeojnZYd0xG46ezFXodBzi7akNDco20o5KOaySo0C1DnpMgzUWeOm
	k3Mk/Lg4yxtM7hT+beX1FJzb6qKmD5u5DJazpmH2k5xS7W731uzi26brsWyYPEoJV/cb2BuaiPT9F
	uRWEwiSGQBAwAIZM8yrAHZcsXOMAPRMRs2/Q==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1ty6Au-00000002vOJ-2Re6; Fri, 28 Mar 2025 10:38:52 +0100
Received: from p5dc5515a.dip0.t-ipconnect.de ([93.197.81.90] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1ty6Au-00000002uX7-18sv; Fri, 28 Mar 2025 10:38:52 +0100
Message-ID: <4276c8d0b72f11f325482756d3bc251327d0ac47.camel@physik.fu-berlin.de>
Subject: Re: Testsuite failure on s390x and sparc64 after 6840fe9ee2
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Patrick Steinhardt <ps@pks.im>, Todd Zullinger <tmz@pobox.com>
Cc: git <git@vger.kernel.org>, Derrick Stolee <derrickstolee@github.com>
Date: Fri, 28 Mar 2025 10:38:51 +0100
In-Reply-To: <Z-Zr7BZL1UGqVxKu@pks.im>
References: 
	<89257ab82cd60d135cce02d51eacee7ec35c1c37.camel@physik.fu-berlin.de>
	 <Z-R_Zmr6kxCPLm-O@teonanacatl.net> <Z-Zr7BZL1UGqVxKu@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Patrick,

On Fri, 2025-03-28 at 10:29 +0100, Patrick Steinhardt wrote:
> > I reported this during the rc period.  I didn't hear back on
> > it, but hopefully your message will arrive at a more
> > convenient time. :)
> >=20
> > https://lore.kernel.org/git/Z8HW6petWuMRWSXf@teonanacatl.net/
>=20
> Copy-pasting the test logs from that mail:
>=20
>     expecting success of 5620.4 'do partial clone 2, backfill min batch s=
ize':
>             git clone --no-checkout --filter=3Dblob:none      \
>                     --single-branch --branch=3Dmain           \
>                     "file://$(pwd)/srv.bare" backfill2 &&
>             GIT_TRACE2_EVENT=3D"$(pwd)/batch-trace" git \
>                     -C backfill2 backfill --min-batch-size=3D20 &&
>             # Batches were used
>             test_trace2_data promisor fetch_count 20 <batch-trace >matche=
s &&
>             test_line_count =3D 2 matches &&
>             test_trace2_data promisor fetch_count 8 <batch-trace &&
>             # No more missing objects!
>             git -C backfill2 rev-list --quiet --objects --missing=3Dprint=
 HEAD >revs2 &&
>             test_line_count =3D 0 revs2
>     +++ pwd
>     ++ git clone --no-checkout --filter=3Dblob:none --single-branch --bra=
nch=3Dmain 'file:///tmp/git-t.sYdo/trash directory.t5620-backfill/srv.bare'=
 backfill2
>     Cloning into 'backfill2'...
>     +++ pwd
>     ++ GIT_TRACE2_EVENT=3D'/tmp/git-t.sYdo/trash directory.t5620-backfill=
/batch-trace'
>     ++ git -C backfill2 backfill --min-batch-size=3D20
>     ++ test_trace2_data promisor fetch_count 20
>     ++ grep -e '"category":"promisor","key":"fetch_count","value":"20"'
>     error: last command exited with $?=3D1
>     not ok 4 - do partial clone 2, backfill min batch size
>=20
> It would be nice to learn what the file contains instead of the expected
> string, which might give us a bit more of a hint what's wrong. You can
> for example apply the following patch:
>=20
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index 79377bc0fc2..197494cd28c 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -1975,7 +1975,7 @@ test_region () {
>  #	GIT_TRACE2_EVENT=3D"$(pwd)/trace.txt" git pack-objects ... &&
>  #	test_trace2_data pack-objects reused N <trace2.txt
>  test_trace2_data () {
> -	grep -e '"category":"'"$1"'","key":"'"$2"'","value":"'"$3"'"'
> +	test_grep -e '"category":"'"$1"'","key":"'"$2"'","value":"'"$3"'"'
>  }
> =20
>  # Given a GIT_TRACE2_EVENT log over stdin, writes to stdout a list of UR=
Ls
>=20
> If you then re-run the test with `-ix` we should end up printing the
> contents of that non-matching file.

Could you please post the complete command line? I have no clue where to pa=
ss "-ix".

I was previously running the tests with "make test".

Thanks,
Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
