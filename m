Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0AD364
	for <git@vger.kernel.org>; Sat, 27 Apr 2024 14:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714229304; cv=none; b=fAn/ffwLUtleyRBjNQVUmTUK1eY8J9HHGKkGAJWu/OKXPCeR3WAOqQP9vbJkb1DVEk9SEqk4uJGPp3FujlyVWEWwUT2uGypadiodbdsOG/mvxflqbN4kAIBEIjqZGYwegjuY676oMYoKoBRL5NGQyjCbwjMeA0bvT4zbQlsmKFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714229304; c=relaxed/simple;
	bh=c3iNgwOxQWWAJllmyvC+THB8yn3uY0GOtDtTxmo/4f4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=O/k6HD/W/9qpdLCX2iptfbsyvFmiWSSvg6ZM4l7IXSr1NEpWAw2aDJHDJASfykACn03cahKEHB6y2tNF+Yw5Q1elZoBs1OGh/gYJF6YBdGKDFHG50AbrC8qBs9Hj76kPcCu9h8qu6neTcevKJtf3vVQ+YmYZRkJKAez2YR5nh9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=V1ywR+UC; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="V1ywR+UC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1714229273; x=1714834073;
	i=johannes.schindelin@gmx.de;
	bh=K8AnKbdZTUXjeKyuuSNuJYVtXgGTY/RDV81bc7GMjW8=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=V1ywR+UCYckeZkn0rAbgrUebXc/6NbVl9UAalhH/C4BUqWW1EBXEEGH4yD6b85qY
	 RKywV2rCUyJmR/I96yG3Hrkrz9FGy70PdB0BxlUwTWxD/VH9Cu72cIYBjz833RAOU
	 83qn3q+RrQBghMvoy6716sBDbUxEwHJwD4DWxMSzVIP05ONhMSP7dyJgrBbsjVN3v
	 MYfCBQGN0HOvZPL8tdE41ZZtgbsAqF0rCArn6yYV/lQ/OGlEdD99oPdp0yU4FN0FW
	 uHru/0TFLOMarhJ2zgI8bhL7mdvSC4zHyREzYOrzTd4h1khCqimLl9XB1Kkwa7T4z
	 U5TERF3mgEUjanFexg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.213.45]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M1ps8-1ryXTs3UAy-002FkQ; Sat, 27
 Apr 2024 16:47:52 +0200
Date: Sat, 27 Apr 2024 16:47:50 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: Jeff King <peff@peff.net>, git@vger.kernel.org, 
    Eric Sunshine <sunshine@sunshineco.com>, 
    Han Young <hanyang.tony@bytedance.com>
Subject: Re: [PATCH v2] t4126: make sure a directory with SP at the end is
 usable
