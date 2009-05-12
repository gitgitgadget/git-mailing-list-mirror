From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Extend sample pre-commit hook to check for non ascii file/usernames
Date: Tue, 12 May 2009 23:55:59 +0200
Message-ID: <200905122356.00659.jnareb@gmail.com>
References: <419AD153-53B4-4DAB-AF72-4127C17B1CA0@gmail.com> <m3r5yukv6g.fsf@localhost.localdomain> <20090512214250.GA22974@macbook.lan>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Esko Luontola <esko.luontola@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue May 12 23:56:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3zxT-00043z-HV
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 23:56:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752395AbZELV4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2009 17:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbZELV4J
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 17:56:09 -0400
Received: from fk-out-0910.google.com ([209.85.128.187]:58887 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751772AbZELV4I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2009 17:56:08 -0400
Received: by fk-out-0910.google.com with SMTP id 18so125591fkq.5
        for <git@vger.kernel.org>; Tue, 12 May 2009 14:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=lokPoLzcw3ef8OAn6GPw94t6Wl+eKCOk6YOXgcgJRo8=;
        b=Gn1UL+iRLfquKHYmpl4au2/+qmf4GFaBSMA+o9xSWwZAt1+VZR2EgL+KZvCw2sfwyA
         BoUCWJ5PEbElv313KTWFkbDH4ZCL9J8aXw8uMMOgbXJOicNfiEmIWaz94JvUJLX5fMDy
         6LiNKmm4r31cdi5liHQWWntWIkf/t6FJs+Oqg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=ADehRnjfnvd4CeRzpY4uV5i1D4gMrZ7lCmTgloj3Dor2iJZNbaVJKOKTbaRuTs5gjL
         Z2E/WX0kylSWZWxKqzkcf9NCU9fv7cl2JO5R+WgzyDiB82bAL2D5vfBRJpHV2p4moA+w
         ZQDPAR2FAsaMKmHy4yF/qx3Ifx8MOKE1ZKILk=
Received: by 10.103.102.17 with SMTP id e17mr109009mum.119.1242165367739;
        Tue, 12 May 2009 14:56:07 -0700 (PDT)
Received: from ?192.168.1.13? (abvp65.neoplus.adsl.tpnet.pl [83.8.213.65])
        by mx.google.com with ESMTPS id j10sm1002498mue.41.2009.05.12.14.56.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 12 May 2009 14:56:06 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20090512214250.GA22974@macbook.lan>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118959>

On Tue, 12 May 2009, Heiko Voigt wrote:

> At the moment non-ascii encodings of file/usernames are not very well
> supported by git. This will most likely change in the future but to
> allow repositories to be portable among different file/operating systems
> this check is enabled by default.

> +	# non-ascii username issue a warning in git gui so tell the
> +	# user to change it
> +	if ! git config user.name | is_ascii; then
> +		echo "Please only use ascii characters in your username!"
> +		exit 1
> +	fi
> +
> +	if ! git config user.email | is_ascii; then
> +		echo "Please only use ascii characters in your email!"
> +		exit 1
> +	fi

Actually 1.) there is no easy way to avoid non-ASCII names at least
in user.name (I think they are not allowed in email), but 2.) there
is no trouble with non-ASCII encoding of commits, as they have 
'encoding' header if it is not uft-8 (see *encoding* config variables).

-- 
Jakub Narebski
Poland
