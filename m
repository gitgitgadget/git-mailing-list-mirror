From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Document pack v4 format
Date: Tue, 27 Aug 2013 11:25:02 -0700
Message-ID: <xmqqzjs3c7pd.fsf@gitster.dls.corp.google.com>
References: <1377577567-27655-1-git-send-email-nico@fluxnic.net>
	<1377602225-30439-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 27 20:25:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VENx4-0000zU-0q
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 20:25:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752719Ab3H0SZI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Aug 2013 14:25:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42381 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752237Ab3H0SZH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Aug 2013 14:25:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9978E3C749;
	Tue, 27 Aug 2013 18:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=rw5SAlEODH6e
	IlMZVXVXaUAlORM=; b=dbFPUD+qjPLWBTTa2ECYOfsmT8VFuaMof+h+vI4gtunt
	6TzadpO/iKKBXluQ1yXkSCn8jkMeD2I4x3V5B7vxLBevi7YypZMAEOU0y+qLrogf
	Oo5xZ75/aOVGjlWc0/dFq7cBxVeLOvCLirW1moosB4Hs9liX7jPZWtX8Ls1Ds54=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=XquoHG
	biV1JDywGqKhI5Xuxq6YtSBSdRJ1oT2UoTpnElGyas3qFN6NIcRi8u3kb5C/mVSA
	XI5gKYhBD9YTHjBjybm2Wdtz5IhfcCiHB82VvKnZB2EIYR6qGUH9/ryYH66MvZa1
	7z6N0dhiKI8Pv2wJJTsrHedFSY5xfZ0cM4fpM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D4CE3C748;
	Tue, 27 Aug 2013 18:25:05 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B38893C744;
	Tue, 27 Aug 2013 18:25:04 +0000 (UTC)
In-Reply-To: <1377602225-30439-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 27
 Aug 2013 18:17:05 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FE746C96-0F45-11E3-888C-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233132>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  For my education but may help people who are interested in the
>  format. Most is gathered from commit messages, except the delta tree
>  entries.

Thanks.

> diff --git a/Documentation/technical/pack-format-v4.txt b/Documentati=
on/technical/pack-format-v4.txt

In the final version it may be a good idea to either have this
together with the documentation for the existing pack-formats, or
add a reference from the documentation for the existing formats to
point at this new file saying "for v4 see ...".

> new file mode 100644
> index 0000000..9123a53
> --- /dev/null
> +++ b/Documentation/technical/pack-format-v4.txt
> @@ -0,0 +1,110 @@
> +Git pack v4 format
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +=3D=3D pack-*.pack files have the following format:
> +
> +   - A header appears at the beginning and consists of the following=
:
> +
> +     4-byte signature:
> +	  The signature is: {'P', 'A', 'C', 'K'}
> +
> +     4-byte version number (network byte order): must be version
> +     number 4
> +
> +     4-byte number of objects contained in the pack (network byte
> +     order)
> +
> +   - (20 * nr_objects)-byte SHA-1 table: sorted in memcmp() order.
> +
> +   - Commit name dictionary: the uncompressed length in variable
> +     encoding, followed by zlib-compressed dictionary. Each entry
> +     consists of two prefix bytes storing timezone followed by a
> +     NUL-terminated string.

The log and code use different names to call this thing.  "commit
name" is misleading (e.g. it is not "commit object name", but "names
recorded in commit objects"; it is not only for "committer" names,
but also applies to authors; it is not just names but also emails
and TZ used).  Perhaps a better name would be "ident" table, as we
use the word "ident" only to refer to data to refer to people who
are recorded on either author/committer/tagger lines of the objects?

> +     (undeltified representation)
> +     n-byte type and length (4-bit type, (n-1)*7+4-bit length)
> +     [uncompressed data]
> +     [compressed data]

These two lines are not useful; it is better spelled as [data
specific to object type] as you have to enumerate what are stored
and how for each type separately anyway.

> +=3D=3D=3D Tree representation
> +
> +  - n-byte type and length (4-bit type, (n-1)*7+4-bit length)
> +
> +  - Number of trees in variable length encoding
> +
> +  - A number of trees, each consists of

The above "number of trees" sounds both wrong; aren't they the
number of "tree entries" (that can be blobs or subtrees) this tree
object records?

> +    Path component reference: an index, in variable length encoding,
> +    into tree path dictionary, which also covers entry mode.
> +
> +    SHA-1 in SHA-1 reference encoding.
> +
> +Path component reference zero is an indicator of deltified portion a=
nd
> +has the following format:
> +
> +  - path component reference: zero
> +
> +  - index of the entry to copy from, in variable length encoding
> +
> +  - number of entries in variable length encoding
> +
> +  - base tree in SHA-1 reference encoding
> +
> +=3D=3D=3D SHA-1 reference encoding
> +
> +This encoding is used to encode SHA-1 efficiently if it's already in
> +the SHA-1 table. It starts with an index number in variable length
> +encoding. If it's not zero, its value minus one is the index in the
> +SHA-1 table. If it's zero, 20 bytes of SHA-1 is followed.
