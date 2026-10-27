Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793125951;
	b=15FHWUKZnOW5MBc24VAeRsIgXuSSce/tilPxRSosXP0f2KE3t5eKZvcR+7pzOi4xOUku
	 c9uVAnf8RlpYSbh3J2LZ37Swhhn90IBzQFYsQaBqgSRvQGOZUDQD4ByCbgk2KbglaKeWp
	 C0akBH4lkwXfMDGK/I8K9yKVyG+GKsSJZ6DT7mBeTPq6+dLRPLeYK72/omLkWDORbQiNx
	 I+qqSbXKh1xWdf6GOH+xLt33s7pvyjooVsu3olZtjrMisGXSvlyX45fAdD9V23GuUQeef
	 8r/LaYYaIQu1Y4fjHly0DOGA+V4jIo/+wUTEYCto6LI1xTficPf1KPp2b9C8ggkYKlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793125951;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=qopBp0ww2IFAGw/4QfbAk8srNUp96H4WZNqtnCFGzVs=;
	b=tqOO1MyR6nyq+kb02Oz2hrB9vfwBUUf96V8Hmq+NpuS2rM/MPNgmuBRpAHiHLMEspSXg
	 kA3P+4XWsnC5SXjzfSdko7OllYjrHKDAgCNatFyIgfDz17q0FUysi+nThPPUR1QFCfcp9
	 lbABzXQhfNzqXeybc/MY96Idmb1HjvKNI4MzmkGKeGdsc3Fw98aSuB9PuTyxj/+usOBC9
	 zFzG6El9c5S7HMalOQ8Q7q/P7vwJwhpv7pt87IswhEHjqfrqhy+Jb2BQihgEZEuSuhy6e
	 UPVvUcmlyp0KU5254S3cL9zMp9gCL38RUXjBAK1gDcCxXv4ITmoDgSQUvvSQLF0xIUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="zKfTX/wM";
	arc=none smtp.remote-ip=209.85.161.50
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17357606A31A
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 18:32:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17357606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zKfTX/wM
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6d68de53053so159659eaf.0
        for <git@vger.kernel.org>; Tue, 27 Oct 2026 11:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793125950; x=1793730750; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qopBp0ww2IFAGw/4QfbAk8srNUp96H4WZNqtnCFGzVs=;
        b=zKfTX/wMhVQMMr19QEIj2QcUDm1y0Kf3RazvPQqpv0GS1wVSKtCZcY8o8iK5N28D2y
         SHiQ6aopcrWPi1fukVlXHzUbExsN7FN0TFOuas81P0YN7Iy6DUTcTq2qpUel0i6CoBOr
         DT7CaCKSzpMgR+wmmiU84L+dg+pDgPES4VQO0RPg7gAN0BITUdCawJJ303eQ+tdd0KmV
         EHEDtHoZeYmmxPzGb+iaPlsroR9orhnSnpwtd7s3ilX4mh77sOzHZ9sWnErKHxvCrZIU
         W9c3Mh76jZoEb1LyrSpEevOFpQK4tISjTuzE0K532p1WUvX3P4SVVJlYHWe5/0qJjhze
         OJAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793125950; x=1793730750;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qopBp0ww2IFAGw/4QfbAk8srNUp96H4WZNqtnCFGzVs=;
        b=1oGUCmYb5xURZ8wyHFR8fMgGNlXxqoUoqgx6rMa1ybAufQGmnzyuPPtIJTGgmpGrMH
         4uKqfktuFQe3vd5McIA8t1MRxCtgAtEKD2Bx+CNmNNrJ00EpcdR5eHamt1ol0tbfRDKG
         eejsfDo7XX2khT3uK4a9N3+joc9KETUWQKWt7Nw8cxIt8Kat243jRFW9GZABn0wx+iJ1
         EU5ECCcdSppEih5K8gWN3O6L4ILO1s8mPvTlDFQeGkuwJ8umYqnk5YXa1lKp/F7YDZ9i
         efIYwFVSdVwusQXPsPrqXjHQ7dtyvflN93qSVNJh6RCMnvkjEYnGUJOSpZcBa/chROeO
         7KTA==
X-Gm-Message-State: AFq9FYJUVBUsmuINf7Z1lSTGfbhUqVa8oO95nvcFmwNd80T80h0Fwvk0
	rQ4+JXUW6DbnZs/0xTepJmfl1QHKT5RJXJr6E8LNp4othxZ2M5sXal+ZnNHcfg==
X-Gm-Gg: AYBFou2L7KnHWvftFSn5/A4iDA0G8q6lE192mS9GGAkh5ZcWnt39VohjS2yes0aAuCb
	h066lD7uWYdL5C26pXuuXvFshvxW8GbjpaIww4Mu1P9sS2i1wWm/gaVCfIREWlhHyk6uyjKlOVl
	rX5N1C0Ja7bwYOCRUQH3kuyfgpkI1iPIi64uIVJsyvIpcb0p0rjqui2N1LlbtQfaYo7pH005FDd
	epTCTV0QQL+mw4pdxr6ZByBgALtPlt86ygYU/ILXAZJIaA7fjjMp68lkimDNLNRIVkHRrw7lI4k
	RSYn1OUAIAzWkKn1kGkKxysfjG9EKWovXauVgdQ81ITO71L25hl43BglfVov1QHece7uZdVzuke
	3k1Z6Am3ChwlyvhOenT+832V0tYAxmtZ2eLR5Ov+snO3N7Ji94xmIdhWSi1szM4f28dEs6kEH0B
	V0JL5dBGZnhfhYR7u6Sdnb6bLJfXxBDxBjefxK/O181iuxa/7WwtPuNz0iITL/yHXjQ/VJCwql4
	9148LO+7FWb9JYRcj89EGX36b7/hKmd8Xq2AYEPrq5TljJV1Fz/0U702Jwk64b7MhBgD4ujZXep
	b2gunw==
X-Received: by 2002:a05:6820:8585:20b0:6b7:46e9:96fa with SMTP id 006d021491bc7-70ba0e2d4acmr4057834eaf.42.1793125950043;
        Tue, 27 Oct 2026 11:32:30 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-70e1dd8712bsm6571339eaf.1.2026.10.27.11.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 11:32:29 -0700 (PDT)
Date: Tue, 27 Oct 2026 13:32:28 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im
Subject: Re: [PATCH v4 3/4] object-file: explicitly write ".keep" lockfile
Message-ID: <auDt1rq4a_ENlQiK@denethor>
References: <20261020132900.1208343-1-jltobler@gmail.com>
 <20261021182528.3055494-1-jltobler@gmail.com>
 <20261021182528.3055494-4-jltobler@gmail.com>
 <CAOLa=ZSdT2W19-Vg682iv6zhq6sEFM0+rHS-NqL=XQu--JOknw@mail.gmail.com>
 <auDsoWt5XVXw2hPN@denethor>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auDsoWt5XVXw2hPN@denethor>

On 26/10/27 01:26PM, Justin Tobler wrote:
> On 26/10/26 09:08AM, Karthik Nayak wrote:
> > Justin Tobler <jltobler@gmail.com> writes:
> > > +	if (write_in_full(fd, contents.buf, contents.len) < 0) {
> > > +		ret = error_errno(_("unable to write '%s'"), lock_path.buf);
> > > +		close(fd);
> > > +		unlink(lock_path.buf);
> > 
> > Should we use `unlink_or_warn()` here?
> 
> Ya, adding a warning here would probably be useful. I'll go ahead and do
> so in the next version.

I just noticed that this series was already merged to next, so I can
just send this change a separate patch.

-Justin
