Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793106906;
	b=LnE9EelCL2kdrBirXTwz/wD06Hl4hy1pQzKr8wbNM9HgZcljYAg7BZ5m53EUwOmY1udN
	 IshXfejuBaYyjCpMVDkDa7Apw2Whq+0xNiiQIKUjP/dqNMFsVd8dj8M094zixTNMqJt/Y
	 RH42WZaDUxx+CAML8NyL0s01PxruJSHmPBQxHfkCAxBVXyxv8IhdM5npOgGGLo7eE2NZF
	 ceVNEhKjrDJBh591iBqGnV8VcfqH7drSgHCfTixIUNzv7WHhv3d8XBNJ5uV8X9in4kuzh
	 Kby5buxhFU/4IMqJF6iE5UJ6HTZAxsZNlwyp6czfhkW4+UOvRGxWoIULSoPzrUflp0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793106906;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=P+yQRCKdkSMlZ7qfciJGjXvoZ65d8d0BFZvvWA6dI7U=;
	b=NIoIgXWtdnXLvRcfzErPyeiqykRGIMKGlw5YxxKOXXJnZrl1lgNb9JcXyr2QD9EarKGy
	 2PfIV+O5H/Rsj50OsGaW9KXw3Zrkg34k9Zh/Ma3nIPTvyKBr5fomBnOAtpDMRRMgwMPje
	 Zd+9pG3qDCOr1O+Hg4n5bl7Z1iSL3nhwGFwAFsfsyijHN07jtZA4r/6mEpdfcfStE1SZb
	 tOSLNnbCOJOGIR95uc7sqyb7DvD8PdxpZVdIWzBebH4dRi1PoUulTXYhRXaInK55nPBsl
	 37pQhKpLgWtznopUK67xxVXV4gR8M+mDwbODIf1GkGx9nlKaOPDrx0gqHjovVoFszpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=GshoVjpr;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=UfiuhHfC;
	arc=none smtp.remote-ip=103.168.172.145
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51102606A31F
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 13:15:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51102606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=GshoVjpr;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=UfiuhHfC
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 8738FEC016F
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 09:15:05 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 27 Oct 2026 09:15:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793106905;
	 x=1793193305; bh=P+yQRCKdkSMlZ7qfciJGjXvoZ65d8d0BFZvvWA6dI7U=; b=
	GshoVjpre/fcOHnfEDUQKLDmGS4Na8IS3cTtP7snpdjJ7p9X42Ssxp8+doySTapD
	X9BH0yCJEvg8npi9VzS3JLxsW73BUqa7uohOXPXcDLicjXN6OXQ30dqMaMZdBTkP
	iyx/00v53HiFV5Z1+bYf8AahuywOIhNDZgi1YJldATQGSVlaWPkg57RpEa8yU3+u
	b7a/V3NiIFodM4PnCjW/6GW9idcum2PoOhKDCpfZsR1i0Kqf8cjPpl4U0+jsL4cr
	J4D4SL0yGKH3gQnZSBSfkdqIIcrYRgudJyIAEhjKWfrikVh0qihPSHXnqp+5MUtN
	o+TZ4eSidRXOAsvk7N4xgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793106905; x=
	1793193305; bh=P+yQRCKdkSMlZ7qfciJGjXvoZ65d8d0BFZvvWA6dI7U=; b=U
	fiuhHfC0GTz8H7SIw9AHnkFLCDrl7YK2UjUZoCFIGYaxosKESFS/aGXPug202F3K
	Wvnr+m+1FB3ZugoN36y7bvgHV7M9OSHVHdM+a5M4f5jBj0qKf/bENCDbUsTaATZu
	YcDo8vkQPhQCWCOrfKX3QY2N9k9303t1ktQFgAQ5lobZOJiIqXWX+H8KCXn79a4t
	Gi4bgMFGEFtQ9+dEm6w8JV/oHLFHJ3nsYEdzMfjAby8IZL/FrkmjCfRjqsizPzto
	x7gsLT6BIOtB2ttJXezIg8FqrFYAUm+IXpxOLjnMycbgPTqU0A1/zr/R28DGm38T
	t0t12a6T82bidg0W3Z0Xw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793106905; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:ZdIKuLGzDj3nW1AWUbwxU4BPNBzYYtlntEruU6C0aUPXX3o
	e/9uGku+imUTf/6rZm2PEffkJSkEKb0a5j4/eBt63DIsLX/fUwN00hKHe+GVfH4M
	kcAykKmrfrNZ0GB9VG+GwVuyoQ9r/+IMg0K02Yw6sCp0BuRCeC+uVafjGx16aJLz
	ZmijpN6jnbJkVIjKS8mszqukOU0TJGapX8NWTqHhscSpXht+nTt/cRs5ClL3CHDi
	Kt8mmtk5EAAZ2PqjYcmdwa0TBQnwjmLK2ozGt0WZxvJg13nKJFFeGanAgTWk1wua
	EpUitTpmGtu3J6l7XneEGkYC+KztRcZjTSwGh8w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-disposition,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:k9Vzp+M/PMkrOSNg/1BO/OQGKfU2PJBnMf1N3V15dZQ=:i1hVGohJIY1zozLAPRiN6FqXafnCXfrk7U31Hek4vss=;
