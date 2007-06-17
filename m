From: Sergey Yanovich <ynvich@gmail.com>
Subject: git tool to keep a subversion mirror
Date: Sun, 17 Jun 2007 21:49:42 +0300
Message-ID: <11821061823423-git-send-email-ynvich@gmail.com>
To: git@vger.kernel.org, normalperson@yhbt.net
X-From: git-owner@vger.kernel.org Sun Jun 17 20:48:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hzzno-0004vV-TM
	for gcvg-git@gmane.org; Sun, 17 Jun 2007 20:48:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758296AbXFQSsn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Jun 2007 14:48:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757592AbXFQSsn
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jun 2007 14:48:43 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:62635 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755319AbXFQSsn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jun 2007 14:48:43 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1237510ugf
        for <git@vger.kernel.org>; Sun, 17 Jun 2007 11:48:41 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:from:to:subject:date:message-id:x-mailer;
        b=NxNlkUbptY4b2FtIg73mX5fq4GofOSmXwNo99+wbnofltUA9BfMm3FmUd1ufshNOIgj0GAgyLF8NivPZAdwJ6c4sZfrQj3Yz8EoGoAhP2kkahl3uSgVZj3GujCxJfJTmo/HAStsTFOvJmSL9wqCspjF/ybHSAkx0sfWL2Jut5NA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:message-id:x-mailer;
        b=f086wEU5H07guI/28DhEGHj2ugksAlqz+Y3TsqvYtznnWcyLoCUWxp7xZJbJZZEsAv2IK1syG7QNuhK/ECFrhcH1ITKhRDNP5zoVN3Rf6bccK+pM55Z+WIFPMs8Q3Bd+WVsx7x/fkpkzA0xX9zqiMAPRJiNkkLFIe88GQjMqatM=
Received: by 10.67.102.12 with SMTP id e12mr4430654ugm.1182106121887;
        Sun, 17 Jun 2007 11:48:41 -0700 (PDT)
Received: from host3 ( [87.252.237.202])
        by mx.google.com with ESMTP id z40sm7603742ikz.2007.06.17.11.48.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 17 Jun 2007 11:48:41 -0700 (PDT)
Received: from sergei by host3 with local (Exim 4.63)
	(envelope-from <ynvich@gmail.com>)
	id 1Hzzok-0002Tj-T2; Sun, 17 Jun 2007 21:49:42 +0300
X-Mailer: git-send-email 1.5.2.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50363>


I am actively using git for my project. Thanks everyone envolved.

However, I got tired of administering own web server and registered my
project at sourceforge. Unlike repo.or.cz (thanks again for everyone
envolved), they do not provide git hosting. But a project without a
source repository is non-sence.

I am not in any way going to use Subversion after I tried git, but I
need to be able to export to a Subversion repository. I found an
excellent tool called 'git-svn'. However, the flawed nature of
Subversion put shackles on normal git usage after you do 'git-svn init'.

Since git is the best scm system, my situation is probably quite common.
So I am filing these patches.

There is a 'git-svn' command which does want I need, so I created a
simple wrapper around it. I also found that 'git-svn commit-diff' is
having a small trouble dealing with root <tree-ish>, which is corrected
by an attached patch.
