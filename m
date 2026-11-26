Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795684660;
	b=ozBKPN1VADFuqc53i8HtjivtSmDVWwapUWVaCD3vGQ8WxZSr1OzvT5Y8OsLs62yJSLpf
	 qeAnP0YdDI59NyIgfahHe7jH3qt/DfjEsxlfHdfrTN/phqYBTlnqwMTf0yUQPzDOncoR6
	 En/pdacfBYReHCauRJy7yteHnW4TK+ucDexyDjsXadU2dP5nB+ppE6RhLSOhcYaNMX+RF
	 tbdDKxJiBnjWetDzzOTtp65slIXZwx8Zm7FtSBJWlmuYrUD+LX+xTIn1Zrs/6g6T250mZ
	 ZKkWq9pjzFKHZ0cvQFjAOrYXAGSyNxpVMfowZEGLi6sepsZGheueYHkBJcMzuDksSOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795684660;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=i23uJrRSktJT77iIktAQylNdrIkp7GXj1YOunSc7oRk=;
	b=4Hili3FiFobTi3t6Tl9sNHmZ6Gk1RXk+moM4mzO4v3F9f3L4gnDqvv6vq5punVSoFOwz
	 JaAy3oI+u5yUnhqZpk19JVhMRny01mtqSKzq/mgqSBlmwwqPuRXj/obg8WBCyzA/LM0u9
	 7ZSXfwBfrnhPjvDGDWvZoEAwQy6nYQ1Yv2hfs8XRQRwC2hDc26aSkhC4IZDKQuN2t1luY
	 YmxFEW72co/FWf7a8Gd5IVUHA4Oqq4nItTw2I3BPNontHBl5nxY8d14t1/2HnGbgfZeF8
	 8FJMQPaXeEvltAmx8E9kEfMkJXdYi5Al/plquXgvn7snBi4rYllDszVxWf/xVhlBDQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iQYoNkQk;
	arc=none smtp.remote-ip=209.85.167.52
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801A7606A31C
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 09:17:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 801A7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iQYoNkQk
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5c102ad8420so3678126e87.1
        for <git@vger.kernel.org>; Thu, 26 Nov 2026 01:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795684658; x=1796289458; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i23uJrRSktJT77iIktAQylNdrIkp7GXj1YOunSc7oRk=;
        b=iQYoNkQkPWMrJEENijaqGmg8mhiz+pzpQ/mmqAVVtB0KXXlYm20EjeIcBDBvnrbVUD
         W3UlolDTRkHBXGCkBl83yZyQ3zuTajAOxhhTL6QZj5J8wl8ps0EtjHeeHrrg8WPikF96
         7XWd2mySmba7p3BABXvLVN3OFyn6X0cZQMu3dRi4oUmnqmkal0EQvxzaqFvlDgGHCj5d
         7G1a5l/qBo5+UQbUXDna+B19vuqwXmYBVZ5qzFG0vvTNnPskdKPxZQOD7Ih8Je9/3K3a
         TW9kBukoZD5TqBtM36nfmT+1mwrzGE5Pqvh73Pww8yzA3RuGWCt1ZIawnYs3IZpVwnlB
         MTag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795684658; x=1796289458;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i23uJrRSktJT77iIktAQylNdrIkp7GXj1YOunSc7oRk=;
        b=pmUxH2+PKx99Rgxdu66thR5nNAcNhYq56bGBItvLkKinaOA5/03FxBFcAQn0CQXUfA
         44EF6OrzKlKZ06RF/GASIjnkZNC5gFPQC5AdIE+V+l1HXu5vuiIKJ6gzrCdvax8wzc1x
         193kX5bSzEgPlf34wltSAzX5OWcsxvT6X/LZe9uw+CplnlYBGDxWZ+sPxDn81fy3NX5L
         dT4yxZTxWLQFtiRS25KeEjRCTeopSN/LvxgN0PHIdKkeRgYTYbdlhSlg/Rt7u3gyNMvk
         xovsokqqAuAVVKgqHTVU1RioVud/tkkRgLgSPnhkU01H9aKZpnm+9dkfBbaGFzJ6nbnp
         rxIQ==
X-Forwarded-Encrypted: i=1; AL+hErFE63tsaEVa+lqzgwG0qZawuuljDX48r1SQ1bgAMJlyqr7SKNTiGkEXV7WoqN1mtcZXRfY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8G8fULOyE8STm52SClYX1/wHRgVNfm9xllXdjuShFzGim9VndF
	Fcn1vOcyksf2FWe/dxnbf7+IZ3EViiKoU7QsRPsRdVvxmo+M2iIBj8TS
