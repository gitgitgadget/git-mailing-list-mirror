From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 1/2] replace: use a GIT_NO_REPLACE_OBJECTS env variable
Date: Tue, 17 Nov 2009 10:33:28 +0100
Message-ID: <4B026DE8.9070905@drmicha.warpmail.net>
References: <20091117051125.3588.91072.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	bill lam <cbill.lam@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Paul Mackerras <paulus@samba.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Nov 17 10:34:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAKSL-00021t-Rq
	for gcvg-git-2@lo.gmane.org; Tue, 17 Nov 2009 10:34:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753512AbZKQJe0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2009 04:34:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753355AbZKQJeZ
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Nov 2009 04:34:25 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:56238 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753400AbZKQJeY (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Nov 2009 04:34:24 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 41001C05E8;
	Tue, 17 Nov 2009 04:34:30 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Tue, 17 Nov 2009 04:34:30 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=i+BwdniKf4w6aMxpwiJQO43u5fA=; b=RC9TVhWDH0k39dOvyB5oo7Nmn+I5Gj6RXsV47IkWgXigaSLNlkb1rFO2gDBhSbvduXsgEHzJYt2z22urJ8UxJQURqiU/1E0HhUnkAfHTm7H18eG4OdMONtrvazSdSPNVGeZuszuTCBJtGABxrxP/aelUIOIK+nOFfi/wqam3PCM=
X-Sasl-enc: u9Oeugzo7EwMwDoKpbj2A2Sc6b4v/z9iG1/vsQDPN9oU 1258450469
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id A02F4F335;
	Tue, 17 Nov 2009 04:34:27 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.6pre) Gecko/20091116 Lightning/1.0pre Shredder/3.0.1pre
In-Reply-To: <20091117051125.3588.91072.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133084>

Christian Couder venit, vidit, dixit 17.11.2009 06:11:
> This environment variable is set when the --no-replace-objects
> flag is passed to git, and it is read when other environment
> variables are read.
> 
> It is useful for example for scripts, as the git commands used in
> them can now be aware that they must not read replace refs.
> 
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>

Tested-by: Michael J Gruber <git@drmicha.warpmail.net>

:) This works, thanks, as well as the gitk patch 2/2, which is difficult
to cover by test scripts. Some OSes (or rather certain setenv/putenv
variants) have problems distinguishing an unset variable from an empty
one. I think we've worked around this, but avoiding it is safer, as J6t
pointed out.

Thanks!
Michael
