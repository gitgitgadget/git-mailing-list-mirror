Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFCF41FE90
	for <e@80x24.org>; Wed, 19 Apr 2017 20:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967367AbdDSUDX (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 16:03:23 -0400
Received: from mout.web.de ([217.72.192.78]:54460 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966707AbdDSUDV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 16:03:21 -0400
Received: from [192.168.178.36] ([79.213.114.92]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Mb8sh-1cke7S0y1T-00Kgv3; Wed, 19
 Apr 2017 22:03:01 +0200
Subject: Re: [PATCH v3 1/2] use HOST_NAME_MAX to size buffers for
 gethostname(2)
To:     =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        David Turner <dturner@twosigma.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>
References: <20170418215743.18406-1-dturner@twosigma.com>
 <20170418215743.18406-2-dturner@twosigma.com>
 <20170419012824.GA28740@aiede.svl.corp.google.com>
 <c0333c81-d3b2-ca2d-a553-75642d8fb949@web.de>
 <1b3e983f-4a70-652b-53f3-0c571c6efa1e@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <7d075a07-edc9-83eb-25cf-7f8b13700584@web.de>
Date:   Wed, 19 Apr 2017 22:02:59 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.0.1
MIME-Version: 1.0
In-Reply-To: <1b3e983f-4a70-652b-53f3-0c571c6efa1e@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:Cr0Bw7GPAjLZ4Y7v1cCPPBmgz2Ms8xPT2EUGYi8s63R/nAItEX/
 opuwbY3eHqU+0gpIJ7LPXomMTtDOIQgi4sNDg+x0GkFv/wxqOtLj2U49yKxTJR3OyJg1lD9
 VxeVdxBwov8MzEz0NH8zGaVFnOuR8qqpXL0vEwbRLIjP5mh8M+wD0a5FGIChf5Tfx60Wblu
 /5DxXqcSdxcR7I1waEwlQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:W5kwL+r1WZ4=:ydTWwbLBQPxKcURDZVbFg+
 oOcJJ/kb1Zf9s0ibL+8vDMkvzpfT68QUEgUf3iFFhPrBbRrDpXBgb20vBJkvvla2ynHiGx1o6
 k7TScBdhKC+n+Oa4PVpHS1Wk5lPrGlwQkvDIVvzZ4M1rZx7J6Wf2nY2w8ifRfPylcsU8XhmE5
 HBeAqHJCWm6KHjGJfGiYzvx0VgrGEkgrvqcwTuodgaIVX6zP57/+hXLqWfJA1ZNLsShknEUHN
 VTDVH+amku3utvMKXmuO6fNzbh6Smd2WSMxzaCLkqPw58TktBkCDYpTGOV53m5fC43QQ1uuVr
 /0/BpExGT767r2NGeJoOmNcUgu62AIOJY6uQp4j+aybqytWJmfnuKyMARMbCB0I6cGxhRrVTC
 L7GSHIaupKq/nytUTjTGWyoXh9inyEUvbr+hWwJfqnnMlnuUJgi7xob1A98YV6HSF/IypRxC2
 9qU/1uAhtsTSx15bN2/5Q+Bw2CokV57IUXvN4AfG9jZxdfwff9o2QAyFy3QXZjFD0loJyz2iM
 3bHC8wn1txNie6+4lGfIPyRPusRUaSA1kdPhbiE2NoOS17fwSAVORdRtXvXIhCUh0R2esu2bf
 jKeZKeAl+J1/47YjrERwzMrRPBU0TYb5DFmmZaNJGurIAUxU+NbqZ1hxwTmn1FvrMLE2OxBve
 p21q0xO5arinoCAM51XDPMlx4t+lA4jvCYCfhXfgxG1WyQ8Q7lf0AbVZYwEusrI/RB7ceGW1e
 8IfGve4I9FUPhVtmEakzOp7uNVwcCEhznT8id8T6fbQ1rq/bxM0a1MHSYuRfsJBhPZDBowPbN
 CI4fFoh
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 19.04.2017 um 21:09 schrieb Torsten Bögershausen:
> On 2017-04-19 19:28, René Scharfe wrote:
> []
> One or two minor comments inline
>> diff --git a/builtin/gc.c b/builtin/gc.c
>> index 2daede7820..4c1c01e87d 100644
>> --- a/builtin/gc.c
>> +++ b/builtin/gc.c
>> @@ -228,21 +228,99 @@ static int need_to_gc(void)
>>   	return 1;
>>   }
>>   
>> +struct pidfile {
>> +	struct strbuf buf;
>> +	char *hostname;
>> +};
>> +
>> +#define PIDFILE_INIT { STRBUF_INIT }
>> +
>> +static void pidfile_release(struct pidfile *pf)
>> +{
>> +	pf->hostname = NULL;
>> +	strbuf_release(&pf->buf);
>> +}
>> +
>> +static int pidfile_read(struct pidfile *pf, const char *path,
>> +			unsigned int max_age_seconds)
>> +{
>> +	int fd;
>> +	struct stat st;
>> +	ssize_t len;
>> +	char *space;
>> +	int rc = -1;
>> +
>> +	fd = open(path, O_RDONLY);
>> +	if (fd < 0)
>> +		return rc;
>> +
>> +	if (fstat(fd, &st))
>> +		goto out;
>> +	if (time(NULL) - st.st_mtime > max_age_seconds)
>> +		goto out;
>> +	if (st.st_size > (size_t)st.st_size)
> 
> Minor: we need xsize_t here ?
> if (st.st_size > xsize_t(st.st_size))

No, xsize_t() would do the same check and die on overflow, and 
pidfile_read() is supposed to handle big pids gracefully.

> 
>> +		goto out;
>> +
>> +	len = strbuf_read(&pf->buf, fd, st.st_size);
>> +	if (len < 0)
>> +		goto out;
>> +
>> +	space = strchr(pf->buf.buf, ' ');
>> +	if (!space) {
>> +		pidfile_release(pf);
>> +		goto out;
>> +	}
>> +	pf->hostname = space + 1;
>> +	*space = '\0';
>> +
>> +	rc = 0;
>> +out:
>> +	close(fd);
>> +	return rc;
>> +}
>> +
>> +static int parse_pid(const char *value, pid_t *ret)
>> +{
>> +	if (value && *value) {
>> +		char *end;
>> +		intmax_t val;
>> +
>> +		errno = 0;
>> +		val = strtoimax(value, &end, 0);
>> +		if (errno == ERANGE)
>> +			return 0;
>> +		if (*end)
>> +			return 0;
>> +		if (labs(val) > maximum_signed_value_of_type(pid_t)) {
>> +			errno = ERANGE;
>> +			return 0;
>> +		}
>> +		*ret = val;
>> +		return 1;
>> +	}
>> +	errno = EINVAL;
>> +	return 0;
>> +}
>> +
>> +static int pidfile_process_exists(const struct pidfile *pf)
>> +{
>> +	pid_t pid;
>> +	return parse_pid(pf->buf.buf, &pid) &&
>> +		(!kill(pid, 0) || errno == EPERM);
>> +}
>> +
>>   /* return NULL on success, else hostname running the gc */
>> -static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
>> +static int lock_repo_for_gc(int force, struct pidfile *pf)
>>   {
>>   	static struct lock_file lock;
>>   	char my_host[128];
> 
> Huh ?
> should this be increased, may be in another path ?

It should, but not in this patch.

René
