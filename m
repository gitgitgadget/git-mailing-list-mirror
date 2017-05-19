Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFF342023D
	for <e@80x24.org>; Fri, 19 May 2017 20:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757217AbdESUyt (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 May 2017 16:54:49 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:35094 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756693AbdESUyp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 May 2017 16:54:45 -0400
Received: by mail-wm0-f50.google.com with SMTP id b84so245681926wmh.0
        for <git@vger.kernel.org>; Fri, 19 May 2017 13:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=leFRGW6gGZA0Bqd1sqo2/Jfpg4v0hTTJ6Z0LXrnQWeM=;
        b=oXZByhyDcc0VVnbyAuQNHsy17FZcSVdrAI7yWILkjA/6TMxSLCDW2rwR6u7JmUvOCW
         Ea00qI08vyuBxnsY4DiNyVHFMrTWBuE1HHbpqZK3qQu4cTuEeF4fJAogSwdh9jxft9qb
         dUIDOfRqmVXzhklR0Jw515ee2hHvEnKxMdKwUWMQLLzQgXkm+mILbs88SD1iN/JdhWz9
         1ogk+XxLeMNuDvFzxwT2CSf6zrY+s3bUuarjIOykSQ+FJAzgNPatHGBa5sQWAAa1QpNA
         uC6epnE5NH8wgEc5rZgVZ5SfcwvizgMmJVqQrPY2zv1amK7nGmSC5x4hJW8PpgtGZfug
         /ZYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=leFRGW6gGZA0Bqd1sqo2/Jfpg4v0hTTJ6Z0LXrnQWeM=;
        b=rulUWcUJbN9fNb9RHy28dLLpcCAtnQdatvbUTBNV7GqqhnSt6bZtO57OyvGaBW48I7
         2SPQdsMIGtAUYt+7AZHdakTip0RbRozUwrRCGYEKTSRh1aKM+f55b83hM9aGnZaBiL0x
         4sdABzCG3+6XDeIs8HT2J1Mx9nebzxEqfVSgt5jh1nFKe2sFV8X84oWI9Zzmx9uaCRzC
         JmIN2AYQp8kBVGTJ9Fudn2oxKS0HF6JJhDL5fJczyrfmk+TpbUCRg6lhv7oEWKNESIuu
         4Co/oQeA5dGQzkgZhmwuC3efrNk85pOPrTLg9Ye3TEgNSjvMjG2at4DQrn0yY7yabzVg
         RurA==
X-Gm-Message-State: AODbwcAfX4DIFZCVNOZgsWDL1MK7gsOjXdX6dDJfw9qQZB2Vvo3Yau9S
        8IGHV6wq+KpZLlXtqBlwdw==
X-Received: by 10.80.137.155 with SMTP id g27mr8715905edg.125.1495227248536;
        Fri, 19 May 2017 13:54:08 -0700 (PDT)
Received: from [192.168.1.80] ([145.129.9.233])
        by smtp.gmail.com with ESMTPSA id w44sm3698899edd.53.2017.05.19.13.54.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 May 2017 13:54:08 -0700 (PDT)
Message-ID: <1495227246.19473.3.camel@kaarsemaker.net>
Subject: Re: [PATCH v2] send-email: Net::SMTP::SSL is obsolete, use only
 when necessary
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     git@vger.kernel.org, avarab@gmail.com, gitster@pobox.com
Date:   Fri, 19 May 2017 22:54:06 +0200
In-Reply-To: <1493881302.20467.3.camel@kaarsemaker.net>
References: <CACBZZX5j1dYk8aeRED7T7iJ=b32aFUpfUWPpMpmtofBL3QnVXQ@mail.gmail.com>
         <20170324213732.29932-1-dennis@kaarsemaker.net>
         <1493881302.20467.3.camel@kaarsemaker.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Second ping. This problem is not going away, so if this solution is not
acceptable, I'd like to know what needs to be improved.

On Thu, 2017-05-04 at 09:01 +0200, Dennis Kaarsemaker wrote:
> Ping. It's a little over a month since I sent this, but I haven't seen
> any comments. Is this commit good to go?
> 
> On Fri, 2017-03-24 at 22:37 +0100, Dennis Kaarsemaker wrote:
> > Net::SMTP itself can do the necessary SSL and STARTTLS bits just fine
> > since version 1.28, and Net::SMTP::SSL is now deprecated. Since 1.28
> > isn't that old yet, keep the old code in place and use it when
> > necessary.
> > 
> > While we're in the area, mark some messages for translation that were
> > not yet marked as such.
> > 
> > Signed-off-by: Dennis Kaarsemaker <dennis@kaarsemaker.net>
> > ---
> >  git-send-email.perl | 54 ++++++++++++++++++++++++++++++++++-------------------
> >  1 file changed, 35 insertions(+), 19 deletions(-)
> > 
> > diff --git a/git-send-email.perl b/git-send-email.perl
> > index eea0a517f7..0d90439d9a 100755
> > --- a/git-send-email.perl
> > +++ b/git-send-email.perl
> > @@ -1353,10 +1353,12 @@ EOF
> >  			die __("The required SMTP server is not properly defined.")
> >  		}
> >  
> > +		require Net::SMTP;
> > +		my $use_net_smtp_ssl = version->parse($Net::SMTP::VERSION) < version->parse("1.28");
> > +		$smtp_domain ||= maildomain();
> > +
> >  		if ($smtp_encryption eq 'ssl') {
> >  			$smtp_server_port ||= 465; # ssmtp
> > -			require Net::SMTP::SSL;
> > -			$smtp_domain ||= maildomain();
> >  			require IO::Socket::SSL;
> >  
> >  			# Suppress "variable accessed once" warning.
> > @@ -1368,34 +1370,48 @@ EOF
> >  			# Net::SMTP::SSL->new() does not forward any SSL options
> >  			IO::Socket::SSL::set_client_defaults(
> >  				ssl_verify_params());
> > -			$smtp ||= Net::SMTP::SSL->new($smtp_server,
> > -						      Hello => $smtp_domain,
> > -						      Port => $smtp_server_port,
> > -						      Debug => $debug_net_smtp);
> > +
> > +			if ($use_net_smtp_ssl) {
> > +				require Net::SMTP::SSL;
> > +				$smtp ||= Net::SMTP::SSL->new($smtp_server,
> > +							      Hello => $smtp_domain,
> > +							      Port => $smtp_server_port,
> > +							      Debug => $debug_net_smtp);
> > +			}
> > +			else {
> > +				$smtp ||= Net::SMTP->new($smtp_server,
> > +							 Hello => $smtp_domain,
> > +							 Port => $smtp_server_port,
> > +							 Debug => $debug_net_smtp,
> > +							 SSL => 1);
> > +			}
> >  		}
> >  		else {
> > -			require Net::SMTP;
> > -			$smtp_domain ||= maildomain();
> >  			$smtp_server_port ||= 25;
> >  			$smtp ||= Net::SMTP->new($smtp_server,
> >  						 Hello => $smtp_domain,
> >  						 Debug => $debug_net_smtp,
> >  						 Port => $smtp_server_port);
> >  			if ($smtp_encryption eq 'tls' && $smtp) {
> > -				require Net::SMTP::SSL;
> > -				$smtp->command('STARTTLS');
> > -				$smtp->response();
> > -				if ($smtp->code == 220) {
> > +				if ($use_net_smtp_ssl) {
> > +					$smtp->command('STARTTLS');
> > +					$smtp->response();
> > +					if ($smtp->code != 220) {
> > +						die sprintf(__("Server does not support STARTTLS! %s"), $smtp->message);
> > +					}
> > +					require Net::SMTP::SSL;
> >  					$smtp = Net::SMTP::SSL->start_SSL($smtp,
> >  									  ssl_verify_params())
> > -						or die "STARTTLS failed! ".IO::Socket::SSL::errstr();
> > -					$smtp_encryption = '';
> > -					# Send EHLO again to receive fresh
> > -					# supported commands
> > -					$smtp->hello($smtp_domain);
> > -				} else {
> > -					die sprintf(__("Server does not support STARTTLS! %s"), $smtp->message);
> > +						or die sprintf(__("STARTTLS failed! %s"), IO::Socket::SSL::errstr());
> > +				}
> > +				else {
> > +					$smtp->starttls(ssl_verify_params())
> > +						or die sprintf(__("STARTTLS failed! %s"), IO::Socket::SSL::errstr());
> >  				}
> > +				$smtp_encryption = '';
> > +				# Send EHLO again to receive fresh
> > +				# supported commands
> > +				$smtp->hello($smtp_domain);
> >  			}
> >  		}
> >  
