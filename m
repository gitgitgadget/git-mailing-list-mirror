From: =?UTF-8?Q?Felipe_Gon=C3=A7alves_Assis?= <felipeg.assis@gmail.com>
Subject: Re: [PATCH v2 0/5] Tests and fixes for merge-recursive rename options
Date: Mon, 22 Feb 2016 19:37:32 -0300
Message-ID: <CALMa68pYL+x62zOKKrwS9VtH8Qm=-hbzARHN1kJ+4t-Hz+TpAA@mail.gmail.com>
References: <1456095545-20201-1-git-send-email-felipegassis@gmail.com>
	<xmqqpovo5ul2.fsf@gitster.mtv.corp.google.com>
	<CALMa68qmGie+AHOWZ=BKHZOeSK9K4djiHRuooCz2h72rNZg7_A@mail.gmail.com>
	<xmqqwppw4bvw.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?Q?Felipe_Gon=C3=A7alves_Assis?= <felipegassis@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 23:37:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXz6w-00088t-0C
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 23:37:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756223AbcBVWhk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Feb 2016 17:37:40 -0500
Received: from mail-io0-f176.google.com ([209.85.223.176]:36047 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755725AbcBVWhc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Feb 2016 17:37:32 -0500
Received: by mail-io0-f176.google.com with SMTP id l127so193636391iof.3
        for <git@vger.kernel.org>; Mon, 22 Feb 2016 14:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=ZvD/cbC3yd7XC13M9SixNiiZWDUSItcw95CUmEWjdG4=;
        b=bkz6eHb1jcQkLuv8aIj2EFUYvYJYOrLI/hzs2bPw/Tm0SCXxDGcNLFuBe/dQEXqqwN
         JDkHQY8rAPXAeDt0J+K8iUmEb+4JWMgRC0MtcIZZ63T4w+nC6mvWcmb9FqG5yvX/4uN5
         kRa3KfRVy2tS77ALLYuE43s77SiFZ3/qBxUd62tCycwcVzxf5sKSbUTt+oHMeyFsZ0M0
         kg2357TpwLmHWWJrZgwGyjtLKenKN4Q3sPptdfHB/7yXnWW9ev5smK8eV+p1SERHJE7N
         igi46I5jnKe0GLah8GYlRl2KbXHSITRt8OBCJqMrZWt3jJdq8LV4TDHS81CcFxtFIQJ7
         1HvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ZvD/cbC3yd7XC13M9SixNiiZWDUSItcw95CUmEWjdG4=;
        b=CSD+PQ4a8e5B32jRikPXSY5XjIGMM54Jl7sOr9BOAHY7zp9iHG3NIcMyIIV/6vfoy9
         l5XeflphTT8IAld0cOn9Idv54ewgLSWkfgR2c8/zWruXndz9wWAznpMq8j46UdlXFzXn
         ogdLimXiZW3KdCDx0tS+v/qY0h7n5okt4OQrG7l9Muf82fPc1Exc6pEVpduAsmJJtKo+
         4KwnaekPJfgsnroySy7lTP9SRFHDt/SBzmi1Wu9qLReUa7Vpj+t2JSGje3jtYm0mhepB
         DlqgtMtFp48i+hQUBrOk4NWqmNQrw1GpBvCYU6inR2t2fvoGCakiJg5xe5zbK8UAZuX2
         ZgXA==
X-Gm-Message-State: AG10YORsMc8fRitwfSmjO3hFrSukefjUx3zAq8Gemb2zAOkVj63cYT9OVv4eptlcoK4KXP8lzTBvWDMgRZEDsg==
X-Received: by 10.107.157.18 with SMTP id g18mr30558319ioe.151.1456180652304;
 Mon, 22 Feb 2016 14:37:32 -0800 (PST)
Received: by 10.107.3.94 with HTTP; Mon, 22 Feb 2016 14:37:32 -0800 (PST)
In-Reply-To: <xmqqwppw4bvw.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286969>

On 22 February 2016 at 19:29, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Gon=C3=A7alves Assis <felipeg.assis@gmail.com> writes:
>
>>> As I said, I am reluctant to take the 25%/50%/75% tests in their
>>> current form.  Let me take the first one and a half of the last one
>>> (i.e. excluding the test) for now.
>>>
>>> Thanks.
>>
>> Ok, should I post a new version of the patch without the tests while=
 I
>> rework them or does that mean that you have already filtered them ou=
t
>> locally?
>
> I already have and queued them tentatively as
>
>     c443d39 merge-recursive: find-renames resets threshold
>     83837ec merge-strategies.txt: fix typo
>
> but they haven't been merged to 'next', so it is up to you whether
> you rebuild the remainder on top of c443d39 or redo these 5 patches
> altogether (just tell me to drop these two if you go the latter
> route).
>

My original patch started with exactly those commits and then added
the tests, so it is fine for me.

The motivation for the reorganisation was bundling the relevant test
with the fix, but then it might be better to publish the fix soon,
right?
