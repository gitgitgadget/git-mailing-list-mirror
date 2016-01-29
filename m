From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v2] convert: legitimately disable clean/smudge filter with an empty override
Date: Fri, 29 Jan 2016 19:55:36 +0100
Message-ID: <B8302383-658F-4FBD-965A-3330B9164A0E@gmail.com>
References: <1454055697-6742-1-git-send-email-larsxschneider@gmail.com> <1454055697-6742-2-git-send-email-larsxschneider@gmail.com> <xmqqh9hwjlha.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, tboegi@web.de, sunshine@sunshineco.com,
	peff@peff.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 29 19:55:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPECw-0002ZX-Pq
	for gcvg-git-2@plane.gmane.org; Fri, 29 Jan 2016 19:55:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932816AbcA2Szm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2016 13:55:42 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34338 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932495AbcA2Szl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jan 2016 13:55:41 -0500
Received: by mail-wm0-f68.google.com with SMTP id p63so11493537wmp.1
        for <git@vger.kernel.org>; Fri, 29 Jan 2016 10:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=references:mime-version:in-reply-to:content-type
         :content-transfer-encoding:message-id:cc:from:subject:date:to;
        bh=6Nk2RkzAyZdFykCC/1q9y2IiSQTKIIFKYDVShVgBY5Y=;
        b=pYhedQSsPhfkMGJAMmG53LZfzZ0ggbCVffWtrXFg4Ht3ks61DDTzeL6BimMazIpZTP
         i0EM9eDkjIks/lesnpI4nkOSeJCScQaWIYj5H9/6fL+jvRmkfnbf0vJnapdyhiLzNXh4
         dXYfO9rlgKbwZBITtg5Xw0jfnfDRsaALQnCRp9JECEsMpRck+jAbJG2h03ieHGgc0hwO
         /wLAb58GR+KA8eaqPWh1fOXONlsoX+9cu82m86psC5m9fR1WZ99ngtzJ2ihDfi5+jYZ0
         IJkV6iz5FnQLEcu6olk796I2i7CbgD9oaUYUZPdFY//3knbS1IudbKfo4GdffZpLKC23
         9xOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:references:mime-version:in-reply-to:content-type
         :content-transfer-encoding:message-id:cc:from:subject:date:to;
        bh=6Nk2RkzAyZdFykCC/1q9y2IiSQTKIIFKYDVShVgBY5Y=;
        b=f4O15S9htFJXHsQoKU+58Jw2aTzmEAuQ+SWNTnIIaz7pTi2lQVe9Zdj8zGymQxJzCk
         Hscsp5xakk0bz3hBL+YvzgmagIkFny11dQVh8y0yF4veQshTCn4M4lkP9gG2EJuXgDa8
         ei6xD92ZzuTq/1NbMZhKaVfaOnSrMM2BbQdvhPtBck4n0FAbBWGldWL8rz5zQ3cVkJKI
         vwgrfFE76bkZg59L3QRPOfViLbb1nt0K8WnmkFtlrlAQ1Lc+1JMP4Ah+gJ7yCCnhHf1r
         2ZLza3yNbFZ1D1EJC1qfLsG3wOsxuiTF+5PtPS6JalnV2JJTLWEuPvRQpc8d/6tzgqK9
         GmzA==
X-Gm-Message-State: AG10YOQuzo0s4sDmrAW96rYQxbPmKMCyst18J5cmpE+vEmOeEsn4ZnCrqJVPjBuZz0uhIQ==
X-Received: by 10.28.17.8 with SMTP id 8mr9992752wmr.65.1454093740389;
        Fri, 29 Jan 2016 10:55:40 -0800 (PST)
Received: from [10.22.142.121] (tmo-107-68.customers.d1-online.com. [80.187.107.68])
        by smtp.gmail.com with ESMTPSA id gl10sm16844673wjb.30.2016.01.29.10.55.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 29 Jan 2016 10:55:39 -0800 (PST)
