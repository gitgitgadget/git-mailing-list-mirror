Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C3AE1F4F8
	for <e@80x24.org>; Sun, 16 Oct 2016 10:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755727AbcJPKGZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Oct 2016 06:06:25 -0400
Received: from mout.web.de ([212.227.17.12]:64682 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755686AbcJPKGW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Oct 2016 06:06:22 -0400
Received: from [192.168.178.36] ([79.197.211.11]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0MRl5x-1cO0iz3whl-00Sumy; Sun, 16 Oct 2016 12:06:05
 +0200
Subject: Re: [PATCH] avoid pointer arithmetic involving NULL in FLEX_ALLOC_MEM
To:     Jeff King <peff@peff.net>
References: <ccb15072-d949-fc84-ee45-45ba013f53c4@web.de>
 <20161015171325.k2jggjezfmhk3tz7@sigill.intra.peff.net>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <c99474f2-dac3-e42a-5e4a-02464cac3982@web.de>
Date:   Sun, 16 Oct 2016 12:06:02 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20161015171325.k2jggjezfmhk3tz7@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:iz4+GoYsdY7qanhQqHMQgwxu0+jNy8crspGi8J4t32JT+0UhVfM
 PD+oKvBnBKGyJWG6ZlPkZlM20eN88nHw4vDyKa+e3yDBAYyOPtnp9K8HmshzirtamE913gc
 95M20+u8w5OpJ/sLkzwnrt2RiBrGkMgLokBzb4rZh2TR/Nqq/aQ5sYHzkExto/FF4zegA5e
 K/7Zmewo8gds6GOi01Oqw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OBQ4dme6mXE=:FqeNV+541eC6IrsiThF8AU
 li4V8oN/E/JqD2FaOuISfqaGdkmntbKD9/nNRuWJ+LTyVC+ITJIDDgBsXxwUfMBfc00j31wlZ
 zJc/zXrH6+YSRBfO15VXJqU/lmo+qGzGuche0EOqwrAVaVlSgKv9DHQZBQkayDSj3G714ZapB
 cUPPkpdewWUtBhtmC8J7bPeMKZ4ln1UD2xE2R814C+IxYijGW+9hBwasHA29THwzBI93q8X7C
 EvDwA96MIGJljYIpONwZbXmr8tFHVtoCxoMSegZ6w8OVk/eYJTdRElp7YWetLC6z5e4e/66Ci
 K5kyqCg+lNwBeeczsazBM4/Rl0CAe6fIQbHBgW8A36G/OwK80oXXrXo0iqMgH1CV0dPTvXIDW
 yVAjCe4R9wsphKXKnpJJ3W8CA/3BBQh0/wL0QBtJs5+pABBkkZ8O9eLqZXPlPAL6FHFSBZGxW
 eln1zqMD2mHHEuNKF3oT/OIaVhv4/HmR4s7OiUrqBUU+rwf9SNcwIktOaHFjn4DVy2c6GjkDg
 8EXPGRKb9vrmVTk2nhE8+0GTDB6n/tciDa+KXdTG6VKZepujWVg0mS7M9XKEk5UOMZvQ9zdQj
 j2W7ul+6uu2PhU84eB1Ghd2hnYEqj5k0qVZRlhq2fkJZEWitS0I3/iSH6nEZhCLADmI/lUtIa
 dgRlbFmwErLH35dEaj2CLaXGmLLeZXd1EWj8lSl5z4pZtqmdYK0b8rFYcZFHQtvlYIy6ZLgiH
 ZVFCM+ZYJdi8vuy/705ucPTmZDmHo1B8YDo1zDid9EDmBghcS1byfUHkqOZ+bQpDriT1ekDse
 82sxBGQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.10.2016 um 19:13 schrieb Jeff King:
> On Sat, Oct 15, 2016 at 06:23:11PM +0200, René Scharfe wrote:
> 
>> Calculating offsets involving a NULL pointer is undefined.  It works in
>> practice (for now?), but we should not rely on it.  Allocate first and
>> then simply refer to the flexible array member by its name instead of
>> performing pointer arithmetic up front.  The resulting code is slightly
>> shorter, easier to read and doesn't rely on undefined behaviour.
> 
> Yeah, this NULL computation is pretty nasty. I recall trying to get rid
> of it, but I think it is impossible to do so portably while still using
> the generic xalloc_flex() helper.

The only way I see is to pass the type to the macro explicitly (because
typeof is an extention), and that would make call sites ugly.

>>  #define FLEX_ALLOC_MEM(x, flexname, buf, len) do { \
>> -	(x) = NULL; /* silence -Wuninitialized for offset calculation */ \
>> -	(x) = xalloc_flex(sizeof(*(x)), (char *)(&((x)->flexname)) - (char *)(x), (buf), (len)); \
>> +	size_t flex_array_len_ = (len); \
>> +	(x) = xcalloc(1, st_add3(sizeof(*(x)), flex_array_len_, 1)); \
>> +	memcpy((void *)(x)->flexname, (buf), flex_array_len_); \
> 
> This looks correct. I wondered at first why you bothered with
> flex_array_len, but it is to avoid evaluating the "len" parameter
> multiple times.

Right; we could drop that feature of the original macros and require
users to pass length expressions that don't have side effects -- all of
them already do that anyway.  But let's keep it in this round; it just
costs one extra line.

>>  } while (0)
>>  #define FLEXPTR_ALLOC_MEM(x, ptrname, buf, len) do { \
>>  	(x) = xalloc_flex(sizeof(*(x)), sizeof(*(x)), (buf), (len)); \
> 
> Now that xalloc_flex() has only this one caller remaining, perhaps it
> should just be inlined here, too, for simplicity.

-- >8 --
Subject: [PATCH 2/1] inline xalloc_flex() into FLEXPTR_ALLOC_MEM

Allocate and copy directly in FLEXPTR_ALLOC_MEM and remove the now
unused helper function xalloc_flex().  The resulting code is shorter
and the offset arithmetic is a bit simpler.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 git-compat-util.h | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index f964e36..49ca28c 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -856,7 +856,9 @@ static inline void copy_array(void *dst, const void *src, size_t n, size_t size)
 	memcpy((void *)(x)->flexname, (buf), flex_array_len_); \
 } while (0)
 #define FLEXPTR_ALLOC_MEM(x, ptrname, buf, len) do { \
-	(x) = xalloc_flex(sizeof(*(x)), sizeof(*(x)), (buf), (len)); \
+	size_t flex_array_len_ = (len); \
+	(x) = xcalloc(1, st_add3(sizeof(*(x)), flex_array_len_, 1)); \
+	memcpy((x) + 1, (buf), flex_array_len_); \
 	(x)->ptrname = (void *)((x)+1); \
 } while(0)
 #define FLEX_ALLOC_STR(x, flexname, str) \
@@ -864,14 +866,6 @@ static inline void copy_array(void *dst, const void *src, size_t n, size_t size)
 #define FLEXPTR_ALLOC_STR(x, ptrname, str) \
 	FLEXPTR_ALLOC_MEM((x), ptrname, (str), strlen(str))
 
-static inline void *xalloc_flex(size_t base_len, size_t offset,
-				const void *src, size_t src_len)
-{
-	unsigned char *ret = xcalloc(1, st_add3(base_len, src_len, 1));
-	memcpy(ret + offset, src, src_len);
-	return ret;
-}
-
 static inline char *xstrdup_or_null(const char *str)
 {
 	return str ? xstrdup(str) : NULL;
-- 
2.10.1
