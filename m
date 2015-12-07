From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC/PATCH 1/8] update-index: add untracked cache notifications
Date: Mon, 7 Dec 2015 10:12:50 +0100
Message-ID: <CACsJy8Dd9qVGNOfn-g=Ys_KL=SqRVyAp4Jd67KM64GRvu8gsgQ@mail.gmail.com>
References: <1449001899-18956-1-git-send-email-chriscool@tuxfamily.org>
 <1449001899-18956-2-git-send-email-chriscool@tuxfamily.org>
 <CACsJy8BWEQNnpoXNBWSmmm-Ff7jJ9=+D6748TMXFyospU7jt1A@mail.gmail.com> <CAP8UFD0w9X+7TfPvW0mPxgU75HMR=1WWb6baJ2YrdNTDETJ6hQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 07 10:13:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a5rrL-0005u1-Ns
	for gcvg-git-2@plane.gmane.org; Mon, 07 Dec 2015 10:13:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755425AbbLGJNX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2015 04:13:23 -0500
Received: from mail-lb0-f169.google.com ([209.85.217.169]:33500 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755401AbbLGJNV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2015 04:13:21 -0500
Received: by lbbkw15 with SMTP id kw15so54622791lbb.0
        for <git@vger.kernel.org>; Mon, 07 Dec 2015 01:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=i9fPfpK66dMc1Y0uxvDVCLJMYjaW237fb/0qHy7sKoo=;
        b=097tV9W6PAmsFtps/PD0sl3glf5T5t9ozI3QswMIRs3kblTCeEmS8w4+t5YH9X6MLR
         BmG/6a8E+RfiELoBwKeioNCz0rFJvK1wP15Cc2Ggbwp6RftSgG6h1mQLhEYz7BOrI7nq
         q7KKY9OmPhsuVzjq7JlOw/zYCkgqXwZX7ADqhG6e23SMPum8mdDRET68mZms34EoEzGC
         7vgPdEh6JpLZke2v6KMtjOi1mDvNviYg+XDh7Wu3OBqJD7SQpc+HeX6ytUTeO+10BExa
         U74BgeiJErxDhbji2gX6gAyy27mTLc5beoszMZlqrPsxinXIhXXaDBAspG8yD0UaV5Dn
         QSlw==
X-Received: by 10.25.165.202 with SMTP id o193mr12977457lfe.83.1449479599684;
 Mon, 07 Dec 2015 01:13:19 -0800 (PST)
Received: by 10.112.199.5 with HTTP; Mon, 7 Dec 2015 01:12:50 -0800 (PST)
In-Reply-To: <CAP8UFD0w9X+7TfPvW0mPxgU75HMR=1WWb6baJ2YrdNTDETJ6hQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282089>

On Mon, Dec 7, 2015 at 10:08 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Wed, Dec 2, 2015 at 8:16 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>>> --- a/builtin/update-index.c
>>> +++ b/builtin/update-index.c
>>> @@ -121,7 +121,7 @@ static int test_if_untracked_cache_is_supported(void)
>>>         if (!mkdtemp(mtime_dir.buf))
>>>                 die_errno("Could not make temporary directory");
>>>
>>> -       fprintf(stderr, _("Testing "));
>>> +       fprintf(stderr, _("Testing mtime in '%s' "), xgetcwd());
>>
>> We probably should respect --verbose. I know I violated it in the first place.
>
> The verbose help is:
>
>     --verbose             report actions to standard output
>
> so yeah, it is not respected first because the output is on by
> default, and second because the output is on stderr instead of stdout.
> Anyway it can be a separate patch or patch series to make it respect
> one or both of these points.
>
> I am not very much interested in doing it myself as I think it's
> interesting to have the output by default especially if the above
> patch is applied. But if people agree that it would be a good thing, I
> will do it.

Then we can leave it out. Not important (until people actually complain).
-- 
Duy
