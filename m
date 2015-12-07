From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [RFC/PATCH 7/8] update-index: prevent --untracked-cache from
 performing tests
Date: Mon, 7 Dec 2015 06:40:14 +0100
Message-ID: <CAP8UFD0Dp9KD=EqjSC4O3Gz=QcY11BuN0YC0ChN7mMjWc1LMyg@mail.gmail.com>
References: <1449001899-18956-1-git-send-email-chriscool@tuxfamily.org>
	<1449001899-18956-8-git-send-email-chriscool@tuxfamily.org>
	<CACsJy8BhcrOz=JT=ESoG_Jgf=_4VP+kB7wGoofZ7LoVP_t4Vvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 07 06:40:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a5oXf-0004hM-66
	for gcvg-git-2@plane.gmane.org; Mon, 07 Dec 2015 06:40:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750977AbbLGFkR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2015 00:40:17 -0500
Received: from mail-lb0-f172.google.com ([209.85.217.172]:36391 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750819AbbLGFkQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2015 00:40:16 -0500
Received: by lbblt2 with SMTP id lt2so49939958lbb.3
        for <git@vger.kernel.org>; Sun, 06 Dec 2015 21:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=th5r20y3cIi/vT3pqoxQ2Tyx9UsqOOvb4h6Jwvgn6bk=;
        b=q6EDChzbO5gYeFYrd5HW2/uDEiIM27ukGxsr5yCcrZWlbB47yWhjzxpDoolqHooy90
         LVAB1CDHneaZMiGELxEpGcn9j76OXfJus2rIZF0vOu9qHwARk7M7ki1AV78gqbxt3bXm
         wjtcLAh0uqC/Pn+HiGj+OL5aaEIHvVSwQUI8O/D0bO6HTMGfsRbc+yQycWqwa9I/2Yws
         N2QFZR0sSlU/8UuGorcLQnCn3+z9rAvS4YKWpuQNZddVamT9wSplNYqjOlDCrSwBMshV
         +GqbPQGuGMj7sfnOZepzuuaFYx6/a7TgZcjiDA+UrrCaEWdMr0rkReEwTtDBl5ZM1U4z
         5Cbg==
X-Received: by 10.25.207.205 with SMTP id f196mr12698916lfg.124.1449466814242;
 Sun, 06 Dec 2015 21:40:14 -0800 (PST)
Received: by 10.25.152.7 with HTTP; Sun, 6 Dec 2015 21:40:14 -0800 (PST)
In-Reply-To: <CACsJy8BhcrOz=JT=ESoG_Jgf=_4VP+kB7wGoofZ7LoVP_t4Vvw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282080>

On Wed, Dec 2, 2015 at 8:18 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Tue, Dec 1, 2015 at 9:31 PM, Christian Couder
> <christian.couder@gmail.com> wrote:
>  diff --git a/t/t7063-status-untracked-cache.sh
> b/t/t7063-status-untracked-cache.sh
>> index 0e8d0d4..8c3e703 100755
>> --- a/t/t7063-status-untracked-cache.sh
>> +++ b/t/t7063-status-untracked-cache.sh
>> @@ -11,7 +11,7 @@ avoid_racy() {
>>  # It's fine if git update-index returns an error code other than one,
>>  # it'll be caught in the first test.
>
> Notice this comment. You probably have to chance --test-untr.. for the
> first test too if it's stilll true, or delete the comment.

Ok, I think I will remove the comment and still use "git update-index
--untracked-cache" in the first test.

>>  test_lazy_prereq UNTRACKED_CACHE '
>> -       { git update-index --untracked-cache; ret=$?; } &&
>> +       { git update-index --test-untracked-cache; ret=$?; } &&
>>         test $ret -ne 1
>>  '

Thanks,
Christian.
