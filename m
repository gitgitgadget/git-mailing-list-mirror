Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,FREEMAIL_FROM,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F0B320282
	for <e@80x24.org>; Fri, 23 Jun 2017 15:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754312AbdFWPUe (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 11:20:34 -0400
Received: from mout.web.de ([212.227.15.14]:53469 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750932AbdFWPUd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 11:20:33 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Luu81-1doiak1YUT-01054a; Fri, 23
 Jun 2017 17:20:23 +0200
Subject: Re: [PATCH] strbuf: change an always NULL/"" strbuf_addftime() param
 to bool
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <20170623144603.11774-1-avarab@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <a2673ce4-5cf8-6b40-d4db-8e2a49518138@web.de>
Date:   Fri, 23 Jun 2017 17:20:19 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20170623144603.11774-1-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:318tQEvo9eNQqWjORZv3rFg5Dn7qOPDVxD0D2lZCIKNbwlUrW3Y
 J417G2taDEppG9yWeud1Zmw5a7biXYUy5jyRgFulM5jIQGFWn44Ro2012F8mWBkDFt9pBTb
 KDfQGLbcLopSzGjdJwJ6S1nNDhTILnF35PEMDFzfnwHvN8L23YiUuvH0kQUTqp+b++ztpyY
 yvsHLqv0GXQQoZOZDV+ew==
X-UI-Out-Filterresults: notjunk:1;V01:K0:M0eLdpapc+g=:xDHoUADa+Tkyi4OnR2MKSN
 4qRYTNKjJa1658Ou7Nv/HSeQjE05Kh/dp7T8gWpL6kAbEluqJiUvFD8X3XR1ov4Lap+0gkD6Z
 EduBZwLtV3CmjFO1kbkvQ/I5ZOWHE3qT0CGeiUJ9UIG89Mj7uwbOU2iPgiuDdbDsJKDN6FQ/A
 g8T+2nApX/WkhIEnyvmqO0ZhtkbtBHgHgoEZ/nxJRiJNmYoDlGY60m1u2J0NA4hanCYBUY9vg
 iWHicKrEr267tMfnO+Dpw+IiHNDi7fbGPzT9sAMM17UjwpHJo5L+ktav2hl4SKbyvisx6zXRK
 5HoK/Rwd4ACKIWbvkg8pvqp3bLecBUHUggUy37hkFEE2Uu4R0/RLs9OK4k8392m1liBNlawuH
 P/1hW81hR518kTROiG8SYTLv63WOvxy+f7Z5raQTmAHQm0FS01lTYEif5Mpht9D2/BQ6KVEHG
 sD2E8wYQTeXSTp7UHOZMDhg4HsKGmcPGkCHJpVRgtZEnOIJ7rUj4TQbslSCBZdPCcbbE2E50t
 uSLdGsCQZWqFD9vzzzh4yYOlzOqo87uC4HY4QiUeQyrz5E3pPfVA4Wq90Xsp9kcdEtMSg5QVU
 Tzaj2N0v7R8u++VZBLneJB6mSxFS858KT7JRZ5a3/hfw7LWgeR9LlbbEbYON4Sye1Oj5KfXN+
 Jf/4regHWYVXBMPBXsOgR4Uwz0QJ0EdEWJVwUMVNPfjl3p95T1vmurWMIdsbxTS1pKcGDyz6J
 SMJfkZ/HVLDNpe2gmyCKoivhP8cizxu2nVrAwCF5UusqaOjZxh/T3bMXaoxkRA0z7DShcw7t9
 ewsLAHk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 23.06.2017 um 16:46 schrieb Ævar Arnfjörð Bjarmason:
> Change the code for deciding what's to be done about %Z to stop
> passing always either a NULL or "" char * to
> strbuf_addftime(). Instead pass a boolean int to indicate whether the
> strftime() %Z format should be omitted, which is what this code is
> actually doing.

"Omitting" sounds not quite right somehow.  We expand %Z to the empty
string because that's the best we can do -- which amounts to a removal,
but that's not the intent, just an implementation detail.  Calling it
"handling %Z internally" would be better, I think.

> This code grew organically between the changes in 9eafe86d58 ("Merge
> branch 'rs/strbuf-addftime-zZ'", 2017-06-22) yielding an end result
> that wasn't very readable. Out of context it looked as though the call
> to strbuf_addstr() might be adding a custom tz_name to the string, but
> actually tz_name would always be "", so the call to strbuf_addstr()
> just to add an empty string to the format was pointless.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>   date.c   | 2 +-
>   strbuf.c | 5 ++---
>   strbuf.h | 5 +++--
>   3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/date.c b/date.c
> index 1fd6d66375..5f09743bad 100644
> --- a/date.c
> +++ b/date.c
> @@ -256,7 +256,7 @@ const char *show_date(timestamp_t time, int tz, const struct date_mode *mode)
>   			tm->tm_hour, tm->tm_min, tm->tm_sec, tz);
>   	else if (mode->type == DATE_STRFTIME)
>   		strbuf_addftime(&timebuf, mode->strftime_fmt, tm, tz,
> -				mode->local ? NULL : "");
> +				mode->local ? 0 : 1);

I don't see how this is more readable -- both look about equally ugly to
me.  Passing mode->local unchanged would be better.

>   	else
>   		strbuf_addf(&timebuf, "%.3s %.3s %d %02d:%02d:%02d %d%c%+05d",
>   				weekday_names[tm->tm_wday],
> diff --git a/strbuf.c b/strbuf.c
> index be3b9e37b1..81ff3570e2 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -786,7 +786,7 @@ char *xstrfmt(const char *fmt, ...)
>   }
>   
>   void strbuf_addftime(struct strbuf *sb, const char *fmt, const struct tm *tm,
> -		     int tz_offset, const char *tz_name)
> +		     int tz_offset, const int omit_strftime_tz_name)

