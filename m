Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3692B35A390
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 19:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773342339; cv=pass; b=L0tmrBeZvitWnZpQmVGS2Ny1PZUkwrDd8vSYS9et204JvMxutT3blN6nMFH/c4E501tWCmDf4e3ZjFHyvSTgpF2R8e9xh9q6FeV8EiC/2ihKGzjNOKJ5RTF9m+hgOYD8NHTguD3dfqXzq/A5hksJTce12KPZFJP+gw0gyI2P4NY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773342339; c=relaxed/simple;
	bh=IAaYUwjChfMAnAhkD2xx4OuDm+lBBqF4PunPD6EGyB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bSnbwrKPadp3pom+fWmpS8baKYp0uCfbaOiTZ3n1M1eHavzeDRnG8ZUPeZrIpIuvHpZdVo7Tz80ITM1KKN7N5rsBKV9yr8+1yCTWBAZa1dWZqioBmxkvs194hxidniBRQhupjD++uF7xyCuJvCirpUOYNqjuDrs82U7nEZyRwI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=pass smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2be22d699c9so87722eec.0
        for <git@vger.kernel.org>; Thu, 12 Mar 2026 12:05:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773342337; cv=none;
        d=google.com; s=arc-20240605;
        b=GpHK+klcScJNWteLU112t/1dsHtQVws669aRW/33t/EG057ZJGtTidDUqSKf5hU0ta
         Ad/PSabn26zsGF62a2nNls0kOEpE4TMd/b5fJcmPezyE7dC+ww9TBoU0QnXlPaDoviu4
         k+JgGngXbnwx1i9wyYT6E6ezTj0CsDTqddGj0bMRLFJJlqBQFDj46sMDxeJSKJxUtJhX
         vgE+lUEymlGuiiH9fQvP8ZE+YcPBcuZQqs3uirH5OP6QZrZV8OZdzIhHMxztWi/sYz/J
         fq9j2c7GiGKBXRYUk/UVwWGpBaNKyVmf38Xn5EBgjPZ2A9N7gojHgS6ZHcSu1tbCdxkQ
         4qGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=5Jo2SYF7Kyu0BEG0DVwUWzc+GoASVvjl5g+kFaGZkYs=;
        fh=iio2uoOBAWn7SWeSQbYhiY0qAwgocdKu3eQ+r4UbYXM=;
        b=IHMG9OJsy3WcZx0jcI1TcHpoKiNCJTOEklCsErBlFxRvDVGON4x7C4WhnVXC77IGvq
         ePrVkxodinjjIH395mQOHKRIAnm5UFnRc5E6cVdAk0hN+i2bfjCq3SY6zE3hQ8W2N4aM
         SLSRbqus0zJ+sI2GG6B/6Be+/tORZ8IWXmRaibRT/8rFBeSaxV5ay6J2xMMWlhT6AaAk
         o7urRh9gBhOjqkLdaLjf1/kkXUuweBBNrQgQI58g2WXewaisAc0Hvfad9Fl5WuP8SMVO
         /qxKcMnP4U1blxJLl+80m/bTUg63V0j0uMXnYQkX3q8379M5hzdmv0khJK/2EkO+E1GY
         nIxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773342337; x=1773947137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5Jo2SYF7Kyu0BEG0DVwUWzc+GoASVvjl5g+kFaGZkYs=;
        b=c++Ra+PUHswxUETIvYL0D60FXmTFOFCp3gedbyGCHUbjsbk33uylf97vq8tzskHwHf
         0DRj/kujcPlFXf6lK61AkaNKvSWH+xRW0PNSUd6ADXTeK/cpWiBKh8rPyPFAoKO6c6/O
         /EoeASJVPRx23LOIbzKzUiHTVZOt6Fl8g42tqIODzy69UrZMoglULKpLkG6H1QLYPUQB
         r3Woir/yv0OFE90xQHZ9VvlTDiqNY2thqeMHsdFVS+wn8DgKFQNezEHXerxiD80lStUl
         Rtgxh+185zjOdQ2Dbp14isdOBmyssDfMLTS8KiApdZPcR/Fx35bGoRpKAcnxphccuxMP
         /7Rg==
