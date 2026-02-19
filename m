Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400F126ED3A
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 15:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771513290; cv=pass; b=QamTmw7/lacWmmyq8pswLUV9Qfk1p0oRtAEhgop1EL5ZLvyApuk8AzGEwEqyrvO0+5zQp1dyQJBouLVIW0THbZfOIEhxji04g8EMciF3bbDEyH7LRPipiTPwC6cgEVhSe6QmeDWHqHghYJFn6XIY/RKxm4s9oVBRubJFnX84knI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771513290; c=relaxed/simple;
	bh=eA9tVJ1ZqhOLf3yeOMXYuRxEjlhO05g0HYY7kUP1S+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=duT1fPlVZDZgFZ13Eag1fjTPGHgfcE/50NRl4FXR1Sd3xbjdtQiMUKc1dvyzOJfutu17CrdABNJFckv+QSJObu47Rd8S+7QnWaXiGRWqQu6uLOFR25UZ91dbtdYT0NZuBr/ZLzAxAPUfhWbMXF0dIq3P1pPwr1hvR/h3tw6UX1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJtyZ2v0; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJtyZ2v0"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-59e64657f0cso1177133e87.2
        for <git@vger.kernel.org>; Thu, 19 Feb 2026 07:01:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771513287; cv=none;
        d=google.com; s=arc-20240605;
        b=Ffv/emWD3bUjBTn0yA95Xyi0QK5nh2GFbUP49LTflxmBZhBnNvLG7Dttq8iYS8HYrr
         91IZHnNTMJbOyUhJ4uySUqKhCLl6wJeJ3W1mJrG3M/fiaon56lT44Gq6pcXTll751B/f
         gS0qJ2vqYXVtlIM7Yu/w6c0jy0z1kR7hbkbxkvNkgH/P7uM+D1WKFU09bnPf1ovCPOiw
         nigPTKOiQyo/M2iCr4mZJemYoidOV5GaW1O8KzIn1JQzmPIhcsWwfAyv9WNYKOI5ioIs
         0iqetv1vhK45E/1qMXXZTUGjJ7/RSOoVJX8x04XfIk86x4T7FF3rmSFJFxx2IqPTfid5
         JnPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SHggAFFbSUtYMzM5SUM8LbvVnQ7vvkGLDuuVJDnkPT0=;
        fh=sulDRuqcvZwDHc0E6OQ2zx+/iCX/JVLhUA+HoKuaG64=;
        b=iipwbS/W/gzuLDwsfz3je2ly5B3/1Bskb6zmbGhG01KbyyEdWzc0t5k5XhfhvpXWsn
         zw57Glh3GrmAx66ClNiB3aZWng88wn1vBzbet6oy+M4zm6MTCWoUAP9BDp+Ob8Lu0FHN
         hdjViqjH5EsSs+7gv6yxH63k+haJRV7jZfC8kP/BMMFXnFWOIVCxs7ENGbmpwt/7kyIT
         m2RGoFvNsOxEnL7qHcSyPPWS3a8vjfA42clcd1Wi6DhBWKZOFS3VyuxCCE89xMPYj2H5
         HVJa3iSo5ytfSgqk3vpJbAVM3LiB85OshqrGk901aQLv3iV2w9dNOLXwvMjbEZhXgUda
         PLCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771513287; x=1772118087; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SHggAFFbSUtYMzM5SUM8LbvVnQ7vvkGLDuuVJDnkPT0=;
        b=aJtyZ2v0JisLjf7DVRVFbICPmYM29zPpc9tXZ/8lgK7DJKev8E/ro+FREVkks1nxee
         kKhp2X6PEPDPIcg3ebQtb8DrJwk+LBWDbELTN15qZs40wecoQ6FXy5gJLB0GU2DXdpew
         HHMWaeUdt2KjIu/x3lrCFKLT2CljMnA90yRvD48EKSkkvcsKC/jn0ArJermXxq8p3jw4
         wtcpYl6RL1xgQNSiVtPfI0BXf6qFI/4FgNQXirRBLM3d7XrODW1Yg0vC16FzKsllEBh8
         VBLhK3g+2ll1IxxPoz3TShh89pB6AdIUmscIjiiI5Wx4dTpCapTtqTReJ5wEXRCfWIXY
         0ANw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771513287; x=1772118087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SHggAFFbSUtYMzM5SUM8LbvVnQ7vvkGLDuuVJDnkPT0=;
        b=QOJmlmIPg9357bmf3dknhWwJOukrBxrEzL/W1weccnui+2EMvw+HB8z2xWVaPLyFFA
         lYYqNRN2wDY+2Xdy0M4bcWcql/f/jZshsQ0F9wI7HQxN4NEcVyuidbsnt0mFUm6IyN3a
         2tqL1xZIerFJhM9HwjnAftrOsUwBVzkfX6XRZ5VQahTqXV/2wyRwJxwN3nmZBe4d86+2
         pZqlzNEycEIX1nGunMjhlvbMWKjjy/iajHn4tYjqIEUPSbDz5YGnm1TGRPbFdn40unb2
         xEm6LzLQzvGXIdMeQTg16n5JeoK7Xm/yvg4EKAET/GlW75YWmaySzwgCXI6F7q0w4Ij5
         kiHQ==
