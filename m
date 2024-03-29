Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE39F320B
	for <git@vger.kernel.org>; Fri, 29 Mar 2024 19:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711741705; cv=none; b=n5FGmcGNbGMs1OOvxxe1U+YsKhtpPSK6Mr0XILBwrcwB3y1wF4oK6FZCGS9cKEW41Vuu+GLcrro9/MmtVrRyTfIs+z9onEty8n4jkHZyWOYnVYTkt0anj8rJu5rfZZurpHY9o4wbCC96aB6mH3cvaaLan/supaM7Lno0/rq3FVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711741705; c=relaxed/simple;
	bh=aSupUPvBj6webblagZigvcpEyS3AedIhe7/jwARTFDY=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Ko82oOt9tdu7iaTBm5/oSTPSvuUmz2ApsswQvNl5Jo6/kZvlabNf9OxY4QcjWFL+NIdpe0IFJQ+5YbdvdV+A+ZD/NgxxfMggBBUHCYbh6nbo8c0qFdTBzTcN6V17r9aGtnD1alBWrFHjR/v5zks/CJ8wJltKGi1ea3YwBY8FBUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=aTNMNova; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="aTNMNova"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1711741699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oZcd9hB4RmH+202x3sZVVLyaV2AbliKb8wwG0dGI85w=;
	b=aTNMNovaYL/kHkFejfhbvVH8m7nAPiDvGRYEA84dUR4aG3OBOURYcH24fOUvC86EGUEzTY
	Mg6oCPQJsrm3dQsRYVIc+FlOEFaY58N8C3VsnSAYoVdyTSH6FA2tmLzoZfUPtgZbMPlzU3
	DL73K05IJJpymBH9p8L3aI7FQUyGat5WVhIqLqLHm+HAurLdJb5AB+i4JFjtLD7K9GOphJ
	HZPf11hwQY9yLqNUG3WoBokf+egYEEzcMkLwQkNgcwo+q32crYJ5YE1xdOVRGsluqhqQAt
	YcBAOr0f6DfLmUZNeuNR1Pfxvw3xm72AAzHq3krspSq7KOCeG3+ZL5YkoWNKXw==
Date: Fri, 29 Mar 2024 20:48:18 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Phillip Wood
 <phillip.wood123@gmail.com>, Git List <git@vger.kernel.org>, Johannes
 Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 0/2] improve interactive-patch
In-Reply-To: <c19f444c-f4ad-497b-a82d-4f6195b44fce@gmail.com>
References: <2c99dee8-fa6b-4f4f-93b4-3f7a8e0901f9@gmail.com>
 <6f2ed406-2152-476b-b463-3010afe7e11e@gmail.com>
 <59f19783-a663-449d-a1ef-3a9ebc43cc59@gmail.com>
 <xmqq5xx9dn6q.fsf@gitster.g>
 <eabf30e0-091e-475a-b59f-16b1091763ed@gmail.com>
 <xmqqcyrgajrp.fsf@gitster.g>
 <c19f444c-f4ad-497b-a82d-4f6195b44fce@gmail.com>
Message-ID: <c9fc1de0f499a35d8dcc34666167050f@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-03-29 20:26, Rubén Justo wrote:
> On Tue, Mar 26, 2024 at 12:13:46PM -0700, Junio C Hamano wrote:
>> > On Tue, Mar 26, 2024 at 08:31:41AM -0700, Junio C Hamano wrote:
>> >
>> >> 'r'edisplay may work well (and I wonder "r | less" or
>> >> piping the hunk display to anything in general would be a useful
>> >> future enhancement).
>> >
>> 
>> It would be more like tweaking fputs() of a strbuf that
>> was filled by render_hunk() to instead spawn a pager and feed the
>> same strbuf to it, or something.  IOW, we already have the payload
>> to show.  We just want a pager involved in its showing so that users
>> with a huge hunk that does not fit on a page can use "less" on it.
> 
> I do not plan to address this in this series, but while the topic is
> warm;  Perhaps?:

As a note, I find that having chunks displayed through the pager
would be really nice.

> --- >8 ---
> diff --git a/add-patch.c b/add-patch.c
> index 778f168298..cb74fe84f5 100644
> --- a/add-patch.c
> +++ b/add-patch.c
> @@ -5,6 +5,7 @@
>  #include "environment.h"
>  #include "gettext.h"
>  #include "object-name.h"
> +#include "pager.h"
>  #include "read-cache-ll.h"
>  #include "repository.h"
>  #include "strbuf.h"
> @@ -1450,7 +1451,7 @@ static int patch_update_file(struct add_p_state 
> *s,
>  		if (file_diff->hunk_nr) {
>  			if (rendered_hunk_index != hunk_index) {
>  				render_hunk(s, hunk, 0, colored, &s->buf);
> -				fputs(s->buf.buf, stdout);
> +				fputs_to_pager(s->buf.buf);
>  				rendered_hunk_index = hunk_index;
>  			}
> 
> diff --git a/pager.c b/pager.c
> index b8822a9381..f00fc87a67 100644
> --- a/pager.c
> +++ b/pager.c
> @@ -264,3 +264,30 @@ int check_pager_config(const char *cmd)
>  		pager_program = data.value;
>  	return data.want;
>  }
> +
> +void fputs_to_pager(const char* s)
> +{
> +	struct child_process process;
> +	FILE* pager_stdin;
> +	const char *pager = git_pager(isatty(1));
> +
> +	if (!pager) {
> +		fputs(s, stdout);
> +		return;
> +	}
> +
> +	child_process_init(&process);
> +
> +	prepare_pager_args(&pager_process, pager);
> +	pager_process.in = -1;
> +	strvec_push(&pager_process.env, "GIT_PAGER_IN_USE");
> +	if (start_command(&pager_process))
> +		return;
> +
> +	pager_stdin = fdopen(pager_process.in, "w");
> +	fputs(s, pager_stdin);
> +	fflush(pager_stdin);
> +
> +	close(pager_process.in);
> +	finish_command(&pager_process);
> +}
> diff --git a/pager.h b/pager.h
> index b77433026d..dcccfa632b 100644
> --- a/pager.h
> +++ b/pager.h
> @@ -11,6 +11,7 @@ void term_clear_line(void);
>  int decimal_width(uintmax_t);
>  int check_pager_config(const char *cmd);
>  void prepare_pager_args(struct child_process *, const char *pager);
> +void fputs_to_pager(const char* s);
> 
>  extern int pager_use_color;
