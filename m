From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv3 09/13] submodule config: keep update strategy around
Date: Tue, 22 Sep 2015 08:50:12 -0700
Message-ID: <CAGZ79kYmz9+V8CUQhr3QsRdUkzi7ofMPK=qdXkW=o-+CToU1kw@mail.gmail.com>
References: <1442875159-13027-1-git-send-email-sbeller@google.com>
	<1442875159-13027-10-git-send-email-sbeller@google.com>
	<CAPig+cRGBSYbt6FsRwNR2TYz7vD650f3=KH_c87h27SaVCUTcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Jacob Keller <jacob.keller@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Vitali Lovich <vlovich@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Sep 22 17:50:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZePpp-0004U7-Hk
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 17:50:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758303AbbIVPuS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2015 11:50:18 -0400
Received: from mail-yk0-f169.google.com ([209.85.160.169]:36286 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758184AbbIVPuN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2015 11:50:13 -0400
Received: by ykdt18 with SMTP id t18so13439067ykd.3
        for <git@vger.kernel.org>; Tue, 22 Sep 2015 08:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=jfI9havdrgQiw6ZXAvD/ePHpHEh540euWaY/bfWfeFE=;
        b=cNytWvo8JZ/gKL72bkgoZXLNcay1pvj7wgzaZnT1o4p+kV5pSEXT/61A7RIDKZT1I8
         KLoZ3/hA6i3ZkRMpTwc65YyAWYFqISrN8bjjiAt1wqG2a/0gz9F8be3UVW4o9cgziF4u
         oHQ7ElcuVabyy4431xuyE9yeGbQeZd23hp3EXiUzimAwwuscdRJUrD6Mt7Ysf/QIi9Qr
         jITlGSMnyLT86zo26YZ2/ECUwsR1M6SinaGUnmUJ+aLduYQDrhkbgVjqijj01cGbv65H
         hNuaG7O/h3jjvvhahBLw4BAiYfy9f4Es1p+ctf7jkBKn05/Z7b8KSxbI0nYZzJ6PtlZ/
         AuCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=jfI9havdrgQiw6ZXAvD/ePHpHEh540euWaY/bfWfeFE=;
        b=il99LjXpjAQiEv47zbsD3gCnYYUXJk5VIpUAT5hXvByJEQWJrxyG8icgEXgdiKyrWF
         P6MizXAqKeourVwgd6H0O8Jrl9TusMYZwNVsZtCbHv1uHsIPZoxIzA5eisONiIxwYcFc
         UM2tnSdj3xENrCCFWWT114/2eVizO31voWanS4V01aCzur9lR4MhfNvbuokLcqgtLwl5
         u5knyOf1R4JBIfEotq1h3wkCoaoPCozCd0XvP+Ua+lmIo+m7fBJYlt9CFL9OKr+ikDCK
         UEK//rZ3RseNh4QPG8YT5nobN0FDO6izC8hKP7HJvij6wm0q3fXcRchWlCL+xUK2Xb4P
         8PHA==
X-Gm-Message-State: ALoCoQnuA0nA+ozmM/Q5cJcFE0AD4pCCRiw6s8xGcM7OV0f9vQCyNYHIv7qpPXkDdag3CT32ZoGd
X-Received: by 10.13.211.135 with SMTP id v129mr5011769ywd.129.1442937012183;
 Tue, 22 Sep 2015 08:50:12 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Tue, 22 Sep 2015 08:50:12 -0700 (PDT)
In-Reply-To: <CAPig+cRGBSYbt6FsRwNR2TYz7vD650f3=KH_c87h27SaVCUTcQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278394>

On Mon, Sep 21, 2015 at 5:56 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Mon, Sep 21, 2015 at 6:39 PM, Stefan Beller <sbeller@google.com> wrote:
>> We need the submodule update strategies in a later patch.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>> diff --git a/submodule-config.c b/submodule-config.c
>> @@ -326,6 +327,21 @@ static int parse_config(const char *var, const char *value, void *data)
>>                 free((void *) submodule->url);
>>                 strbuf_addstr(&url, value);
>>                 submodule->url = strbuf_detach(&url, NULL);
>> +       } else if (!strcmp(item.buf, "update")) {
>> +               struct strbuf update = STRBUF_INIT;
>> +               if (!value) {
>> +                       ret = config_error_nonbool(var);
>> +                       goto release_return;
>> +               }
>> +               if (!me->overwrite && submodule->update != NULL) {
>> +                       warn_multiple_config(me->commit_sha1, submodule->name,
>> +                                       "update");
>> +                       goto release_return;
>> +               }
>> +
>> +               free((void *) submodule->update);
>> +               strbuf_addstr(&update, value);
>> +               submodule->update = strbuf_detach(&update, NULL);
>>         }
>>
>>  release_return:
>
> Why the complicated logic flow? Also, why is strbuf 'update' needed?

To be honest, I just copied it from above, where the url is read using
the exact same workflow. In the reroll I'll fix both.

>
> I'd have expected to see something simpler, such as:
>
>     } else if (!strcmp(item.buf, "update")) {
>         if (!value)
>             ret = config_error_nonbool(var);
>         else if (!me->overwrite && ...)
>             warn_multiple_config(...);
>         else {
>             free((void *)submodule->update);
>             submodule->update = xstrdup(value);
>         }
>     }
