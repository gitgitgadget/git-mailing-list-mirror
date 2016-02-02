From: Marc Strapetz <marc.strapetz@syntevo.com>
Subject: git submodule should honor "-c credential.helper" command line
 argument
Date: Tue, 2 Feb 2016 18:13:14 +0100
Message-ID: <56B0E3AA.30804@syntevo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 02 18:17:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQeaB-0008AX-RI
	for gcvg-git-2@plane.gmane.org; Tue, 02 Feb 2016 18:17:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933672AbcBBRRg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2016 12:17:36 -0500
Received: from smtprelay06.ispgateway.de ([80.67.31.95]:42754 "EHLO
	smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932649AbcBBRRf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2016 12:17:35 -0500
X-Greylist: delayed 304 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Feb 2016 12:17:35 EST
Received: from [91.113.179.170] (helo=[192.168.92.24])
	by smtprelay06.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES128-SHA:128)
	(Exim 4.84)
	(envelope-from <marc.strapetz@syntevo.com>)
	id 1aQeUb-0000Wc-Q3
	for git@vger.kernel.org; Tue, 02 Feb 2016 18:11:53 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
X-Df-Sender: bWFyYy5zdHJhcGV0ekBzeW50ZXZvLmNvbQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285283>

git -c credential.helper=helper submodule update --init submodule

does not invoke "helper", but falls back to the default strategies.
When configuring in ~/.gitconfig:

[credential]
   helper=helper

git submodule update --init submodule

works fine. This behavior is somewhat unexpected -- is this a bug or by 
intention? In case intention, what's the recommended way to "inject" 
credentials helpers to work on submodules without modifying Git's config 
files?

Tested with Git 2.5.0 (Windows).

-Marc
