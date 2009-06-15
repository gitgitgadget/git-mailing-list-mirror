From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCHv2 1/3] git-sh-setup: introduce say() for quiet options
Date: Mon, 15 Jun 2009 08:25:52 +0200
Message-ID: <4A35E970.8080406@viscovery.net>
References: <1244924500-27391-1-git-send-email-bebarino@gmail.com> <1245021374-8430-1-git-send-email-bebarino@gmail.com> <1245021374-8430-2-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 15 08:26:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MG5e5-0004XW-O7
	for gcvg-git-2@gmane.org; Mon, 15 Jun 2009 08:26:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753780AbZFOG0H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2009 02:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754254AbZFOG0G
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jun 2009 02:26:06 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:7965 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755454AbZFOG0F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2009 02:26:05 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MG5dg-0001GT-A1; Mon, 15 Jun 2009 08:25:59 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 046086B7; Mon, 15 Jun 2009 08:25:51 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <1245021374-8430-2-git-send-email-bebarino@gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121585>

Stephen Boyd schrieb:
> diff --git a/git-sh-setup.sh b/git-sh-setup.sh
> index 80acb7d..f88184e 100755
> --- a/git-sh-setup.sh
> +++ b/git-sh-setup.sh
> @@ -44,6 +44,13 @@ die() {
>  	exit 1
>  }
>  
> +say () {
> +	if test -z "$GIT_QUIET"
> +	then
> +		echo "$@"
> +	fi
> +}

Is it intended that this obeys any GIT_QUIET that appears in the
environment? If not, then you should add

GIT_QUIET=

here to override the environment.

-- Hannes
