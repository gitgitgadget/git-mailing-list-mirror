From: Bryan Jacobs <bjacobs@woti.com>
Subject: Re: [PATCH] git svn dcommit: avoid self-referential mergeinfo lines
 when svn.pushmergeinfo is configured
Date: Thu, 15 Mar 2012 18:07:03 -0400
Organization: White Oak Technologies
Message-ID: <20120315180703.7c9c0629@robyn.woti.com>
References: <CAHkK2bpq1J2SW2P1tkFnjw5dWEr=uQrfrTUaS2J-swuKsP4kig@mail.gmail.com>
	<20120315220242.GA9348@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Avishay Lavie <avishay.lavie@gmail.com>, git@vger.kernel.org,
	Sam Vilain <sam@vilain.net>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Mar 15 23:07:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8IpH-0004jN-Vm
	for gcvg-git-2@plane.gmane.org; Thu, 15 Mar 2012 23:07:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757334Ab2COWHI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Mar 2012 18:07:08 -0400
Received: from mail02.woti.us ([66.92.158.6]:35697 "EHLO roscoe.woti.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756208Ab2COWHG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2012 18:07:06 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by roscoe.woti.com (Postfix) with ESMTP id 41F065143FD44;
	Thu, 15 Mar 2012 18:07:05 -0400 (EDT)
X-Virus-Scanned: amavisd-new at woti.com
Received: from roscoe.woti.com ([127.0.0.1])
	by localhost (roscoe.woti.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ydbV1AIVLgVX; Thu, 15 Mar 2012 18:07:04 -0400 (EDT)
Received: from robyn.woti.com (robyn.woti.com [192.168.168.187])
	by roscoe.woti.com (Postfix) with ESMTPSA id CFFC5504CDACF;
	Thu, 15 Mar 2012 18:07:04 -0400 (EDT)
In-Reply-To: <20120315220242.GA9348@dcvr.yhbt.net>
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.22.0; x86_64-redhat-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193230>

On Thu, 15 Mar 2012 22:02:42 +0000
Eric Wong <normalperson@yhbt.net> wrote:

> 
> This test breaks t9161-git-svn-mergeinfo-push.sh:
> 
>   not ok - 12 check reintegration mergeinfo
>   #
>   #               mergeinfo=$(svn_cmd propget svn:mergeinfo
> "$svnrepo"/branches/svnb4) #               test "$mergeinfo" =
> "/branches/svnb1:2-4,7-9,13-18 #       /branches/svnb2:3,8,16-17
>   #       /branches/svnb3:4,9
>   #       /branches/svnb4:5-6,10-12
>   #       /branches/svnb5:6,11"
> 
> Be sure tests run successfully before submitting patches (or ask
> for help fixing tests).

The test is demonstrating the behavior the patch fixes.

A merge is made to "svnb4", and then the test checks that the mergeinfo
contains "svnb4:5-6,10-12". So really this test could be adapted to
prove that the patch is functioning as intended :-).

Bryan Jacobs