Why const?  And as written above, naming the parameter local would make
it easier to understand instead of exposing an implementation detail in
the interface.

>   {
>   	struct strbuf munged_fmt = STRBUF_INIT;
>   	size_t hint = 128;
> @@ -815,8 +815,7 @@ void strbuf_addftime(struct strbuf *sb, const char *fmt, const struct tm *tm,
>   			fmt++;
>   			break;
>   		case 'Z':
> -			if (tz_name) {
> -				strbuf_addstr(&munged_fmt, tz_name);
> +			if (omit_strftime_tz_name) {

Getting rid of this strbuf_addstr call is nice, but as Peff mentioned in
his reply it also reduces the flexibility of the function.  While it's
unlikely to be needed I'm not convinced that we should already block
this path (even though it could be easily reopened).

>   				fmt++;
>   				break;
>   			}
> diff --git a/strbuf.h b/strbuf.h
> index 4559035c47..bad698058a 100644
> --- a/strbuf.h
> +++ b/strbuf.h
> @@ -340,14 +340,15 @@ extern void strbuf_vaddf(struct strbuf *sb, const char *fmt, va_list ap);
>   
>   /**
>    * Add the time specified by `tm`, as formatted by `strftime`.
> - * `tz_name` is used to expand %Z internally unless it's NULL.
>    * `tz_offset` is in decimal hhmm format, e.g. -600 means six hours west
>    * of Greenwich, and it's used to expand %z internally.  However, tokens
>    * with modifiers (e.g. %Ez) are passed to `strftime`.
> + * `omit_strftime_tz_name` when set, means don't let `strftime` format
> + * %Z, instead do our own formatting.
>    */
>   extern void strbuf_addftime(struct strbuf *sb, const char *fmt,
>   			    const struct tm *tm, int tz_offset,
> -			    const char *tz_name);
> +			    const int omit_strftime_tz_name);
>   
>   /**
>    * Read a given size of data from a FILE* pointer to the buffer.
> 
