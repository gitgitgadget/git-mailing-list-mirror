From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] contrib/hooks: adapt default Debian install location for
 contrib hooks
Date: Tue, 20 Sep 2011 12:44:18 -0700
Message-ID: <7vr53b578t.fsf@alter.siamese.dyndns.org>
References: <20110920111914.17913.qmail@d29ca435be5a3d.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Tue Sep 20 21:44:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R66F1-0008Ps-PB
	for gcvg-git-2@lo.gmane.org; Tue, 20 Sep 2011 21:44:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086Ab1ITToX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Sep 2011 15:44:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40756 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750823Ab1ITToW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Sep 2011 15:44:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 021405E8A;
	Tue, 20 Sep 2011 15:44:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MK25xSd7XPRBRmjCgIuGfhHN2Og=; b=cxl892
	ZIL6+JeI9L6wXyoIwJhPlFQ3jcKrOwESrI1keJo2iVPg2lleCkYCuRRNsaYSBA18
	MLBMPEkKvVvHuiM2Z61MxEfQaBydkdJnoW3bS3r7ABU5uK9JtKhguoY5HpJNiAFx
	cARH524sIsYsWkVtv2g23pjjGv1VPV8zpKG5I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Pnddq7s1I4NidxnzaOZ7MlnAzEAeiAXo
	BOWrYxDeb16v7U6p3rN45/nlt/Tfn+CHf4DAiTQA+uJxuyQETeQFAoF6H0lCx0/Q
	dxBqU5AooSgf49vrnV5HXj/7xBgVTQiBM4Dk9aUbT2kmQwwxUe5WkyLOX+qjY1gQ
	hvnXCA/WlLA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EC82F5E89;
	Tue, 20 Sep 2011 15:44:20 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5CD325E88; Tue, 20 Sep 2011
 15:44:20 -0400 (EDT)
In-Reply-To: <20110920111914.17913.qmail@d29ca435be5a3d.315fe32.mid.smarden.org> (Gerrit
 Pape's message of "Tue, 20 Sep 2011 11:19:14 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EEFD2346-E3C0-11E0-B0D8-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181784>

Gerrit Pape <pape@smarden.org> writes:

> diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
> index fa6d41a..ba077c1 100755
> --- a/contrib/hooks/post-receive-email
> +++ b/contrib/hooks/post-receive-email
> @@ -11,11 +11,11 @@
>  # will have put this somewhere standard.  You should make this script
>  # executable then link to it in the repository you would like to use it in.
>  # For example, on debian the hook is stored in
> -# /usr/share/doc/git-core/contrib/hooks/post-receive-email:
> +# /usr/share/git-core/contrib/hooks/post-receive-email:
>  #
>  #  chmod a+x post-receive-email
>  #  cd /path/to/your/repository.git
> -#  ln -sf /usr/share/doc/git-core/contrib/hooks/post-receive-email hooks/post-receive
> +#  ln -sf /usr/share/git-core/contrib/hooks/post-receive-email hooks/post-receive

This one I do not have any problem with; the leading text makes it very
clear that this is an example that is specific to Debian and that is 
good enough to signal readers that they may have to look elsewhere if they
are on a different distribution.

> diff --git a/templates/hooks--post-receive.sample b/templates/hooks--post-receive.sample
> index 7a83e17..e48346e 100755
> --- a/templates/hooks--post-receive.sample
> +++ b/templates/hooks--post-receive.sample
> @@ -12,4 +12,4 @@
>  # see contrib/hooks/ for a sample, or uncomment the next line and
>  # rename the file to "post-receive".
>  
> -#. /usr/share/doc/git-core/contrib/hooks/post-receive-email
> +#. /usr/share/git-core/contrib/hooks/post-receive-email

I am however not sure about this. For one thing, it is not clear that this
(both old and new) text are meant to be Debian specific, and they should
not complain and instead should look for it elsewhere, if the users do not
find the sample in the path that is shown in the file. For another, it is
not "see ... for a sample, OR UNCOMMENT" at all, for readers who are _NOT_
interested in sending e-mails from the hook at all, but the way it is
stated makes it sound as if people who do not want to bother reading the
samples can blindly enable the hook and it is guaranteed that the
particular sample hook satisfies their needs, which is not the case.

Perhaps removing this sample file might be a better option. The first ten
lines or so repeat what the documentation says, which can go stale, and if
we remove them, the only thing that remains is the "see contrib/hooks for
a sample".

Thanks.
