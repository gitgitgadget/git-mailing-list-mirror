From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [PATCH] gitweb: use Git.pm, and use its parse_rev method for
 git_get_head_hash
Date: Tue, 03 Jun 2008 00:31:51 +0200
Message-ID: <484474D7.6070306@gmail.com>
References: <1212188412-20479-1-git-send-email-LeWiemann@gmail.com> <200806020019.23858.jnareb@gmail.com> <20080602092926.GJ18781@machine.or.cz> <200806022332.29853.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org,
	Lars Hjemli <hjemli@gmail.com>,
	John Hawley <warthog19@eaglescrag.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 00:33:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3IaT-0002iR-O9
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 00:33:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752490AbYFBWcE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 18:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755288AbYFBWcC
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 18:32:02 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:26588 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752726AbYFBWcA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 18:32:00 -0400
Received: by fg-out-1718.google.com with SMTP id 19so857823fgg.17
        for <git@vger.kernel.org>; Mon, 02 Jun 2008 15:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        bh=LAX8uDgnDA5Sjco2BOKuqjvwgK+yPGMoY3HbUhGQHmA=;
        b=M46IW3TE2mDU/4tmlwi68ajoqpMd/MMx+dA42MRlxmvQbwzeiXhr2u1/3yWZJCzkW7954UgIeJXV1SRPcQ2eLBTGc/FOqDusO21ahDbBVmE/Rw0GlhOEB06QBf+rQxiC2M4Fo6L00MHS935lt6Zp5RPRQAkPci0CyrCFrSC/YQk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=pnYs+o/o9Qpv6Od6slXz6mqbvxIXRHMXH9vDWsbkcX2Z5BdFaIbTRyiSm3tcG206LJJKDW+zJV+J8kUZe66TFpLuHJJxpe+CbOKvbu+cY4CtEwdHfZxA4XgMQ2QRO+Y6cz1G4UIxgFiBskKWZIjLHoC9Xj85FWjpeFSVMwaYaI4=
Received: by 10.86.54.4 with SMTP id c4mr4284280fga.33.1212445915434;
        Mon, 02 Jun 2008 15:31:55 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.231.153])
        by mx.google.com with ESMTPS id j12sm11644311fkf.0.2008.06.02.15.31.53
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 02 Jun 2008 15:31:54 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <200806022332.29853.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83586>

Jakub Narebski wrote:
> Is there some iotop tool, and can it be used to measure performance
> bottlenecks of web scripts (web applications)?

There is iotop and sysstat's iostat, but the more interesting measure 
would probably be comparing top's 'wait' vs user+sys CPU time under 
realistic load ('wait' indicates that the CPU is idling because it is 
waiting for IO).

-- Lea
