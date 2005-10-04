From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: What to expect after 0.99.8
Date: Tue, 04 Oct 2005 10:40:43 -0700
Message-ID: <4342BE9B.5010409@zytor.com>
References: <7v7jcvxxrl.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0510031522590.23242@iabervon.org> <7vmzlqnwmw.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0510031709360.23242@iabervon.org> <7v1x32l0gz.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0510031606550.31407@g5.osdl.org> <20051004071210.GA18716@localdomain> <Pine.LNX.4.63.0510040321170.23242@iabervon.org> <pan.2005.10.04.14.18.59.102722@smurf.noris.de> <Pine.LNX.4.63.0510041213460.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Matthias Urlichs <smurf@smurf.noris.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 04 19:44:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EMqnR-0001ey-Rq
	for gcvg-git@gmane.org; Tue, 04 Oct 2005 19:41:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964863AbVJDRlm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Oct 2005 13:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964864AbVJDRlm
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Oct 2005 13:41:42 -0400
Received: from terminus.zytor.com ([192.83.249.54]:64928 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S964863AbVJDRlm
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 4 Oct 2005 13:41:42 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j94HeluC001755
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 4 Oct 2005 10:40:48 -0700
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.63.0510041213460.23242@iabervon.org>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.1 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9685>

Daniel Barkalow wrote:
> 
> I actually mean UNIX (a.k.a. PF_LOCAL) sockets; git-ssh-fetch is connected 
> to ssh via sockets from "socketpair()". Looks like you can set the buffer 
> size with a socket option here, too, but I doubt ssh will try setting 
> socket options on standard in and out, and git-ssh-fetch leaves them at 
> their defaults. I'm not clear where the defaults for these come from in 
> general.
> 

Well, git-ssh-fetch could set both SO_SNDBUF and SO_RCVBUF if it cared.

For portability, it would be a good thing to explicitly set the buffer 
size rather than just blindly assume it can hold a specific amount of data.

	-hpa
