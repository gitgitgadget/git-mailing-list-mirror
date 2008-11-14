From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2 02/11] gitweb: git_get_heads_list accepts an optional list of refs.
Date: Fri, 14 Nov 2008 19:48:57 +0100
Message-ID: <200811141948.57785.jnareb@gmail.com>
References: <1226616555-24503-1-git-send-email-giuseppe.bilotta@gmail.com> <1226616555-24503-2-git-send-email-giuseppe.bilotta@gmail.com> <1226616555-24503-3-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 14 19:50:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L13kZ-0007rc-Da
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 19:50:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754066AbYKNStH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Nov 2008 13:49:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752042AbYKNStG
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 13:49:06 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:30109 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753452AbYKNStD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2008 13:49:03 -0500
Received: by ug-out-1314.google.com with SMTP id 39so1729358ugf.37
        for <git@vger.kernel.org>; Fri, 14 Nov 2008 10:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=7wWDljHo6HRIx6WfC/j3jqtVw4++jtFO6w9DwE/6yLI=;
        b=lnHEy5xfmQGv14oTD4aFVE7aM2eNyViHU9X6s1YRu1MbXvMEJhFEhA9EED+g0srK3u
         Lk2goa6ec250tXAqv5cqBsohzjxsvoBZcSNi/EN95oea7XIrOqXKcPuPI5hDwdxH115b
         CGMhO87GpEmgJ9u8/WQ22s19H3LMD3UDoZR7c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=iCu3loeiFn860hZCTYdjvzzapkcQs8ESPpG0fhnPoavOOpwRfHpTN4C4lKIBTZPcz9
         eascSU3rmxwgloFlbh3lSf8Jt4hYuQ4dzJdNBzRJj7mGl6IYgpioeo+01aF9X5gAqsZz
         tGcra1ZfBDnum7oCToNcFoCJdyhcDHrtBV8Tk=
Received: by 10.210.51.10 with SMTP id y10mr1380931eby.87.1226688541908;
        Fri, 14 Nov 2008 10:49:01 -0800 (PST)
Received: from ?192.168.1.11? (abwt29.neoplus.adsl.tpnet.pl [83.8.243.29])
        by mx.google.com with ESMTPS id 10sm1209556eyd.6.2008.11.14.10.48.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 14 Nov 2008 10:49:00 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1226616555-24503-3-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101001>

Dnia czwartek 13. listopada 2008 23:49, Giuseppe Bilotta napisa=C5=82:

> git_get_heads_list(limit, dir1, dir2, ...) can now be used to retriev=
e
> refs/dir1, refs/dir2 etc. Defaults to ('heads') or ('heads', 'remotes=
')
> depending on the remote_heads option.

Minor nit: I think it would be better to use the same terminology in
commit message as in code, i.e. 'class1' instead of 'dir1', or perhaps
'ref_class1' if it would be better.

This is only a suggestion, but perhaps this patch could be squashed
with a later one?

>=20
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
> ---
>  gitweb/gitweb.perl |   11 +++++++----
>  1 files changed, 7 insertions(+), 4 deletions(-)
>=20
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index b6c4233..d7c97a3 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -2663,15 +2663,18 @@ sub parse_from_to_diffinfo {
>  ## parse to array of hashes functions
> =20
>  sub git_get_heads_list {
> -	my $limit =3D shift;
> +	my ($limit, @class) =3D @_;
> +	unless (defined @class) {
> +		my ($remote_heads) =3D gitweb_check_feature('remote_heads');
> +		@class =3D ('heads', $remote_heads ? 'remotes' : undef);
> +	}
> +	my @refs =3D map { "refs/$_" } @class;

Nice.

>  	my @headslist;
> =20
> -	my ($remote_heads) =3D gitweb_check_feature('remote_heads');
> -
>  	open my $fd, '-|', git_cmd(), 'for-each-ref',
>  		($limit ? '--count=3D'.($limit+1) : ()), '--sort=3D-committerdate'=
,
>  		'--format=3D%(objectname) %(refname) %(subject)%00%(committer)',
> -		'refs/heads', ( $remote_heads ? 'refs/remotes' : '')
> +		@refs
>  		or return;
>  	while (my $line =3D <$fd>) {
>  		my %ref_item;

So this is a bit of generalization of (part of) previous patch,
isn't it?

--=20
Jakub Narebski
Poland
