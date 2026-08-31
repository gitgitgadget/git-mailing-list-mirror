Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DB13D903E
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 13:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788182874; cv=none; b=o7RAbam6KzQsho+ieOFPmo2vgfG5xDCh1LtMwXPJr9MYd55mMsMjU/ZLSVqlO31p93E0AJSeBl7/d8xnfjscpnbzooNSerMT/BUsapiidI1MQmA9OvWmXAJZsRbrVArlz3ilkTB64nIpRQ2WVrY3aZKdsidrTAkJPXHoDac/KFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788182874; c=relaxed/simple;
	bh=qawamj1swqv9yK/RXkXm2nSK9z++dlmmsKg1E8ZQtbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q/UfPaGlOtCnXKZ1XcqIdwcNic1/waDdpVXbrWxeHFxZZDh2J8r4y4wOVMMeBbk7m6I258s7+VtNL/lvasZzO8ClApMoWvrcdqkhs5QRomQPuB6F6kCrIZ5h4d8NwPTsrfbbQAQyabJXBCAB3gic15jd1YQS8v7UpVDH8OVHjZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RpivklZU; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RpivklZU"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-52cd38ddcdfso30638541cf.3
        for <git@vger.kernel.org>; Mon, 31 Aug 2026 06:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788182871; x=1788787671; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P0Js+shwjkSHsbP0XSKcHDajScxKZbFfYfudOtDCJXk=;
        b=RpivklZU+TUILUMDxcuhId1sZ/RAZ+zYHL9EEDtYQup+CuAcQFxPhFzPiUolmT941K
         oxtT1bw1Lv7Y0CtyJUPuOfYlIOU3lxo0/Gu+N9XrZpsgko7qDZeGb7f/9X86ZPBBYxPH
         gKbxUaraaFTuMzHG7q1Y119OoWNcPmJdW3XsEoUULoQAk208aKGCTsxMREbDb5SrH8+Y
         BMoYl7qp+KIxUzm4KcT/y6oXJcJLi2HKIcngl4QWHB7YXl/rHtJf8oT3VKFRO80Rbg9o
         jsvYY+LvThs7tF0oTfUx9WyAEM6IvSuDLy79vfZMhGfxIKEhRuxavKr3CjBg/wxnoxQq
         2+/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788182871; x=1788787671;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P0Js+shwjkSHsbP0XSKcHDajScxKZbFfYfudOtDCJXk=;
        b=Xzvd0hGsTbU/4YKpZxU+t1tJcI9JscqLExhfOjqjr2W0okX+XNqIPvqdP8qIYyIxR+
         gj1aY9g0DB+ew7YUK4WoXJL5oy3S7w0STnTYKYnzA+JDpShcfjxLMKAbaKsPVIOxiQw6
         rpOsMHCBGnU2kgvHHZDCCG+V+Cm4GEtlaGdM0E/ByN8DPBJ7je5od+OpippRVY8pyG4m
         J9ks+2deOX0pMU089uPfo0s1Ky/L3gkwtZnaRhI31Z8H/1CRRHlHiFkXNc3j2CzuLFVI
         TfOdp+Iq3Cwrvccz+EC9bUIu2C4/K40gLk54dgN63isl6n7yIQfe50WB2SFHmWrQdhSK
         XWYQ==
X-Gm-Message-State: AFuF++kpLPS9idUP7M7/R7GJBe7Pd9QJD4044fRk3CMRSbqBhotb7uok
	IC+u36hN/MKiup3lcf2QXgzFKCnVznqoJRsayEaoS7TN+KNaUs2ZoB7D
