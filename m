From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 06/14] t9501-*.sh: Fix a test failure on Cygwin
Date: Tue, 14 Dec 2010 20:04:28 +0100
Message-ID: <201012142004.30322.jnareb@gmail.com>
References: <4D07B6DE.8080400@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>, marada@uwaterloo.ca
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue Dec 14 20:04:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSaB4-0005y0-PJ
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 20:04:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758934Ab0LNTEl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Dec 2010 14:04:41 -0500
Received: from mail-fx0-f43.google.com ([209.85.161.43]:41035 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756477Ab0LNTEl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Dec 2010 14:04:41 -0500
Received: by fxm18 with SMTP id 18so1101761fxm.2
        for <git@vger.kernel.org>; Tue, 14 Dec 2010 11:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=LV9iCzf0JaWEfxS+NehCXRGtEMnHeHLYElNKTWzBQkg=;
        b=pnZedsnqz/btz+cURBBcSztbkcLlEgn4Yv8XZDRgfCNzeQotJNffJo7FvTTM8PaGQw
         ou7+QYLpasnu6G6CaqLdS39EI1j8iStF6H0RsUzYYYnDbpBlIvXVfCNmEyrCfY3TbLj/
         Qwzh4ySNN/MURicVLBC6PubE5VU3PL3zSECew=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=LoDK5SQbV4IzptpaqX0K1H33Ykf3+BpGNhwzap7Uh6a29qeSsDBfwpdmHcRdOJp+vE
         VOr6Rt5In7A/J1ettelWRzOgVrjkXXZJbwNwnw6DSjt88FSHj3EiRZwDC+77nowukS3V
         IT4RGo+xdoFUEclmpMoguMV/7GQeR4MqllXBw=
Received: by 10.223.101.140 with SMTP id c12mr6128833fao.16.1292353479800;
        Tue, 14 Dec 2010 11:04:39 -0800 (PST)
Received: from [192.168.1.13] (abwf130.neoplus.adsl.tpnet.pl [83.8.229.130])
        by mx.google.com with ESMTPS id y1sm118386fak.39.2010.12.14.11.04.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 14 Dec 2010 11:04:38 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <4D07B6DE.8080400@ramsay1.demon.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163676>

Ramsay Jones wrote:
> 
> The first (setup) test attempts to create a file, using the
> test_commit function, called 'i can has snapshot?'. On cygwin
> (and MinGW) this fails with a "No such file or directory" error.
> In order to fix the tests, we simply remove the '?' wildcard
> from the name, since the purpose of these tests is not about
> creating funny filenames.
> 
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>

All right.

Acked-by: Jakub Narebski <jnareb@gmail.com>

BTW. if the test was about handling funny filenames (containing
leading, embedded and trailing space, +&@=<>"' characters), what
should we do instead?

> ---
>  t/t9501-gitweb-standalone-http-status.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/t/t9501-gitweb-standalone-http-status.sh b/t/t9501-gitweb-standalone-http-status.sh
> index 2487da1..18825af 100755
> --- a/t/t9501-gitweb-standalone-http-status.sh
> +++ b/t/t9501-gitweb-standalone-http-status.sh
> @@ -16,7 +16,7 @@ code and message.'
>  # snapshot settings
>  
>  test_expect_success 'setup' "
> -	test_commit 'SnapshotTests' 'i can has snapshot?'
> +	test_commit 'SnapshotTests' 'i can has snapshot'
>  "
>  
>  
> -- 
> 1.7.3
> 
> 
> 

-- 
Jakub Narebski
Poland
