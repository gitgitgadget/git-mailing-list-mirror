Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B35D207B3
	for <e@80x24.org>; Thu,  4 May 2017 07:01:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751519AbdEDHBq (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 03:01:46 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34405 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751400AbdEDHBp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 03:01:45 -0400
Received: by mail-wm0-f67.google.com with SMTP id z129so1249623wmb.1
        for <git@vger.kernel.org>; Thu, 04 May 2017 00:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=I0n8axGaNFxGTHt0U4nebb2zvcvMkPZzW9WmhfkY4cw=;
        b=RdVno2wDKn31iWfHAM7negM3dbKxFIB087tFYhLg6T8OZYKkTvSVM3MxKjwWPNSfTB
         4fXEl6XzUrNmjE6gvPAlHM5WbY1HhKH6tWjRlulbpetdU1qzXpXx+zpspFxpbKY1J/SO
         M9O7fl9H5eUkeoSZnkh/ohnqfeHt1UZZ1p1GeYM7vDr0pxFTyHozwBc84uBtntNP89kE
         d7/E8fgZ2dEPQZjBptIi+rwZdYtS0Z9uoFX+rrU2QUPzXoBv51HuYC+RXJRRAjDxbd6W
         R9oVQFuiIAM0kMJEa29qrWVBXEBAF86vzMLYnVKBRvzPpqbZT3khMmUZ9NUCGL8AeZC5
         CFAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I0n8axGaNFxGTHt0U4nebb2zvcvMkPZzW9WmhfkY4cw=;
        b=W7dWpVPmh3vuvJJXmTkYVOhSzX+bsPDy/aozpMVpd+H0iorUiksbj+E8Vp7f1iiU0/
         rEFouP9W/BwqZV76hLhSEaU+mI67WHuiwixrw7HzDCYCmRdxIF6MZWAlBQPaDOKMjDM0
         kOjEdMhS/VnLXcL6jbDhPik4wg0n2H6ZX+UUcysiO1nndLe8I28wS8VkfUyifpocWphV
         5MuODmuLcYdUVBJGgnM/bzxxpjQrK30A0s+1YkkW1YKV1vnh4ru/k42AwxBaV+ffTLtL
         gBlw2BeZEjqZm/qAk+9UhB8IJ44ES70+2P+DdoOzcJlyQKPRm8PeKQOAzvF2IglYtBXJ
         G9vQ==
X-Gm-Message-State: AN3rC/6iCybNHsKqG+4pLga/l1wbivGet46aDv3p/nVnaOgR6CfGwjVg
        edDYC61cthVdw3fJ+Yc=
X-Received: by 10.80.215.155 with SMTP id w27mr6502138edi.70.1493881303362;
        Thu, 04 May 2017 00:01:43 -0700 (PDT)
Received: from [192.168.1.80] ([145.129.9.233])
        by smtp.gmail.com with ESMTPSA id z34sm428865edz.57.2017.05.04.00.01.42
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 May 2017 00:01:42 -0700 (PDT)
Message-ID: <1493881302.20467.3.camel@kaarsemaker.net>
Subject: Re: [PATCH v2] send-email: Net::SMTP::SSL is obsolete, use only
 when necessary
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     git@vger.kernel.org
Date:   Thu, 04 May 2017 09:01:42 +0200
In-Reply-To: <20170324213732.29932-1-dennis@kaarsemaker.net>
References: <CACBZZX5j1dYk8aeRED7T7iJ=b32aFUpfUWPpMpmtofBL3QnVXQ@mail.gmail.com>
         <20170324213732.29932-1-dennis@kaarsemaker.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ping. It's a little over a month since I sent this, but I haven't seen
any comments. Is this commit good to go?

On Fri, 2017-03-24 at 22:37 +0100, Dennis Kaarsemaker wrote:
> Net::SMTP itself can do the necessary SSL and STARTTLS bits just fine
> since version 1.28, and Net::SMTP::SSL is now deprecated. Since 1.28
> isn't that old yet, keep the old code in place and use it when
> necessary.
> 
> While we're in the area, mark some messages for translation that were
> not yet marked as such.
> 
> Signed-off-by: Dennis Kaarsemaker <dennis@kaarsemaker.net>
> ---
>  git-send-email.perl | 54 ++++++++++++++++++++++++++++++++++-------------------
>  1 file changed, 35 insertions(+), 19 deletions(-)
> 
> diff --git a/git-send-email.perl b/git-send-email.perl
> index eea0a517f7..0d90439d9a 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1353,10 +1353,12 @@ EOF
>  			die __("The required SMTP server is not properly defined.")
>  		}
>  
> +		require Net::SMTP;
> +		my $use_net_smtp_ssl = version->parse($Net::SMTP::VERSION) < version->parse("1.28");
> +		$smtp_domain ||= maildomain();
> +
>  		if ($smtp_encryption eq 'ssl') {
>  			$smtp_server_port ||= 465; # ssmtp
> -			require Net::SMTP::SSL;
> -			$smtp_domain ||= maildomain();
>  			require IO::Socket::SSL;
>  
>  			# Suppress "variable accessed once" warning.
> @@ -1368,34 +1370,48 @@ EOF
>  			# Net::SMTP::SSL->new() does not forward any SSL options
>  			IO::Socket::SSL::set_client_defaults(
>  				ssl_verify_params());
> -			$smtp ||= Net::SMTP::SSL->new($smtp_server,
> -						      Hello => $smtp_domain,
> -						      Port => $smtp_server_port,
> -						      Debug => $debug_net_smtp);
> +
> +			if ($use_net_smtp_ssl) {
> +				require Net::SMTP::SSL;
> +				$smtp ||= Net::SMTP::SSL->new($smtp_server,
> +							      Hello => $smtp_domain,
> +							      Port => $smtp_server_port,
> +							      Debug => $debug_net_smtp);
> +			}
> +			else {
> +				$smtp ||= Net::SMTP->new($smtp_server,
> +							 Hello => $smtp_domain,
> +							 Port => $smtp_server_port,
> +							 Debug => $debug_net_smtp,
> +							 SSL => 1);
> +			}
>  		}
>  		else {
> -			require Net::SMTP;
> -			$smtp_domain ||= maildomain();
>  			$smtp_server_port ||= 25;
>  			$smtp ||= Net::SMTP->new($smtp_server,
>  						 Hello => $smtp_domain,
>  						 Debug => $debug_net_smtp,
>  						 Port => $smtp_server_port);
>  			if ($smtp_encryption eq 'tls' && $smtp) {
> -				require Net::SMTP::SSL;
> -				$smtp->command('STARTTLS');
> -				$smtp->response();
> -				if ($smtp->code == 220) {
> +				if ($use_net_smtp_ssl) {
> +					$smtp->command('STARTTLS');
> +					$smtp->response();
> +					if ($smtp->code != 220) {
> +						die sprintf(__("Server does not support STARTTLS! %s"), $smtp->message);
> +					}
> +					require Net::SMTP::SSL;
>  					$smtp = Net::SMTP::SSL->start_SSL($smtp,
>  									  ssl_verify_params())
> -						or die "STARTTLS failed! ".IO::Socket::SSL::errstr();
> -					$smtp_encryption = '';
> -					# Send EHLO again to receive fresh
> -					# supported commands
> -					$smtp->hello($smtp_domain);
> -				} else {
> -					die sprintf(__("Server does not support STARTTLS! %s"), $smtp->message);
> +						or die sprintf(__("STARTTLS failed! %s"), IO::Socket::SSL::errstr());
> +				}
> +				else {
> +					$smtp->starttls(ssl_verify_params())
> +						or die sprintf(__("STARTTLS failed! %s"), IO::Socket::SSL::errstr());
>  				}
> +				$smtp_encryption = '';
> +				# Send EHLO again to receive fresh
> +				# supported commands
> +				$smtp->hello($smtp_domain);
>  			}
>  		}
>  
