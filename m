Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BA7A1FD09
	for <e@80x24.org>; Wed, 31 May 2017 21:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751198AbdEaVqj (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 17:46:39 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36255 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751149AbdEaVqi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 17:46:38 -0400
Received: by mail-pf0-f196.google.com with SMTP id n23so4367643pfb.3
        for <git@vger.kernel.org>; Wed, 31 May 2017 14:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=W7D9I5jx2WZUkTw6nqHPRqiR49C2R2Z1i4jtPMWFuu4=;
        b=Lkec6+YnwuUPSAFAneao4sSb68S6bIt+fDul/R66gb2wabIme/1bTTUA2T6fGO7QXB
         USWbQhtzyF48pRiWECY9y3d7n3m8Vv/xZZLBXeWYZsv9vIyocPFsMYIysDA7iH1EsYHs
         AspSGbTXiYQ9NL7dcTwogpR63U7XNxvdCGy8YdRudyb0QLNi6MTDQUnl2tnGNzcRwd41
         5TlOa/cGvTlQh+BXHtJFFxBEgB8OYfzBJXBWt05iXayGVVCFj4eCm8ZtdBSRhUYpPRSR
         6B9pmCDA6zaRLjIeTn4GTJWo2WGfHSOoSg06lLziOmaW7M+Id5yojBfh6kWzg0Hv36+V
         zvuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=W7D9I5jx2WZUkTw6nqHPRqiR49C2R2Z1i4jtPMWFuu4=;
        b=bMG08XxeOfHOw+YhcTF6z9a2RAS383Zg1UwRJJBz3wNgCv363xKtxrqN/WlEbogkHY
         Yq7f9g70RMxA3YSDz630BKZIrnjflgENHYfy7nz7UIwwoAnsI5Us668QSmp4iH9tR6qw
         DvGK5DcBLFFWIO6yRtLlS834xENohC+2cq/dBRm1EOe0ZOea96JnmKeeMpzgFMCpVFZZ
         6o2NCX9/wLCvCoFM2FcSnb5OjXEbnz50BZ4s6KLJTPtQSl+rpv6MhYdXK/OVjkWpiMQz
         6oQypYLyoDe2LvDI3S6h+quvl0gO/h5sV97Q7kSyTv269erbxzVUkyydo20pJk4w1KeC
         Zmrw==
X-Gm-Message-State: AODbwcCaneZsVOEEyBgafRtUrQ7mEYRNUq/hT4UO95Iv8vH1E8QrIm6V
        ww0/Hbw3XJndeA==
X-Received: by 10.99.108.133 with SMTP id h127mr35561120pgc.175.1496267197459;
        Wed, 31 May 2017 14:46:37 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:6469:e172:b5f4:6d97])
        by smtp.gmail.com with ESMTPSA id g191sm265686pgc.49.2017.05.31.14.46.35
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 31 May 2017 14:46:36 -0700 (PDT)
Date:   Wed, 31 May 2017 14:46:34 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Dennis Kaarsemaker <dennis@kaarsemaker.net>
Cc:     git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] send-email: Net::SMTP::SSL is obsolete, use only when
 necessary
Message-ID: <20170531214634.GB81679@aiede.mtv.corp.google.com>
References: <CACBZZX5j1dYk8aeRED7T7iJ=b32aFUpfUWPpMpmtofBL3QnVXQ@mail.gmail.com>
 <20170324213732.29932-1-dennis@kaarsemaker.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170324213732.29932-1-dennis@kaarsemaker.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Dennis Kaarsemaker wrote:

> Net::SMTP itself can do the necessary SSL and STARTTLS bits just fine
> since version 1.28, and Net::SMTP::SSL is now deprecated. Since 1.28
> isn't that old yet, keep the old code in place and use it when
> necessary.

This broke git send-email for me.  The error message is

  Can't locate object method "starttls" via package "Net::SMTP" at /usr/lib/git-core/git-send-email line 1410.

Is 1.28 the right minimum version?

  $ perl -e 'require Net::SMTP; print version->parse($Net::SMTP::VERSION); print "\n"'
  2.31
  $ grep VERSION /usr/share/perl/5.18.2/Net/SMTP.pm
  use vars qw($VERSION @ISA);
  $VERSION = "2.31";
  $ grep starttls /usr/share/perl/5.18.2/Net/SMTP.pm
  $ dpkg-query -W perl
  perl    5.18.2-2ubuntu1.1

Patch left unsnipped for reference.

Thanks,
Jonathan

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
> -- 
> 2.12.0-488-gd3584ba
> 
