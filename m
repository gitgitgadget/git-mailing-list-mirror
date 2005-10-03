From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Honor extractor's umask in git-tar-tree.
Date: Sun, 02 Oct 2005 21:44:43 -0700
Message-ID: <4340B73B.1090409@zytor.com>
References: <20050930160353.F025C352B7B@atlas.denx.de> <Pine.LNX.4.64.0510010934290.3378@g5.osdl.org> <7vr7b53y0n.fsf@assigned-by-dhcp.cox.net> <7vk6gx3vkt.fsf_-_@assigned-by-dhcp.cox.net> <433F52DC.5090906@zytor.com> <pan.2005.10.02.09.55.52.564046@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 03 06:46:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EMIDK-00018y-Qk
	for gcvg-git@gmane.org; Mon, 03 Oct 2005 06:46:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbVJCEqH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Oct 2005 00:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbVJCEqH
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Oct 2005 00:46:07 -0400
Received: from paleosilicon.orionmulti.com ([209.128.68.66]:53132 "EHLO
	paleosilicon.orionmulti.com") by vger.kernel.org with ESMTP
	id S932152AbVJCEqG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2005 00:46:06 -0400
X-Envelope-From: hpa@zytor.com
Received: from [172.27.0.18] (c-67-180-239-42.hsd1.ca.comcast.net [67.180.239.42])
	(authenticated bits=0)
	by paleosilicon.orionmulti.com (8.12.10/8.12.10) with ESMTP id j934idJv005981
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 2 Oct 2005 21:44:40 -0700
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: Matthias Urlichs <smurf@smurf.noris.de>
In-Reply-To: <pan.2005.10.02.09.55.52.564046@smurf.noris.de>
X-Spam-Status: No, hits=0.0 required=5.0 tests=AWL autolearn=ham version=2.63
X-Spam-Checker-Version: SpamAssassin 2.63 (2004-01-11) on 
	paleosilicon.orionmulti.com
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on paleosilicon.orionmulti.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9630>

Matthias Urlichs wrote:
> Hi, H. Peter Anvin wrote:
> 
>>I've thought that it would be nice if the files/directories were written
>>into the archive with 0666/0777 permissions by default, and then
>>extracted with the umask honoured.
> 
> The git archive oesn't *have* permissions, just one "execute" bit.
> 

My point is that I believe it should.  It has the bitfield for it, it 
just doesn't use it at the moment.

>> A special option then could be used
>>to add files with special permissions, like files in .ssh, which *have*
>>to be g-w or sshd will reject them.
> 
> I'd include a script in the archive which you'd run afterwards to fix
> problems like this. IMHO, in most situations you'll need it anyway
> (for instance, to re-start services).

That is true in some cases, but I highly disagree with the statement "most".

	-hpa
