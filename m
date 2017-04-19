Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFD521FE90
	for <e@80x24.org>; Wed, 19 Apr 2017 19:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030767AbdDSTJY (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 15:09:24 -0400
Received: from mout.web.de ([212.227.15.4]:58702 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S969152AbdDSTJW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 15:09:22 -0400
Received: from macce.local ([195.198.252.176]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MZlNu-1cjwaY40tS-00LRyw; Wed, 19
 Apr 2017 21:09:09 +0200
Subject: Re: [PATCH v3 1/2] use HOST_NAME_MAX to size buffers for
 gethostname(2)
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        David Turner <dturner@twosigma.com>
References: <20170418215743.18406-1-dturner@twosigma.com>
 <20170418215743.18406-2-dturner@twosigma.com>
 <20170419012824.GA28740@aiede.svl.corp.google.com>
 <c0333c81-d3b2-ca2d-a553-75642d8fb949@web.de>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <1b3e983f-4a70-652b-53f3-0c571c6efa1e@web.de>
Date:   Wed, 19 Apr 2017 21:09:06 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:45.0)
 Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <c0333c81-d3b2-ca2d-a553-75642d8fb949@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:9EZaDJ/zOZS2a5zxpBttPVpxzy2zZ562nzKGAj5of9deUkaLtda
 eIaDSzJVnCZ8QHgApHIcsMGH4JzuoFtdnVc/WvkOvZmr92fOzoEFbU7ICo2iRBDJ7lqaQgE
 FrwFNGJ4g8QQjepFNc/IKvYZLTgsPCegHyWpeEnZRpiwJMNEGpsBDSXdx317KORplWI3hk3
 skA3ZmqgoR1gYaCW5FOZQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UOvNcoKHecA=:sPIDGbgy8onn+RGKFxbLNv
 R31VJz4tL0mRPVEXaTQ+35lAkEaLnj8K86KGbk4DgphFq9q+e7iX/YkqiWduZA2tpddxSgh/O
 xhIUgZAXlabIN0LUoK5hBRIH2McnJjkIfILpt6EX67qYxhR3Avs+9EVVs7Y+zcgw3dctgAYh8
 JwSWyBWOTrdVV5FJNqVv+mRqy21K2SfUEjIzwZlM5O618uwZlj/M6mknhwHdXtFE37SYcDkyA
 iqL6EO6v+KhL5wZih8VMv9FqpmStjDR8RZXI4jyeNZYtq10JZaXOm88kc1SYrcOKbOWhYuxjS
 j+0cyqgaQAau0lvucn+hHnqn+5KvTuB6VXph4KmDe1Wg3pzA7s3jHRbt6wufnGFtgQmOc5pE3
 kPhtvj1QfVXgS6yHBuMwdoWBmQ/uUOkzzoEsZhRmfTFZ8yWd0NPWZ98aRUN0kfoXMgmXQz1ro
 EBzIwD3DpTcEgmPxLvKNGIMG9i1vQYrz9pFsrhG+Cub/7VVMhKXUEB+EbQN9ymoSsmhqbwC2K
 MHEicV4/SH2K+Ru/kt47RXESh8ugBZsEJQRrO6f2iHAYzLC+FUDEr3wDdc3GM+MBDxsdoo771
 Wm8XaTfq0gLtinVHroXMhzS4sEs/+JF4nCxu+sQ5ef6p4vL27mq+ivhJFK+lC3decg00EJPIT
 28Yf+p5ScthhzQQCc88N5j0A0pYT5qw93iQk8wlapuHNB+/c5h9SrVpipVnOIA2lU54/WgVpU
 sN7HbpkUn9F7dqscZUNYloh1CHi3tkc/SbRjmKTpcwXlPAgrJHVyAiVLOYsSzQYAleAecjkTD
 ESD5k8x
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-04-19 19:28, René Scharfe wrote:
[]
One or two minor comments inline
> diff --git a/builtin/gc.c b/builtin/gc.c
> index 2daede7820..4c1c01e87d 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -228,21 +228,99 @@ static int need_to_gc(void)
>  	return 1;
>  }
>  
> +struct pidfile {
> +	struct strbuf buf;
> +	char *hostname;
> +};
> +
> +#define PIDFILE_INIT { STRBUF_INIT }
> +
> +static void pidfile_release(struct pidfile *pf)
> +{
> +	pf->hostname = NULL;
> +	strbuf_release(&pf->buf);
> +}
> +
> +static int pidfile_read(struct pidfile *pf, const char *path,
> +			unsigned int max_age_seconds)
> +{
> +	int fd;
> +	struct stat st;
> +	ssize_t len;
> +	char *space;
> +	int rc = -1;
> +
> +	fd = open(path, O_RDONLY);
> +	if (fd < 0)
> +		return rc;
> +
> +	if (fstat(fd, &st))
> +		goto out;
> +	if (time(NULL) - st.st_mtime > max_age_seconds)
> +		goto out;
> +	if (st.st_size > (size_t)st.st_size)

Minor: we need xsize_t here ?
if (st.st_size > xsize_t(st.st_size))

> +		goto out;
> +
> +	len = strbuf_read(&pf->buf, fd, st.st_size);
> +	if (len < 0)
> +		goto out;
> +
> +	space = strchr(pf->buf.buf, ' ');
> +	if (!space) {
> +		pidfile_release(pf);
> +		goto out;
> +	}
> +	pf->hostname = space + 1;
> +	*space = '\0';
> +
> +	rc = 0;
> +out:
> +	close(fd);
> +	return rc;
> +}
> +
> +static int parse_pid(const char *value, pid_t *ret)
> +{
> +	if (value && *value) {
> +		char *end;
> +		intmax_t val;
> +
> +		errno = 0;
> +		val = strtoimax(value, &end, 0);
> +		if (errno == ERANGE)
> +			return 0;
> +		if (*end)
> +			return 0;
> +		if (labs(val) > maximum_signed_value_of_type(pid_t)) {
> +			errno = ERANGE;
> +			return 0;
> +		}
> +		*ret = val;
> +		return 1;
> +	}
> +	errno = EINVAL;
> +	return 0;
> +}
> +
> +static int pidfile_process_exists(const struct pidfile *pf)
> +{
> +	pid_t pid;
> +	return parse_pid(pf->buf.buf, &pid) &&
> +		(!kill(pid, 0) || errno == EPERM);
> +}
> +
>  /* return NULL on success, else hostname running the gc */
> -static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
> +static int lock_repo_for_gc(int force, struct pidfile *pf)
>  {
>  	static struct lock_file lock;
>  	char my_host[128];

Huh ?
should this be increased, may be in another path ?


