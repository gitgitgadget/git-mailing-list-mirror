From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 05/18] Do not use "diff" found on PATH while building
 and installing
Date: Tue, 01 Jun 2010 21:39:20 -0700
Message-ID: <7v4ohmqc93.fsf@alter.siamese.dyndns.org>
References: <20100514093131.249094000@mlists.thewrittenword.com>
 <20100514093746.689775000@mlists.thewrittenword.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
X-From: git-owner@vger.kernel.org Wed Jun 02 06:39:39 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJfju-0002DL-DJ
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 06:39:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751804Ab0FBEj1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jun 2010 00:39:27 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:34975 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751795Ab0FBEj0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jun 2010 00:39:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8230AB6EED;
	Wed,  2 Jun 2010 00:39:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=+3BuqlO2uY6cjmmPJnK5BX2iUKY=; b=LNhjCWK125RSOJJRO9IZtmf
	eUTe3S9rdG90bH9J/yj2l76k70W8y5nYBYJOCIxgHBZnzHM3OKhLwT0LG6bW8A5G
	IcUwbhAubf7fX2xbvC6VdmXQ1o2mT976uKXoHZHPn381Tmtc6S7MznkpEvVlZCfU
	hNau2hG7AYDhNBtc9HiA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=cZEzW61i6dtlK05HFrpwWObx8C46oD8JlrZ7OXBs/QMb3lBpt
	AfF7u6WaZH5KztqrsbOT+AZq2X3LKn426fmuau8CoUx4pLLDvS/vVRGJTGMcxeKH
	qvCK9UjPLKL3yp7NV4c553B/jEW2M2hdAtA5CXv0Cvb6CYzrJ7ZHvt4GGo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 59B4DB6EE9;
	Wed,  2 Jun 2010 00:39:24 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A912BB6EE6; Wed,  2 Jun
 2010 00:39:21 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D1CDEB16-6E00-11DF-B381-6730EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148196>

"Gary V. Vaughan" <git@mlists.thewrittenword.com> writes:

> Index: b/Documentation/install-webdoc.sh
> ===================================================================
> --- a/Documentation/install-webdoc.sh
> +++ b/Documentation/install-webdoc.sh
> @@ -12,7 +12,7 @@ do
>  	then
>  		: did not match
>  	elif test -f "$T/$h" &&
> -	   diff -u -I'Last updated [0-9][0-9]-[A-Z][a-z][a-z]-' "$T/$h" "$h"
> +	   $DIFF -u -I'Last updated [0-9][0-9]-[A-Z][a-z][a-z]-' "$T/$h" "$h"

Do we or do we not want to quote "$DIFF"?  iow, how well do we deal with $IFS
whitespace in the path?
