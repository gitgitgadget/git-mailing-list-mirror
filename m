From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/8] contrib/subtree: Code cleaning and refactoring
Date: Mon, 18 Feb 2013 14:55:24 -0800
Message-ID: <7vy5el8c6b.fsf@alter.siamese.dyndns.org>
References: <1361221013-12756-1-git-send-email-greened@obbligato.org>
 <1361221013-12756-5-git-send-email-greened@obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Techlive Zheng <techlivezheng@gmail.com>,
	James Nylen <jnylen@gmail.com>
To: "David A. Greene" <greened@obbligato.org>
X-From: git-owner@vger.kernel.org Mon Feb 18 23:55:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7Zcl-0003zr-Ff
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 23:55:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757540Ab3BRWz1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 17:55:27 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61434 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757512Ab3BRWz1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 17:55:27 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 87DACB9B1;
	Mon, 18 Feb 2013 17:55:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=clMTe97KyueDCe2p3JTTHluZH3Y=; b=eZ+lQT
	FrCHVfZUK0M1HXGXUEPoskEYGx6dnEeNw0XFUSf++8PJu8poZLv//nLp6pSCuS2t
	AmZWRbkslw4FRyzTCHMVmdej9Dx6sLuyjrzokKjaTlbw4p95YuIbZ2WNzsYYT0YP
	aKtYtkGf3TZnIrqb6ox2o7sl7v/ipj/QTsQjo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ADeVEXUmR+OYKgQ6bpOCCpuiCDw/Beb4
	7mPP51OxOjIBUBgSnVuhEBPubteM+ehqVdh17m/0NVEOGOv3cIl+XeaGAhPHDDKh
	E13VbNdfUj9XJr7NEDcEJz7lmfAiNY9J8bNLn0p2R2GDrcpxNYvOUMHJwgaDHcOu
	erGFhcytp1g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C3DEB9B0;
	Mon, 18 Feb 2013 17:55:26 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DEEF5B9AF; Mon, 18 Feb 2013
 17:55:25 -0500 (EST)
In-Reply-To: <1361221013-12756-5-git-send-email-greened@obbligato.org> (David
 A. Greene's message of "Mon, 18 Feb 2013 14:56:49 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 488B1036-7A1E-11E2-8C74-21622E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216544>

"David A. Greene" <greened@obbligato.org> writes:

> From: Techlive Zheng <techlivezheng@gmail.com>
>
> Mostly prepare for the later tests refactoring.
>
> Signed-off-by: Techlive Zheng <techlivezheng@gmail.com>
> Signed-off-by: David A. Greene <greened@obbligato.org>
> ---

Applying: contrib/subtree: Code cleaning and refactoring
/srv/project/git/git.git/.git/rebase-apply/patch:219: space before tab in indent.
 	git branch spl1 "$spl1" &&
/srv/project/git/git.git/.git/rebase-apply/patch:222: space before tab in indent.
 	undo
/srv/project/git/git.git/.git/rebase-apply/patch:239: space before tab in indent.
 	undo &&
/srv/project/git/git.git/.git/rebase-apply/patch:269: space before tab in indent.
 	git subtree split --unannotate="subproj:" --prefix subdir --onto FETCH_HEAD --branch splitunann &&

>  contrib/subtree/t/t7900-subtree.sh |  256 +++++++++++++++++++-----------------
>  1 file changed, 136 insertions(+), 120 deletions(-)
>
> diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
> index c7f9e1a..3787408 100755
> --- a/contrib/subtree/t/t7900-subtree.sh
> +++ b/contrib/subtree/t/t7900-subtree.sh
> @@ -4,7 +4,7 @@
>  #
>  test_description='Basic porcelain support for subtrees
>  
> -This test verifies the basic operation of the merge, pull, add
> +This test verifies the basic operation of the add, pull, merge

Why this change?  The new list does not match the order of things
that are tested ("add" is not the first thing that gets tested), it
is not alphabetical either ("pull" sorts earlier than "merge"), nor
it is the natural progression of operation users would expect (it
would be more like "add" to start working with subtree, then "merge"
locally and finally "pull" to interact with others, no?)
