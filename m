From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/6] read-cache: use sha1file for sha1 calculation
Date: Sun, 05 Feb 2012 23:34:55 -0800
Message-ID: <7vsjio8leo.fsf@alter.siamese.dyndns.org>
References: <1328507319-24687-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Thomas Rast <trast@inf.ethz.ch>,
	Joshua Redstone <joshua.redstone@fb.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 06 08:35:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuJ6N-0007uR-8e
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 08:35:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432Ab2BFHe6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Feb 2012 02:34:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41133 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750817Ab2BFHe6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Feb 2012 02:34:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 60AEE485F;
	Mon,  6 Feb 2012 02:34:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Erbr1MvFRi/z
	80+v6+tufOc2uXE=; b=IZyluuzyGdG7FaJgJ1eZiUe3NJV+e530rmYJ1Gol4RG/
	DEGVCWHjYNKbaijSYtaIP//QdpI+q8UqTtgg/wKpSiwrYpXLc5yaTDqa0cVJPPWI
	0nnbrzcwnl7tvP2c8z0q1498y+OAg1L7eOU1c15h83a/TKkSLcdpdFy0y5YHzF4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ZlJveu
	i1gPlJ7Gv6SQ9YJ+SVM4zBGrDrqP5DzKtlwxFzTE/TKfpfLPfMc4NzUkeIFngIbn
	jaxMii++4Hyw3L+stHXxQq8h/bZa38GJ6PyOAvlwh1bpj0Erf+O1RKSkvtPNjpeW
	Cy5LrdP1tlLznpM9Hu+vt2YkY1ajXoFTqbAAE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 582E5485E;
	Mon,  6 Feb 2012 02:34:57 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D068A485C; Mon,  6 Feb 2012
 02:34:56 -0500 (EST)
In-Reply-To: <1328507319-24687-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 6 Feb
 2012 12:48:34 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 11504338-5095-11E1-A41B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190037>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>

Having no explanation on any of the patch in the series without cover
letter makes it hard to comment on anything, and not having any numbers
makes it even harder after guessing that this is about some performance
tweaks for 2M entry index cases.

This is open source, and I wouldn't stop you from spending time on anyt=
hing
that interests you.

But having said that, if you have extra Git time, I would still rather =
see
you spend it first on tying up loose ends of your topics in flight and
on helping others that touch parts that are related to areas that you h=
ave
already thought about, namely:

 (1) nd/commit-ignore-i-t-a, which I think should be marketted as fixin=
g
     an earlier UI mistake and presented with a clean migration path to
     make the updated behaviour the default in the future; and

 (2) the negative pathspec thing that resurfaced in disguise as Albert
     Yale's "grep --exclude" series.

than playing with the approach of this series.  The two reasons I suspe=
ct
that spending your time on this series will give us much less value tha=
n
the above two topics out of you are:

 (1) While I think 2M-entry index is an interesting issue, it does not
     affect most of the people; and more importantly

 (2) I think the proper way to handle 2M-entry index case is to avoid
     having to write and read the whole 2M-entry as a flat table in the
     first place, not by weakening how its integrity is assured in orde=
r
     to micro-tweak the read/write efficiency without re-examining the
     flatness of the current in-core index [*1*].

The first patch that reuses the existing csum-file API to older code th=
at
was written before csum-file was invented is probably a good thing to d=
o,
though, independent of the 2M-entry issue.

Thanks.


[Footnote]

*1* A possible approach might be to stuff unmodified trees in the index
without exploding them into its components, and as entries are modified=
,
lazily expand these "tree" entries, while ensuring the "unmodified" par=
ts
remain unmodified by turning the files in the working tree read-only an=
d
requiring the user to say "git edit" or "git open" or something before
starting to edit.  But as I said, I consider this not an ultra-urgent
issue, so I haven't thought things through yet.
