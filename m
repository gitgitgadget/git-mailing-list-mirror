From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 06/13] Simplify "How to make a commit"
Date: Sat, 24 Aug 2013 20:20:50 -0700
Message-ID: <xmqqr4dimp65.fsf@gitster.dls.corp.google.com>
References: <282216171.1090748.1377328932833.JavaMail.ngmail@webmail08.arcor-online.net>
	<1687455733.1090999.1377329376866.JavaMail.ngmail@webmail08.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, wking@tremily.us
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Sun Aug 25 05:20:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDQsr-0001fT-UF
	for gcvg-git-2@plane.gmane.org; Sun, 25 Aug 2013 05:20:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755683Ab3HYDUy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Aug 2013 23:20:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55115 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755220Ab3HYDUx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Aug 2013 23:20:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B9802AE24;
	Sun, 25 Aug 2013 03:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1DaETHCT6X+y/Xl3OPi8NyZxuYI=; b=GVv7KH
	bHcbBxeq8ghZKmZy231EYU5NcUxq1NOiXUrD3X6orU/NDo6W/gANah1nXhI/p3S+
	OZDz75bycy1yIR9ZU1sa3pggPugs8cnoi6kP11z/lpuQB4I9Mx0QDwnoedHaGn16
	hESRlE4OzieRely4dSrKkjsRL0K6ucbHMrCOk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=X0Ab0+6PvKjdO3svbGaGeFYZMTa1HfYN
	J5e9Wat3BZGkVUK2s8O7lmj+mGH7ZG9Q1l0T1fb+xSe++JiVm9g3ixc8cnIYh41k
	LqMnB466TTYSw1wDXgUj7E+kfeyKo5AWPtxfkGCHjfkJjZA603bB9FbZ8NGcIPRC
	HYESZ5laRlQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F6962AE23;
	Sun, 25 Aug 2013 03:20:53 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 704C72AE22;
	Sun, 25 Aug 2013 03:20:52 +0000 (UTC)
In-Reply-To: <1687455733.1090999.1377329376866.JavaMail.ngmail@webmail08.arcor-online.net>
	(Thomas Ackermann's message of "Sat, 24 Aug 2013 09:29:36 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 58C08706-0D35-11E3-B8BE-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232899>

Thomas Ackermann <th.acker@arcor.de> writes:

> Combine the two cases for "git add" into one.
> Add verb "use" to "git rm" case.
>
> Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
> ---
>  Documentation/user-manual.txt | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> index 8a1a441..ca78333 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -1080,19 +1080,14 @@ produce no output at that point.
>  
>  Modifying the index is easy:
>  
> -To update the index with the new contents of a modified file, use
> +To add the contents of a new file to the index or update the index 
> +with the new contents of a modified file, use
>  
>  -------------------------------------------------
>  $ git add path/to/file
>  -------------------------------------------------
>  
> -To add the contents of a new file to the index, use
> -
> --------------------------------------------------
> -$ git add path/to/file
> --------------------------------------------------

OK.

> -To remove a file from the index and from the working tree,
> +To remove a file from the index and from the working tree, use
>  
>  -------------------------------------------------
>  $ git rm path/to/file
