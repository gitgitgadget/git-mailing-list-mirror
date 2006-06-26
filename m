From: Andreas Ericsson <ae@op5.se>
Subject: Re: Setting up git server?
Date: Mon, 26 Jun 2006 09:55:34 +0200
Message-ID: <449F92F6.7020108@op5.se>
References: <4491EAE8.6090009@cc.jyu.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 26 15:44:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FurOO-0006uk-Mf
	for gcvg-git@gmane.org; Mon, 26 Jun 2006 15:44:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030209AbWFZNoK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Jun 2006 09:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030196AbWFZNoJ
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jun 2006 09:44:09 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:63396 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1030194AbWFZNoH
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jun 2006 09:44:07 -0400
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 9E8936BCC4; Mon, 26 Jun 2006 15:44:05 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.8-1.1.fc4 (X11/20060501)
X-Accept-Language: en-us, en
To: lamikr@cc.jyu.fi
In-Reply-To: <4491EAE8.6090009@cc.jyu.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22674>

lamikr wrote:
> Hi
> 
> I have git-repo cloned from the linux-omap-2.6 that we have used as a
> base for our h6300 development.
> Earlier we have kept our kernel in svn (sync between git-branches and
> svn has happened about once in a month by using
> traditional diff files...)
> 
> I have now pulled the server to "/repos/git/linux-omap-h6300-2.6" and
> setup the /etc/xinetd.d/git-daemon by using docs in
> http://www.kernel.org/pub/software/scm/git/docs/everyday.html
> 
> How can I now create the git url for this? For example something like
> this: git://aragorn.kortex.jyu.fi/repos/git/linux-omap-h6300-2.6.git
> 


Assuming '/repos' is in your root directory, do

touch /repos/git/linux-omap-h6300-2.6.git/git-daemon-export-ok

This will mark the repo as allowed to export for the git-daemon, and 
then you can tell people to pull from the url you mentioned.

For those that need push access you will need to setup ssh accounts. It 
is easier if they also pull over ssh+git, using a similar url but 
replacing "git://" with "ssh://" (or "git+ssh://").

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