In-Reply-To: <xmqqplvd0y6c.fsf@gitster.g>
Message-ID: <386aecc6-d94b-3f76-9a11-f05c68fb6767@gmx.de>
References: <20240319095212.42332-1-hanyang.tony@bytedance.com> <xmqqttl2qml9.fsf@gitster.g> <xmqqfrwlltjn.fsf@gitster.g> <xmqqsf0bz5oj.fsf@gitster.g> <20240328103254.GA898963@coredump.intra.peff.net> <20240328114038.GA1394725@coredump.intra.peff.net>
 <CAPig+cQe1rAN2MUFTwo7JoCt3sO2eCk_psnJL9D=Rs=Q9MWO9A@mail.gmail.com> <xmqqa5miuutd.fsf@gitster.g> <xmqqh6gqt674.fsf_-_@gitster.g> <xmqqil15srub.fsf@gitster.g> <20240329112730.GA15842@coredump.intra.peff.net> <xmqqplvd0y6c.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:HIfw3j2xC82p4anfn8j35kSsHUbM1+5cCmLCoxI6QzifXSRKzzP
 8G6u4Zl6awL9zjGax1tkvH1f2mHdHFrqwGTxg55W/NQq+mZGOCuZDOz5b1Dm43uZq4L67qS
 Ct2jGHFI9h2+LBfM9BJEj5Cn4GAq0obASnKRcSxsfPoGTYM/rFFufSjLLuxhlA+lGrBF3r/
 DudOQuNvBL0GJ1OrYP37w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RShpjEOd87g=;g+nVnwNhHCqyg3m6cddlpxRWniv
 lSFesYCBeRZ9JfXBaS3JhtOhU+cJSr2sfuK6tB0SQvNMxbjrDjrSIvXqTNfblAmwoo/bkDFXJ
 Pbre/u9vzqLzpJ0r6qsNljznbxWvaWEAkOK/WrbGhbsGX7VfOvmDa3vGb2cZ9JxjdAtHP2xQi
 HNIvCkciogIiZLXwR1A3bkGBoiCoEs53xY8LF2XOAK6MBSYjuaI3YIZbtM9NUY9TZvaLjcmce
 VZI4PxaUyky8Nc+FtgaRbY9Lw+RRJ+OGZK/uCf2n+tcOgmV5Rof/jZwI0firX2VSmwfEkZN70
 9gmNUckZegm6B1tfO485CbOPYTvqv8Uhqb7fJGXVs0iAeCVI9MmYMteFnTdPsYwlL8W3kuGzs
 mxYpT9tuuG3I3xRXKz9YyqsDs8mQMl8d8xJgfasbsVxQVhc4xTIBJeaO5NFZZ0OvKiffNNdNU
 kK4Ux4wJ1BXDSBcJ2rWW4UTCkptCPUZQDk8yQIPKdYVGZWBYMqOiMmWQGtefeO6Nde9lMcObk
 isNEY9K/zzrqsRuHScVt2/DomBejYl0RtZMs0i4x76uUiKXGahZD+dFthIi7rfiyTq6c1n3vJ
 aiyxCp4cgbssY+FTeqiLJHfJkYAZ2XxX6k4m4nsvgwnsPIAuvG67an6V6BlN26diBzdcx6UYm
 GwzoBw/khPQJMtwiC3pRL3eYICeQkZIv9tmDBIdJwPzqHJ+Kj7ntiTtSAFOxklmIVlHnxdYLk
 CDObLtQ7Qq+JUw3wiM/oLd8zxMGnn4zi6vqIaeXLY1u6l7wnhmGehmJOzOxAP5H2tRAAdK9cc
 h2f5eKTJ30q3Qs/DJ57KmXNYVTt0Fp4bU2Dn1EQoM0scw=
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Fri, 29 Mar 2024, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
>
> > On Thu, Mar 28, 2024 at 07:18:52PM -0700, Junio C Hamano wrote:
> >
> >> Junio C Hamano <gitster@pobox.com> writes:
> >>
> >> > +test_expect_success 'parsing a patch with no-contents and a funny =
pathname' '
> >> >  	git reset --hard &&
> >> > +	empty_blob=3D$(test_oid empty_blob) &&
> >> > +	echo "$empty_blob" >expect &&
> >> >
> >> > +	git update-index --add --cacheinfo "100644,$empty_blob,funny /emp=
ty" &&
> >>
> >> It seems that on Windows, this step fails with "funny /empty" as
> >> "invalid path".
> >>
> >> https://github.com/git/git/actions/runs/8475098601/job/23222724707#st=
ep:6:244
> >
> > Ah, sorry, I didn't actually try my suggestion on Windows. I guess we
> > are falling afoul of verify_path(), which calls is_valid_path(). That =
is
> > a noop on most platforms, but is_valid_win32_path() has:
> >
> >                   switch (c) {
> >                   case '\0':
> >                   case '/': case '\\':
> >                           /* cannot end in ` ` or `.`, except for `.` =
and `..` */
> >                           if (preceding_space_or_period &&
> >                               (i !=3D periods || periods > 2))
> >                                   return 0;
>
> Yes, and no need to say sorry.  I was also surprised, as I thought
> that the non working tree operations ought to be platform
> independenty, with this.
>
> > It's interesting that there is no way to override this check via
> > update-index, etc (like we have "--literally" for hash-object when you
> > want to do something stupid). I think it would be sufficient to make
> > things work everywhere for this test case. On the other hand, if you
> > have to resort to "please add this index entry which is broken on my
> > filesystem" to run the test, maybe that is a good sign it should just =
be
> > skipped on that platform. ;)
>
> This is a far-away tangent but we may want to think about "the core
> of Git made into a library that works only with the objects in the
> object-store and does not deal with working trees".  To work with
> the objects, we would probably need something like the index that is
> used in the original sense of the word (a database you consult with
> a pathname as a key and obtain the object name with mode bits and a
> stage number), etc.  Elijah's merge-tree may fit well within the
> scheme.
>
> There is no place like the above code in such a world.  The
> restriction must exist somewhere to protect the users that use on a
> limited system, but should come in a layer far above that "core
> library".

Indeed, it should have been at another layer, but alas, I could not find a
_better_ layer back when.

BTW it _is_ possible to override this check. This invocation works:

$ git -c core.protectNTFS=3Dfalse update-index --add --cacheinfo "100644,$=
empty_blob,funny /empty"

It has been on my radar for a long time that in particular with sparse
checkouts, this check is overzealous.

I would have loved to work on it, and once I find a position where I am
funded to work meaningfully on Git for Windows again, I will.

> Anyway, I think you convinced me in the other response that we
> should just use an existing prerequisite, perhaps FUNNYNAMES.  The
> idea is to exclude platforms that are known to break with the test
> without any hope of fix.  Because they are incapable of taking their
> users into the problematic state being tested in the first place,
> this is not making things any worse.

That was indeed the correct thing to do, as far as I am concerned.

Thank you for fixing this, and sorry that I was not able to contribute
meaningfully to the fix.

Ciao,
Johannes
