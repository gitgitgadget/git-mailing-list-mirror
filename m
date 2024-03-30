Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B551C0DFD
	for <git@vger.kernel.org>; Sat, 30 Mar 2024 13:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711806565; cv=none; b=PAQZyJsVXnk+zzQbBXnwNxkVHjxCYCzLQudMbQJcnQVv2Jph0n30lW0BI2mEcms6CnpVLDdnNm26/ke1dKh/EQknbioRgYtIdqpTki4QySIMZAUCLc7NfZhI6aYfSVdNPllxif/AkWBk30o5TRkYLavk/rs3n0c3FjIFg1TLekQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711806565; c=relaxed/simple;
	bh=rUed1b5X7EtNDbn4dThGn56vW27V/8ceD5sF0hiu4Po=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LqQnodxx+9ITCNQ5PX+7I/1kixJTXY4df1VStrpYhBAwczlHRqYs4o+1UnnVYEWNPJ3MTYEHrorjI5YLl1BFn2kpQSvwDKaS2lyzxq5O20UwIbovjr1XOgsrGY5jsf1ovJwT/sjbAlibT+jZj/eApFLSaN0B0TUrWCgOPFtlxAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aqcTJpRH; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aqcTJpRH"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41553f150b9so8899665e9.1
        for <git@vger.kernel.org>; Sat, 30 Mar 2024 06:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711806562; x=1712411362; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0lgBTNiMTwxWpwdN+JU/H4/jY6wvbebQKhSdY07PSRA=;
        b=aqcTJpRHr8/8cXkEqzTt+iGYhlGF50MvM/sUdADByaBSRtv3LVGecwGHcC4yX1Qv2u
         EiDUg3O5CYputNLc645j0AtO2WcCeUoGQOj1Rktbod0eXZJ8yjcmUqohAHcLDuzFNbur
         vH4jmOA3Z9VWQc4l+qwRwbv54rtsAjZqfEG4caqc3u0uHnMg96ZNMlsThoHP2cwZHlqj
         99QuGcofGbfRvkUgz/c8EeaMbhOAg4wQaFYwkNosVjf6vTX7698/fmmMW0L3swupAHNA
         lKRyby9vXIgbiZYhRnJmlDWG0hP/vlVYEsYsWjTi3quzag3knskpewLQE1uQKc90/FK6
         SEqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711806562; x=1712411362;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0lgBTNiMTwxWpwdN+JU/H4/jY6wvbebQKhSdY07PSRA=;
        b=Me6w9YCYjXdVaAR2hvuT0RLJb0oiK6+flHkSRNx0OoHw/wQGX28YUOyu0Hxm73ZNmO
         qwOL8rLC/AMUp39QxfGxPTtKbq5yGPlC0GItGyeiFzncVuKLxakNAXI3lA01jTatjsyt
         m3/WzkhfqXFwyZUNmTCMtJ+z/YMo2VDfBG6AZl8s2Uwye0Rbv4Kar0Z+FFu2yvhLX7Ea
         IQ7WB5AAG7Nz5EU7QMH1al+NHnbG0oYo6l8q+LjqYXAYL+kyz9N77Hz784aaoOKAMYAw
         dwkKWJxNMN64PDOKOK1Xmd2g609XbvPFjXZ1JSttothwcsVkO5FrjG8w+f+391EMwHf8
         f5Fw==
X-Forwarded-Encrypted: i=1; AJvYcCUuRLyq0DKFhzcipb1nf75ijj8E7bmeov5XNc0yNdTSnoPwpgPd6HOiQn45OzpqBNQJUwU9GxgfppQbTaBvwL2dGUP2
X-Gm-Message-State: AOJu0YzB3y0htxncqsXk/XRNezou2rR4OvVHNv8iP2Q+1o6WkpA6ybl9
	WqNovkX10OwYhaamxc3mi6wIk5o92qxecRf9pJjI+CcxhsgQch4D
X-Google-Smtp-Source: AGHT+IHhJUZlNkile6NkZoyRy/eqUQhr+OgH3DEfnCoH+hPAbhgeDySxvmq4zkpNzMZ+8v29depVIg==
X-Received: by 2002:adf:f482:0:b0:341:76bc:2bfe with SMTP id l2-20020adff482000000b0034176bc2bfemr3997995wro.4.1711806561952;
        Sat, 30 Mar 2024 06:49:21 -0700 (PDT)
Received: from gmail.com (40.red-88-14-45.dynamicip.rima-tde.net. [88.14.45.40])
        by smtp.gmail.com with ESMTPSA id cp32-20020a056000402000b00341c88ab493sm6534535wrb.10.2024.03.30.06.49.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Mar 2024 06:49:21 -0700 (PDT)
