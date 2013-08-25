From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 07/13] Improve description in "How to merge"
Date: Sat, 24 Aug 2013 20:22:02 -0700
Message-ID: <xmqqmwo6mp45.fsf@gitster.dls.corp.google.com>
References: <282216171.1090748.1377328932833.JavaMail.ngmail@webmail08.arcor-online.net>
	<8609038.1091034.1377329428557.JavaMail.ngmail@webmail08.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, wking@tremily.us
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Sun Aug 25 05:22:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDQu6-0003mg-TV
	for gcvg-git-2@plane.gmane.org; Sun, 25 Aug 2013 05:22:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755179Ab3HYDWL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Aug 2013 23:22:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51811 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754894Ab3HYDWK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Aug 2013 23:22:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BB06D2AE4D;
	Sun, 25 Aug 2013 03:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Wa4NgKSIiG7oc3QQ6VW0jH9WRAw=; b=QVckyE
	PmnJ7WaXD+ETtzR4dkqh8HoEZW6Ud5EtYHHpNhLTOnlGaW5zj/bbXXEpLy6qA18M
	BUNgNQ2y7eL23eSnNkQM2rFEbmUBPr24fEaoyyAn6xquoC2HTb3UwAroJIRpESe6
	qQtCzGOjVbV7/+RKuTx06eVoAVJBu50eyeXqQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gB5tD726R6hTuXyLi4iM8SsGfNnO1myU
	TRujQ3W6eBhDp80OwxXvQ6r6xNsnxLbuhcG7b/tlkFKyaqX8BEIh38/uneOJC5oT
	rASUnpI7UefVt8VMD1wQWbyK1vaVlTeGqQ5zDbCNtgo68oUBBJRVQ3lDvLuCBkak
	bO/7u3sTt4A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B0CEA2AE4C;
	Sun, 25 Aug 2013 03:22:09 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 277212AE4B;
	Sun, 25 Aug 2013 03:22:09 +0000 (UTC)
In-Reply-To: <8609038.1091034.1377329428557.JavaMail.ngmail@webmail08.arcor-online.net>
	(Thomas Ackermann's message of "Sat, 24 Aug 2013 09:30:28 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 86786786-0D35-11E3-ADA1-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232900>

Thomas Ackermann <th.acker@arcor.de> writes:

> Describe the conflict resolution in terms of the
> commands the user is supposed to use.
>
> Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
> ---
>  Documentation/user-manual.txt | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> index ccbddc7..0656191 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -1251,10 +1251,8 @@ Automatic merge failed; fix conflicts and then commit the result.
>  -------------------------------------------------
>  
>  Conflict markers are left in the problematic files, and after
> -you resolve the conflicts manually, you can update the index
> -with the contents and run Git commit, as you normally would when
> -creating a new file.
> -
> +you have resolved the conflicts manually, you can `git add` the
> +new contents and do a `git commit` in the end.

This is a slight documentation regression, as there are cases your
conflict resolution is a removal of the file, isn't it?

>  If you examine the resulting commit using gitk, you will see that it
>  has two parents, one pointing to the top of the current branch, and
>  one to the top of the other branch.
