From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: quick bare clones taking longer?
Date: Thu, 10 May 2007 10:05:01 +0200
Message-ID: <vpqtzul3xzm.fsf@bauges.imag.fr>
References: <7virb1sm6h.fsf@assigned-by-dhcp.cox.net>
	<20070509.150256.59469756.davem@davemloft.net>
	<7v3b25siwk.fsf@assigned-by-dhcp.cox.net>
	<20070509.162301.48802460.davem@davemloft.net>
	<7vy7jxr35a.fsf@assigned-by-dhcp.cox.net>
	<7vd519r10c.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 10 10:05:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hm3eI-0003o9-Db
	for gcvg-git@gmane.org; Thu, 10 May 2007 10:05:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755726AbXEJIFO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 04:05:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756669AbXEJIFO
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 04:05:14 -0400
Received: from imag.imag.fr ([129.88.30.1]:58044 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755726AbXEJIFM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2007 04:05:12 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l4A851PV000692
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 10 May 2007 10:05:02 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Hm3e1-0005Jg-AD; Thu, 10 May 2007 10:05:01 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Hm3e1-0002hC-80; Thu, 10 May 2007 10:05:01 +0200
Mail-Followup-To: git@vger.kernel.org
In-Reply-To: <7vd519r10c.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Wed\, 09 May 2007 17\:11\:15 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Thu, 10 May 2007 10:05:02 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46844>

Junio C Hamano <junkio@cox.net> writes:

>  get_repo_base() {
> -	(cd "$1" && (cd .git ; pwd)) 2> /dev/null
> +	(
> +		cd "`/bin/pwd`" &&
> +		cd "$1" &&
> +		(
> +			cd .git
> +			pwd
> +		)
> +	) 2>/dev/null
>  }

Will this work on windows?

-- 
Matthieu
