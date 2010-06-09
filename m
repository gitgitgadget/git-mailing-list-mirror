From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC/PATCHv2] bash completion: Support "divergence from upstream"
 warnings in __git_ps1
Date: Wed, 09 Jun 2010 23:03:54 +0200
Message-ID: <4C1001BA.5010206@drmicha.warpmail.net>
References: <4C0AE640.3040503@pileofstuff.org> <201006062014.59386.trast@student.ethz.ch> <4C0C09BF.4070503@pileofstuff.org> <201006070942.34753.trast@student.ethz.ch> <4C0EB7F1.1030707@pileofstuff.org> <4C0F5C26.5080108@drmicha.warpmail.net> <4C0FFE06.60903@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Andrew Sayers <andrew-git@pileofstuff.org>,
	Thomas Rast <trast@student.ethz.ch>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Wed Jun 09 23:04:16 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMSRb-00008c-2u
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 23:04:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932458Ab0FIVEJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jun 2010 17:04:09 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:40712 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932339Ab0FIVEG (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Jun 2010 17:04:06 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 86237F89E8;
	Wed,  9 Jun 2010 17:03:49 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Wed, 09 Jun 2010 17:03:54 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=0Y1VFo2t4uoUwuvFXidd2FAMuww=; b=XdJMG573fJFDDcIPatFYbqIkfz9E+KOdO+0s7uIVbbMVdFnqi210ZGeVeeqmjYP7xgnkZrqMeEmY62lYIM9eoHfJbqTGezNgLN9fhA4wo6tvbOx6MtGGx6md9cT+E/JgH73JdYefHDga2UrDzazxu00N2qlOHiZV+rLmBUEgLVg=
X-Sasl-enc: SWLAlRIiq0FgtWWnfnW65K5khvyUPOuOWkZ9BY/vfGbq 1276117425
Received: from localhost.localdomain (p54858C81.dip0.t-ipconnect.de [84.133.140.129])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 003854CE703;
	Wed,  9 Jun 2010 17:03:44 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.6pre) Gecko/20100604 Lightning/1.0b2pre Lanikai/3.1.1pre
In-Reply-To: <4C0FFE06.60903@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148818>

Michael J Gruber venit, vidit, dixit 09.06.2010 22:48:

> 					case "$p" in
> 						\<*\>*|\>*\<* ) p="+"$(echo "$p"|grep ">"|wc -l)"-"$(echo
> "$p"|grep "<"|wc -l)  ;;
> 						*\<*          ) p="-"$(echo "$p"|grep "<"|wc -l)  ;;
> 						*\>*          ) p="+"$(echo "$p"|grep ">"|wc -l)  ;;
> 

...make this

grep -Fc ">"

etc. rather than

grep ">"|wc -l

etc. of course. Sorry for the bash-spam :)

Michael
