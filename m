Received: from avasout-peh-001.plus.net (avasout-peh-001.plus.net [212.159.14.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D34255F31
	for <git@vger.kernel.org>; Thu, 22 May 2025 21:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747951002; cv=none; b=e3LkW5e33WOYsYefx8MWnPYM8e37CBJQs0BhsJsVrlxCI/czTLYfDcINrNMRYkQAtEkJs89aP0PQlhHFltEVF+dmy5urpzZDhawgCVQFdlA2Qv4M5iVTTdce5yxImJmXAEHxHHu1ee/SrRQZfLi/+AOvls15tD+U1lA1QDAryE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747951002; c=relaxed/simple;
	bh=/1+vqXi7f8cBVQNU766xTRtftjL7mBfaqTdQtqnOYdI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pgQwhft5YyYuzoB8TeS/3Ej3KGMiqkgKjfFbk8nVSpja7QBWv6cAatc7/+IlFX4U9n2getnOye/M3VWz3mezP7BDw05nLtAZcl4SiYwZUCOC8sZDwL067XF3qrsIRVOgg3PLpqpvrDYWnjuGL3rLebnHQq0jJIBp7onzlq+9W20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=nhFByBBG; arc=none smtp.client-ip=212.159.14.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="nhFByBBG"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id IDqxuC7mFUuMSIDqyukq7Z; Thu, 22 May 2025 22:53:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1747950808; bh=vWoEKu+2CFrpBYsYQ2dnpVN7BRKgTfQolhGGN99p+cQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=nhFByBBGm35ehLUYBsa+6w4c2Ap2Z5qLxGqo80Y+BLu0SAkj5RwKW7U/LwFeyPNSU
	 g/7w9Ob1f2q9QfmkCmVp1MLv33n8pnJpC0htvAv2tlvI1i49A85iWYKuvbTw6M4ix1
	 sE+YrW63hc57NTDAC8+D0t/K6pP7W8zmd4w2xhqvLCLOaUZN+hhh8TZkZkU8sTvwJb
	 BaYHMwa03VCnCswVcCz88G4luqxVWlVCuqWz1obasaERO9L8AkVFR+UTCnA7HGKQlX
	 aeRCDLdN8jcSBws9jjpVAOthtTFBi0RyN5AXginta8fdvPQJy22pGjvkGkCNGXFrYp
	 ewcd01YvHsndg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=K/eBHDWI c=1 sm=1 tr=0 ts=682f9cd8
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=iKrn8l-KAAAA:8 a=jgYHi3uYQLidFf0bK0QA:9 a=QEXdDO2ut3YA:10
 a=vz8bQswTWcriz0i0jksL:22
X-AUTH: ramsayjones@:2500
Message-ID: <2e8e7eb0-f526-49cb-8f75-379fa7ef6446@ramsayjones.plus.com>
Date: Thu, 22 May 2025 22:53:27 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/5] reflog-walk: expose read_complete_reflog
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, "D. Ben Knoble" <ben.knoble@gmail.com>
References: <20250508234458.3665894-1-sandals@crustytoothpaste.net>
 <20250522185524.18398-1-sandals@crustytoothpaste.net>
 <20250522185524.18398-4-sandals@crustytoothpaste.net>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <20250522185524.18398-4-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfJNXNNGq86wdHdWysWSwf85hqThPZ4PTtsVJQsTXD3GB6oMWEVlrwde4/J8xpFMQ4kB4aUHJmnffCJPwUxv+lBYp0r1e8KrKOmHWQ5tGgK2Hxco+8Pa8
 H7lKlEEZjMEzJwM2EmUUoUMLuL5UR+IvKJBgOv34LziHaRfRAUnjh00OPriQnAdvWjIDljUKZagC7j8ryDw5j8EIbYsCIPVCF28=



On 22/05/2025 19:55, brian m. carlson wrote:
> In a future commit, we'll use this function and the corresponding free
> function to read the entire reflog.  Expose it in the header so we can
> do so.
> 
> Include the appropriate header files so that our header is complete.
> 
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  reflog-walk.c | 17 ++---------------
>  reflog-walk.h | 18 ++++++++++++++++++
>  2 files changed, 20 insertions(+), 15 deletions(-)
> 
> diff --git a/reflog-walk.c b/reflog-walk.c
> index c7070b13b0..b7a9d70966 100644
> --- a/reflog-walk.c
> +++ b/reflog-walk.c
> @@ -9,19 +9,6 @@
>  #include "string-list.h"
>  #include "reflog-walk.h"
>  
> -struct complete_reflogs {
> -	char *ref;
> -	char *short_ref;
> -	struct reflog_info {
> -		struct object_id ooid, noid;
> -		char *email;
> -		timestamp_t timestamp;
> -		int tz;
> -		char *message;
> -	} *items;
> -	int nr, alloc;
> -};
> -
>  static int read_one_reflog(struct object_id *ooid, struct object_id *noid,
>  		const char *email, timestamp_t timestamp, int tz,
>  		const char *message, void *cb_data)
> @@ -41,7 +28,7 @@ static int read_one_reflog(struct object_id *ooid, struct object_id *noid,
>  	return 0;
>  }
>  
> -static void free_complete_reflog(struct complete_reflogs *array)
> +void free_complete_reflog(struct complete_reflogs *array)
>  {
>  	int i;
>  
> @@ -64,7 +51,7 @@ static void complete_reflogs_clear(void *util, const char *str UNUSED)
>  	free_complete_reflog(array);
>  }
>  
> -static struct complete_reflogs *read_complete_reflog(const char *ref)
> +struct complete_reflogs *read_complete_reflog(const char *ref)
>  {
>  	struct complete_reflogs *reflogs =
>  		xcalloc(1, sizeof(struct complete_reflogs));
> diff --git a/reflog-walk.h b/reflog-walk.h
> index 989583dc55..8f0640f662 100644
> --- a/reflog-walk.h
> +++ b/reflog-walk.h
> @@ -1,9 +1,24 @@
>  #ifndef REFLOG_WALK_H
>  #define REFLOG_WALK_H
>  
> +#include "git-compat-util.h"

Why? 'git-compat-util.h' must be #include-d in any compilation
unit before 'reflog-walk.h', so ...

(Sorry, I have not studied these patches, they were just floating
in front of my eyes ... so, please ignore me if the reason is
obvious! :) ).

ATB,
Ramsay Jones

> +#include "hash.h"
> +
>  struct commit;
>  struct reflog_walk_info;
>  struct date_mode;
> +struct complete_reflogs {
> +	char *ref;
> +	char *short_ref;
> +	struct reflog_info {
> +		struct object_id ooid, noid;
> +		char *email;
> +		timestamp_t timestamp;
> +		int tz;
> +		char *message;
> +	} *items;
> +	int nr, alloc;
> +};
>  
>  void init_reflog_walk(struct reflog_walk_info **info);
>  void reflog_walk_info_release(struct reflog_walk_info *info);
> @@ -24,4 +39,7 @@ int reflog_walk_empty(struct reflog_walk_info *walk);
>  
>  struct commit *next_reflog_entry(struct reflog_walk_info *reflog_info);
>  
> +void free_complete_reflog(struct complete_reflogs *array);
> +struct complete_reflogs *read_complete_reflog(const char *ref);
> +
>  #endif
> 

