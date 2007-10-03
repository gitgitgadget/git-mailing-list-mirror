From: Perry Wagle <wagle@cs.indiana.edu>
Subject: Clone corruption to G4 MacOSX
Date: Tue, 2 Oct 2007 21:29:07 -0700
Message-ID: <82638874-6766-4DCD-BF5B-3893F9B5046F@cs.indiana.edu>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 03 07:26:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Icwkl-0002i4-VF
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 07:26:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751531AbXJCF02 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 01:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751514AbXJCF02
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 01:26:28 -0400
Received: from newman.cs.indiana.edu ([129.79.247.4]:44051 "EHLO
	newman.cs.indiana.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751400AbXJCF01 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 01:26:27 -0400
X-Greylist: delayed 3433 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Oct 2007 01:26:27 EDT
Received: from smtp.cs.indiana.edu (smtp.cs.indiana.edu [129.79.247.7])
	by newman.cs.indiana.edu (8.13.1/8.13.1/IUCS_2.80) with ESMTP id l934TDib006024
	for <git@vger.kernel.org>; Wed, 3 Oct 2007 00:29:13 -0400
Received: from [192.168.1.65] (pool-71-111-64-33.ptldor.dsl-w.verizon.net [71.111.64.33])
	(authenticated bits=0)
	by rage.cs.indiana.edu (8.13.1/8.13.1/IUCS_SMTP_Alternate_Port_1.4) with ESMTP id l934T9Jm004023
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <git@vger.kernel.org>; Wed, 3 Oct 2007 00:29:13 -0400
X-Mailer: Apple Mail (2.752.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59786>

I have a G4 iBook running MacOSX 10.4.10.  If I build the most recent  
production git (git-1.5.3.2) from the tarball from the git website, I  
get a corrupt copy of Linus's kernel repository (git://git.kernel.org/ 
pub/scm/linux/kernel/git/torvalds/linux-2.6.git) when I try to clone  
it.  Specifically, my copy is missing several files, including ./ 
include/linux/netfilter/xt_CONNMARK.h.  The involved files seem to be:

include/linux/netfilter/xt_CONNMARK.h
include/linux/netfilter/xt_DSCP.h
include/linux/netfilter/xt_MARK.h
include/linux/netfilter/xt_TCPMSS.h
include/linux/netfilter_ipv4/ipt_CONNMARK.h
include/linux/netfilter_ipv4/ipt_DSCP.h
include/linux/netfilter_ipv4/ipt_ECN.h
include/linux/netfilter_ipv4/ipt_MARK.h
include/linux/netfilter_ipv4/ipt_TCPMSS.h
include/linux/netfilter_ipv4/ipt_TOS.h
include/linux/netfilter_ipv4/ipt_TTL.h
include/linux/netfilter_ipv6/ip6t_HL.h
include/linux/netfilter_ipv6/ip6t_MARK.h
net/ipv4/netfilter/ipt_ECN.c
net/ipv4/netfilter/ipt_TOS.c
net/ipv4/netfilter/ipt_TTL.c
net/ipv6/netfilter/ip6t_HL.c
net/netfilter/xt_CONNMARK.c
net/netfilter/xt_DSCP.c
net/netfilter/xt_MARK.c
net/netfilter/xt_TCPMSS.c

I first noticed this corruption around August 14, 2007, when it  
seemed to be in the head of the clone of Linus's repository.  I was  
able to make it go away by committing the HEAD.  I was just starting  
with git, and figured I got some incomplete copy because Linus was in  
the middle of something.  Now I cannot find any commits for  
xt_CONNMARK.h or xt_connmark.h since 2006, especially around August  
14, but that might be my naivete.

If I clone Linus's repository to a x86 machine, I get no corruption.

My wild ass guess is that being big-endian is causing trouble.

-- Perry
