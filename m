From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 2/2] Makefile: work around ksh's failure to handle missing
 list argument to for loop
Date: Sun, 04 Jul 2010 20:37:09 +0200
Message-ID: <4C30D4D5.3020900@drmicha.warpmail.net>
References: <80typu1ozt.fsf@tiny.isode.net> <8YdP-GcDDflOVZnykNVIGceOm01bqeg9PDvdgIfgqUnh29RKC-6Qi8_KBVoqLIt5iyt7g1TX5l96M5KyLrfOqg@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org, PWalker752@aol.com,
	newsletter@dirk.my1.cc, bruce.stephens@isode.com,
	Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Sun Jul 04 20:37:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVU4E-0004Ot-78
	for gcvg-git-2@lo.gmane.org; Sun, 04 Jul 2010 20:37:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757547Ab0GDShF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Jul 2010 14:37:05 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:49998 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755630Ab0GDShD (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Jul 2010 14:37:03 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id CEB2310EAE9;
	Sun,  4 Jul 2010 14:37:01 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Sun, 04 Jul 2010 14:37:02 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=9/k2+cIvIYhC9JxekzfMMPF0lVI=; b=OFLtp/xH+M5AjG2PUr1hQFLWwxIPzt8s5/2BBsYEdV8GnqsqHXbRlQDjFLProNcy9wZKN1b807wQQj1j9/b7YrWdYhOjVxCtrzrHVPNOnH/RbX+YmHHaIyo8wuX06jlruvDe36O6sTWb+JYkOh+i8qqOhmS+2lTHLlYtXFZIObQ=
X-Sasl-enc: I/3XbUgkVoHt8mHXvXcVrnZPPqf0m0YZjjqI2pgxMKNi 1278268621
Received: from localhost.localdomain (p54858DB6.dip0.t-ipconnect.de [84.133.141.182])
	by mail.messagingengine.com (Postfix) with ESMTPSA id E5BEB4E5FB4;
	Sun,  4 Jul 2010 14:36:59 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.8pre) Gecko/20100702 Lightning/1.0b2pre Lanikai/3.1.1pre
In-Reply-To: <8YdP-GcDDflOVZnykNVIGceOm01bqeg9PDvdgIfgqUnh29RKC-6Qi8_KBVoqLIt5iyt7g1TX5l96M5KyLrfOqg@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150227>

Brandon Casey venit, vidit, dixit 02.07.2010 20:50:
> From: Brandon Casey <drafnel@gmail.com>
> 
> ksh does not like it when the list argument is missing in a for loop.  This
> can happen when NO_CURL is set which causes REMOTE_CURL_ALIASES to be unset.
> In this case, the for loop in the Makefile expands to look like this:
> 
>    for p in ; do
> 
> and ksh complains like this:
> 
>    /bin/ksh: syntax error at line 15 : `;' unexpected
> 
> The existing attempt to work around this issue, introduced by 70b89f87,
> tried to protect the for loop by first testing whether REMOTE_CURL_ALIASES
> was empty, but it does not seem to work.  So adopt Bruce Stephens's

What does that mean? Either it works or it doesn't. I did work back
then. Does it (i.e.: the test for emtyness) fail to work for certain shells?

Michael
