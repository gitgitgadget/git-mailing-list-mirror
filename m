From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] contrib/subtree: Make testing easier
Date: Wed, 20 Jan 2016 11:28:33 -0800
Message-ID: <xmqqvb6o59um.fsf@gitster.mtv.corp.google.com>
References: <44704afe6f728263b5200da2b343783a5a209eca.1453074427.git.greened@obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, sunshine@sunshineco.com,
	davidw@realtimegenomics.com
To: David Greene <greened@obbligato.org>
X-From: git-owner@vger.kernel.org Wed Jan 20 20:28:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLyQx-000809-26
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 20:28:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753635AbcATT2n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2016 14:28:43 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55645 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755040AbcATT2l (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2016 14:28:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DAB233C3A4;
	Wed, 20 Jan 2016 14:28:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KK/wwYac6rEOA0oisIwNmRRHXrY=; b=E6w54L
	PYYgdbuYOR9Qdziml18ZmW6x27aW99Lw6yXx1Y/Jo+X43XQJ1bJDWBrgMnXTsOw2
	JmtJ4F8AfH9TUwyJKCUSLGK9nrlx61qhK2bcMp/n57o2AMSr1Hxv1C0eBTRgFqF+
	58A9buVs7LdFzUWQoaj2hB7hAuGNhZ2kL0zXI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vY/Lh0o74bt5ohmA3OKRILek4pZlK1XX
	7xPwhg4FX4fg0lPJthSsWIcm2kJWIIu1wi+rduB3E09FHwNLp4+CC4ENPds06Yap
	FHEQg3DfN0Z81sitmRpaxv3vBGW+fZTo1rmvOshP2x+5Z64sGIzuaTZ2R74buhmc
	dc5FXTEouRM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D28393C3A1;
	Wed, 20 Jan 2016 14:28:35 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 43D963C39F;
	Wed, 20 Jan 2016 14:28:35 -0500 (EST)
In-Reply-To: <44704afe6f728263b5200da2b343783a5a209eca.1453074427.git.greened@obbligato.org>
	(David Greene's message of "Sun, 17 Jan 2016 17:47:59 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FF94DF98-BFAB-11E5-B2C2-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284459>

David Greene <greened@obbligato.org> writes:

> From: David A. Greene <greened@obbligato.org>
>
> Add some Makefile dependencies to ensure an updated git-subtree
> gets copied to the main area before testing begins.
>
> Signed-off-by: David A. Greene <greened@obbligato.org>
> ---
>
> Notes:
>     v1 - Initial patch

This looks OK to me, but does this change make what's written in
contrib/subtree/INSTALL somewhat stale?

>
>  contrib/subtree/Makefile | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/contrib/subtree/Makefile b/contrib/subtree/Makefile
> index 3071baf..6afa9aa 100644
> --- a/contrib/subtree/Makefile
> +++ b/contrib/subtree/Makefile
> @@ -37,6 +37,7 @@ GIT_SUBTREE_DOC := git-subtree.1
>  GIT_SUBTREE_XML := git-subtree.xml
>  GIT_SUBTREE_TXT := git-subtree.txt
>  GIT_SUBTREE_HTML := git-subtree.html
> +GIT_SUBTREE_TEST := ../../git-subtree
>  
>  all:: $(GIT_SUBTREE)
>  
> @@ -71,7 +72,10 @@ $(GIT_SUBTREE_HTML): $(GIT_SUBTREE_TXT)
>  	$(ASCIIDOC) -b xhtml11 -d manpage -f $(ASCIIDOC_CONF) \
>  		-agit_version=$(GIT_VERSION) $^
>  
> -test:
> +$(GIT_SUBTREE_TEST): $(GIT_SUBTREE)
> +	cp $< $@
> +
> +test: $(GIT_SUBTREE_TEST)
>  	$(MAKE) -C t/ test
>  
>  clean:
