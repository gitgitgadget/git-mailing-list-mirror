From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: git-cvsimport broken?
Date: Thu, 02 Mar 2006 14:54:41 -0800
Message-ID: <440777B1.5030807@zytor.com>
References: <440775FB.4000300@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 02 23:55:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEwh6-00005M-Cw
	for gcvg-git@gmane.org; Thu, 02 Mar 2006 23:54:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849AbWCBWyp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Mar 2006 17:54:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750985AbWCBWyp
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Mar 2006 17:54:45 -0500
Received: from terminus.zytor.com ([192.83.249.54]:35795 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750849AbWCBWyo
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Mar 2006 17:54:44 -0500
Received: from [192.168.10.106] (63-207-7-10.ded.pacbell.net [63.207.7.10])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id k22Msg0L007171
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 2 Mar 2006 14:54:42 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <440775FB.4000300@zytor.com>
X-Virus-Scanned: ClamAV version 0.88, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17117>

H. Peter Anvin wrote:
> I have started consistently getting the following error trying to do a 
> git-cvsimport into an empty directory:
> 
> + git cvsimport -C /home/hpa/local/kernel-cvs-import -k -u -m -A 
> /home/hpa/local/authors -d /home/hpa/local/cvsroot 
> project/sw/kernel/linux-2.6
> cp: cannot stat `/export/hpa/kernel-cvs-import/.git/refs/heads/origin': 
> No such file or directory
> fatal: master: not a valid SHA1
> fatal: 'HEAD': No such file or directory
> usage: git-read-tree (<sha> | -m [-u | -i] <sha1> [<sha2> [<sha3>]])
> checkout failed: 256
> 

Turns out to be user error (the CVS module is "projects", not 
"project"), but that probably indicates something that could use a 
better error message, in particular: if there are zero changesets.

	-hpa
