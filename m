From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v7 09/11] config: add core.untrackedCache
Date: Tue, 26 Jan 2016 07:50:25 +0100
Message-ID: <CAP8UFD27UOh-ckA3-JPY6a7KAZHOOLv+j4TkBSp-EDZRwdcbKw@mail.gmail.com>
References: <1453649304-18121-1-git-send-email-chriscool@tuxfamily.org>
	<1453649304-18121-10-git-send-email-chriscool@tuxfamily.org>
	<xmqqio2hfku0.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Stefan Beller <sbeller@google.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 26 07:50:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNxSR-0001HP-LM
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 07:50:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754823AbcAZGu3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2016 01:50:29 -0500
Received: from mail-lb0-f182.google.com ([209.85.217.182]:36676 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754376AbcAZGu0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2016 01:50:26 -0500
Received: by mail-lb0-f182.google.com with SMTP id oh2so86519606lbb.3
        for <git@vger.kernel.org>; Mon, 25 Jan 2016 22:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=GuPKJHoYrHLE09LRAaYAcomA5/aldhvWJ/ZPFpRmuBI=;
        b=m9VmIRo7n8sP3CkHX38x4bVAxiBxKf0/4WcsVmZfQd1XEdXxodXfzLGt9kJdTej2hj
         dYI6c8KwTeb1Id18MBoCfG/IxI52KtdiFxs+AoI6mSa5lN9gSnoWxOzglTJ1MuknrhL9
         SedoKY9x89yi8K0aYI8FTXPH2s3+qGphHeLwP0GL4Y/WEZMzdWUSgJoi/CJ3CTKykZqv
         Rq/eqVu56IqyxRQANStJq7x1E1QPHvUidCGWJT93bq4zap/mk0Sma5BM/hFYcDghg1zR
         yh5HFqW2vHIPXml6ZJZbYEpgo97L0iBTVCL6pbFUwq/qOQ+BKuyp/FW413qnXRDQmFdZ
         VzAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=GuPKJHoYrHLE09LRAaYAcomA5/aldhvWJ/ZPFpRmuBI=;
        b=J5iQNfql74MdEIrJneO26wHVHBo+uLzUsQGU4qGrw2uJLnnxT7h4Rj+QFNTpWmLPSk
         jgY0nnOWJbJ+Pha9kTI6Is+g7fs7TD7rT9aBF2XsE83pRaG4MRq4mZXpyAgTwEe6SU4w
         ZlHiCBZACABrK2Y8peKeNB1eUx4oWBkc98qrBp84ugNXA6TVZBaGnX0ieM4asqddDYfI
         oF96KMo7E7e05yTGRc4w/SHGMfS6rFMLBhWTyl5TGlocIFGnwS2IvodEvzf+flP33Qeo
         02921T64v5yClXeCNyFWOh3ffjceUzlLx0tl9/Dngd0S1grInjXDgOgpdiUj4TLl2u/V
         /HRQ==
X-Gm-Message-State: AG10YOSUXmHqq82tKIfI2oc0ryJzdSOrGza2cZ30Kh4ci/oMhGlqhF01d8u0768UK2N7LKy2v6l8c+Y4+RNXMA==
X-Received: by 10.112.64.5 with SMTP id k5mr7900000lbs.133.1453791025644; Mon,
 25 Jan 2016 22:50:25 -0800 (PST)
Received: by 10.25.216.143 with HTTP; Mon, 25 Jan 2016 22:50:25 -0800 (PST)
In-Reply-To: <xmqqio2hfku0.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284782>

On Mon, Jan 25, 2016 at 9:47 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> diff --git a/read-cache.c b/read-cache.c
>> index 5be7cd1..a04ec8c 100644
>> --- a/read-cache.c
>> +++ b/read-cache.c
>> @@ -1497,10 +1497,23 @@ static struct cache_entry *create_from_disk(struct ondisk_cache_entry *ondisk,
>>       return ce;
>>  }
>>
>> -static void check_ce_order(struct index_state *istate)
>> +static void post_read_index_from(struct index_state *istate)
>>  {
>>       unsigned int i;
>>
>> +     switch (git_config_get_untracked_cache()) {
>> +     case -1: /* keep: do nothing */
>> +             break;
>> +     case 0: /* false */
>> +             remove_untracked_cache(istate);
>> +             break;
>> +     case 1: /* true */
>> +             add_untracked_cache(istate);
>> +             break;
>> +     default: /* unknown value: do nothing */
>> +             break;
>> +     }
>> +
>>       for (i = 1; i < istate->cache_nr; i++) {
>>               struct cache_entry *ce = istate->cache[i - 1];
>>               struct cache_entry *next_ce = istate->cache[i];
>
> Bad manners.
>
>  * The new code added to an existing function, unless there is a
>    good reason, goes to the bottom.  In this case, the verification
>    of the ordering of cache entries and tweaking of UC extension are
>    two unrelated things that can be independently done, and there is
>    no justification why the new code has to come to top.
>
>  * The old function name served as a good documentation of what it
>    does.  That is no longer the case.  Each unrelated segment of
>    this new function needs to be commented.  Even better, perhaps
>    leave the original check_ce_order() as-is, introduce a new
>    function tweak_uc_extension(), and make the post_read_index()
>    to be just two-liner function:
>
>         static void post_read_index(struct index_state *istate)
>         {
>                 check_ce_order(istate);
>                 tweak_uc_extension(istate);
>         }
>
>    That way the documentation value of each function that does one
>    specific thing and named specific to its task will be kept, and
>    there is no need for extra comments.

Ok, I will do that, thanks.
