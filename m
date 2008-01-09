From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Simplified the invocation of command action in submodule
Date: Wed, 09 Jan 2008 00:19:45 -0800
Message-ID: <7vsl17l8bi.fsf@gitster.siamese.dyndns.org>
References: <1199851140-31853-1-git-send-email-imyousuf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Imran M Yousuf <imran@smartitengineering.com>
To: imyousuf@gmail.com
X-From: git-owner@vger.kernel.org Wed Jan 09 09:20:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCWAs-00046X-K2
	for gcvg-git-2@gmane.org; Wed, 09 Jan 2008 09:20:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbYAIITw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2008 03:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbYAIITw
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jan 2008 03:19:52 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54866 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751156AbYAIITv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2008 03:19:51 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 05ACE1827;
	Wed,  9 Jan 2008 03:19:51 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 78CC11826;
	Wed,  9 Jan 2008 03:19:47 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69964>

imyousuf@gmail.com writes:

> diff --git a/git-submodule.sh b/git-submodule.sh
> index ad9fe62..8a29382 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -16,6 +16,7 @@ update=
>  status=
>  quiet=
>  cached=
> +command=

Doesn't the patch make some if not all of the above variables
unused?

>  	case "$1" in
>  	add)
>  		add=1
> +		command="module_$1"
>  		;;
>  	init)
> -		init=1
> +		command="modules_$1"
>  		;;

Does the remaining code still use $add?