X-ME-Sender: <xms:2aPgavSizz5HNvG4RvBXHgbjwLuqZovgqDmz0k9QEPotzxiBUUgC3w>
    <xme:2aPgaoORkc1RR54caGwooqqhP6LlexchnP3BS9YXOtVbrr0KHsNHYYHOE3x-Rrcvi
    iYRTOXQrqKpBXTx_LPGbpWtvHSM56S4dK34BOjOU_4qh5YFYo7Gow>
X-ME-Received: <xmr:2aPgaiOv-EKaALBhe22kTYc5CbGi9v-u6Ilr6UQnhEzA1Yr7aiDGmw>
X-ME-Proxy-Cause: dmFkZTEOZx1kzXKS+xyWwZOXj7mkib3tWf4oTDdwYt+tyWXWA8AOYAS3G8dG7lclou0+ZI
    ohLGl8LygXpEIKCufgm830wE4+PHNWvz5pOKsuOR+MTZHVmuv6wqKnQS8eOG4K0iIb4Zo0
    uoS1zc5IkAjjSx8qt955ObDLnNrc4AeapI7xZ6mmRlqqtS07R/LOEoM19/I8eTplDUSJUD
    RdqTdFYXJ6+TZ86VjxId2CKeq/5j9TLhiDsYdtprtjIVH4XV8NczZ0vFLP7x8fN4mHJGPC
    U/pYC5dTE8kW2kLkPE7p9i4AgQi/Akkl4zopOyQ6lBcfEKqIsuCsfrhC+6+Yaxpvq9RJTl
    vIhGsLVZ5iP4mVpNj/FnKQpy1LtLuEgzKeXvLyyBUn8+bCq9OiffKyOh9iZeYPHRZYdsvz
    qxn7jaPqkloM65RyZ8hPZKfVrw6hRRTR6RptPFVZPzBEY9pCZmi9Qu+hj7LjX47q5ws23K
    dzYPk/1P9fQZRiocAF7Q5h0miz6f+UkkIqNqpucU91p/dBw8ly3Bo0vjdHY67XZMVntHqU
    lOG077CvKvt7+gfOug2j4vkMYqCNEVNgkUk+2kqfZ3KbFjMh/jQGGQGuXPvTXtDl4su9o0
    DUG058d1HkOcP1/FQ0LammcL4xKQfrhCPrDwyvBzMAcxJu48PZnVkirKVFnQ
X-ME-Proxy: <xmx:2aPgaouHSqhXQeXIsjdeGW40vNWqWGXySddzTuiKjjtiOLOIvtQChw>
    <xmx:2aPgasUTCIZgbEGIFBflUFCub53ONmn_ttRAcHSwdwVi8aOId-SmrA>
    <xmx:2aPgagvqYG2HCoKT8NgdymOVpr9iGOMOOebdCS_mTFTjQQ3vSSN51Q>
    <xmx:2aPgaoWSgF4ZsPyhHSa6oYdy5aNVEKQky0bpSlc5Qcd8AEcbR_cDug>
    <xmx:2aPgaoMdcAUaUgsfTX1y16fwTWtqjDI_bpvpT4I2ClOOLRRtq9iVde0z>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Oct 2026 09:15:04 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cf46a6d2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Oct 2026 13:15:04 +0000 (UTC)
Date: Tue, 27 Oct 2026 14:15:01 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 6/6] odb/source-files: only reload alternates when the
 file has changed
