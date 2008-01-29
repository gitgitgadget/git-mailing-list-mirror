From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: convert from perl internal to utf8 for commitdiff_plain
Date: Tue, 29 Jan 2008 03:09:50 -0800 (PST)
Message-ID: <m3prvk99c8.fsf@localhost.localdomain>
References: <87ve5dicih.wl@mail2.atmark-techno.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-3
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Yasushi SHOJI <yashi@atmark-techno.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 12:10:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJoMU-0000ck-RK
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 12:10:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753901AbYA2LJz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Jan 2008 06:09:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753979AbYA2LJz
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jan 2008 06:09:55 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:36871 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752383AbYA2LJy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Jan 2008 06:09:54 -0500
Received: by fg-out-1718.google.com with SMTP id e21so2052996fga.17
        for <git@vger.kernel.org>; Tue, 29 Jan 2008 03:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:content-transfer-encoding:from:date;
        bh=Gnr/je8+jLS/Pr2JKNnHD5JR58AvtNGhCWwLkifnbm4=;
        b=NnIqgVRhx5VhvIe4lY11g5W4nfjZfrW6IQagBZhkzogMetwWamppBBhYn1sl4v4MSPqAvUJBE7feQAi6/DY29hpqOgRMqz/EWyv6K/i0/knDjTaSmhmAR8NgYIratg2k6f5mkD7aEpedSb1EeMXPIVYdK+Vr92btOMluu6xa5NQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:content-transfer-encoding:from:date;
        b=SLq7uC9hRxPhPmd/O++EZM9kaBcpfvLkhXr9x6mH0x2IxzhsEY5ltQKFm9k2miMTBzgvdwoW909nS2xMUtVwDCpk6bymR7XTqR267g7skU9Qri/78cQEfm9O7dMFGhhWR54kV4yrkuoh0QVwmOHBvRLCkgBTPEWA1/ltvbdz2GA=
Received: by 10.82.134.12 with SMTP id h12mr11925852bud.29.1201604992157;
        Tue, 29 Jan 2008 03:09:52 -0800 (PST)
Received: from localhost.localdomain ( [83.8.244.23])
        by mx.google.com with ESMTPS id j8sm8814692gvb.7.2008.01.29.03.09.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 29 Jan 2008 03:09:50 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m0TB9jlm027315;
	Tue, 29 Jan 2008 12:09:46 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m0TB9ifX027312;
	Tue, 29 Jan 2008 12:09:44 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <87ve5dicih.wl@mail2.atmark-techno.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71974>

Yasushi SHOJI <yashi@atmark-techno.com> writes:

> commitdiff with raw, or plain format if you are reading the code,
> doesn't convert any word from perl internal to utf8, which is set to
> charset in http header.  this cause a problem when commit includes no=
n
> ascii code.

Nice catch. Thanks.
=20
> here is a few example in the git tree:
>=20
> http://git.kernel.org/?p=3Dgit/git.git;a=3Dcommitdiff_plain;h=3D6ba78=
238a824282816944550edc4297dd2808a72
> http://git.kernel.org/?p=3Dgit/git.git;a=3Dcommitdiff_plain;h=3De360b=
ebf713b6b03768c62de8b94ddf9350b0953
> http://git.kernel.org/?p=3Dgit/git.git;a=3Dcommitdiff_plain;h=3D9459a=
a77a032621a29d53605542844641cca843a

=2E..but commit message could be improved :-)

=46or example:

-- >8 --
gitweb: Convert generated contents to utf8 in commitdiff_plain

If the commit message, or commit author contains non-ascii, it must be
converted from Perl internal representation to utf-8, to follow what
got declared in HTTP header.  Use to_utf8() to do the conversion.

This necessarily replaces here-doc with "print" statements.

Signed-off-by: Yasushi SHOJI <yashi@atmark-techno.com>
Acked-by: =A9smail D=F6nmez <ismail@pardus.org.tr>
Acked-by: Jakub Narebski <jnareb@gmail.com>
-- >8 --

> This patch effectively revert the commitdiff plain part of the commit
>=20
> 	59b9f61a3f76762dc975e99cc05335a3b97ad1f9
>=20
> which converted from print to here-doc. but it doesn't
> explain why in the commit log.

Sorry about that.

IMVHO using here-doc for longer sequence of output lines is more
readable than long "print" command, or sequence of print's. But of
course if you have to parse / transform some parts of output it is
simply not possible.

> ---
>  gitweb/gitweb.perl |   12 ++++++------
>  1 files changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 6256641..5d9ac1d 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -5048,16 +5048,16 @@ sub git_commitdiff {
>  			-expires =3D> $expires,
>  			-content_disposition =3D> 'inline; filename=3D"' . "$filename" . =
'"');
>  		my %ad =3D parse_date($co{'author_epoch'}, $co{'author_tz'});
> -		print <<TEXT;
> -From: $co{'author'}
> -Date: $ad{'rfc2822'} ($ad{'tz_local'})
> -Subject: $co{'title'}
> -TEXT
> +		print "From: " . to_utf8($co{'author'}) . "\n";
> +		print "Date: " . to_utf8($ad{'rfc2822'}) . " "
> +			       . to_utf8($ad{'tz_local'}) . "\n";

I think that date, or at least timezone would never have characters
outside US-ASCII, so to_uft8 is not really necessary, but I guess that
it is better to be safe than sorry.

> +		print "Subject: " . to_utf8($co{'title'}) . "\n";
> +
>  		print "X-Git-Tag: $tagname\n" if $tagname;
>  		print "X-Git-Url: " . $cgi->self_url() . "\n\n";
> =20
>  		foreach my $line (@{$co{'comment'}}) {
> -			print "$line\n";
> +			print to_utf8($line) . "\n";
>  		}
>  		print "---\n\n";
>  	}

By the way, I guess that with new git we could just use --pretty=3Demai=
l
option to git-log / git-rev-list, and add X-Git-Tag and X-Git-Url at
the beginning (or insert it after headers).  Perhaps also generate
diff with the same diff command... but I think this improvement is to
be done _after_ release.

=46or what is worth:

Acked-by: Jakub Narebski <jnareb@gmail.com>

--=20
Jakub Narebski
Poland
ShadeHawk on #git
