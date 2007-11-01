From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Don't use cpio in git-clone when not installed
Date: Thu, 01 Nov 2007 02:00:48 +0100
Organization: At home
Message-ID: <fgb8b6$hqo$1@ger.gmane.org>
References: <1193861145-20357-1-git-send-email-mh@glandium.org> <alpine.LFD.0.999.0710311742170.3342@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 01 01:58:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InOOS-0001Vm-LT
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 01:58:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752838AbXKAA63 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 20:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752627AbXKAA63
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 20:58:29 -0400
Received: from main.gmane.org ([80.91.229.2]:52671 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752723AbXKAA62 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 20:58:28 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1InOO8-0004S5-Ko
	for git@vger.kernel.org; Thu, 01 Nov 2007 00:58:24 +0000
Received: from abvb125.neoplus.adsl.tpnet.pl ([83.8.199.125])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 01 Nov 2007 00:58:24 +0000
Received: from jnareb by abvb125.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 01 Nov 2007 00:58:24 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvb125.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62901>

Linus Torvalds wrote:

> 
> 
> On Wed, 31 Oct 2007, Mike Hommey wrote:
>> +    if type cpio > /dev/null 2>&1; then
>> +            local=yes
>> +    fi
> 
> Isn't "type" a bashism?
> 
> Maybe just do
> 
>       if echo . | cpio -o > /dev/null 2>&1; then
> 
> instead? Maybe even doing this at install time to avoid the overhead of 
> executing another process..

Or perhaps trap / check actual execution of cpio in git-clone, and
fallback to ln -s / link if it fails...

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
