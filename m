From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2 2/8] gitweb: Pass esc_html_hl_regions() options to esc_html()
Date: Sat, 24 Mar 2012 20:15:50 +0100
Message-ID: <201203242015.50421.jnareb@gmail.com>
References: <1332543417-19664-1-git-send-email-michal.kiedrowicz@gmail.com> <1332543417-19664-3-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: =?utf-8?q?Micha=C5=82_Kiedrowicz?= <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 24 20:16:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBWRd-0000Kx-1r
	for gcvg-git-2@plane.gmane.org; Sat, 24 Mar 2012 20:16:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756082Ab2CXTP4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Mar 2012 15:15:56 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:36456 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756072Ab2CXTPw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Mar 2012 15:15:52 -0400
Received: by wgbdr13 with SMTP id dr13so2842900wgb.1
        for <git@vger.kernel.org>; Sat, 24 Mar 2012 12:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=A1DMPzoT3NKe6A3XQ3nzCU1tqhIxMn0gPxu2dnlOM2w=;
        b=IhGwaFoLQdWQMPzMH4i2qf3qpX/qVpZsO9Ce5BBmsZb8hkvUrTiiahSevftJjNEmf8
         trglIU3425lOv389FZMeJ0ZBrbLoNL5hB1Q2zkVE+8siZE7jQrLaNn48WeIg3SYMbTFf
         fEDt1Ans89/kTUrdx/TtiTn0eiDLtBKQcPYmnc0IZ05Blp0hw0Us8rKzDznDOQ1i0fDp
         cB7CjcgysOUXcFIwFuGHNCYO5yvlDDQzpRJrDHhWp/sLdTrIYq2lIIpgQRuOz7S4jx3L
         2lOu/PCHIsdOwSPZm66sP5U5otdyLkwKANhQDDxw7uyWPsDLLtZNfE9lm3qKC/9qykcA
         igyQ==
Received: by 10.180.81.166 with SMTP id b6mr6668020wiy.0.1332616550607;
        Sat, 24 Mar 2012 12:15:50 -0700 (PDT)
Received: from [192.168.1.13] (epw177.neoplus.adsl.tpnet.pl. [83.20.64.177])
        by mx.google.com with ESMTPS id df3sm25270544wib.1.2012.03.24.12.15.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 24 Mar 2012 12:15:50 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1332543417-19664-3-git-send-email-michal.kiedrowicz@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193841>

On Fri, 23 Mar 2012, Micha=C5=82 Kiedrowicz wrote:

> With this change, esc_html_hl_regions() accepts options and passes th=
em
> down to esc_html().  This may be needed if a caller wants to pass
> -nbsp=3D>1 to esc_html().
>=20
> The idea and implementation example of this change was described in
> 337da8d2 (gitweb: Introduce esc_html_match_hl and esc_html_hl_regions=
,
> 2012-02-27).  While other suggestions may be more useful in some case=
s,
> there is no need to implement them at the moment.  The
> esc_html_hl_regions() interface may be changed later if it's needed.
>=20
> Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
> ---
>=20
> Jakub, The code was in fact stolen from a yours patch posted to the
> list (gitweb: Use esc_html_match_hl() in 'grep' search) that wasn't
> merged so maybe I should pass the authorship to you?

Either passing authorship, with double signoff (mine and yours), and
note explaining modification, e.g.

  [mk: extracted from larger patch and wrote commit message]

or courtesy contribution in the form of signoff-like annotation just
before signoff, e.g.

  Based-on-patch-by: Jakub Nar=C4=99bski <jnareb@gmail.com>

is fine by me.
=20
>  gitweb/gitweb.perl |   10 ++++++----
>  1 files changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index af645e5..1744c40 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -1732,7 +1732,9 @@ sub chop_and_escape_str {
>  # '<span class=3D"mark">foo</span>bar'
>  sub esc_html_hl_regions {
>  	my ($str, $css_class, @sel) =3D @_;
> -	return esc_html($str) unless @sel;
> +	my %opts =3D grep { ref($_) ne 'ARRAY' } @sel;
> +	@sel     =3D grep { ref($_) eq 'ARRAY' } @sel;
> +	return esc_html($str, %opts) unless @sel;
> =20
>  	my $out =3D '';
>  	my $pos =3D 0;
> @@ -1741,14 +1743,14 @@ sub esc_html_hl_regions {
>  		# Don't craete empty <span> elements.
>  		next if $s->[1] <=3D $s->[0];
> =20
> -		$out .=3D esc_html(substr($str, $pos, $s->[0] - $pos))
> +		$out .=3D esc_html(substr($str, $pos, $s->[0] - $pos), %opts)
>  			if ($s->[0] - $pos > 0);
>  		$out .=3D $cgi->span({-class =3D> $css_class},
> -		                   esc_html(substr($str, $s->[0], $s->[1] - $s->[0=
])));
> +		                   esc_html(substr($str, $s->[0], $s->[1] - $s->[0=
]), %opts));
> =20
>  		$pos =3D $s->[1];
>  	}
> -	$out .=3D esc_html(substr($str, $pos))
> +	$out .=3D esc_html(substr($str, $pos), %opts)
>  		if ($pos < length($str));
> =20
>  	return $out;
> --=20
> 1.7.8.4
