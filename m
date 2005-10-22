From: Andreas Ericsson <ae@op5.se>
Subject: git-core rpm requires
Date: Sat, 22 Oct 2005 19:22:58 +0200
Message-ID: <435A7572.70202@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Oct 22 19:24:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ETN5D-0003Rd-Jq
	for gcvg-git@gmane.org; Sat, 22 Oct 2005 19:23:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbVJVRXA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 22 Oct 2005 13:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbVJVRXA
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Oct 2005 13:23:00 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:7114 "EHLO smtp-gw1.op5.se")
	by vger.kernel.org with ESMTP id S1750780AbVJVRW7 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Oct 2005 13:22:59 -0400
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP id B74CE6BCFE
	for <git@vger.kernel.org>; Sat, 22 Oct 2005 19:22:58 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10471>

I tried git on one of our not too updated servers and noticed that 
git-update-index requires zlib >= 1.2, which introduced the *Bound 
functions.

It took a while to track down due to lazy symbol resolution and the fact 
that the problem was hidden by stderr redirection in the first git 
version I tried (some months ago).

Here's a cut'n paste solution if you have sed >= 4.0.9 installed and 
have some sort of aversion to manual editors. Feels a bit silly to send 
a patch for a one-liner.

sed -i 's/^Requires:./&zlib >= 1.2, /' git-core.spec.in

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
