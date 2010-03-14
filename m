From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 3/3] git-send-email.perl - Fix 550 EHLO argument does not match calling host
Date: Sun, 14 Mar 2010 12:53:02 -0700 (PDT)
Message-ID: <m3y6huk7f4.fsf@localhost.localdomain>
References: <4B97C157.4020806@gmail.com>
	<20100311081213.GA13575@sigill.intra.peff.net>
	<20100311083148.GA13786@sigill.intra.peff.net>
	<7vaaueziv8.fsf@alter.siamese.dyndns.org> <4B9A74CA.4080507@gmail.com>
	<7vy6hxnnfx.fsf@alter.siamese.dyndns.org>
	<87bpesi0om.fsf_-_@jondo.cante.net>
	<7vfx433l9x.fsf@alter.siamese.dyndns.org>
	<87eijng4hy.fsf@jondo.cante.net>
	<7vtysjs9hi.fsf@alter.siamese.dyndns.org>
	<878w9vdx01.fsf@jondo.cante.net> <87sk83aq76.fsf_-_@jondo.cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Sun Mar 14 20:53:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NqtsM-0005Ml-Br
	for gcvg-git-2@lo.gmane.org; Sun, 14 Mar 2010 20:53:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752850Ab0CNTxK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Mar 2010 15:53:10 -0400
Received: from mail-fx0-f227.google.com ([209.85.220.227]:40462 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752732Ab0CNTxI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Mar 2010 15:53:08 -0400
Received: by fxm27 with SMTP id 27so3178222fxm.28
        for <git@vger.kernel.org>; Sun, 14 Mar 2010 12:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=5a6fzT4FWg9Md6bq2yWPDb/+/QtZgNPJ8y/BPp5Ztok=;
        b=xauH532wXmq4Ri7RMzgj4h/aRhavLRHpn2P+wY3gI8seDuKti48Heb9rtQGKX53nIR
         4AFFD9efqDdC4HKU76mctdSg1D77P2vQCVzu1J12Y1fMdnh6xqTOxLAZt3sGqkMFZFmv
         tUQMXfPscFTPh7t6vIHPaksP9UKG6cLocJj3s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=Hlf6O+m0NXlrvZFC5YZKm8VBIfVth904kBkjiJ/WoPaJ5+4d0WoarwcJZxABXzmXmB
         iafz6NR5BiXsCulj7YCAA0DROhsrDzfsq8mFP4Us2N5ukV8HjDFE4wKdiZIrJkQeSNQe
         G7tolFOVrWCmrx6c0SS7FNCM2V7kreMqWrN2c=
Received: by 10.223.132.197 with SMTP id c5mr4145283fat.35.1268596384691;
        Sun, 14 Mar 2010 12:53:04 -0700 (PDT)
Received: from localhost.localdomain (abwr74.neoplus.adsl.tpnet.pl [83.8.241.74])
        by mx.google.com with ESMTPS id 12sm6155316fks.20.2010.03.14.12.53.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Mar 2010 12:53:02 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o2EJqVjW029161;
	Sun, 14 Mar 2010 20:52:41 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o2EJqFtN029157;
	Sun, 14 Mar 2010 20:52:15 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <87sk83aq76.fsf_-_@jondo.cante.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142149>

Jari Aalto <jari.aalto@cante.net> writes:

> ---
>  git-send-email.perl |   71 ++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 70 insertions(+), 1 deletions(-)
> 
> 
> 
>     ================================
>     This is REVISION SET 4, reworked
>     ================================
 
Here you should describe differences from v3 (from previous version),
for easier review.
 
> +# This maildomain*() code is based on ideas in Perl library Test::Reporter
> +# /usr/share/perl5/Test/Reporter/Mail/Util.pm ==> sub _maildomain ()

Nice... although it might be better to use Test::Reporter::Mail::Util
as canonical module name (the package can be installed somewhere else,
depending on operating system / distribution, and if one uses
local::lib for local / per-user installation).

> +sub maildomain_net
> +{
> +	my $maildomain;
> +
> +	if (eval { require Net::Domain; 1 }) {
> +		eval "use Net::Domain";
> +		unless ($@) {
> +		    my $domain = Net::Domain::domainname();
> +		    $maildomain = $domain
> +			    unless $^O eq 'darwin' && $domain =~ /\.local$/;


Here should be a comment 'following what Test::Reporter does' or
something like that.

> +		}
> +	}
> +
> +	return $maildomain;
> +}

You still have duplicated 'require' ('use' is 'require' + 'import')
and check if it succeeded.  It should read:

+sub maildomain_net {
+	my $maildomain;
+
+	if (eval { require Net::Domain; 1 }) {
+		my $domain = Net::Domain::domainname();
+		$maildomain = $domain
+			unless $^O eq 'darwin' && $domain =~ /\.local$/;
+	}
+
+	return $maildomain;
+}

In the subroutine below you do not duplicate check for require.

Sidenote: alternate soultion would be to write (with one less level of
indent):

+sub maildomain_net {
+	my $maildomain;
+
+	eval { require Net::Domain; };
+	return if $@;
+
+	$maildomain = Net::Domain::domainname();
+		unless $^O eq 'darwin' && $domain =~ /\.local$/;
+
+	return $maildomain;
+}


> +
> +sub maildomain_mta
> +{

Use the same Perl convention that used elsewhere in git-send-email.perl
(this is usually used Perl style).

+sub maildomain_mta {

> +	my $maildomain;
> +
> +	if (eval { require Net::SMTP; 1 }) {
> +		for my $host (qw(mailhost localhost)) {
> +			my $smtp = Net::SMTP->new($host);
> +			if (defined $smtp) {
> +				my $domain = $smtp->domain;
> +				$smtp->quit;
> +
> +				$maildomain = $domain
> +					unless $^O eq 'darwin' && $domain =~ /\.local$/;
> +
> +				last if $maildomain;
> +			}
> +		}
> +	}
> +
> +	return $maildomain;
> +}
> +
> +sub maildomain
> +{
> +	return maildomain_net() || maildomain_mta() || $mail_domain_default;
> +}

Nice.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