X-Gm-Gg: AR+sD11YRkk96B+G0sY8BE413pWdrK0GnQURTpfWyLqSsCFuuucNzHe/o/1bGIvAIZ1
	YhamdHoDVgw/oY5du4RLg/85Hej3cllYKlmcVuKew/ApARIQk7tJJL5uCN2Z2WNRFnu2iQI5doA
	lfXhIfc8W1sWAN75QGAv5+GNEkXKPu8lGDZCAdny/dwsxsUyddrETSMxzYIM2/nsBOXlGww/InQ
	9IK+5s6neKGxrcNfepd6PXFfuRpeoD+NG4zUsQpPRBgyaWxEGp+CX7jlsNDjUcHMSU+Zhr8SF9l
	74/cniK4ZCtULBwO2jdvGJyq00q/TdEEUQ/wibjKEGjrN1AzSZ9OXbULQ4v9y4ROWrtX/QUEjiG
	NA5R+mD/SXQL738RGkYvOF8M1vVRiryFK1Tq/4zZHGKICfE06YwycNfFyZ5Cojdk8xXzDMuMSVz
	46I+5iqUX2oy4r70YXvz/ZllX7sZCxugxBkRFAJsxjpks2JqUZvCrNBNS3lpjq9RhWbTnnGwo1n
	TFM0FetujcsglpxTJueaRF1uGisT5ANIlkmZY46jilJ2baCtggDjVUVgF25gjJ5nGjDVE/fQM6I
	9UnenpXztbMpXaJA
X-Received: by 2002:a05:622a:58f:b0:52f:b1b6:a4aa with SMTP id d75a77b69052e-53021b0f659mr9512381cf.4.1788182871094;
        Mon, 31 Aug 2026 06:27:51 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90ce8769b76sm75446546d6.13.2026.08.31.06.27.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 06:27:50 -0700 (PDT)
Message-ID: <a41bdb3b-1fe7-4c1e-9d16-72390d93503b@gmail.com>
Date: Mon, 31 Aug 2026 09:27:49 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] trace2: stop allowing die()
To: Jeff King <peff@peff.net>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, Taylor Blau <ttaylorr@openai.com>
References: <pull.2178.git.1784131932489.gitgitgadget@gmail.com>
 <pull.2178.v2.git.1787684181.gitgitgadget@gmail.com>
 <20260827052318.GC176544@coredump.intra.peff.net>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20260827052318.GC176544@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/27/2026 1:23 AM, Jeff King wrote:
> On Tue, Aug 25, 2026 at 06:56:14PM +0000, Derrick Stolee via GitGitGadget wrote:
> 
>> This starts with a new banned-die.h header file at the root of the repo and
>> including it from all trace2 API *.c files. It starts empty, but the later
>> patches will add one method at a time:
>>
>>  * xsnprintf() : This is the original patch, but made more complete by
>>    adding the method to banned-die.h.
>>  * xstrdup()
>>  * ALLOC_ARRAY()
>>  * xstrfmt()
>>  * ALLOC_GROW()
>>  * xcalloc()
> 
> OK. This feels like the tip of the iceberg, though. All of strbuf would
> have to be off-limits, too (both because it calls malloc directly, but
> also because it will bail if snprintf() returns -1). I won't be
> surprised if there are other indirect calls hiding in various places
> (e.g., all of json-writer.c).

You're absolutely right. Not only in json-writer.c, but several direct
calls to the strbuf API. The only real way to fix that would be to
create a "safe strbuf" library. This is potentially an interesting
direction that I might want to pursue and send an RFC after getting
started. 
> I think if you really want to avoid allocations in trace2 it would
> probably need to be a ground-up no-dependency rewrite.

Or to update the dependencies to be "safe". Not an easy thing, either
way.

I don't have much knowledge of CodeQL, but the following vibe-coded
.ql script is able to detect these transitive calls and demonstrate
the issue:

----

import cpp

class Trace2Function extends Function {
  Trace2Function() {
    getFile().getRelativePath() = "trace2.c" or
    getFile().getRelativePath().matches("trace2/%.c")
  }
}

predicate directlyCalls(Function caller, Function callee) {
  exists(FunctionCall call |
    call.getEnclosingFunction() = caller and
    call.getTarget() = callee
  )
}

from Trace2Function source, Function sink
where
  sink.getName() = "die" and
  directlyCalls+(source, sink)
select source, "This Trace2 function can transitively reach die()."

----

Adding such a check now would obviously fail and not provide any
ability to demonstrate incremental progress like banned-die.h.

I know that microsoft/git is running CodeQL analysis to look for
security issues [1] but doesn't appear to be running specific
queries like this one.

[1] https://github.com/microsoft/git/commit/6b367b94752b7ae0fada0629a542e90ea0a1892c

Perhaps this is something we could investigate in the future.

Thanks,
-Stolee