In-Reply-To: <xmqqh9hwjlha.fsf@gitster.mtv.corp.google.com>
X-Mailer: iPhone Mail (13D15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285087>



> On 29 Jan 2016, at 19:20, Junio C Hamano <gitster@pobox.com> wrote:
> 
> larsxschneider@gmail.com writes:
> 
>> From: Lars Schneider <larsxschneider@gmail.com>
>> 
>> If the clean/smudge command of a Git filter driver (filter.<driver>.smudge and
>> filter.<driver>.clean) is set to an empty string ("") and the filter driver is
>> not required (filter.<driver>.required=false) then Git will run successfully.
>> However, Git will print an error for every file that is affected by the filter.
>> 
>> Teach Git to consider an empty clean/smudge filter as legitimately disabled
>> and do not print an error message if the filter is not required.
>> 
>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>> ---
>> convert.c             |  2 +-
>> t/t0021-conversion.sh | 16 ++++++++++++++++
>> 2 files changed, 17 insertions(+), 1 deletion(-)
>> 
>> diff --git a/convert.c b/convert.c
>> index 814e814..02d5f1e 100644
>> --- a/convert.c
>> +++ b/convert.c
>> @@ -395,7 +395,7 @@ static int apply_filter(const char *path, const char *src, size_t len, int fd,
>>    struct async async;
>>    struct filter_params params;
>> 
>> -    if (!cmd)
>> +    if (!cmd || !*cmd)
>>        return 0;
> 
> This is certainly simpler than v1.  I was initially worried about
> the fact that slightly changes the semantics around the "required"
> variable relative to v1, which said:
> 
>    if (ca.drv && ca.drv->clean && *ca.drv->clean) {
>            filter = ca.drv->clean;
>                required = ca.drv->required;
>    }
>    ret |= apply_filter(path, src, len, -1, dst, filter);
>        if (!ret && required)
>            die;
> 
> but in v2, this part of the code is just as before, i.e.
> 
>    if (ca.drv) {
>            filter = ca.drv->clean;
>                required = ca.drv->required;
>    }
>    ret |= apply_filter(path, src, len, -1, dst, filter);
>        if (!ret && required)
>            die;
> 
> So unlike v1, 'required' is set to true in the function, which is a
> good thing, but because in v2, apply_filter knows that an extrernal
> filter command that is an empty string is a no-op success, the above
> codepath behaves identically to v1 when observed from outside, i.e.
> "an empty string given as clean/smudge filter is a no-op success".
> 
> Good.
> 
> By the way, I find it somewhat annoying to see "legitimately" twice
> in the log message.  It makes it sound like there are legitimate way
> and not-so-kosher way to disable the filters.  Perhaps something
> like this instead?
> 
> -- >8 --
> convert: treat an empty string for clean/smudge filters as "cat"
> 
> Once a lower-priority configuration file defines a clean or smudge
> filter, there is no convenient way to override it.  Even though the
> configuration mechanism implements "the last one wins" semantics,
> you cannot set them to an empty string and expect them to work, as
> apply_filter() would try to run the empty string as an external
> command and fail.  The conversion is not done, but the function
> would still report a failure to convert.
> 
> Even though resetting the variable to "cat" (i.e. pass the data back
> as-is and report success) is an obvious and a viable way to solve
> this, it is wasteful to spawn an external process just as a
> workaround.
> 
> Instead, teach apply_filter() to treat an empty string given as a
> filter means the input must be returned as-is without conversion,
> and the operation must always succeed.
> -- >8 --

That reads perfect. I am sorry that I caused so much work for you with this patch. 

I really appreciate your editing as this helps me to improve my commit message writing skills!

Thanks,
Lars

> 
>> 
>>    if (!dst)
>> diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
>> index 718efa0..7bac2bc 100755
>> --- a/t/t0021-conversion.sh
>> +++ b/t/t0021-conversion.sh
>> @@ -252,4 +252,20 @@ test_expect_success "filter: smudge empty file" '
>>    test_cmp expected filtered-empty-in-repo
>> '
>> 
>> +test_expect_success 'disable filter with empty override' '
>> +    test_config_global filter.disable.smudge false &&
>> +    test_config_global filter.disable.clean false &&
>> +    test_config filter.disable.smudge false &&
>> +    test_config filter.disable.clean false &&
>> +
>> +    echo "*.disable filter=disable" >.gitattributes &&
>> +
>> +    echo test >test.disable &&
>> +    git -c filter.disable.clean= add test.disable 2>err &&
>> +    test_must_be_empty err &&
>> +    rm -f test.disable &&
>> +    git -c filter.disable.smudge= checkout -- test.disable 2>err &&
>> +    test_must_be_empty err
>> +'
>> +
>> test_done
