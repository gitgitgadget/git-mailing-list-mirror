From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Bug report - git show <tagname> together with --pretty=format
Date: Wed, 08 Apr 2009 17:28:21 +0200
Message-ID: <49DCC295.7010908@drmicha.warpmail.net>
References: <49DC9F07.4090105@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Cornelius <c.r1@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 08 17:31:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrZjw-000340-Nd
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 17:31:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934083AbZDHP23 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2009 11:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934080AbZDHP22
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 11:28:28 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:53487 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933993AbZDHP21 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Apr 2009 11:28:27 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 4FE36313FDC;
	Wed,  8 Apr 2009 11:28:26 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 08 Apr 2009 11:28:26 -0400
X-Sasl-enc: RPGdcMTRrsn0pj+OtZCYG2nfaBysiXdP6V33K9uXhH9X 1239204506
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id BC8A225574;
	Wed,  8 Apr 2009 11:28:25 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090408 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <49DC9F07.4090105@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116085>

Cornelius venit, vidit, dixit 08.04.2009 14:56:
> Hi,
> I've a problem with git 1.6.2.2 (self compiled) and git show. I use it's 
> output for parsing the git data, so this is more than a minor issue for 
> me. When you normally do a git show on a tag name it's output resembles 
> the following:
> tag <tagname>
> Tagger: Cornelius <c.r1@gmx.de>
> Date:   Wed Apr 8 14:39:17 2009 +0200
> 
> 
> tagmessage
> commit 77e312e0527f87604e4c70ebf6040e79bb55d2ed
> <snip>
> 
> Now when you do a git show <tagname> 
> --pretty=format:"ENDOFGITTAGOUTPUTMESAGEHERE%n%H" --
> the Date: line is missing. Git 1.6.0.5 (which is avaible in my distro's 
> repos) doesn't have this issue. Please CC me, I'm not subcribed here.
> Cornelius

It's not a bug, it's a feature ;)

In fact, git show used to ignore format specifiers for the tag part and
apply them to the commit part only. Since
ea718e6 (show <tag>: reuse pp_user_info() instead of duplicating code,
2009-01-02)
(which is in v1.6.2) it applies the format to both, which is why there
is no tag date unless you ask for it (or use the default format).

Michael