X-Gm-Message-State: AOJu0YwupUZ/WnHpgLQJhlN3MnHxEv4SyZnuHzESvT2t6GIL56XlPcoc
	FyCDiNzjpT4sc0sPJVxzMbwqaXbcvE4D3VFixLUk76a47LKJ5v75BP1boIPAxbxRHcpiKWyJMLA
	wQKxNmt/f4vfupNV0iHM8ophARpMNHpQ=
X-Gm-Gg: AZuq6aKtwY+StOIJJT3SlLDuLJBBTIWAtJ9nWnbwbXR51iDr1cFurLC7tKs3+3X+6dg
	P+QRXYy+AU761PRmhe2rmvVyhKwOLJNwYoQalbuXKsrbPqsEAUU4BnX0X17wp7I8sN3Zlb6CpS+
	2jgXQK/tbK7R+16DL5e/+ZbB/CgWaMA/1QrD+s4srACBx3A9IqRw282bRmUMLdi120O6bXY9ITt
	G2m8T5amHpKEIYqVFNdPNdn8WjHOF+txSCLtk4Jfo5LBfsM1lU/zM4c6LOyLmr1lbAHSARjjZ53
	TuNafvESSbkCiX+Y9P6lVnF8+NSKfb3UI+ceoU01
X-Received: by 2002:a05:6512:33d5:b0:59c:b819:1c13 with SMTP id
 2adb3069b0e04-59f6d3786e8mr4944054e87.26.1771513285491; Thu, 19 Feb 2026
 07:01:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260208062949.596-1-kumarayushjha123@gmail.com> <0d6c5b14-1c53-4372-8395-7c7cba9fbf0b@gmail.com>
In-Reply-To: <0d6c5b14-1c53-4372-8395-7c7cba9fbf0b@gmail.com>
From: Ayush Jha <kumarayushjha123@gmail.com>
Date: Thu, 19 Feb 2026 20:31:13 +0530
X-Gm-Features: AaiRm50IJK9O8nh0sKHRkJ7zWtvIoe-XRPGf-JErcyoymVnMXbXqFgvkrSe88LY
Message-ID: <CAFNBzOeSa-wiLDWO7P7MdVvMAbAJwt7DL8N3SgWA1HfnUG10gw@mail.gmail.com>
Subject: Re: [RFC GSoC PATCH v3 0/2] Make read_attr() repository-aware by
 introducing a lazy bare state
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>, 
	Karthik Nayak <karthik.188@gmail.com>, Justin Tobler <jltobler@gmail.com>, 
	Ayush Chandekar <ayu.chandekar@gmail.com>, Siddharth Asthana <siddharthasthana31@gmail.com>, 
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Phillip,

After revisiting this earlier patch in light of the recent discussion,
and based on my current understanding, I agree that this change falls
under the same lazy-parsing concerns that Junio previously
highlighted.

Thank you for pointing that out.

Best regards,
Ayush

On Thu, Feb 19, 2026 at 4:12=E2=80=AFPM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> Hi Ayush
>
> On 08/02/2026 06:29, Ayush Jha wrote:
> > This patch series is v3 of an earlier RFC that aimed to remove the
> > dependency on the global `the_repository` from read_attr().
> >
> > Based on feedback from Lucas Seiki Oshiro and Junio C Hamano, this
> > iteration introduces a repository-scoped, lazily initialized "bare"
> > state in struct repo_settings, exposed via repo_settings_get_is_bare().
> > The read_attr() function is then updated to use this helper instead of
> > is_bare_repository().
>
> Doesn't the lazy initialization here suffer from the same problems that
> Junio explained in https://lore.kernel.org/xmqqpl63b2tm.fsf@gitster.g ?
> Changing config settings that are currently parsed eagerly to being
> parsed lazily opens up a whole can of worms and is best avoided. As
> Junio said Bello Olamide is exploring a different approach that avoids
> the lazy parsing.
>
> Thanks
>
> Phillip
>
> > The series is split as follows:
> >    1/2 repo-settings: add repo_settings_get_is_bare
> >    2/2 attr: use local repository state in read_attr
> >
> > Comments and suggestions are welcome.
> >
> > Ayush Jha (2):
> >    repo-settings: add repo_settings_get_is_bare
> >    attr: use local repository state in read_attr
> >
> >   attr.c          |  3 ++-
> >   repo-settings.c | 12 ++++++++++++
> >   repo-settings.h |  5 +++++
> >   3 files changed, 19 insertions(+), 1 deletion(-)
> >
>
