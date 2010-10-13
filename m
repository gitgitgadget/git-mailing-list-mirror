From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 5/4] Documentation: flesh out diff --no-index
 description
Date: Wed, 13 Oct 2010 15:40:29 -0700
Message-ID: <7vtykphg2q.fsf@alter.siamese.dyndns.org>
References: <20101011150342.292ad725@chalon.bertin.fr>
 <AANLkTinqPiGf1nbo0oOvDD5edgLBdO8xZfjGeFC4q0MU@mail.gmail.com>
 <20101011161721.35940919@chalon.bertin.fr> <20101011160224.GA25842@burratino>
 <20101011160718.GF25842@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yann Dirson <dirson@bertin.fr>,
	Santi =?utf-8?Q?B=C3=A9jar?= <santi@agolina.net>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 14 00:40:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6A06-0001Id-HK
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 00:40:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753461Ab0JMWkm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 18:40:42 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52308 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753425Ab0JMWkl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 18:40:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D2AA2DE056;
	Wed, 13 Oct 2010 18:40:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IQuza1GvX78FmTg+7xYk7EUUD+s=; b=bieGSo
	1B5ayRuJaFNp6fTt++ECVWMXdmcycmPAoFs7IPQvMbz//+A+dNBhsfRLrteI/fs+
	lDzk+b1YnR/zhhHJWfn6+CP6XQvDIWAk3fOLRwNpEEyhkRzRONWt2bt5y+EQK/tW
	DdsyW636sg5wDD9nj7Xp1hJ93hBgWQzRpS0c4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QR1onKvk3A1plRFk+D4GEWDpW7xa3zIW
	DLFtseQV0ym9h6qEh9g7zSaOkra5NWroysuq4/p42G/YiKM/yDU1ADJ1k8Pp9ZiR
	fBH43ZJBft7iODURl3bSqCcM8m6Y1i9bv9Wm/AuyobzxSRsTGQnQnmWikiV6dCie
	0XgCmZOlYKc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6AC0FDE050;
	Wed, 13 Oct 2010 18:40:36 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5A58EDE04C; Wed, 13 Oct
 2010 18:40:31 -0400 (EDT)
In-Reply-To: <20101011160718.GF25842@burratino> (Jonathan Nieder's message of
 "Mon\, 11 Oct 2010 11\:07\:18 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E58139A0-D71A-11DF-8EFA-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158996>

Jonathan Nieder <jrnieder@gmail.com> writes:

> +'git diff' [--options] --no-index [--] <path> <path>::
> +
> +	In this form, 'git diff' will compare a pair of files or
> +	directories that are not necessarily being managed by git.
> +	The tracked content of files in the index and the object
> +	database are ignored.
> ++
> +In other words, this form allows 'git diff' to be used as a
> +traditional 'diff' command (plus the familiar extras like --check,
> +color, pagination, automatic use of -r, --stat/--name-status,
> +--pickaxe, --binary, copy/rename detection, -Oorderfile, and
> +--patience).

My initial knee-jerk reaction was "how would -C/-M/-O be useful when you
can only give two paths?"  Perhaps it would become easier to read if we
phrased it like this?

    This form allows 'git diff' to be used as a better 'diff' command,
    with extras like whitespace checks (--check), coloring (--color),
    wordwise diff (--color-words), pagination, diffstat (--stat), binary
    patch (--binary), alternative algorithm (e.g. --patience).  In
    addition, when comparing two directories, rename detection (-M) may
    come in handy.

Note, by the way, that I didn't verify all the claims the above makes.
