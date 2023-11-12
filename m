Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C575154AB
	for <git@vger.kernel.org>; Sun, 12 Nov 2023 18:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="Hj1cvKfD"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2331C1FF6
	for <git@vger.kernel.org>; Sun, 12 Nov 2023 10:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1699814303; x=1700419103; i=l.s.r@web.de;
	bh=3CmUWK9y/9j3PJYT38G2QvxrLcY3oQcHTlMPB+GOtCU=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=Hj1cvKfDAYtx4w1ZAy4Z++48oM/GFdIBlPeQdPpqLs95bCdLZVyrlzTYAvXVDnTF
	 CWMIGzJkJTQ7ucNL2+gOTzBGRJpFXMh98498tPwXD3bdOlKTMloPxJ68Z4bLaRwXs
	 eF8Xp98bQc/RuvrHjxuBfu4qhROmkt4UgAS9N/G/5vhl2EVG2/GifOMaCtqDGbU1z
	 rTGsrh5MS5H4yrdVEwZ00b/91g8dPIfIlz2kyoHid5ZYdjO3FB+ycz05HUGkAE5v/
	 mYIy9Mir2K5KdEjZu+pmoxQ6N9QPzi4ReHecMWR8/SDBWjJWfL4bTRGLilVEEYvDN
	 HkdYYhsq5zSreGisTQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.159.220]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MC0PR-1rE6Fv41U5-00CdXd; Sun, 12
 Nov 2023 19:38:23 +0100
Message-ID: <0c0d685c-29e5-462c-a743-4573a56d7e04@web.de>
Date: Sun, 12 Nov 2023 19:38:22 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] format-patch: fix ignored encode_email_headers for cover
 letter
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
 Simon Ser <contact@emersion.fr>
References: <20231109111950.387219-1-contact@emersion.fr>
 <20231109183506.GB2711684@coredump.intra.peff.net>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20231109183506.GB2711684@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gmKjQf5sB6KcEiQMor7kvKHgZNI9LYUK+xuhTBPX+0Y2iH8GgYf
 D/tq8r9m/uHZY1kmFLeLt5C66HlqPxSuzroUPMZPhlPyF3DOn0laq7TXf7PEPQYsClGour0
 qwlXEsWpmg9wyTOeKPWrwWwdtPMFPyBCJmszNrPoeNfH1et66DMgb0QJ16GSnNgFg7CLixL
 1iGXoJs86zl6B5wOtIJdg==
UI-OutboundReport: notjunk:1;M01:P0:0OlBQ1p08J8=;V5fOkl5PjSIjEivun0S4E3f7im8
 FoD4cnxJzZx52sfiN9xsQ2lUwCke6JdjuPkzXnTa7qQZSHdz3B384ZvVMzVS3lea6uD2oRwhy
 PVt5A9patftdYkPx7MJo6eSb+EFHejfFpN5b6cJqNHEvJOs9mjBo0m8zxLLileJksgRglJ4M6
 QfGPEw2CUyjHU7akE7m9sg9dESqfPSNigDg/79dCZTh3jTvbWxSNDx9+3aLRJRt/vIa7YzSjv
 j3fEaNDlK9VCOBYTvx5R1bOe6t4IE5Jp9FM7iM+S+ufNOCvM3RLAUGAiyLBJyL7c6iNz9AcI6
 j0l2RWFFHp8Z22/6kQ+aoy7Kbq3VKRnQDtvK3UZcAuIgzJv1AoYO2pwqAx3k+JWR4QExf16BX
 24c7OrggS9ByqX6SReK8X84JfC2bjrGylTewBb5VadjUMvaOG/UXjq8ZigTBR25yyetDkTFua
 88cYABSd72R62HnhdM48HvxhuAQMIozPB3q/EJf3aCHWJpGlQTqKbkdkoDZXvLEpUCfT0rQTl
 9q5qVAhcque2rWRuAoAYaWAQJRXhjCXGdQIoUJKG388f1Ucls6q1yTlQWZHnHZ0gIJBmSZ+5u
 0RYEm4/go01pVNPlFOLMPlCAgi4pmSwkjJX2xRPawlM02CPN9ndMJPQu07TU8XWp3CCDu70/R
 lNpBchPsmolg8gBZxT59ihGke5RlGAC+0wvOEgawnM+OzuRDVgFbOGxJdJov/EK5Yl3o9Uk5E
 0pmEHhR23IXz4x9X0J2IoGdcNptXNrjj39IpDDvN73TYzLvfj8wZ9hWhnfgq2wfB68k8HHbhq
 o8I2nbhBwo+L/KYW0e4fmg9IRuuEgORQsqtuAUVo+6Y4P8nbZV3YGCGD0gWbmh17HCyVtTtxI
 zjm1UKSP77eXUSaTxdslPuzf2Nj5zNQDHkUN6rGsrIwZhoQOzd/rCUl2xkDQG9WaTHdNkJlCo
 Ea7bKPzW+g2XTKo9pUZOHO9TukE=

Am 09.11.23 um 19:35 schrieb Jeff King:
> On Thu, Nov 09, 2023 at 11:19:56AM +0000, Simon Ser wrote:
>
>> When writing the cover letter, the encode_email_headers option was
>> ignored. That is, UTF-8 subject lines and email addresses were
>> written out as-is, without any Q-encoding, even if
>> --encode-email-headers was passed on the command line.
>>
>> This is due to encode_email_headers not being copied over from
>> struct rev_info to struct pretty_print_context. Fix that and add
>> a test.
>
> That makes sense, and your patch looks the right thing to do as an
> immediate fix. But I have to wonder:
>
>   1. Are there other bits that need to be copied?

Good question.

> Grepping for other
>      code that does the same thing, I see that show_log() and
>      cmd_format_patch() copy a lot more.

show_log() copies almost half of the struct 6d167fd7cc members
from struct rev_info!

cmd_format_patch() doesn't seem have a struct pretty_print_context,
though...

> (For that matter, why doesn't
>      make_cover_letter() just use the context set up by
>      cmd_format_patch()?).

... which answers this question, but did you perhaps mean a different
function?

>   2. Why are we copying this stuff at all? When we introduced the
>      pretty-print context back in 6bf139440c (clean up calling
>      conventions for pretty.c functions, 2011-05-26), the idea was just
>      to keep all of the format options together. But later, 6d167fd7cc
>      (pretty: use fmt_output_email_subject(), 2017-03-01) added a
>      pointer to the rev_info directly.

Hmm.  Was sticking the rev_info pointer in unwise?  Does it tangle up
things that should be kept separate?  It uses force_in_body_from,
grep_filter, sources, nr, total and subject_prefix from struct rev_info.
That seems a lot, but is just a small fraction of its total members and
we could just copy those we need.  Or prepare the subject string and
pass it in, as before 6d167fd7cc.

> So could/should we just be using
>      pp->rev->encode_email_headers here?

Perhaps.  If we want struct pretty_print_context to be a collection of
named parameters, though, then it makes sense to avoid using
complicated types to provide a nice interface to its callers, and
struct rev_info is one of our largest structs we have.

>      Or if that field is not always set (or we want to override some
>      elements), should there be a single helper function to initialize
>      the pretty_print_context from a rev_info, that could be shared
>      between spots like show_log() and make_cover_letter()?

That would help avoid forgetting to copy something.  But copying is
questionable in general, as you mentioned.  Given the extent of the
overlap, would it make sense to embed struct pretty_print_context in
struct rev_info instead?  Or a subset thereof?

Ren=C3=A9
