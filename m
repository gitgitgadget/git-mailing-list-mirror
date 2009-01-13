From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: gitignore excludes too much
Date: Tue, 13 Jan 2009 18:36:24 +0100
Message-ID: <496CD118.7000302@drmicha.warpmail.net>
References: <alpine.LSU.2.00.0901131429020.23531@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jan Engelhardt <jengelh@medozas.de>
X-From: git-owner@vger.kernel.org Tue Jan 13 18:37:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMnD5-000082-AL
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 18:37:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754767AbZAMRg0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 12:36:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754669AbZAMRg0
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 12:36:26 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:58881 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752377AbZAMRgZ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Jan 2009 12:36:25 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id CBF92210682;
	Tue, 13 Jan 2009 12:36:24 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 13 Jan 2009 12:36:24 -0500
X-Sasl-enc: +LvNP8hcOq0ixDON6zJoihPC2wPv5UVDrO9AatZGrgif 1231868184
Received: from [139.174.44.34] (pascal.math.tu-clausthal.de [139.174.44.34])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 3A3C848DA2;
	Tue, 13 Jan 2009 12:36:24 -0500 (EST)
User-Agent: Thunderbird 2.0.0.19 (X11/20081209)
In-Reply-To: <alpine.LSU.2.00.0901131429020.23531@fbirervta.pbzchgretzou.qr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105514>

Jan Engelhardt venit, vidit, dixit 01/13/09 14:30:
> Hi,
> 
> 
> I noticed that having "*.d" in .gitignore ignores files that would start 
> with a dot, such as ".main.o.d". This is against Unix shell behavior;
> but maybe it's a feature rather than a bug?
> In case of latter, please fix :-)

git uses fnmatch with the last option (flags) being either 0 (for most
purposes) or FNM_PATHNAME (leading /), but never with FNM_PERIOD.

Think "sh with dotglob set" ;)

Since dotfiles tend to be the ones which are not tracked this behaviour
is the more practical one (compared to using FNM_PERIOD and forcing the
typical user to write two patterns).

Cheers,
Michael
