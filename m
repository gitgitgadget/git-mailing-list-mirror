From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 00/25] More flexibility in making shallow clones
Date: Fri, 12 Feb 2016 07:24:01 +0700
Message-ID: <CACsJy8DYkQe7DkY1AQbG5ZaJ-cLA3=1wjqAkekc3bdQQ1ANWMg@mail.gmail.com>
References: <1454576641-29615-1-git-send-email-pclouds@gmail.com> <xmqq60xy7u6u.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 12 01:24:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aU1XI-0007nh-Pp
	for gcvg-git-2@plane.gmane.org; Fri, 12 Feb 2016 01:24:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750890AbcBLAYd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Feb 2016 19:24:33 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:36665 "EHLO
	mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799AbcBLAYc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Feb 2016 19:24:32 -0500
Received: by mail-lf0-f66.google.com with SMTP id h198so3444214lfh.3
        for <git@vger.kernel.org>; Thu, 11 Feb 2016 16:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=tWhi0BkPvpu9Xtdp2Gn+thd8eA7r0ksomhZEupU9Kb4=;
        b=Ovtf1ZmVJR7sTBR/eMSEkQv3jeNKBQnqrGHQ3r2YF45OY3UG8oKtGCHHXB7D804zMR
         ojQSdpOJKyBG8XcKx46QdHpol/821oRlm6uEMERwnTxr0Fzfn5x78wOuSQDwht3QTU6v
         IPeB83nX3TD3a4+2+VIt2AU1U5TEUprBuR1jGGvhhjtIB4Ae0YHrvv6/jzzeA2NqyIiA
         MPzhLSxuv5xJQJ1wnDXFPs6yk+pROWHYIrIOoTDRpRRM6Gs+ygzkBf0p9ahg7R3u9bxu
         ww/I+QyIBHxNz8lFiF3d4f/qXhrP4ht2E97iAHJUHGmU+Tr513ejebu068tT72gFdp+h
         taKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=tWhi0BkPvpu9Xtdp2Gn+thd8eA7r0ksomhZEupU9Kb4=;
        b=Uup4OSqltykVVFr5wnlW9hCV31RLs0+TMjY4MdIN5aVGOVoivsdxvy4ahEycvEz0K/
         +j4GW5T3OaEv0RngwSTwE43asvno2+xB7mTlh/dsYlwVIN7DZwRKsZKGQ/z4bXw6cl5E
         7otSRxc1DT4sSsup0iVFnplot6G+UnhH32359xRvKKvOqC1UeAILMozJAK5Y6ckiKga2
         UvOxmT95a76Z5bLxO9Jg3M9PAq3mIHrSGiAX/uS6YEUUDt5rpwXm+ozUbdsjZFnchSuq
         mqMz6wvfYKKrt45/Q5ltQWoGEoQS/6nT6347LoJSqKE35wnP5hBOw1rrD1GxN4Bn0XO7
         Q9Dg==
X-Gm-Message-State: AG10YOQqG5c6K0v9E6DJIwBqKndyDCJOr3hNe+qxFBLG9pHuu+MiPBeEzqmg99NXJfiqcvp2/gxOZihh9k0+iA==
X-Received: by 10.25.5.6 with SMTP id 6mr16405532lff.3.1455236671062; Thu, 11
 Feb 2016 16:24:31 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Thu, 11 Feb 2016 16:24:01 -0800 (PST)
In-Reply-To: <xmqq60xy7u6u.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286023>

On Tue, Feb 9, 2016 at 4:45 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> This series brings three new options to shallow clone/fetch, to let
>> you specify cut point by time, or by excluding some refs, or to let
>> you extend shallow boundary by <N> commits.
>>
>> The series is now complete. Changes since v1 [1]
>>
>>  - smart http support
>>  - option names --not and --since are changed to --shallow-exclude
>>    and --shallow-since
>>  - fix the last patch per Eric's comments (the tests were totally
>>    broken but I didn't realize)
>>
>> The meat starts since 14/25. Before that is just cleanups and stuff.
>> Happy (shallowly) cloning!
>
> Nicely done.  While I had a few "Huh?" moments, and I still feel
> some changes are under-justified, it was a pleasant read overall.

Thanks. Will resend some time later.

> How extensively have you been using this, or is this hot off the
> press?

No I have not used it at all (can't use it for real when I can't
control the server side of github ;)
--=20
Duy
