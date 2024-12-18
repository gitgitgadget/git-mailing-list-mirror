Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C68165F18
	for <git@vger.kernel.org>; Wed, 18 Dec 2024 08:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734511046; cv=none; b=YMbGo4kmlGtNxiMAnrCXTGIHkSwuWcQIzq9ouqAorZ+j95Oxn8BVIHquOdKHj7k9rx9WJCEecx54Buqht9n5RNpunHxNvWeKgdvm2DxcyTtwx6+X5Gu7uXbZrlB/0N3Ar8OOqq1bZWF5gMKPkN6NOsxatvHZmV8YA3cpRogH7nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734511046; c=relaxed/simple;
	bh=0Udg7gW/iUJ4ut5XNDRuUZYvIuL7IsZgVTjfgVAp8LI=;
	h=MIME-Version:From:To:Cc:In-Reply-To:Subject:Message-ID:Date:
	 Content-Type; b=Az6FOL+qIj9n0aOI9fptyLEv9YB6UaYkLqcY4ep3CEQhyn6CJSice9Vj41vZHhNBOFNVWaRoa1l6XZ3L/Pm7jDu9HrsGxjK3pTZKjUNs16yv3TTUnSUWVBFfHX9RpYEnO4cgMi0XpfV3m0e8V3m8TVqvESNUezbaUryMhzlLYlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ADnOsSSP; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ADnOsSSP"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21683192bf9so58952855ad.3
        for <git@vger.kernel.org>; Wed, 18 Dec 2024 00:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734511045; x=1735115845; darn=vger.kernel.org;
        h=content-transfer-encoding:date:message-id:subject:in-reply-to:cc:to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KDlZLiIPVBynEUgzM15qGAb+ywoRoC/Rw/eBIr0zSz8=;
        b=ADnOsSSPvPyZrTKG5niufMYqIsPXMY67pviJxktGDWExKBed7MeL+/Qn2zjFOhd6Db
         vccUSI2Q285gCPpEYThVJHGVtMC+oNlvF8oWII9Kt+IOqaa7zYbVNJRs/u+Aq8YH3kjJ
         H0++FLrQQJFIbnNz+EP1elpgw1Icu8qYc2FRcye7awAAHaCagXFKvZXsNy4PNCMyY7wK
         O8b+jIrFzXUoymfjMzpZAkqaC0yZI5+wOZh9cc45MX0oZfqEKqMieQ9rSszjZqf2OgsO
         VO3TC5X/SvcVYH3lFRRpR80N/vJZVlrt+gjV2lWc3xG4q1kgX/tm/HWUL+IkZIPlyc0z
         3U/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734511045; x=1735115845;
        h=content-transfer-encoding:date:message-id:subject:in-reply-to:cc:to
         :from:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KDlZLiIPVBynEUgzM15qGAb+ywoRoC/Rw/eBIr0zSz8=;
        b=LSuGENxysOfoCkMm5olJAAJ98MnbMFv9kmFF7P93tY3OIi7ck29KMfL68/rPaYDdhN
         d+jMJiEGbzWZL7FSO9GiM5mYm8BzfzHAmz8QrujVxLtL5YOQd6rpgcX2BXeB7s2Y96ud
         tHYpHzBayazGgfEGuta1guIfITBlPPOfx9/+7HjkbVvpKwXtBPBENCofZF4R8iyeCgWP
         Fw18LUtqLyvJam18CuKdTcTP6Ly9un6ca5sa3kJF+ZMFYj1GjHzkPpPQKy6AWAgpp9P/
         rknbgWF9siak9wXtaKofIl4BVXkfsMyNQyAaLg9fV9FtdL0ng/FTqYmS3yIJvP9cNAle
         6q9Q==
X-Gm-Message-State: AOJu0YxCL8XNoEsX5/P7SYiKSmzdtqb23G5AZlAe5pQokSWS5iNwqeDo
	aEiOS7+0JcwPkfyHfWkHUxb3QNCsWqWEFj1dhfldu5vn1LalVK80
