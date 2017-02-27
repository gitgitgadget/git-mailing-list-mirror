Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7AF51F5FB
	for <e@80x24.org>; Mon, 27 Feb 2017 22:57:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751605AbdB0Wzd (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 17:55:33 -0500
Received: from mout.web.de ([212.227.15.14]:54448 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751344AbdB0Wza (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 17:55:30 -0500
Received: from [192.168.178.36] ([79.237.49.102]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MMFB7-1cfSyJ3XJN-0082pB; Mon, 27
 Feb 2017 23:54:23 +0100
Subject: Re: [PATCH 2/2] commit: don't check for space twice when looking for
 header
To:     =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>,
        Git List <git@vger.kernel.org>
References: <23989e76-24ba-90a4-91a9-9f66bfccb7c9@web.de>
 <b1d5c882-38b8-dd2d-2e5f-aafb8dfada81@web.de>
 <1dd0884c-032c-fb04-67f6-8b181fd65eea@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <cd9f3874-7428-9906-f805-31fe4661d4b6@web.de>
Date:   Mon, 27 Feb 2017 23:54:22 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <1dd0884c-032c-fb04-67f6-8b181fd65eea@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:sTzbJsCWCZt09/uMXBjJP9EJm3acw8hy5Q0uMjgF2+wkDk1OXC1
 6G7kVnYNg4b3lh52pf3sUaA7AltijklG2RsDJx0+DCle+B4wSb+KN0REHe6nTIZEREZHQ65
 R8yvCujzDxBwUoA/jeTKwzx+MLW/UNc8sODUGcTG4fkpbZWSf77owIBu/CsNIWQwxHZeNwM
 isS/bW4Hc60dVKBVhpzxQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:b7kIGwsNOrs=:XIan6auqb5aPgKQYb9+yG6
 4/bxuwFfnCDhJ5rpw1WV5TCu/0NImRbqycuYSbBMVaIt5Rlq2lKMBTSa+zYLSDFRxtHHZ9VOz
 vDRZoUzWq6OT1OY/eHwPHzQD5cqObXZDXE1mYXRbmpQVLQY0D4Y9OMDy+6Z1phijAc2qEHQxW
 qyDvCPIx7jnE+7cyiEk7ygF1u2HwKYOl5sfxM7WhLrCD5JFBwDt1Jz3uevC89AUNAlWwH94h/
 Y3d1KLjjFNKWn3e1X+x2eyq30JV5e7FSjKFc6jZI6AanuMytgHFnwGkz5Qi5hcn6J/G/IzD61
 lrY7KD6d/vrNU/XUOiZmiGTweCdLRk6r6uYxgcLIL+mD2KcRZ1nBFJRBpWntEQRBURCXh46uu
 EReuvrFHh8AuYQbNJ69TlH886dW076d7Z2A/a35UsxYkV63oBRsTkYSl7rSg3gjRkk2H0Vg2b
 yCBGOG2GnUm4+Z7Q5yC5mTumVF6pJxVduYV/Bc88Ktv0EkHdApoSoRg8FuZmeeU6Q1/pAZ3c/
 ATpKvIw4YvjPdI5p7JWCGZU283L2jvUoLsLRHK1s2PtwO3HxDSObhThUf9L3XOQptpsIps79C
 G4fIsXqndYj0NmZQwjJ22GKIHCB/N7RGDHMeoWGJ4ggbRzN9Py4ITmontBLCmMoDYCrD9h3cg
 f+ggeNpmQjmQ7Zg3zRRyZ9EquHQUlz13Ud0bqt8ypvuuKMXwlR+ZChY4MuOexQBDan7kL6dYJ
 mbFg40c5z6ONkWNkbTEXkOSnmGfpw5hezt8muoZHe13ZXNdK7TgskyF4EpQrf3163VKiAOUQP
 RIAd2nx
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 27.02.2017 um 23:27 schrieb Jakub Narębski:
> W dniu 25.02.2017 o 20:27, René Scharfe pisze:
>> Both standard_header_field() and excluded_header_field() check if
>> there's a space after the buffer that's handed to them.  We already
>> check in the caller if that space is present.  Don't bother calling
>> the functions if it's missing, as they are guaranteed to return 0 in
>> that case, and remove the now redundant checks from them.
>>
>> Signed-off-by: Rene Scharfe <l.s.r@web.de>
>> ---
>>  commit.c | 18 ++++++++----------
>>  1 file changed, 8 insertions(+), 10 deletions(-)
>>
>> diff --git a/commit.c b/commit.c
>> index 173c6d3818..fab8269731 100644
>> --- a/commit.c
>> +++ b/commit.c
>> @@ -1308,11 +1308,11 @@ void for_each_mergetag(each_mergetag_fn fn, struct commit *commit, void *data)
>>
>>  static inline int standard_header_field(const char *field, size_t len)
>>  {
>> -	return ((len == 4 && !memcmp(field, "tree ", 5)) ||
>> -		(len == 6 && !memcmp(field, "parent ", 7)) ||
>> -		(len == 6 && !memcmp(field, "author ", 7)) ||
>> -		(len == 9 && !memcmp(field, "committer ", 10)) ||
>> -		(len == 8 && !memcmp(field, "encoding ", 9)));
>> +	return ((len == 4 && !memcmp(field, "tree", 4)) ||
>> +		(len == 6 && !memcmp(field, "parent", 6)) ||
>> +		(len == 6 && !memcmp(field, "author", 6)) ||
>> +		(len == 9 && !memcmp(field, "committer", 9)) ||
>> +		(len == 8 && !memcmp(field, "encoding", 8)));
>
> I agree (for what it is worth from me) with the rest of changes,
> but I think current code is better self-documenting for this
> function.

Having a function that is given a buffer/length pair and accessing the 
byte after it raises questions, though. :)

Nicer than keeping the space would be to use excluded_header_field() for 
standard headers as well as a next step, I think -- but that would be a 
bit slower.

>
>>  }
>>
>>  static int excluded_header_field(const char *field, size_t len, const char **exclude)
>> @@ -1322,8 +1322,7 @@ static int excluded_header_field(const char *field, size_t len, const char **exc
>>
>>  	while (*exclude) {
>>  		size_t xlen = strlen(*exclude);
>> -		if (len == xlen &&
>> -		    !memcmp(field, *exclude, xlen) && field[xlen] == ' ')
>> +		if (len == xlen && !memcmp(field, *exclude, xlen))
>>  			return 1;
>>  		exclude++;
>>  	}
>> @@ -1357,9 +1356,8 @@ static struct commit_extra_header *read_commit_extra_header_lines(
>>  		eof = memchr(line, ' ', next - line);
>>  		if (!eof)
>>  			eof = next;
>> -
>> -		if (standard_header_field(line, eof - line) ||
>> -		    excluded_header_field(line, eof - line, exclude))
>> +		else if (standard_header_field(line, eof - line) ||
>> +			 excluded_header_field(line, eof - line, exclude))
>>  			continue;
>>
>>  		it = xcalloc(1, sizeof(*it));
>>
>