X-Gm-Gg: AZFdTZdKXXKcPIK5ht2c479ILOzc9P8iCnLPTusEqNQbeltwQpZbonMu6Y2bXa33pa2
	BQ7mcyrwjzoptKlMlgFuwwUW6Q8xQB8a69bgo2TxMmgRgcRX77jlpGiCCqE1auxJtmfwhvSnh9z
	vPOXX2eWA+DVv7XhBQmtwINr4SJnmIbJzXfnHRzf5XEvm5tTSRXbOowAu1vXaecf+OUiomz2t7T
	9IHDAatwW4e7MUqB3cCCviI/YuPq9voVmuDqfl0N8CZvOWQX63aigqzuO1Mz7rshr+0FLb8QfHQ
	vMaRMYHy8WjPlvlilwdVC7z7S281160t5vSHYs7hoO9ak+1iUzwR2eOJlUADe5DYrZX3VGLGGDi
	o9qBJozaZO/bD+gi7QFMHPMSvAPxeqeXL4vXCzIQFbozvpH6qL9dgh9sb5U4SEEOr/LxGBydkCw
	QkTerRpWSPWhBtMvSfiwkmstY4zB2JWYf6mn2uhH8ShtnFUhXV3O3ZB9UUT6dMs4KAVD4EssgAI
	fmzXqRAaA+mv1kySMQjoN814vA3HJ41x8UB6Uu0HDhrYj4UG4bmVrdqIZgKGteiUSHRgNB5BR3B
	as/7WUPxSAHbFpzZCnOe5+LBAH0HzcE4EsyTv/ZGLdnZ4f726hCIn5K+b6c6YS5gqFU3JuPmpTP
	I/PRngrjNcD1WltO715U3ARKpugU8kX0Kp1H2zdFt/5xsDQ==
X-Received: by 2002:a05:6512:6d0:b0:5c1:5bcc:befc with SMTP id 2adb3069b0e04-5c1bc7fb293mr5762420e87.38.1795684658121;
        Thu, 26 Nov 2026 01:17:38 -0800 (PST)
Received: from localhost ([2001:2043:be0a:d700:bd32:e7e3:cfbd:5b51])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c1bcff86c4sm5030520e87.22.2026.11.26.01.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 01:17:37 -0800 (PST)
Date: Thu, 26 Nov 2026 10:17:37 +0100
From: erik88 <erik88@gmail.com>
To: phillip.wood@dunelm.org.uk
Cc: Erik Cervin-Edin <erik@cervined.in>, git@vger.kernel.org, 
	gitster@pobox.com
Subject: Re: [PATCH v4 0/3] commit: allow -m/-F/-c/-C for all --fixup variants
Message-ID: <awfzGjPqQaaCSRd8@vader>
References: <cover.1790082176.git.erik@cervined.in>
 <cover.1795562078.git.erik@cervined.in>
 <bfb8aad3-7cab-4394-a16c-be743562eced@gmail.com>
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
In-Reply-To: <bfb8aad3-7cab-4394-a16c-be743562eced@gmail.com>

On 25/11/26 14:37, Phillip Wood wrote:
> Hi Erik
> 
> On 24/11/2026 23:32, Erik Cervin-Edin wrote:
> > Changes since v3:
> > 
> >    * New 1/3 refactors prepare_to_commit() to write the --fixup subject
> >      in a block before the message-source chain, as --squash already
> >      does.  On v3 1/2 Phillip found it unfortunate that the -m and -F
> >      arms had to be guarded with "!fixup_message" while the fixup arm
> >      duplicated their work [1] and I agree.
> > 
> >      Originally, I wanted to avoid a refactor -- but the guards were
> >      getting nasty, and a refactor is the proper fix.  It turned out not
> >      to be that difficult and I think it makes the series land cleaner.
> > 
> >      With the subject written up front, the -m and -F arms serve every
> >      --fixup variant unchanged, and the fixup arm is left with only the
> >      amend case.
> 
> This change looks good and makes the second patch much nicer. I'm happy with
> everything apart from
> 
>     Plain --fixup never opens an editor, so -c there behaves like -C.
> 
> in patch 3. It would be much nicer if we didn't change the meaning of "-c"
> when it is combined with "--fixup". Users who do not want to edit the
> message can use "-C". I've not looked at how easy it would be to fix that.
> If it turns out to be tricky then I'm happy to merge this as is and leave it
> as #leftoverbits.

That's fair. I suspect nobody will use plain --fixup with -c but it's
inconsistent if all of a sudden it means -C just because the --fixup is
plain. What should work under v4s patch 3 is --fixup -c --edit, but
forcing that is a bit weird.

> I've not looked at how easy it would be to fix that.

Looks easy enough, -c sets edit_message in cmd_commit()

    OPT_STRING('c', "reedit-message", &edit_message, N_("commit"),
    N_("reuse and edit message from specified commit")),

so it's already set when we reach

    if (fixup_message) {

in parse_and_validate_options(), and we could probably change

      } else {
        fixup_commit = fixup_message;
        fixup_prefix = "fixup";
        use_editor = 0;
      }

to

      } else {
        fixup_commit = fixup_message;
        fixup_prefix = "fixup";
        if (!edit_message)
          use_editor = 0;
      }

I can reroll with something like that if that seems better.

Given that the rest of the series tries to get rid of some of the
somewhat arbitrary restrictions on which options can be interchanged with
the other ones, it doesn't make much sense to me to introduce a new
"by the way, if you use -c with --fixup we'll assume you meant -C"
caveat.

To me it makes sense to keep the meaning of -c consistent.
