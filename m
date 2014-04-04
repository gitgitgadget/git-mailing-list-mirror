From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] MSVC: allow using ExtUtils::MakeMaker
Date: Fri, 04 Apr 2014 11:57:27 -0700
Message-ID: <xmqqeh1cq5wo.fsf@gitster.dls.corp.google.com>
References: <1396510443-29087-1-git-send-email-marat@slonopotamus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marat Radchenko <marat@slonopotamus.org>
X-From: git-owner@vger.kernel.org Fri Apr 04 20:57:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WW9JG-0003Jj-Oj
	for gcvg-git-2@plane.gmane.org; Fri, 04 Apr 2014 20:57:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754618AbaDDS5e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Apr 2014 14:57:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52748 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754048AbaDDS5a (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Apr 2014 14:57:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1EC1479A7D;
	Fri,  4 Apr 2014 14:57:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fEUBD8B4Q5Eki9WLJxEDAGv0wAo=; b=kWG8Go
	X+rFsPMxsL/gHaznY+0cV1hlVDHQfAo2pZcgvQCZo9ni4pmWZEFvl6vUyl4bzQJ7
	zm/Y/a1z9Se3dh2HL1cD38hd7OdZJmMVEOP3O6u01qt19domIPPbNcFjQeFKPG0i
	qSa6Q8YRsWWqhuXdMHZvMroQ1vFEhmniQinnA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=q272jvS2CIZy5NBcnvUayzv4tzO5au/J
	urDniZPMiRHRs0OKUZFZStlBJTVfHVOdrWmsqX42qAISN4PBiwB7pa8L5qCNFvPp
	evVhcVcf8lpLLlEoMsKHUVcKwaAb8GZP684mjoQqoIx2xodUldQ2sHfrO/k59l7U
	JHDfOEZGWFI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0569579A7C;
	Fri,  4 Apr 2014 14:57:30 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 23FA779A76;
	Fri,  4 Apr 2014 14:57:29 -0400 (EDT)
In-Reply-To: <1396510443-29087-1-git-send-email-marat@slonopotamus.org> (Marat
	Radchenko's message of "Thu, 3 Apr 2014 11:34:03 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F84B181E-BC2A-11E3-9C21-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245770>

Marat Radchenko <marat@slonopotamus.org> writes:

> Drop NO_PERL_MAKEMAKER from config.mak.uname for the MSVC platform.
>
> MakeMaker is available on Windows Perl implementations and
> installs modules to correct location, unlike NO_PERL_MAKEMAKER Makefile.
>
> Signed-off-by: Marat Radchenko <marat@slonopotamus.org>
> ---

As nobody seems to object to this change (and I do not have an
environment nor inclination to test MSVC builds myself), I'll apply
this directly to 'master', hoping that doing so reasonably ahead of
2.0-rc0 would give people enough time to complain if needed.

Thanks.


>  config.mak.uname | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/config.mak.uname b/config.mak.uname
> index fc5616d..6db4193 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -338,7 +338,6 @@ ifeq ($(uname_S),Windows)
>  	NO_MKSTEMPS = YesPlease
>  	SNPRINTF_RETURNS_BOGUS = YesPlease
>  	NO_SVN_TESTS = YesPlease
> -	NO_PERL_MAKEMAKER = YesPlease
>  	RUNTIME_PREFIX = YesPlease
>  	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
>  	NO_NSEC = YesPlease
