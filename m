From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: restore a space in unpack-objects usage
Date: Thu, 31 Oct 2013 15:09:54 -0700
Message-ID: <xmqqy5592itp.fsf@gitster.dls.corp.google.com>
References: <1383255671-12784-1-git-send-email-vivien.didelot@savoirfairelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
X-From: git-owner@vger.kernel.org Thu Oct 31 23:10:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vc0RN-0005Iu-FJ
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 23:10:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753251Ab3JaWKB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 18:10:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60832 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751766Ab3JaWKA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 18:10:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B73F4F204;
	Thu, 31 Oct 2013 18:09:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sIEwVTdZBcCfQjvJOB1mx9OdqSQ=; b=fGaM12
	2VV5dZ6bh0OcoYwTR3GgYZ1rvEo1M0LKBkS6VwIMZAMli3p/tm9ql8MbPIBuVgAv
	1Ce3kNgXchslnsBMnvp49CNXXBqSRno2rj/CgQf3vDbMQexz7hRkLILdZXw3mb42
	wT9SoBql3y9DWfPn53NkH2Cnn/gwP3EdzUP9w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WBUu+2ewmnkpW+0/2deILNHWmSUivaUz
	DzVfawSz45PGasvOYLv+/KKUKDFOcs2i54dklXEBh3LkD8JCFps/1sVk0Q5gBU3Q
	EXUMWY15NHsfiy7U7SMP6U9h/CVniHjI+NFulZN4HfceF2b///XyHo1N6iKC2oSH
	f3fhcdvc+QI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C2E74F203;
	Thu, 31 Oct 2013 18:09:58 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 55BFE4F202;
	Thu, 31 Oct 2013 18:09:57 -0400 (EDT)
In-Reply-To: <1383255671-12784-1-git-send-email-vivien.didelot@savoirfairelinux.com>
	(Vivien Didelot's message of "Thu, 31 Oct 2013 17:41:11 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2D884A46-4279-11E3-BC2D-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237188>

Vivien Didelot <vivien.didelot@savoirfairelinux.com> writes:

> The commit 87b7b84 removed a space in the unpack-objects usage, which
> makes the synopsis a bit confusing. This patch simply restores it.
>
> Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
> ---
>  Documentation/git-unpack-objects.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-unpack-objects.txt b/Documentation/git-unpack-objects.txt
> index ff23494..817788e 100644
> --- a/Documentation/git-unpack-objects.txt
> +++ b/Documentation/git-unpack-objects.txt
> @@ -9,7 +9,7 @@ git-unpack-objects - Unpack objects from a packed archive
>  SYNOPSIS
>  --------
>  [verse]
> -'git unpack-objects' [-n] [-q] [-r] [--strict] <pack-file
> +'git unpack-objects' [-n] [-q] [-r] [--strict] < pack-file

Thanks; that change was indeed not intended.

Looking at synopsis sections for other commands that take their
input from the standard input (e.g. "git check-attr"), I think
we should make it clear that "pack-file" is not to be spelled as-is
at the same time, i.e.

	'git unpack-objects' [-n] [-q] [-r] [--strict] < <pack-file>
