From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] count-objects: output "KiB" instead of "kilobytes"
Date: Wed, 03 Apr 2013 07:38:47 -0700
Message-ID: <7vd2ub7k7c.fsf@alter.siamese.dyndns.org>
References: <7vip44a8xl.fsf@alter.siamese.dyndns.org>
 <1364993331-20199-1-git-send-email-mihai@mihaic.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Mihai =?utf-8?Q?Capot=C4=83?= <mihai@mihaic.ro>
X-From: git-owner@vger.kernel.org Wed Apr 03 16:39:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNOqR-000477-W4
	for gcvg-git-2@plane.gmane.org; Wed, 03 Apr 2013 16:39:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758677Ab3DCOiz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Apr 2013 10:38:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48269 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757146Ab3DCOiy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Apr 2013 10:38:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A6B0412892;
	Wed,  3 Apr 2013 14:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=zRLNg84N1XZ2
	/8vHeKk3z2vYWDM=; b=v4VJbMt2dS1mHglHwoWDEXF/Q/somP2xOis6imWRwux3
	zYt3RxEWneySUUvUFOzQKmLb2Bcstn5/sS7rQO1C0cIKabcLFgkCuV8ktp8oyG8E
	Vs2iFABreCvR4YtNsr6SqIYxpLJYThjR4km2ldSqceZClMcNcPAiUVM5GwCZxlk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=tOwnG1
	GuOVO92FD6A0kKnSeQ/DynkfoPTZNIllOnlhJ4HnmalOz4I+sIYyb2zl7pEj2DNl
	MtzdFa3PNvCh3OnOmTNYQ6LmsT+4X6O5NCTAAgXguoIURvnsCOYYgxWQffBhcDND
	HMYWg5TvpHMBx3upZPnT31YdgHiVdj3rVrJRE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 99FE912891;
	Wed,  3 Apr 2013 14:38:49 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F319812890; Wed,  3 Apr
 2013 14:38:48 +0000 (UTC)
In-Reply-To: <1364993331-20199-1-git-send-email-mihai@mihaic.ro> ("Mihai
 =?utf-8?Q?Capot=C4=83=22's?= message of "Wed, 3 Apr 2013 14:48:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 325FD5CE-9C6C-11E2-A0D9-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219938>

Mihai Capot=C4=83 <mihai@mihaic.ro> writes:

> The code uses division by 1024. The master branch count-objects manua=
l also
> uses "KiB".
>
> Also updated the code that reads count-objects output (t5301, t5700, =
t7408, and
> git-cvsimport) and the Git User's Manual.
>
> Signed-off-by: Mihai Capot=C4=83 <mihai@mihaic.ro>
> ---
>  Documentation/user-manual.txt  |    4 ++--
>  builtin/count-objects.c        |    2 +-
>  git-cvsimport.perl             |    8 ++++----
>  t/t5301-sliding-window.sh      |    4 ++--
>  t/t5700-clone-reference.sh     |    4 ++--
>  t/t7408-submodule-reference.sh |    4 ++--
>  6 files changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/Documentation/user-manual.txt b/Documentation/user-manua=
l.txt
> index e831cc2..b61a09c 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -3175,7 +3175,7 @@ lot of objects.  Try this on an old project:
> =20
>  ------------------------------------------------
>  $ git count-objects
> -6930 objects, 47620 kilobytes
> +6930 objects, 47620 KiB
>  ------------------------------------------------
> =20
>  The first number is the number of objects which are kept in
> @@ -3215,7 +3215,7 @@ You can verify that the loose objects are gone =
by looking at the
> =20
>  ------------------------------------------------
>  $ git count-objects
> -0 objects, 0 kilobytes
> +0 objects, 0 KiB
>  ------------------------------------------------
> =20
>  Although the object files are gone, any commands that refer to those

It is good to see the patch being thorough, adjusting even
documentation.

> diff --git a/git-cvsimport.perl b/git-cvsimport.perl
> index 73d367c..de44e33 100755
> --- a/git-cvsimport.perl
> +++ b/git-cvsimport.perl
> @@ -1126,12 +1126,12 @@ unless ($opt_P) {
>  }
> =20
>  # The heuristic of repacking every 1024 commits can leave a
> -# lot of unpacked data.  If there is more than 1MB worth of
> +# lot of unpacked data.  If there is more than 1MiB worth of
>  # not-packed objects, repack once more.
>  my $line =3D `git count-objects`;
> -if ($line =3D~ /^(\d+) objects, (\d+) kilobytes$/) {
> -  my ($n_objects, $kb) =3D ($1, $2);
> -  1024 < $kb
> +if ($line =3D~ /^(\d+) objects, (\d+) KiB$/) {
> +  my ($n_objects, $kib) =3D ($1, $2);
> +  1024 < $kib
>      and system(qw(git repack -a -d));
>  }

This hunk makes me wonder if this s/kilobytes/kib/ is a good idea in
the first place.  This in-tree user was lucky enough to have been
caught and adjusted, but we don't know how many out-of-tree scripts
are broken the same way and in need of a similar treatment.
