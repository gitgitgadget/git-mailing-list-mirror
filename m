From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv7.2 1/4] gitweb: Prepare for splitting gitweb
Date: Wed, 17 Nov 2010 15:10:17 -0800
Message-ID: <7vd3q3eecm.fsf@alter.siamese.dyndns.org>
References: <201010311021.55917.jnareb@gmail.com>
 <1288607092-31458-1-git-send-email-jnareb@gmail.com>
 <201011130035.50229.jnareb@gmail.com> <201011130041.22918.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, John 'Warthog9' Hawley <warthog9@kernel.org>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Petr Baudis <pasky@ucw.cz>, admin@repo.or.cz
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 18 00:10:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIr9J-0008Oz-Ch
	for gcvg-git-2@lo.gmane.org; Thu, 18 Nov 2010 00:10:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935680Ab0KQXKj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Nov 2010 18:10:39 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60859 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935640Ab0KQXKi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Nov 2010 18:10:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DC3D02956;
	Wed, 17 Nov 2010 18:10:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=jUveANSMa+s8khra4egth9fJX5k=; b=jJp+sW5EPU4TXHsyiM1EaE/
	Odmj8HCXDfsYZVClU74aYayClTzsBTFxgbwECQ+pn53yWd1vNaq5f5+zTtsDR2Mi
	7MvY7uVyyURm+CF5+u1fhBqVhFtaFIoB77Z6Mn0A0pnvfxsKpcF7H/aqM8Ah6cFb
	po7kx04HamE9vPI5wxKg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=nz1HR76+Wwq8aHK6AJAYU4Ns9vmdwBiXwPy3FJa/4GuQne9kX
	fvl3Dq02zfdNiXkn0eROpQo/MJhB80zXg40wO/9f0UEQmNzrReJ8xQFygUdbP/c6
	DfO1W1UP/5s/jsgRbgQfcDa/fyXoUv7UsU+XI1HljP+xT0DfyH45rjhMBg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7F4EF2948;
	Wed, 17 Nov 2010 18:10:38 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 34D2A2944; Wed, 17 Nov 2010
 18:10:28 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E4169D58-F29F-11DF-B9FE-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161636>

Jakub Narebski <jnareb@gmail.com> writes:

> That means adding GITWEBLIBDIR for future testing of individual
> modules (it was not present in v7.1).

You confused me.  "git grep" after test-applying this 4-patch series on
top of next shows only one GITWEBLIBDIR, which means that the symbol is
defined but nobody pays attention to it.

> diff --git a/gitweb/Makefile b/gitweb/Makefile
> index 0a6ac00..f9e32eb 100644
> --- a/gitweb/Makefile
> +++ b/gitweb/Makefile
> @@ -57,6 +57,7 @@ PERL_PATH  ?= /usr/bin/perl
> ...
> -.PHONY: all clean install test test-installed .FORCE-GIT-VERSION-FILE FORCE
> +.PHONY: all clean install install-modules test test-installed .FORCE-GIT-VERSION-FILE FORCE
>  

In the earlier series, 478da52 (gitweb: Prepare for splitting gitweb,
2010-10-30) removed the trailing blank line from here but this does not do
so anymore, which is a micronit regression.
