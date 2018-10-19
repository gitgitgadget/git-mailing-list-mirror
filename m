Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFD001F453
	for <e@80x24.org>; Fri, 19 Oct 2018 09:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbeJSRcZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 13:32:25 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38517 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbeJSRcY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 13:32:24 -0400
Received: by mail-ed1-f65.google.com with SMTP id c1-v6so30830826ede.5
        for <git@vger.kernel.org>; Fri, 19 Oct 2018 02:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=+kicXd3ujY3IKiBRRWEFzzPSXAKK8A92O9z/iUtsnBA=;
        b=IpMxlr7eFQRiXjRplQWdtzHEYpyp0b7mZxgXxvp7kdHIiZ4KncyLDxQ6ZIoCDHpj/B
         VmBklgQ5Hqxfugm53JHC+vSRLq22t4KKenZuskk+/DPMJnKYQmceowHw9Jui35Zk0Rtq
         dfc+kRHGVtZPXWrDnaSWK5Y1F6Ti0qGFZNM9xSYpoIN3dy//nwAKxRLfUZFz1+CNPXT8
         LmpO4QNflLEIo5GrL9kl/lidlGvh03GOy9gajHz5t/flUmHuPwULRUP1yL+jX0KqzZK1
         U4nUlYTNxMUAqw08CDDl6F32cnpYDkPP20w7Xwe89nXOI+gZ2ADxPbZtCLc4QkOtPO+O
         eqQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=+kicXd3ujY3IKiBRRWEFzzPSXAKK8A92O9z/iUtsnBA=;
        b=eyuy4Sb8qmlJQQ13HqlbAMJOFgN4zbmIuoOpALYe0fCIxAtMZxa0D2Oh2t99XpchLT
         HY1gUy7HRls4Gob3PI6op27Rd0QigbQKoOO71A7KDPAXsXGCcw58+OIQDrtt6rjSpQkX
         6a85V00x9XvnCje8NTSM5DV7jEWnz0273+NO2bR+THIRqhhQmT/eJXrowLc4M1grr/Ax
         8A3O5mZ4S0wjli/fknRT0T5H29ThBnZcoOvNFbytMu6i7RGXxIkKu1s2nXFK23oJGHWG
         vRQ7b/Mv8LFtvwrafOktgzQVaO6WgqjVeA0faysKMJPKb819YRYY7B2bGOo37huQ+pnv
         ro+w==
X-Gm-Message-State: ABuFfoiKrZb44yE/XPD73DbbTc9n5EHLfOP2p6GkP6IgGQxrUP5pUMNq
        W+rswRZDH1EGticsbLexA0I=
X-Google-Smtp-Source: ACcGV61cYnPzhOI9iR2UeRl6+w7i+lh2ArhT50frTX/QY+Kbgl+Atb2UF4QIqBC2wO52Q5v+es7lQQ==
X-Received: by 2002:a50:cdd8:: with SMTP id h24-v6mr6008237edj.151.1539941227660;
        Fri, 19 Oct 2018 02:27:07 -0700 (PDT)
Received: from szeder.dev (x4db1e3c6.dyn.telefonica.de. [77.177.227.198])
        by smtp.gmail.com with ESMTPSA id z7-v6sm4877825ejp.49.2018.10.19.02.27.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 02:27:06 -0700 (PDT)
Date:   Fri, 19 Oct 2018 11:27:04 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@talktalk.net>
Subject: Re: [PATCH 07/15] sequencer: make sequencer_make_script() write its
 script to a strbuf
Message-ID: <20181019092704.GW19800@szeder.dev>
References: <20181007195418.25752-1-alban.gruin@gmail.com>
 <20181007195418.25752-8-alban.gruin@gmail.com>
 <20181012100101.GE19800@szeder.dev>
 <xmqqzhvaz6z5.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqzhvaz6z5.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 19, 2018 at 05:16:46PM +0900, Junio C Hamano wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
> >>  		if (entry)
> >> -			fprintf(out, "\n%c Branch %s\n", comment_line_char, entry->string);
> >> +			strbuf_addf(out, "\n%c Branch %s\n", comment_line_char, entry->string);
> >>  		else
> >> -			fprintf(out, "\n");
> >> +			strbuf_addf(out, "\n");
> >
> > Please use plain strbuf_add() here.
> 
> FWIW, contrib/coccinelle/strbuf.cocci.patch gave us this:
> 
> diff -u -p a/sequencer.c b/sequencer.c
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -4311,7 +4311,7 @@ static int make_script_with_merges(struc
>  		if (entry)
>  			strbuf_addf(out, "\n%c Branch %s\n", comment_line_char, entry->string);
>  		else
> -			strbuf_addf(out, "\n");
> +			strbuf_addstr(out, "\n");
>  
>  		while (oidset_contains(&interesting, &commit->object.oid) &&
>  		       !oidset_contains(&shown, &commit->object.oid)) {

Uh, right.  I didn't want to copy-paste a patch with too long lines
into my mailer, as it usually doesn't end too good, so I just typed
the function name.  Evidently I couldn't quite manage.

