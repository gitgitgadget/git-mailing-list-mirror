From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Worktree vs. working copy
Date: Tue, 20 Sep 2011 14:45:40 -0700
Message-ID: <7vliti2hoq.fsf@alter.siamese.dyndns.org>
References: <1316505022.13996.12.camel@bee.lab.cmartin.tk>
 <CALkWK0mHQZEPKk3Dy3RSp70thcsw3x6RSvUxTuPVzzRjgsM8-A@mail.gmail.com>
 <7vhb476ned.fsf@alter.siamese.dyndns.org>
 <1316550362.8701.32.camel@centaur.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Wed Sep 21 14:39:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6M5F-0005cw-Tf
	for gcvg-git-2@lo.gmane.org; Wed, 21 Sep 2011 14:39:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753535Ab1IUMjV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Sep 2011 08:39:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61764 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752529Ab1IUMjU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Sep 2011 08:39:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 597E24712;
	Wed, 21 Sep 2011 08:39:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=6N83A22KANXZPqECOApI1pP5P
	so=; b=SebEKd2OGh7bti8jZpB1J2amg8waV2JEMuSvfmOr4FNJtJonZEzHaEQmO
	N/iCDbgliPMMIy+BjDsD9A5ZqwvDit7l3LskRP2OG6t+L6UPxbcYXkWOrfxpFara
	3E2eGwzMjZBNjRF/9t9mm6KBw5fVNCK7zk7AGwqC/s/rjgkHMs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=AWCSi0nLlt3Y7pIIpg3
	aA1VAlsImzUrfZbE6HC0b4T7SBRKko05l3rBYIFsXBybp1o4BamZPhINDarId1Vy
	fE+nA8W0FyrYtfcz/brhn6np4+LGjhOijbsWO0nq7WQ8ahvUsucQCnBppjfXcKkp
	UVch09Hqp6qLJxoAuXlpSRHY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 51AD24711;
	Wed, 21 Sep 2011 08:39:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DA5E94710; Wed, 21 Sep 2011
 08:39:18 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B9551904-E44E-11E0-A240-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181840>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:

> Subject: [PATCH] Remove 'working copy' from the documentation and C c=
ode
>
> The git term is 'working tree', so replace the most public references
> to 'working copy'.
>
> Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>

Thanks.

"working tree" is a term used to collectively call the whole, and I thi=
nk
all the places in your patch read better with "working tree".

People with background from other systems refer to one particular file =
in
the working tree as "working copy", I think, but...

>  core.fileMode::
>  	If false, the executable bit differences between the index and
> -	the working copy are ignored; useful on broken filesystems like FAT=
=2E
> +	the working tree are ignored; useful on broken filesystems like FAT=
=2E

=2E.. this compares "the index and the working tree", meaning each path=
 in
the index and the corresponding file in the working tree (both are take=
n
as a _collection_), so this rewrite makes perfect sense.  The same for
the description for trustctime.

> @@ -292,7 +292,7 @@ core.ignoreStat::
>  	If true, commands which modify both the working tree and the index
>  	will mark the updated paths with the "assume unchanged" bit in the
>  	index. These marked files are then assumed to stay unchanged in the
> -	working copy, until you	mark them otherwise manually - Git will not
> +	working tree, until you mark them otherwise manually - Git will not

This again is "paths in the" working tree, and the term is used as a
collection (good).  The same for "git-svn" manpage.

> diff --git a/diff-lib.c b/diff-lib.c
> index 9c29293..c7d33d7 100644
> --- a/diff-lib.c
> +++ b/diff-lib.c
> @@ -289,7 +289,7 @@ static void show_new_file(struct rev_info *revs,
> =20
>  	/*
>  	 * New file in the index: it might actually be different in
> -	 * the working copy.
> +	 * the working tree.
>  	 */

We are looking at one path, and wondering if it is different "in the"
working tree---again used as a collection (it would have said "it might
actually be different from the working copy" if it referred to an insta=
nce
in the collection). The same for the comment in merge-recursive.c.
