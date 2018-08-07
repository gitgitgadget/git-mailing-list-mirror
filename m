Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B060A208EB
	for <e@80x24.org>; Tue,  7 Aug 2018 21:26:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbeHGXmU (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Aug 2018 19:42:20 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44632 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbeHGXmU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Aug 2018 19:42:20 -0400
Received: by mail-wr1-f68.google.com with SMTP id r16-v6so69527wrt.11
        for <git@vger.kernel.org>; Tue, 07 Aug 2018 14:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=fz1c+V2CR+GHS2WTmFdr/1bJVAopVoSwUHuyAvX9Ww8=;
        b=e8Z0aAbxJNgsPHKqIRdZLTs3Pv9YGpCTL4D7NryP11+sPFbLrfMupsH/7Z7/xTIivU
         aAfNQ0m5YB4KN0xO2TyvQ2SRalX7bRXVQCPHUDuSQfvOfI1y5sBFPIKWARpWjA2SfJyX
         FgnUgaet6RNIyf+/PKFk58mH7qpf4TE3WerX58j+H/OeZqcTlS3KD+nekTMyGmJwWctj
         fofAD3W6AetyafAX6QGsRH21is5BOCL+mLFOewWcUvmYbw4sNfixnji3FIV5u+nfAKuw
         EnpDeQRtuhwHPNa2FLPNWp5zYWQYBjfTy5HTdXmpDfxs4XzeHGx1/Wf9H3IZ+r8+vOFj
         H1cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=fz1c+V2CR+GHS2WTmFdr/1bJVAopVoSwUHuyAvX9Ww8=;
        b=Rg2EFEN1YrzD4pcjxB3Vbaq5XdsdWp2Lh/gU1xK7uUodYUNxpKEXDu78N1pw5af7KG
         Z//lwK3yM/kQdlKv1dApEr4fbXLITGeXTNYbSuLPlttTNYa9I5WyQyMDRc4NNXRAoWSY
         Trn41GKO4wZ050x2LpeacDiW+sim2HhoX7sy0d1A7AFN3IcqzQYjL/X9TCGEIglQcJlG
         9GddJk+k9hpA4RRFtf7jqAl9imHPSl2ANNGbZoohyH6IUbfY1rWp1vzKorD4g5Cnq2/t
         tZ5bB6BtLPiAfcDs0MxR41bn0xS5SvRJgQYDvTeGEwep63tvir70Ult8r453Dvh05ubf
         HcrQ==
X-Gm-Message-State: AOUpUlEOnyKbkZrIAIOGtA5msbUTB+aKfRq38ASi7wh+VLanpoNsxW8L
        XNqdBytgI/B+AOxh3vkCwCTo93w6
X-Google-Smtp-Source: AA+uWPxPYY5CyEQlgZknBozxtnDHlMn6nhQ5jfWZODbocM5th0PNClDIWXd3k3xS/ytToTjP+TcaOQ==
X-Received: by 2002:a5d:4147:: with SMTP id c7-v6mr70773wrq.61.1533677158550;
        Tue, 07 Aug 2018 14:25:58 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id a20-v6sm1677458wmg.23.2018.08.07.14.25.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 14:25:57 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sebastian Kisela <skisela@redhat.com>
Cc:     git@vger.kernel.org, Todd Zullinger <tmz@pobox.com>
Subject: Re: [PATCH 1/2] git-instaweb: support Fedora/Red Hat apache module path
References: <20180807072548.12764-1-skisela@redhat.com>
Date:   Tue, 07 Aug 2018 14:25:57 -0700
In-Reply-To: <20180807072548.12764-1-skisela@redhat.com> (Sebastian Kisela's
        message of "Tue, 7 Aug 2018 09:25:47 +0200")
Message-ID: <xmqqk1p1kgwq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sebastian Kisela <skisela@redhat.com> writes:

> On Fedora-derived systems, the apache httpd package installs modules
> under /usr/lib{,64}/httpd/modules, depending on whether the system is
> 32- or 64-bit.  A symlink from /etc/httpd/modules is created which
> points to the proper module path.  Use it to support apache on Fedora,
> CentOS, and Red Hat systems.
>
> Written with assistance of Todd Zullinger <tmz@pobox.com>
>
> Signed-off-by: Sebastian Kisela <skisela@redhat.com>
> ---
>  git-instaweb.sh | 2 ++
>  1 file changed, 2 insertions(+)

Thanks for a patch, and welcome to the Git development community.

> diff --git a/git-instaweb.sh b/git-instaweb.sh
> index 47e38f34c..e42e58528 100755
> --- a/git-instaweb.sh
> +++ b/git-instaweb.sh
> @@ -332,6 +332,8 @@ apache2_conf () {
>  			module_path="/usr/lib/httpd/modules"
>  		test -d "/usr/lib/apache2/modules" &&
>  			module_path="/usr/lib/apache2/modules"
> +		test -d "/etc/httpd/modules" &&
> +			module_path="/etc/httpd/modules"

The original already has the same issue with two entries but this
patch makes it even worse by adding yet another one.  The longer the
code follows a bad pattern, the more it encourages future developers
to follow the same bad pattern, and usually the best time to do a
clean up like the following

	if test -z "$module_path"
	then
		for candidate in \
			/etc/httpd \
			/usr/lib/apache2 \
			/usr/lib/httpd \
		do
			if test -d "$candidate/modules"
			then
				module_path="$candidate/modules"
				break
			fi
		done
	fi

is when you go from 2 to 3.  Two points to note are:

 - It would be easier to add the fourth one this way

 - The explicit "break" makes it clear that the paths are listed in
   decreasing order of precedence (i.e. /etc/httpd if exists makes
   /usr/lib/httpd ignored even if the latter exists); the original
   "test -d X && M=X ; test -d Y && M=Y" gives higher precedence to
   the later items but readers need to wonder if it is intended or
   the code is simply being sloppy.

Hope this helps.