Message-ID: <903474de-0f95-4e7f-bedb-ddc445100aeb@gmail.com>
Date: Sat, 30 Mar 2024 14:49:16 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] improve interactive-patch
To: Dragan Simic <dsimic@manjaro.org>
Cc: Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood123@gmail.com>, Git List <git@vger.kernel.org>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <2c99dee8-fa6b-4f4f-93b4-3f7a8e0901f9@gmail.com>
 <6f2ed406-2152-476b-b463-3010afe7e11e@gmail.com>
 <59f19783-a663-449d-a1ef-3a9ebc43cc59@gmail.com> <xmqq5xx9dn6q.fsf@gitster.g>
 <eabf30e0-091e-475a-b59f-16b1091763ed@gmail.com> <xmqqcyrgajrp.fsf@gitster.g>
 <c19f444c-f4ad-497b-a82d-4f6195b44fce@gmail.com>
 <c9fc1de0f499a35d8dcc34666167050f@manjaro.org>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <c9fc1de0f499a35d8dcc34666167050f@manjaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, Mar 29, 2024 at 08:48:18PM +0100, Dragan Simic wrote:
> On 2024-03-29 20:26, Rubén Justo wrote:
> > On Tue, Mar 26, 2024 at 12:13:46PM -0700, Junio C Hamano wrote:
> > > > On Tue, Mar 26, 2024 at 08:31:41AM -0700, Junio C Hamano wrote:
> > > >
> > > >> 'r'edisplay may work well (and I wonder "r | less" or
> > > >> piping the hunk display to anything in general would be a useful
> > > >> future enhancement).
> > > >
> > > 
> > > It would be more like tweaking fputs() of a strbuf that
> > > was filled by render_hunk() to instead spawn a pager and feed the
> > > same strbuf to it, or something.  IOW, we already have the payload
> > > to show.  We just want a pager involved in its showing so that users
> > > with a huge hunk that does not fit on a page can use "less" on it.
> > 
> > I do not plan to address this in this series, but while the topic is
> > warm;  Perhaps?:
> 
> As a note, I find that having chunks displayed through the pager
> would be really nice.

I'm glad you find it useful.

I'm not going to include it in this series.  However, I've been using it
these days, and it's been fulfilling my needs.

I'm not sure of the implementation, though.

For a start, fputs_to_pager_or_stdout may be a better name, but ugly.

And "pager.h" may not be the right place to have it.

Perhaps something based on a strbuf is a better and more usable approach.

To name a few ...

> 
> > --- >8 ---
> > diff --git a/add-patch.c b/add-patch.c
> > index 778f168298..cb74fe84f5 100644
> > --- a/add-patch.c
> > +++ b/add-patch.c
> > @@ -5,6 +5,7 @@
> >  #include "environment.h"
> >  #include "gettext.h"
> >  #include "object-name.h"
> > +#include "pager.h"
> >  #include "read-cache-ll.h"
> >  #include "repository.h"
> >  #include "strbuf.h"
> > @@ -1450,7 +1451,7 @@ static int patch_update_file(struct add_p_state
> > *s,
> >  		if (file_diff->hunk_nr) {
> >  			if (rendered_hunk_index != hunk_index) {
> >  				render_hunk(s, hunk, 0, colored, &s->buf);
> > -				fputs(s->buf.buf, stdout);
> > +				fputs_to_pager(s->buf.buf);
> >  				rendered_hunk_index = hunk_index;
> >  			}
> > 
> > diff --git a/pager.c b/pager.c
> > index b8822a9381..f00fc87a67 100644
> > --- a/pager.c
> > +++ b/pager.c
> > @@ -264,3 +264,30 @@ int check_pager_config(const char *cmd)
> >  		pager_program = data.value;
> >  	return data.want;
> >  }
> > +
> > +void fputs_to_pager(const char* s)
> > +{
> > +	struct child_process process;
> > +	FILE* pager_stdin;
> > +	const char *pager = git_pager(isatty(1));
> > +
> > +	if (!pager) {
> > +		fputs(s, stdout);
> > +		return;
> > +	}
> > +
> > +	child_process_init(&process);
> > +
> > +	prepare_pager_args(&pager_process, pager);
> > +	pager_process.in = -1;
> > +	strvec_push(&pager_process.env, "GIT_PAGER_IN_USE");
> > +	if (start_command(&pager_process))
> > +		return;
> > +
> > +	pager_stdin = fdopen(pager_process.in, "w");
> > +	fputs(s, pager_stdin);
> > +	fflush(pager_stdin);
> > +
> > +	close(pager_process.in);
> > +	finish_command(&pager_process);
> > +}
> > diff --git a/pager.h b/pager.h
> > index b77433026d..dcccfa632b 100644
> > --- a/pager.h
> > +++ b/pager.h
> > @@ -11,6 +11,7 @@ void term_clear_line(void);
> >  int decimal_width(uintmax_t);
> >  int check_pager_config(const char *cmd);
> >  void prepare_pager_args(struct child_process *, const char *pager);
> > +void fputs_to_pager(const char* s);
> > 
> >  extern int pager_use_color;
