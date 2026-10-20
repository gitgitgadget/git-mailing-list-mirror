Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792529814;
	b=h26c8pInBCFU0iljkdhO7HvFd58YxMWyk0x8Ic1MgFpSz2PfnZzbcrBeotsE1yvFOO3+
	 DSoS+S3WrByVMcWqDK3ytacqYtRqmxNTonR5bPahT30r/qpMbXiHDKOHSEGvpkrvxi9mH
	 Os3KrFGT5CHRCYYuIxiGApTY4MQr8Q7nKRe82uRhpyBWrQ867Xw39w3pCDM5kP1Qi8G4D
	 yJGVFZOM3CFPYEz8sYsbbJib6RN6XdzvAgtACA6hbsGGai+cUqYevups2YDsFHM4FxPN9
	 glDs10NBG+TqumtHEzi1qgCE6siEC+5uoBZI+8XaWIwaFxyY9l/61idpRIB5pIDnYPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792529814;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:User-Agent:X-Provags-ID:X-Spam-Flag:
	 UI-OutboundReport:Content-Transfer-Encoding;
	bh=jvRUx7ONaMA115sFUOCmECa+IMfF30QmkDDd5FiqskQ=;
	b=RklZA28sqNC/E/Wb1dslk6EXRXzJ/8PKDhPMvsQxIyG8NmqzbvB10l+S7T6JFfALNRGx
	 Cf5DxhrVdKXpTf/4LvCxS5GZTY+ITztWs4oUZh7jas3gizkCSZwXweSkjd6xnN/9AWJZd
	 4GiWRnWoKdCaxkHAK2JCKL+c61QSoKQr5YsapXiXVUMIZPU0keYfqVNsCklRjhUMgMGOc
	 /FBkKzWDFcFE4mf0bIJzRA7goJrdLXhzylEUOJJcTuRKu2//XEzbfCrAXgTNQqyxoYfcL
	 9/7zkXG4VrACtXxOEYeI8lZwqC6x9gMVLhO8jyhemTgp909dXlVl/D+c0J7NnQhIT4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=web.de;
	spf=pass smtp.mailfrom=web.de;
	dkim=pass header.d=web.de header.i=tboegi@web.de header.a=rsa-sha256 header.s=s29768273 header.b="kJKOeDG/";
	arc=none smtp.remote-ip=212.227.15.14
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BE3606A31D
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 20:56:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1BE3606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=web.de header.i=tboegi@web.de header.a=rsa-sha256 header.s=s29768273 header.b=kJKOeDG/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1792529805; x=1793134605; i=tboegi@web.de;
	bh=jvRUx7ONaMA115sFUOCmECa+IMfF30QmkDDd5FiqskQ=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=kJKOeDG/2xl44R9Q1OS8cnUOfYyBmUu8pBmp0xXTyrkjHrYKyb8nWnoDOkVkKnUR
	 aYcWVQV0a+uVN1nAbVCxlHQL0taj8hN4bXn6lVOIw+Oe3/Nk37gkL5PJRd7Wq8Gc7
	 20LCQtOcgKYD/WxmkaU53eLLI+OYUQ4pI8D5bxOaWrnH22ElcsKenkcSev3ijQykU
	 t6upWVURd/+rw/O/aDpGKcArWu3tPKRsl0USwbv4BjSqywgjGkProudWvEpukOwlM
	 xUqpxyAnYZOb/Bs6RuzKBM0zvef8V2cXcZBRSiMhNGi2rzbZGhXBcjr50rGdyGXU+
	 kZF2a7F/E3E1A9O8FA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MgRQJ-1wfnbW2dCh-00hsXB; Tue, 20
 Oct 2026 22:56:45 +0200
Date: Tue, 20 Oct 2026 22:56:44 +0200
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Curtis Allen Smith <curtis.allen.smith@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v5] read-cache: do not trust a size change when
 conversion is active
Message-ID: <20261020205644.GB6367@tb-raspi4>
References: <20261013065915.879-1-curtis.allen.smith@gmail.com>
 <20261013180206.610-1-curtis.allen.smith@gmail.com>
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
In-Reply-To: <20261013180206.610-1-curtis.allen.smith@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:nFBY+9kf1b6fOTXIyAKD0vauYydaoKeScEe/P7WDpKdzOdZ19LS
 h4820CBMrsTcbOfFzOv5nIy6n7lDqT2+bfS4Jb2Ok1t2UQB0OQ6F+9WIyhfOFvk2+hweYXw
 VG3UOmcJ7OPG2+LKvwL4GqMPPhE1VWoSJQhwy6PY3X1UYHRaMDbPEUSfxEYoSXzX4R/Cjzm
 rsiWo9mZ2yrUGfAa1XE8A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/sDeba3mo3M=;OHXQW0pedD1qWgfWfQXa0cU3MmI
 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
 VsgVrvpCSOBxjyvjDVlP6avTQJzuZ7Uc/90V4E=
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 12:02:04PM -0600, Curtis Allen Smith wrote:
[snip]

> diff --git a/read-cache.c b/read-cache.c
> index c4cf08a3a..70f4787de 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -9,6 +9,7 @@
> =20
>  #include "git-compat-util.h"
>  #include "config.h"
> +#include "convert.h"
>  #include "date.h"
>  #include "diff.h"
>  #include "diffcore.h"
> @@ -480,7 +481,8 @@ int ie_modified(struct index_state *istate,
>  	     */
>  	    (!S_ISLNK(st->st_mode) || ce->ce_stat_data.sd_size !=3D MAX_PATH) =
&&
>  #endif
> -	    (S_ISGITLINK(ce->ce_mode) || ce->ce_stat_data.sd_size !=3D 0))
> +	    (S_ISGITLINK(ce->ce_mode) || ce->ce_stat_data.sd_size !=3D 0) &&
> +	    !(S_ISREG(st->st_mode) && would_convert_to_git(istate, ce->name)))
>  		return changed;
> =20
>  	changed_fs =3D ce_modified_check_fs(istate, ce, st);

After some more code reading: I think that, if the (to be commited) conten=
t
is unchanged and would_convert_to_git() return 0, we will do another
check further down:

ce_modified_check_fs() will call ce_compare_data() which does the filter
invokation and concludes that nothing has changed.
The thing is that a changed file size of a regular file does not mean
that the filtered file has changed. And removing this shortcut
gives the following code (with all test cases passed)


#ifdef GIT_WINDOWS_NATIVE
            /*                                                            =
                                                                         *=
 Work around Git for Windows v2.27.0 fixing a bug where symlinks'         =
                                                           * target path l=
engths were not read at all, and instead recorded                         =
                                             * as 4096: now, all symlinks =
would appear as modified.                                                 =
                               *                                          =
                                                                          =
                 * So let's just special-case symlinks with a target path =
length                                                                    =
   * (i.e. `sd_size`) of 4096 and force them to be re-checked.            =
                                                               */
            (ce->ce_stat_data.sd_size !=3D MAX_PATH) &&
#endif
            (S_ISGITLINK(ce->ce_mode)))
                return changed;

        changed_fs =3D ce_modified_check_fs(istate, ce, st);
        if (changed_fs)
                return changed | changed_fs;
        return 0;
}