Message-ID: <auCj1VesUFVBtT5P@pks.im>
References: <20261023-pks-odb-files-reload-alternates-v2-0-30559d7ff43b@pks.im>
 <20261023-pks-odb-files-reload-alternates-v2-6-30559d7ff43b@pks.im>
 <CAP8UFD3XSQXFAiqGEp++=Y_OmEhogDo77t-XRFYAu_1yOQc+Gw@mail.gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD3XSQXFAiqGEp++=Y_OmEhogDo77t-XRFYAu_1yOQc+Gw@mail.gmail.com>

On Tue, Oct 27, 2026 at 12:22:50PM +0100, Christian Couder wrote:
> On Fri, Oct 23, 2026 at 2:48 PM Patrick Steinhardt <ps@pks.im> wrote:
> 
> > -static int read_alternates(const char *object_dir, struct strvec *out)
> > +static void read_alternates(const char *object_dir, struct strvec *out,
> > +                           struct stat_validity *validity)
> >  {
> >         struct strbuf buf = STRBUF_INIT;
> >         char *path;
> >
> >         path = xstrfmt("%s/info/alternates", object_dir);
> > -       if (strbuf_read_file(&buf, path, 1024) < 0) {
> > -               warn_on_fopen_errors(path);
> > -               free(path);
> > -               return 0;
> > +       if (!validity || !stat_validity_check(validity, path)) {
> > +               bool successful = false;
> > +               int fd;
> > +
> > +               fd = open(path, O_RDONLY);
> > +               if (fd < 0) {
> > +                       warn_on_fopen_errors(path);
> > +               } else if (strbuf_read(&buf, fd, 1024) < 0) {
> 
> Here we start reading from the alternates file, but that file could
> start to be written to...
> 
> > +                       warning_errno(_("unable to read alternates file '%s'"),
> > +                                     path);
> > +               } else {
> > +                       parse_alternates(buf.buf, '\n', object_dir, out);
> 
> ...suppose we parse the old content of the file (which calls
> strbuf_realpath() for each entry and so does a few syscalls) while an
> in-place rewrite of the file, like the:
> 
>   `echo "$PWD/alternate/.git/objects" >repo/.git/objects/info/alternates`
> 
> in the new t1006 test added by patch 3/6, happens...
> 
> > +                       successful = true;
> > +               }
> > +
> > +               if (validity) {
> > +                       if (successful)
> > +                               stat_validity_update(validity, fd);
> 
> ...then we would update the validity while the alternates file's
> content has changed (and we only parsed its old content).
> 
> So, if the file content is not changed after that, we never parse the
> content of the file from the in-place rewrite.
> 
> (If the rewrite is not an in-place one, but the file is for example
> replaced through a lock file and rename, the race doesn't happen.)
> 
> It seems to me that if we want to avoid a race here, we should have
> the `stat_validity_update(..., fd);` call before reading from fd like
> in "refs/packed-backend.c" and "shallow.c".
> 
> > +                       else
> > +                               stat_validity_clear(validity);
> > +               }
> > +
> > +               if (fd >= 0)
> > +                       close(fd);
> 
> It looks like v1 didn't have this issue, as it called
> stat_validity_update() before reading. A concurrent rewrite then only
> caused a spurious re-read on the next check. So I wonder if we could
> keep that order, and just clear the validity when reading fails, which
> would also address Junio's point:
> 
>                fd = open(path, O_RDONLY);
>                if (fd < 0) {
>                        warn_on_fopen_errors(path);
>                } else {
>                        if (validity)
>                                stat_validity_update(validity, fd);
>                        if (strbuf_read(&buf, fd, 1024) < 0) {
>                                warning_errno(_("unable to read
> alternates file '%s'"),
>                                                        path);
>                                if (validity)
>                                        stat_validity_clear(validity);
>                        } else {
>                                parse_alternates(buf.buf, '\n', object_dir, out);
>                        }
>                        close(fd);
>                }

Hmm, that's fair. I don't think that we should worry too much about
in-place updates when concurrent processes are active as this is
inherently broken already. That process may see any in-between state,
and that may or may not result in something sensible. But fixing this is
easy enough.

Your proposed variant is subtly broken because you don't clear the stat
cache in the case where open(3p) itself fails. But I'll adapt that a bit
and then include this in the next version.

Thanks!

Patrick
