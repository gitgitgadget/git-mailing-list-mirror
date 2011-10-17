From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC 1/2] gitweb: change format_diff_line() to remove leading SP from $diff_class
Date: Mon, 17 Oct 2011 13:56:30 -0700 (PDT)
Message-ID: <m38voj72xy.fsf@localhost.localdomain>
References: <CAFo4x0LP4fXgSNAnss_WRLo-TH_qe=esYn7P+=iS6t87tdzcbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-4
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Kato Kazuyoshi <kato.kazuyoshi@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 17 22:56:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFuEg-0007Fg-MT
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 22:56:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753990Ab1JQU4e convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Oct 2011 16:56:34 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:35879 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753486Ab1JQU4d convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Oct 2011 16:56:33 -0400
Received: by bkbzt19 with SMTP id zt19so4123671bkb.19
        for <git@vger.kernel.org>; Mon, 17 Oct 2011 13:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=BIKJeoXrw1JljSfafQFh6DUPezCKof8lcufvUjP1BPI=;
        b=Z7aAtNXpjuwSot6lBjNkEtIgCNhWqrtU7IsS2cGJAEMdKc3NaQV3XcKVO/STYH71AC
         ZwFdemX2tqHnV1+PDmvo9pe2gLOym6joCQEuu6ir0tCq0qQ85IpKtGCKTsesQQ7iuzzG
         SV0YiH2GOWASyhkTJk4Nr/wacb8kQksMgKyhU=
Received: by 10.223.14.134 with SMTP id g6mr26632945faa.11.1318884991804;
        Mon, 17 Oct 2011 13:56:31 -0700 (PDT)
Received: from localhost.localdomain (absh126.neoplus.adsl.tpnet.pl. [83.8.127.126])
        by mx.google.com with ESMTPS id u6sm25383449fan.17.2011.10.17.13.56.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 17 Oct 2011 13:56:30 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p9HKu5jv014053;
	Mon, 17 Oct 2011 22:56:15 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p9HKtsFq014047;
	Mon, 17 Oct 2011 22:55:54 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <CAFo4x0LP4fXgSNAnss_WRLo-TH_qe=esYn7P+=iS6t87tdzcbw@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183821>

By the way, it is common to either have following patches to be chain
reply to first patch, or better provide cover letter for patch series
and have all patches be reply to cover letter.


Kato Kazuyoshi <kato.kazuyoshi@gmail.com> writes:

This commit needs some more explanation in the commit message, like
Junio said.

> The format_diff_line() will return $diff_class and HTML in upcoming c=
hanges.

This is not necessary, I think; this change stands alone as a style
(semantic) cleanup.

Signoff?  See Documentation/SubmittingPatches

> ---
>  gitweb/gitweb.perl |   24 +++++++++++++-----------
>  1 files changed, 13 insertions(+), 11 deletions(-)
>=20
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 85d64b2..095adda 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -2235,28 +2235,30 @@ sub format_diff_line {
>  		# combined diff
>  		my $prefix =3D substr($line, 0, scalar @{$from->{'href'}});
>  		if ($line =3D~ m/^\@{3}/) {
> -			$diff_class =3D " chunk_header";
> +			$diff_class =3D "chunk_header";
>  		} elsif ($line =3D~ m/^\\/) {
> -			$diff_class =3D " incomplete";
> +			$diff_class =3D "incomplete";
>  		} elsif ($prefix =3D~ tr/+/+/) {
> -			$diff_class =3D " add";
> +			$diff_class =3D "add";
>  		} elsif ($prefix =3D~ tr/-/-/) {
> -			$diff_class =3D " rem";
> +			$diff_class =3D "rem";
>  		}

Hmmm... that reminds me: this if-elsif chain is a bit ugly, but would
be hard to replace without given ... when, I think.

>  	} else {
>  		# assume ordinary diff
>  		my $char =3D substr($line, 0, 1);
>  		if ($char eq '+') {
> -			$diff_class =3D " add";
> +			$diff_class =3D "add";
>  		} elsif ($char eq '-') {
> -			$diff_class =3D " rem";
> +			$diff_class =3D "rem";
>  		} elsif ($char eq '@') {
> -			$diff_class =3D " chunk_header";
> +			$diff_class =3D "chunk_header";
>  		} elsif ($char eq "\\") {
> -			$diff_class =3D " incomplete";
> +			$diff_class =3D "incomplete";
>  		}

This is also ugly, but this one could in theory be replaced by hash
lookup.  But this would remove symmetry...

>  	}
>  	$line =3D untabify($line);
> +
> +	my $div_open =3D '<div class=3D"' . (join ' ', ('diff', $diff_class=
)) . '">';

Another solution would be to use

  +
  +	my $diff_classes =3D "diff";
  +	$diff_classes .=3D " $diff_class" if ($diff_class);
  +

>  	if ($from && $to && $line =3D~ m/^\@{2} /) {
>  		my ($from_text, $from_start, $from_lines, $to_text, $to_start,
> $to_lines, $section) =3D
>  			$line =3D~ m/^\@{2} (-(\d+)(?:,(\d+))?) (\+(\d+)(?:,(\d+))?) \@{2=
}(.*)$/;
> @@ -2274,7 +2276,7 @@ sub format_diff_line {
>  		}
>  		$line =3D "<span class=3D\"chunk_info\">@@ $from_text $to_text @@<=
/span>" .
>  		        "<span class=3D\"section\">" . esc_html($section, -nbsp=3D=
>1) .
> "</span>";

The above is word-wrapped.  Please turn off word wrapping in the
future to avoid such damage to the patch.

> -		return "<div class=3D\"diff$diff_class\">$line</div>\n";
> +		return "$div_open$line</div>\n";

This would be instead

  +		return "<div class=3D\"$diff_classes\">$line</div>\n";

which is a bit more symmetric.

But that is just a matter of taste.

>  	} elsif ($from && $to && $line =3D~ m/^\@{3}/) {
>  		my ($prefix, $ranges, $section) =3D $line =3D~ m/^(\@+) (.*?) \@+(=
=2E*)$/;
>  		my (@from_text, @from_start, @from_nlines, $to_text, $to_start, $t=
o_nlines);
> @@ -2307,9 +2309,9 @@ sub format_diff_line {
>  		}
>  		$line .=3D " $prefix</span>" .
>  		         "<span class=3D\"section\">" . esc_html($section, -nbsp=3D=
>1)
> . "</span>";
> -		return "<div class=3D\"diff$diff_class\">$line</div>\n";
> +		return "$div_open$line</div>\n";
>  	}
> -	return "<div class=3D\"diff$diff_class\">" . esc_html($line, -nbsp=3D=
>1)
> . "</div>\n";
> +	return $div_open . esc_html($line, -nbsp=3D>1) . "</div>\n";
>  }
>=20
>  # Generates undef or something like "_snapshot_" or "snapshot (_tbz2=
_ _zip_)",
> --=20
> 1.7.7.213.g8b0e1.dirty

--=20
Jakub Nar=EAbski
