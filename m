From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH] rebase -m: Fix incorrect short-logs of already applied commits.
Date: Sat, 1 Sep 2007 14:06:25 +0200
Message-ID: <200709011406.25965.johannes.sixt@telecom.at>
References: <200709010925.27926.johannes.sixt@telecom.at> <7vmyw6u5ca.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 01 14:07:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRRkf-000594-3S
	for gcvg-git@gmane.org; Sat, 01 Sep 2007 14:06:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753772AbXIAMG3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Sep 2007 08:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753709AbXIAMG3
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Sep 2007 08:06:29 -0400
Received: from smtp3.srv.eunet.at ([193.154.160.89]:41772 "EHLO
	smtp3.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753439AbXIAMG2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Sep 2007 08:06:28 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp3.srv.eunet.at (Postfix) with ESMTP id 5BCB010CD5C;
	Sat,  1 Sep 2007 14:06:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id EDBB8575F1;
	Sat,  1 Sep 2007 14:06:26 +0200 (CEST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vmyw6u5ca.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57272>

On Saturday 01 September 2007 11:01, Junio C Hamano wrote:
>  		printf "Committed: %0${prec}d " $msgnum
> -		git rev-list --pretty=oneline -1 HEAD | \
> -			sed 's/^[a-f0-9]\+ //'
>  	else
>  		printf "Already applied: %0${prec}d " $msgnum
> -		git rev-list --pretty=oneline -1 "$cmt" | \
> -			sed 's/^[a-f0-9]\+ //'
>  	fi
> +	git rev-list --pretty=oneline -1 "$cmt" | sed -e 's/^[^ ]* //'

I prefer this over my version as well.

-- Hannes
