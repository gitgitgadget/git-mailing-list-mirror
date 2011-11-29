From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Make feed title valid utf8
Date: Tue, 29 Nov 2011 11:48:39 -0800 (PST)
Message-ID: <m38vmylnfu.fsf@localhost.localdomain>
References: <CAKD0UuxFVtCRT+hqO5vkDRanaX3Gvwf9MAFqNUwAiFA+wEwxXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: =?iso-8859-15?q?J=FCrgen_Kreileder?= <jk@blackdown.de>
X-From: git-owner@vger.kernel.org Tue Nov 29 20:48:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVTfb-000213-5J
	for gcvg-git-2@lo.gmane.org; Tue, 29 Nov 2011 20:48:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755199Ab1K2Tsm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Nov 2011 14:48:42 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40656 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753668Ab1K2Tsl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Nov 2011 14:48:41 -0500
Received: by bkas6 with SMTP id s6so940269bka.19
        for <git@vger.kernel.org>; Tue, 29 Nov 2011 11:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=wE8ylznAab3GKUNn0VDfs/B6Jy+NdkvEauqjYvZvO+g=;
        b=ggxV/TEzGdexUOYjcitnN6lWTRfUbqntHrmqgMOvIbovkmLtFb7htd0DVd/2J9WJ48
         TrYw6JO8Im6B6Nkqg7/Ch1b/Z+zqxDO//CYwD5VtiVAAbIOAk+eh25WkFaMVHrKRY3Ms
         ygN7dICb0EiucFlgGaCst2vHUPJ9SV3paqdd8=
Received: by 10.204.129.70 with SMTP id n6mr52767285bks.0.1322596120337;
        Tue, 29 Nov 2011 11:48:40 -0800 (PST)
Received: from localhost.localdomain (abvz161.neoplus.adsl.tpnet.pl. [83.8.223.161])
        by mx.google.com with ESMTPS id q6sm39220131bka.6.2011.11.29.11.48.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 29 Nov 2011 11:48:39 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id pATJmcIq002234;
	Tue, 29 Nov 2011 20:48:39 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id pATJmcCX002231;
	Tue, 29 Nov 2011 20:48:38 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <CAKD0UuxFVtCRT+hqO5vkDRanaX3Gvwf9MAFqNUwAiFA+wEwxXg@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186078>

Subject: gitweb: Make feed title valid utf8

J=FCrgen Kreileder <jk@blackdown.de> writes:

> gitweb doesn't properly handle UTF8 site names when generating feed t=
itles.
>=20
> Signed-off-by: Juergen Kreileder <jk@blackdown.de>
> ---
>  gitweb/gitweb.perl |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 4f0c3bd..a2838c3 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -7482,7 +7482,7 @@ sub git_feed {
>  	return if ($cgi->request_method() eq 'HEAD');
>=20
>  	# header variables
> -	my $title =3D "$site_name - $project/$action";
> +	my $title =3D to_utf8($site_name) . " - " . to_utf8($project) . "/$=
action";
>  	my $feed_type =3D 'log';
>  	if (defined $hash) {
>  		$title .=3D " - '$hash'";
> --=20

Thanks.  With the minor nit of prefixing subject with subsystem
designation, i.e. with "gitweb: " -- ACK.

--=20
Jakub Nar=EAbski
