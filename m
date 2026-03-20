Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203692D3739
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 16:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774023991; cv=none; b=ROUl83zh0Wc2UjVtDdVt6S3HTACvBu9KedeWdhu+BLg9YxotI9MVmXTNvqIecnH/xEs9+a7pOVPqQ1qZA7Jjo743RH8JhxVQApSAKc+6JuVUYf1Gf30zN0xc7XeaQ35y4mv3hbWZ+l5soWEb6Kulgzeu6POK2JQU0yZjkfTsEIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774023991; c=relaxed/simple;
	bh=myNa+LQp/B4PdKmtgr9szA++H3YjLdiCnpg3QnruaRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aLmGetk4iUICGBvmiNnh2ccN0+xHGmTn0XHrpSiyvOLHXw0TVF9XZuvBq6cF00dyaRPaSQZM4vilYmTQH35cG7uk50B+R9WsXClsXZ1lxNi08ikFv2mcyIDzByEAMB960RCTHOOed3YnfpZZWKPzSf5hhU8fH8OAvj1RDTjXZNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=Aw/oOgb0; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=Y4s5Sacg; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="Aw/oOgb0";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="Y4s5Sacg"
DKIM-Signature: a=rsa-sha256; b=Aw/oOgb067dvGuJT5oJm86U8aKLVr+jXYJvWdoDPLA0cfZ9m5aXvfnE4ynTdt9jXAgxtEm9rAvSSTH7+RALOlMWK6Tk4jbtJcfHnYeviqa6y8Ud97oCfQdjPWguhWS07XiKRLuKSZW0yxGzR9HoGl8Cv8ISo3ZWwVkj6VJ2ksq+Oa66nEE2ICWgtL9bZ1ktrg4p/ewRlYA1IX0utW+yZpn62rJzinG0JkayiOXQRptjvzLnUj2UppnymzZEK0mmth2gICZgPLzuxelmI9uCjhhMHJFFX9JT/xaGwtuMJXeQsOiGr88XtHXYJ1sBO04ggwVL2Zq0mm9dJ5MyMlSnKog==; s=purelymail3; d=malon.dev; v=1; bh=myNa+LQp/B4PdKmtgr9szA++H3YjLdiCnpg3QnruaRQ=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=Y4s5SacgOThhZX4Ku028I3gzZQsRmvDZbNvfZ9/b05HgwZ2Zr08gEcvPG/i0uy+3GGD3HLXaxJLVQSnThVN78aNSK+dYJDrPlCjf7dpMc+PGVcA5LYncWx0r1JHpWLsvAk6BbbwimJ3GoEVcFKVbWqfKHK04XNxfDDhkdEfk6yulChlx/g9YHR0jQCyChMhIQAveFKHDgHdzQ0Ncq/K85erUCgzuOd8OYcU4FfmLQWP4gFOTuCXh4UTcmgyrsk0aeW52jQFg643MCurVP5acdCFmzqERVuotFdozXit3I7/tX+4XrFDAqEpyIyUuU87yQPLjh1dv/o36D+yTvQ1b2w==; s=purelymail3; d=purelymail.com; v=1; bh=myNa+LQp/B4PdKmtgr9szA++H3YjLdiCnpg3QnruaRQ=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1630621250;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 20 Mar 2026 16:26:24 +0000 (UTC)
Message-ID: <4d2001cc-ab9e-4595-88a4-fc650518ab3c@malon.dev>
Date: Sat, 21 Mar 2026 00:26:21 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Question] check_repository_format_gently() is not
 side-effect-free
Content-Language: en-US
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>
References: <c0bb931a-3ee6-416b-8ceb-9fab013a621e@malon.dev>
 <xmqqfr5vlmlu.fsf@gitster.g> <00d622d4-cfb8-41ff-b2df-5fb58a492a75@malon.dev>
 <abzkC9uLwZz_nmgv@pks.im>
From: Tian Yuchen <cat@malon.dev>
In-Reply-To: <abzkC9uLwZz_nmgv@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail

Hi Patrick,

On 3/20/26 14:07, Patrick Steinhardt wrote:

> Yes, I think that the whole of "setup.c" is something we will want to
> refactor eventually so that it does not modify global state anymore. So
> it's not only `check_repository_format_gently()`, but also lots of other
> functionality in that file. The motivation is not only being able to set
> up multiple repositories, but also making the code overall easier to
> understand.
>=20
> That being said, I'll give a small warning that it's probably
> non-trivial to refactor this subystem =F0=9F=99=82

Thanks for the reply!

It=E2=80=99s true =E2=80=94 setup.c seems utterly baffling to me. I thought=
 I understood=20
it before, but the more closely I look at it, the more I realize there=20
are details everywhere that require careful attention.

I won't drop a break-the-world patch out of nowhere. I'll keep learning=20
until I'm able to do so ;)

Thanks,

Yuchen
