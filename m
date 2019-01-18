Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33FC41F453
	for <e@80x24.org>; Fri, 18 Jan 2019 09:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbfARJ0K (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 04:26:10 -0500
Received: from mout.gmx.net ([212.227.15.19]:56925 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbfARJ0J (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 04:26:09 -0500
Received: from [10.49.182.9] ([95.208.59.217]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M8laO-1gwYQs0ZZc-00C7hQ; Fri, 18
 Jan 2019 10:25:42 +0100
Date:   Fri, 18 Jan 2019 10:25:24 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Barret Rhoden <brho@google.com>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, David Kastrup <dak@gnu.org>,
        Jeff King <peff@peff.net>, Jeff Smith <whydoubt@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH v2 1/3] Move init_skiplist() outside of fsck
In-Reply-To: <20190117202919.157326-2-brho@google.com>
Message-ID: <nycvar.QRO.7.76.6.1901181024090.41@tvgsbejvaqbjf.bet>
References: <20190107213013.231514-1-brho@google.com> <20190117202919.157326-1-brho@google.com> <20190117202919.157326-2-brho@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:eteKNp1FzasPdxB1lWC+JfJ2wPjI0qFjfHmwTKFxgTCHw+c+OvH
 aAu9JIQHKXdD+F8iQaTRA33zPgS+od57/aNmjs4T9nVlhXXvUVdY/rGxa70hYmVNpnwUL5q
 KWegoo5iSj0psVL2iaFob6AkHuLWM+n3kcYaQAHz7rYQmc3mwtTO/3JICKo9QPdSnecNXJ6
 fMgFfARS+YGM7NdaKTw1Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PMbAs/thei8=:SrCMqZZMfqFHBMxBOed4P7
 kzvb3vrgB5xCafJuL+nwdCuUfXEQkIXcsYyWoe2YQ48IF2UP6IBEVYg1uwnjNr3CycrvMXqYz
 CeVPhMqyt6R+IYjFVXojggZocVwUzNcoCD/Vja36alBASkNBmBvzcFOIEQZ3ypxwSB3dEp/uh
 +lTZiVvsElxUvirD9g8T7qaZP1HgxgerAUsCbhqjQi/nOAs2mLIrce5w+i214lIzr06B4ADOx
 +/0AqDXxd+Wbp6/Uyf313BLsW7P37IN3h0Rh5ju/wC1GsKH/fC33gSVifmGXSgQD3c4pKArcY
 KrBjYAPFqWrRwrLzyRD5i3EReZ6YBPuNc/zlDwLwemAIklVolWnhrJyuf/M1uW+HJBD8t9L/H
 Zuc40feiHLJLTH3DAw3Fde9hyWhZdm3lDAINcg0i/NEMMsv/SMXDYchaSIcV1vj0BTufApV/c
 xtr0EtEFUadj+ow6sPqVkd6j9LIic5vNB+JJfi3vVmQ2TLFM2s8zbapmeqPj6vDOIRo58n+VK
 p9K432wdvqOOAHDvfEt2rUP+42pVkrKltYV2vQfzh6N+Bx4rhIBLpGYVUqeBSj6K06qXIi2T4
 Rhmtlx2T76rXHNOzqHrty0EMxXwtgd/totPvNxdwfks2T5ctyXfo028V9VOeZoQvrcXGEASSH
 tQZR0rxsYchrEkeHCavVEXNPqKr3XPrmR38+UcBYj6KH//5ZgAVTZbGAMcOjYmCBZCxwakW3a
 Y41cqaMuhslfbvxSVDfqaLM/4vaXgRQsROIMl1xQVBFwfzCRKXvQVpfcrHKh3u7NF5nSiqk+Y
 RnzBrr+ZTkbFD3ClgcFzEWi2xTACpH8pHQ/u1LVXc7NU9QlXlukMA/QqxUcl6CAJzxjxxKzJB
 lH6GtLvJhU9Gp4sz+a/oy6fhfclDYei2DPDA1M1cjb+ZEoS/kRDYE2BSSTGhCH7vP4SYwvlz4
 Fbk5P6rC8Og==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Barret,

On Thu, 17 Jan 2019, Barret Rhoden wrote:

> init_skiplist() took a file consisting of SHA-1s and comments and added
> the objects to an oidset.  This functionality is useful for other
> commands.
> 
> Signed-off-by: Barret Rhoden <brho@google.com>

This patch looks good, I have just one small suggestion: SHA-1's days are
counted. We already know the roadmap, that we want to use SHA-256 instead
at some stage. Why not talk about "object hashes" instead of "SHA-1s"?

Thanks,
Johannes

> ---
>  fsck.c   | 37 +------------------------------------
>  oidset.c | 35 +++++++++++++++++++++++++++++++++++
>  oidset.h |  7 +++++++
>  3 files changed, 43 insertions(+), 36 deletions(-)
> 
> diff --git a/fsck.c b/fsck.c
> index 68502ce85b11..80b53e6f4968 100644
> --- a/fsck.c
> +++ b/fsck.c
> @@ -181,41 +181,6 @@ static int fsck_msg_type(enum fsck_msg_id msg_id,
>  	return msg_type;
>  }
>  
> -static void init_skiplist(struct fsck_options *options, const char *path)
> -{
> -	FILE *fp;
> -	struct strbuf sb = STRBUF_INIT;
> -	struct object_id oid;
> -
> -	fp = fopen(path, "r");
> -	if (!fp)
> -		die("Could not open skip list: %s", path);
> -	while (!strbuf_getline(&sb, fp)) {
> -		const char *p;
> -		const char *hash;
> -
> -		/*
> -		 * Allow trailing comments, leading whitespace
> -		 * (including before commits), and empty or whitespace
> -		 * only lines.
> -		 */
> -		hash = strchr(sb.buf, '#');
> -		if (hash)
> -			strbuf_setlen(&sb, hash - sb.buf);
> -		strbuf_trim(&sb);
> -		if (!sb.len)
> -			continue;
> -
> -		if (parse_oid_hex(sb.buf, &oid, &p) || *p != '\0')
> -			die("Invalid SHA-1: %s", sb.buf);
> -		oidset_insert(&options->skiplist, &oid);
> -	}
> -	if (ferror(fp))
> -		die_errno("Could not read '%s'", path);
> -	fclose(fp);
> -	strbuf_release(&sb);
> -}
> -
>  static int parse_msg_type(const char *str)
>  {
>  	if (!strcmp(str, "error"))
> @@ -284,7 +249,7 @@ void fsck_set_msg_types(struct fsck_options *options, const char *values)
>  		if (!strcmp(buf, "skiplist")) {
>  			if (equal == len)
>  				die("skiplist requires a path");
> -			init_skiplist(options, buf + equal + 1);
> +			oidset_parse_file(&options->skiplist, buf + equal + 1);
>  			buf += len + 1;
>  			continue;
>  		}
> diff --git a/oidset.c b/oidset.c
> index fe4eb921df81..a4f38a040320 100644
> --- a/oidset.c
> +++ b/oidset.c
> @@ -35,3 +35,38 @@ void oidset_clear(struct oidset *set)
>  	kh_release_oid(&set->set);
>  	oidset_init(set, 0);
>  }
> +
> +void oidset_parse_file(struct oidset *set, const char *path)
> +{
> +	FILE *fp;
> +	struct strbuf sb = STRBUF_INIT;
> +	struct object_id oid;
> +
> +	fp = fopen(path, "r");
> +	if (!fp)
> +		die("Could not open skip list: %s", path);
> +	while (!strbuf_getline(&sb, fp)) {
> +		const char *p;
> +		const char *hash;
> +
> +		/*
> +		 * Allow trailing comments, leading whitespace
> +		 * (including before commits), and empty or whitespace
> +		 * only lines.
> +		 */
> +		hash = strchr(sb.buf, '#');
> +		if (hash)
> +			strbuf_setlen(&sb, hash - sb.buf);
> +		strbuf_trim(&sb);
> +		if (!sb.len)
> +			continue;
> +
> +		if (parse_oid_hex(sb.buf, &oid, &p) || *p != '\0')
> +			die("Invalid SHA-1: %s", sb.buf);
> +		oidset_insert(set, &oid);
> +	}
> +	if (ferror(fp))
> +		die_errno("Could not read '%s'", path);
> +	fclose(fp);
> +	strbuf_release(&sb);
> +}
> diff --git a/oidset.h b/oidset.h
> index c9d0f6d3cc8b..a3452eb7de84 100644
> --- a/oidset.h
> +++ b/oidset.h
> @@ -73,6 +73,13 @@ int oidset_remove(struct oidset *set, const struct object_id *oid);
>   */
>  void oidset_clear(struct oidset *set);
>  
> +/**
> + * Add the contents of the file 'path' to an initialized oidset.  Each line is
> + * an unabbreviated SHA-1.  Comments begin with '#', and trailing comments are
> + * allowed.  Leading whitespace and empty or white-space only lines are ignored.
> + */
> +void oidset_parse_file(struct oidset *set, const char *path);
> +
>  struct oidset_iter {
>  	kh_oid_t *set;
>  	khiter_t iter;
> -- 
> 2.20.1.321.g9e740568ce-goog
> 
> 