X-Gm-Gg: ASbGncsyxMxTotgNKJBW5vvVdc6T9SHS7bocByUTMccWdSEKMwYeeTS3VbhDScPBkbf
	J3OSdhr8sJO8sFkeEiYoaCA+Sx6Wr15gkmjl+8HIFsAmbFpdCukUe/YGUr6QpZMc/hoQfoAQ2cv
	URcbCRttLgBd3l3bX2Lt28XfrjL3HxHzq05T5t+pbo9+veJy1WPaUuQ5dwSeAscShlE005FLcY8
	61+ohCZa662BAWuXKyehFf0g4/TMvag3c+9RsjcNmftsqGBqgofQsb+qQp7mxSwHtE3JdePMd/e
	wuUNvw==
X-Google-Smtp-Source: AGHT+IE9WP1SAAh2eNPbxfiieJgmweyfQOR5IetTn+GAKm07HvfdoRiy+oEDlInIJ29CFr5EMkAayw==
X-Received: by 2002:a17:902:d2c1:b0:215:7cd0:758d with SMTP id d9443c01a7336-218d725282fmr27938245ad.36.1734511044633;
        Wed, 18 Dec 2024 00:37:24 -0800 (PST)
Received: from host (36-230-86-110.dynamic-ip.hinet.net. [36.230.86.110])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219ce74004fsm4952945ad.43.2024.12.18.00.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 00:37:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Wang Bing-hua" <louiswpf@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, 
	"Wang Bing-hua via GitGitGadget" <gitgitgadget@gmail.com>
Cc: <git@vger.kernel.org>
In-Reply-To: <xmqq4j32yr3c.fsf@gitster.g>
Subject: Re: [PATCH v2] remote: align --verbose output with spaces
Message-ID: <1812389a7b6fe18d.7946240d95ed36ca.1b2132d5c888cc21@host>
Date: Wed, 18 Dec 2024 08:37:22 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On 17/12/2024 12:47, Junio C Hamano wrote:
> I wonder if it is a better idea to extend get_one_entry() interface
> to take not just a string_list but something like
>=20
> 	struct remotes_data {
> 		int maxwidth;
> 		struct string_list *list_of_remotes;
> 	};
>=20
> if we think it is a good idea to give richer output to show_all()
> function (instead of keep it spartan and compatible for the sake of
> not breaking machine readers).  There may be things other than
> maxwidth that future changes to "git remote [-v]" may find needed.
> And with such a change, you do not need a separate iteration over
> the list of remotes just to call calc_maxwidth() callback.  Keeping
> a tally of "max length we have seen" inside get_one_entry() regardless
> of "--verbose" setting shouldn't be too costly and help reduce the
> complexity of the code.

This is a great idea.

>=20
>>  		string_list_sort(&list);
>> -		for (i =3D 0; i < list.nr; i++) {
>> -			struct string_list_item *item =3D list.items + i;
>> -			if (verbose)
>> -				printf("%s\t%s\n", item->string,
>> -					item->util ? (const char *)item->util : "");
>> -			else {
>> -				if (i && !strcmp((item - 1)->string, item->string))
>> +		for_each_string_list_item (item, &list) {
>=20
> Use of for_each_string_list_item() instead of a manual iteration is
> probably a good idea here.  If this were a larger change, that may
> deserve to be a preparatory step on its own, but it is probably OK
> to do so in the same patch.

Thanks for the reminder.

>=20
>> +			if (verbose) {
>> +				struct strbuf s =3D STRBUF_INIT;
>> +
>> +				strbuf_utf8_align(&s, ALIGN_LEFT, maxwidth + 1,
>> +						  item->string);
>> +				if (item->util)
>> +					strbuf_addstr(&s, item->util);
>> +				printf("%s\n", s.buf);
>> +				strbuf_release(&s);
>=20
> Wouldn't it work to just do (totally untested code snippet below;
> may have off-by-one around maxwidth)
>=20
> 				printf("%.*s%s", maxwidth, item->string,
> 					item->util ? "" : item->util);
>=20
> without using any strbuf operation?

I did try to use printf at first.

				printf("%-*s %s\n", maxwidth, item->string,
				       item->util ? (const char *)item->util :
						    "");

But it broke when there are non-ASCII characters. For example:

$ git remote -v
a  url (fetch)
a  url (push)
=C3=A5 url (fetch)
=C3=A5 url (push)
=C3=A5=C3=A5 url (fetch)
=C3=A5=C3=A5 url (push)


Thank you for reviewing. I'm also debating. It's great to align
"remote -v" and make it behave similarly to "branch -v". But it might
not be worth it to complicate the code and break machine readers.
Do we continue working on this?

