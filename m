From: =?UTF-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?= 
	<dilyan.palauzov@aegee.org>
Subject: git pull & git gc
Date: Wed, 18 Mar 2015 14:53:49 +0100
Message-ID: <5509836D.2020304@aegee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 18 14:54:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYEQ4-0005BE-00
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 14:54:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933149AbbCRNxy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 09:53:54 -0400
Received: from mailout-aegee.scc.kit.edu ([129.13.185.235]:50979 "EHLO
	mailout-aegee.scc.kit.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932960AbbCRNxy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 09:53:54 -0400
Received: from smtp.aegee.org (aegeepc1.aegee.uni-karlsruhe.de [129.13.131.81])
	by scc-mailout-02.scc.kit.edu with esmtp (Exim 4.72 #1)
	id 1YYEPv-0007v6-El; Wed, 18 Mar 2015 14:53:51 +0100
Authentication-Results: aegeeserv.aegee.org; auth=pass (PLAIN) smtp.auth=didopalauzov
DKIM-Filter: OpenDKIM Filter v2.10.0 smtp.aegee.org t2IDrv35021169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aegee.org; s=k4096;
	t=1426686837; i=dkim+MSA-tls@aegee.org;
	bh=x+JFRdTesMlCNrVq/R5MZgX+GCRAveGX6Q3jF01LVXE=;
	h=Date:From:To:Subject;
	b=HCikPVIfGu4bXoims5ZUAT73CE+AjE2xUdH43+6PPYNP04PrRZQv5KbgCYmkdOi/E
	 d3KKLWKQGFF5KYuoG+qU5rhQL1+7rCcEg6LXqs4YxWlsZdB+Htp0O0eECUDUUhr3Qu
	 hzTzPXUDuPKRfKasHgAzYuSUasYlhIA9/MYSeD6vDrKkul6E7QkFn5Rwd5khwe2x1T
	 1V5TVGhR//FTbETBvLbHBMuOe73qFZSTdCgJUneSSF5UO3cvo7vpWGt5v6+0y1dKTs
	 ncNWBy6vGHmtHhVq7f4PKZvewex2z7sHo9k1f7yLpBbzm2H+GyVqeaswMRvmUGPHAo
	 0iYUhChkBhHDEz5nLi9D29CpvHxQmOmOnn88jWk7E5aoNe9av/l3C6jrp2/AeOqZMH
	 TOxFVH0J7Uhh860Bcj/BAToxwBAPzFv5R5bmzr+yPTYYafAgxtGGmU+xcHHggWHyZ+
	 IM3RjkMLpryJwN/vZnjad6GHfFZUrlkZqltJ1cdRl/t4rupiWqrkadTLD8CB4MtVzM
	 eHe4GpdpcIRAyw//MyHipNOaflO3l0wIe2G9QLsbkFNC1i3hkMFuWeyKSbCyj8XZVX
	 GcejuSHnKE03hI0eABIreLzURtXSnaJFzZxpYHms5QOEVAtFNwwycVRDTpXqJz1dsS
	 kzRMSWbbC8OQ4DVs 
Received: from [192.168.0.6] (zuhause [212.202.110.243])
	(authenticated bits=0)
	by smtp.aegee.org (8.15.1/8.15.1) with ESMTPSA id t2IDrv35021169
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
	for <git@vger.kernel.org>; Wed, 18 Mar 2015 13:53:57 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
X-Virus-Scanned: clamav-milter 0.98.6 at aegeeserv
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265730>

Hello,

I have a local folder with the git-repository (so that its .git/config 
contains ([remote "origin"]\n	url = git://github.com/git/git.git\nfetch 
= +refs/heads/*:refs/remotes/origin/* )

I do there "git pull".

Usually the output is
   Already up to date

but since today it prints
   Auto packing the repository in background for optimum performance.
   See "git help gc" for manual housekeeping.
   Already up-to-date.

and starts in the background a "git gc --auto" process.  This is all 
fine, however, when the "git gc" process finishes, and I do again "git 
pull" I get the same message, as above (git gc is again started).

My understanding is, that "git gc" has to be occasionally run and then 
the garbage collection is done for a while.  In the concrete case, if 
"git pull" starts "git gc" in the background and prints a message on 
this, it is all fine, but running "git pull" after a while, when the 
garbage collection was recently done, where shall be neither message nor 
an action about "git gc".

My system-wide gitconfig contains "[pack] threads = 1".

I have "tar xJf"'ed my local git repository and have put it under
   http://mail.aegee.org/dpa/v/git-repository.tar.xz

The question is:

Why does "git pull" every time when it is invoked today print 
information about "git gc"?

I have git 2.3.3 adjusted with "./configure --with-openssl 
--with-libpcre --with-curl --with-expat".

Thanks in advance for your answer

Dilian
