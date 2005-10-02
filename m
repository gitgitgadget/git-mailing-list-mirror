From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Honor extractor's umask in git-tar-tree.
Date: Sat, 01 Oct 2005 20:24:12 -0700
Message-ID: <433F52DC.5090906@zytor.com>
References: <20050930160353.F025C352B7B@atlas.denx.de>	<Pine.LNX.4.64.0510010934290.3378@g5.osdl.org>	<7vr7b53y0n.fsf@assigned-by-dhcp.cox.net> <7vk6gx3vkt.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Rene Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sun Oct 02 05:25:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ELuSj-0004WX-57
	for gcvg-git@gmane.org; Sun, 02 Oct 2005 05:24:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750953AbVJBDY0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Oct 2005 23:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750955AbVJBDY0
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Oct 2005 23:24:26 -0400
Received: from paleosilicon.orionmulti.com ([209.128.68.66]:56457 "EHLO
	paleosilicon.orionmulti.com") by vger.kernel.org with ESMTP
	id S1750952AbVJBDYZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Oct 2005 23:24:25 -0400
X-Envelope-From: hpa@zytor.com
Received: from [172.27.0.18] (c-67-180-239-42.hsd1.ca.comcast.net [67.180.239.42])
	(authenticated bits=0)
	by paleosilicon.orionmulti.com (8.12.10/8.12.10) with ESMTP id j923OCJv025825
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 1 Oct 2005 20:24:13 -0700
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vk6gx3vkt.fsf_-_@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0.0 required=5.0 tests=AWL autolearn=ham version=2.63
X-Spam-Checker-Version: SpamAssassin 2.63 (2004-01-11) on 
	paleosilicon.orionmulti.com
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on paleosilicon.orionmulti.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9606>

Junio C Hamano wrote:
> The archive generated with git-tar-tree had 0755 and 0644 mode bits.
> This inconvenienced the extractor with umask 002 by robbing g+w bit
> unconditionally.  Just write it out with loose permissions bits and
> let the umask of the extractor do its job.

I've thought that it would be nice if the files/directories were written 
into the archive with 0666/0777 permissions by default, and then 
extracted with the umask honoured.  A special option then could be used 
to add files with special permissions, like files in .ssh, which *have* 
to be g-w or sshd will reject them.

	-hpa
