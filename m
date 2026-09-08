Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446ED49891F
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 23:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788908703; cv=none; b=TAftZO+0+6NcCaoy76BoD9rX9CZqHAMp/X+41pJ9oYMx9zcNyn3H4CsZrvOom1I08PFewczQc+QEHWLW6u+/w+IXoRi/kqjg3p+y+DEAX7tufG8j3CfDtl2csQTYER7aQlYEMPjr2XIZMnqgS2Y2eqCWMXw5ymuMfctz/WXmDoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788908703; c=relaxed/simple;
	bh=doWyeND1wyv6pkbqL/NJNNZyGlIuLcC0eJJbfQ7yv+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pRKu/pTMR17GDV+r77JaRT3evwAP3fki0zcRQUZXBVnjDJS8gtuc651ZxoV+QZOFZc7VFdLPmH1wOSZAAkE25HnI5MLMY9ZZ4XymGbIhfzRg2CdAK8UhMAPrpPdo0SvVquvMS/TEF4GEaHeSobm0DMSLOsTindlnVEQmVa4h4Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VYUvkoSb; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYUvkoSb"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6b1b766bf01so2251260eaf.0
        for <git@vger.kernel.org>; Tue, 08 Sep 2026 16:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788908701; x=1789513501; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=u+bBIXAmwl8PVh2+EnW0TK8+Q8PssfzaKhQHboxN1/w=;
        b=VYUvkoSbtQ28AWR85G4vt8fynQPT6zGH2suWjnVYAIMXWXwt0Bo9ItGpjVq/dNjALw
         hdx60RO0VocMAVNCiRhgSpEnBMTnxmUMzsBdjnnRMQNbZ7cKkbLyXDFxF1EhT650UaHl
         MUyecI4d4uRvdEDvrr3jOKdj4oWhEcYaWYUbqWvKDMdkn47+wLUr5uDASo8EKMZLAVXQ
         /NCEw1jolpFMbozpAXFthd8sp+IaT93WFbOKAdqFwrsPw88gWM09WKC/A/Dtv7E0vLYH
         Hmr421NFn2DV5gwUpZUW6C9SCM+gcBiVC37rw2ckThv39PjqVCTquRzWGgGrCCQ1rKkc
         FopQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788908701; x=1789513501;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u+bBIXAmwl8PVh2+EnW0TK8+Q8PssfzaKhQHboxN1/w=;
        b=mITBL+9lk0W50J7nHvIxFSdgGd/G8ymgnNrPwUgSTO7zC3T0lj/GPZGejJQgAp3GLb
         NPkztid5CJCtNpIHYC7TFyuLt9vrQAhxA1nJ9wh6yuXqOBMo3KO1gO+TysNMkHkPpwfZ
         rvCKHRpipwplpw24AzGK3gZmFbVuyp69lr5j2XnqRyRMZEM6dTYklzYD+A5uasll2LCt
         IpygWCurEuEaYiD9z+gCrmUtcNc13gqGkuk412LaqrQCUAvBI0LDdfLwd1Emah0sW7hh
         7gYCpgk8lcSCjgyov3URagjEPr890OnTx7nLs2NjroNh/OwoZheBLgYz/6qvvr6agxhT
         FvdA==
X-Gm-Message-State: AFuF++kvM+WtbB+TYBQJ2PVphWz72f+DMcLqLYynj5squIMLr59o4xyg
	P5iWUYR7vKoGBmduxxDcLHpdWqSaNSb7glAaZekEAGFeTzyCS0+IsD6HdiED3A==
X-Gm-Gg: AYBFou2BYE31oJnObrElz+4N1kZL238oBwv1wLZo461x3AW2YS0x9AZe/cBpOKr43fV
	WMFOqgp9Eb8StXTNLAzGajcJMkCNQOuEfH1aerpw7TKeAFZwbE1LWsdg6NRS+Tg+am3BAwV7mG3
	6OKfbvK/8LDd2HHwrqsYOLUqRwjVYFqZ6iazXodVclkIAkSgto0/bEmgO6lkx2M9ByPdcVv8vc7
	DbB2nh3OgB0tpDdwg+Vv4vTncKVN64KD44YvkzpdoFjKY3z+2CS/1mH0TjL7ErrzphLyiqk9280
	WeUql6Bq4TIEYGt1C9p1HoQuS8KKgTF0r8Mi3KzJIzKqMfZqePdpW/IxMpuG1WvZYD4kRY93wPH
	3fnXz0Y6mnTkZwFkWgVay5AZrMEK3G13UjNQLS4Y+wStmYcXTAvnBsq02gNxcsNc/sCIZYDl3fK
	mVRkl2UeNXccOWMns1cz4X8IA/RwANLjLGTjqCIFQXGydizxsD58qgy9XyueqpdH85JOHfdW9ZC
	k9O1hWEBizi+w==
X-Received: by 2002:a05:6820:823:b0:6bd:df1c:23b1 with SMTP id 006d021491bc7-6bddf1c269emr1241058eaf.15.1788908700862;
        Tue, 08 Sep 2026 16:05:00 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-475501412f2sm14040144fac.0.2026.09.08.16.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 16:05:00 -0700 (PDT)
Date: Tue, 8 Sep 2026 18:04:54 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 05/13] submodule-config: stop registering submodule
 sources
Message-ID: <aqCTAXB3AbGW8Dt8@denethor>
References: <20260902-pks-odb-registering-in-memory-sources-v2-0-c6ca12fdea4d@pks.im>
 <20260902-pks-odb-registering-in-memory-sources-v2-5-c6ca12fdea4d@pks.im>
 <ap2wj0vK0-VUvaW5@denethor>
 <ap5sqR6RBamJjEeP@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ap5sqR6RBamJjEeP@pks.im>

On 26/09/07 09:50AM, Patrick Steinhardt wrote:
> On Sun, Sep 06, 2026 at 01:38:15PM -0500, Justin Tobler wrote:
> > On 26/09/02 03:34PM, Patrick Steinhardt wrote:
> > > When reading the ".gitmodules" file from a blob in a repository other
> > > than `the_repository`, we register the repository's object database as
> > > an in-memory source of `the_repository`'s object database. This call has
> > > its origins in d9b8b8f896 (submodule-config.c: use repo_get_oid for
> > > reading .gitmodules, 2019-04-16): back then, `config_with_options()` was
> > > not able to read a blob from an arbitrary repository, but would always
> > > read it via `the_repository`. So even though the blob could be resolved
> > > in the submodule repository via `repo_get_oid()`, the submodule's object
> > > database had to be registered as an in-memory source of `the_repository`
> > > so that the subsequent object read was able to find the blob at all.
> > 
> > Ok, so IIUC the problem was that a gitmodule blob from a repository that
> > is not "the_repository" would fail to be read by `config_with_options()`
> > because it would only read objects from "the_repository". The workaround
> > was to add the other repositories as another source to ensure the
> > gitmodule blob could be read. I had to reread the commit message a
> > couple of times to follow, but I think it makes sense now.
> 
> Yes. Do you think I should rewrite the commit message to make it a bit
> less dense? Otherwise I'll leave it as-is for now.

It is a little dense. I think it is a bit confusing which "repository"
we are talking about in the first paragraph. I think:

  ...we register _the_ repository's object database... 

is a bit ambiguous since "the repository" is actually a repository that
is _not_ `the_repository`. At least for me, I was getting a bit tripped
up. XD

-Justin
