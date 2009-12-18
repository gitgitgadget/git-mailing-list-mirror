From: Joey Korkames <joey+floss@kidfixit.com>
Subject: Feature suggestion: support arguments for GIT_PROXY_COMMAND &
         core.gitproxy
Date: Fri, 18 Dec 2009 16:39:22 -0700
Message-ID: <cone.1261179562.490491.4033.1000@toolshiner.phx1.kidfixit.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 19 01:05:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLmoq-0001XZ-2s
	for gcvg-git-2@lo.gmane.org; Sat, 19 Dec 2009 01:05:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755818AbZLSAFF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Dec 2009 19:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755572AbZLSAFE
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Dec 2009 19:05:04 -0500
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:59822 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753833AbZLSAFB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Dec 2009 19:05:01 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Dec 2009 19:05:01 EST
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.8.00.01.00 201-2244-105-20090324) with ESMTP
          id <20091218235820.FRZE8308.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>
          for <git@vger.kernel.org>; Fri, 18 Dec 2009 18:58:20 -0500
Received: from mail.phx1.kidfixit.com ([68.110.127.170])
	by fed1rmimpo01.cox.net with bizsmtp
	id JnyK1d00B3gixDg03nyKww; Fri, 18 Dec 2009 18:58:19 -0500
X-VR-Score: 0.00
X-Authority-Analysis: v=1.1 cv=dPH3qklg8Vic3E1mcpSlAaa4ZLB04ixhaZIb8bf8Di4=
 c=1 sm=1 a=Db2MooHyVcAA:10 a=wuBMPUXIKj/V06tqseGGQw==:17 a=F-RN8XJYAAAA:8
 a=H1VwqQI0AAAA:8 a=FUDrNtPjzEhlTNwmMjMA:9 a=FPNSHdURgbRXQvHNk78w2q7XtTAA:4
 a=VxaxaHa4ttIA:10 a=wuBMPUXIKj/V06tqseGGQw==:117
X-CM-Score: 0.00
Received: from toolshiner.phx1.kidfixit.com (unknown [10.1.0.2])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.phx1.kidfixit.com (Postfix) with ESMTP id 0067D808D8B6
	for <git@vger.kernel.org>; Fri, 18 Dec 2009 23:39:22 +0000 (UTC)
X-Mailer: http://www.courier-mta.org/cone/
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135451>

Could /connect.c be patched to support multiple arguments in 
ENV[GIT_PROXY_COMMAND] and git config core.gitproxy?

For instance, something like :
  GIT_PROXY_COMMAND="myproxyscript arg1 arg2"

or (way more useful):
 git config core.gitproxy \
  '"myproxyscript -mode git -proxy joey@gw.myhouse.com -proxy joey@bastion.foocorp.com" for foocorp.com$'

Its slightly annoying to maintain and distribute custom copies of myproxyscript 
that carry the repo-specific proxy arguments inline just because git won't 
pass those arguments itself (arguments that a repo's .git/config can easily 
store).

I think supporting tokens (ala ssh's ProxyCommand - %h=repohost, 
%p=repoport, %u=repouser) would be awesome, but that change would not be 
backward-compatible with existing .git/config files or GIT_PROXY_COMMAND 
utilizing-scripts. Its enough to assume that "$host $port" will always be 
appended to the gitproxy arg list.

Thanks for reading, (and thnaks for git!)
-joey