X-Gm-Message-State: AOJu0YwM1zOB+em9HOAfkVNZ0XMXwS8o/EROjbTJA4rO2uMlDa2wFJal
	sgPF6CE4c/CAfKiwTZl6NdchwzwLaBLhNRe1pbOkyACyebsiBpaEK3WvifVQG0J1wyJvPyQUVTA
	SrH7hUp2nWDYG0adMu4CPme1iuYgT+gM=
X-Gm-Gg: ATEYQzyOItcDCTTBPpDfhu+ggfKfjY/5jrgYj/WXIQa6FR4u3w8WxfPDK9kJ62o20s2
	9zoyNB3AkNnZGAXv22VM1sJuJP36fU/djPOfTZ6BeADsMNsqRaY8kq+3ykB2tYQIFYPNBXMMJit
	hjiGVhYt6oSexQEhGOToeAZckJqr9mdARvdY1Kv1WklxXgRQIRpxzWJ5jXF/F+kw8GMdj22Cc49
	Gwbzjg63mnEZZUV8IEQtmnz3sftLBuF1qipXsttkNdi/eO/Z3jZdMEqbKXyX2e0ORk2ID7JQO2R
	xWFL5tp2j7VvFxis7fBxu8Vhy2yVajjgSs721z6UxA==
X-Received: by 2002:a05:7301:fa8b:b0:2be:298c:a11 with SMTP id
 5a478bee46e88-2bea5538210mr216371eec.3.1773342337179; Thu, 12 Mar 2026
 12:05:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312125030.7799-1-r.siddharth.shrimali@gmail.com>
In-Reply-To: <20260312125030.7799-1-r.siddharth.shrimali@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 12 Mar 2026 15:05:24 -0400
X-Gm-Features: AaiRm52JLFgNxG6AP66XolfZDmlbtCoeJFbAxctYp75Mxj_ZifN41fmm_tf59IQ
Message-ID: <CAPig+cS3v=OT6BJ0WWh=qvWBm1TVck+O7eKd7gJ2fe_d5Rny_A@mail.gmail.com>
Subject: Re: [PATCH] t0410: modernize delete_object helper
To: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com, 
	christian.couder@gmail.com, karthik.188@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 8:50=E2=80=AFAM Siddharth Shrimali
<r.siddharth.shrimali@gmail.com> wrote:
> The delete_object helper currently relies on a manual sed command to
> calculate object paths. This works, but it's a bit brittle and forces
> us to maintain shell logic that Git's own test suite can already
> handle more elegantly.
>
> Switch to 'test_oid_to_path' to let Git handle the path logic. This
> makes the helper hash independent, which is much cleaner than manual
> string manipulation. While we're at it, add a call to
> 'test_path_is_file' so that the test fails early and clearly if we
> try to delete an object that isn't there, rather than failing
> silently.
>
> Signed-off-by: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
> ---
> diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
> @@ -11,7 +11,11 @@ test_description=3D'partial clone'
>  delete_object () {
> -       rm $1/.git/objects/$(echo $2 | sed -e 's|^..|&/|')
> +       repo=3D$1
> +       obj=3D$2
> +       path=3D"$repo/.git/objects/$(test_oid_to_path $obj)" &&
> +       test_path_is_file "$path" &&
> +       rm "$path"
>  }

Despite what the commit message says, adding a call to
`test_path_is_file` here does not add value since `rm` will already
fail noisily and exit with an error code if the path does not exist.
Moreover, because it's unnecessary, the `test_path_is_file` invocation
may confuse readers into thinking that something subtle is going on
that requires extra scrutiny and care even though that's not the case.
So let's not add this needless extra code.
