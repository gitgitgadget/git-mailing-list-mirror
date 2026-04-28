Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A64466B5F
	for <git@vger.kernel.org>; Tue, 28 Apr 2026 18:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777399541; cv=none; b=dwZ62i7NQtJ50FpY/uQNhANvKANdG7V3FGEjRPIinyRzwctR3rMBX940RzZPU2EhHo9Td9rUkAuuymbK4MzPLAB3EdRkWzCUr0YNpFZlE71qvZjAg8HpTO1m9xGxLbghyZSw5ol/DG51VVn2xT5YMfe3K8CrxrtRtTSV6Kj2TYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777399541; c=relaxed/simple;
	bh=nzp1/xOcfHhGKd+7SYtZUwTMqVXT2balDCHnXl3Urh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=brq9zX7XcJZhoGc+QEi0DiIM0Zs7AQb8lrIX3BAFiJUGyjb/p6T4xoB3UA5RGRn/u4ExgP9lTxjK5cm9AXVEvUVedWuZn/cXXB92cv4cxjcWFUfuTFAyuV9KhfpmQ/C2077SPv8hxubVDZ92nCaJzgwi2wdmZKqkdBobjc0dZnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=qAlHfSkp; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=pOmSuvHi; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="qAlHfSkp";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="pOmSuvHi"
DKIM-Signature: a=rsa-sha256; b=qAlHfSkp6/gXSE1+DRn1eB5HMPN/Wdgd60n6CwbVg4J0YojwWcm42HuZR2lXv+213YKoiaDDVtruxJ4Z2KqtIxCFgZKthZaZmS4CF/10/HzIaULX/5zvGtl/ytZ2tuPUKzprFc9lKIKGybmHUgxowTO0dOqI4/9ZKyxGTvEGFP4mdHkzcr+0tcEfu05cfNv0lCUADyoWrG0zEteWx1WBm7p8pTltTU9Fjc/YpZUJoAiHCEDEnM6A4WS+oYG5d+kJc2+nfsw/Q+7cr5dGra3TC/vRmUFPS3k5BZmyeDwMiqRIce47ZTiKLmijx0d37bu8wFNpi1991teZwaplorgunw==; s=purelymail2; d=malon.dev; v=1; bh=nzp1/xOcfHhGKd+7SYtZUwTMqVXT2balDCHnXl3Urh4=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=pOmSuvHieFJHrNNU8FcJ/6DDKHUxsBlxJImK7c1rAA1aO41k7dMoC48UyCtzkznjEYBWIcYIRfeY718JLLbpxm7Vy56Y6fLfBdTBziLTx1ctcqUJ1HfjGufEKaZMOakarmRBJqqhpGfTveg9srQRQwrH6zkkcKQCY0YVk+HApZckWMQktQkJd2lpI57JcHYziiSITGLP8vL+6SCP1DxlsfsHA5qg6/POxA6a7uSbC5D8kD3Ese5DWO1msG2pc+2l40V0Io40kp3ci6+fgliuEGYefg6yr7SgoDhiEqgIhF3LDC8gFn8Eu+ftbOYTJzPobkGILMfCleUFxfxFMTxZRw==; s=purelymail2; d=purelymail.com; v=1; bh=nzp1/xOcfHhGKd+7SYtZUwTMqVXT2balDCHnXl3Urh4=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1620491536;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Tue, 28 Apr 2026 18:05:19 +0000 (UTC)
Message-ID: <5a821f71-3d6e-4942-9bdb-257617484a6b@malon.dev>
Date: Wed, 29 Apr 2026 02:05:16 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Reintegrate: send "Huh?" warnings to stderr, not stdout
To: git@vger.kernel.org, gitster@pobox.com
References: <ae896PlyiYeqldFN@mbp>
Content-Language: en-US
From: Tian Yuchen <cat@malon.dev>
In-Reply-To: <ae896PlyiYeqldFN@mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail

On 4/27/26 18:47, Erik Cervin-Edin wrote:
> The "Huh?: $msg" warning in show_merge(), emitted when a first-parent
> merge subject does not match either "Merge branch '...'" or "Merge
> remote branch '...'", uses
>=20
> =09echo 2>&1 "Huh?: $msg"

Yes, this is clearly wrong.

> The "2>&1" redirect dupes stderr onto stdout's destination; it does
> not change where stdout itself points.  Since echo writes to stdout,
> the "Huh?:" message lands on stdout regardless -- as would any
> command's normal output. =20

> The intent appears to have been ">&2", which dupes stdout onto stderr.

It would be better for me if this sentence (i.e., what was the code=20
originally *intended* to do before the patch?) were placed right at the=20
beginning. Something similar to:

=09In show_merge(), the warning "Huh?: $msg" is emitted to stdout because=
=20
it uses the erroneous redirect `echo 2>&1`. The intent was clearly to=20
use `>&2` to print to stderr...

Of course, it=E2=80=99s up to you ;)

>=20
> In the common Reintegrate invocation that captures stdout, e.g.
>=20
> =09Meta/Reintegrate next..seen >Meta/redo-seen.sh
>=20
> this means the warning is silently embedded in the generated heredoc
> body instead of being printed to the maintainer's terminal.  The
> resulting redo-* script is corrupted with a "Huh?:..." line and the
> maintainer has no diagnostic that something went wrong.
>=20
> Every other diagnostic in this script already uses ">&2"; this line
> is the lone outlier.
>=20
> Use ">&2" so the warning reaches stderr as intended.

Overall, the reasoning is nice :-)

> Signed-off-by: Erik Cervin-Edin <erik@cervined.in>
> ---
>   Reintegrate | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Reintegrate b/Reintegrate
> index a1e67a0330..6fdc7c5f41 100755
> --- a/Reintegrate
> +++ b/Reintegrate
> @@ -327,7 +327,7 @@ show_merge () {
>   =09=09merge_hier=3D
>   =09=09;;
>   =09*)
> -=09=09echo 2>&1 "Huh?: $msg"
> +=09=09echo >&2 "Huh?: $msg"
>   =09=09return
>   =09=09;;
>   =09esac &&

Thanks, Yuchen

