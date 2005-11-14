From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] git-daemon: --inetd implies --syslog
Date: Mon, 14 Nov 2005 15:59:23 -0800
Message-ID: <437924DB.1060602@zytor.com>
References: <20051114164101.58A495BF92@nox.op5.se> <7vlkzrx84p.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <exon@op5.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 15 01:00:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EboEd-00089v-VQ
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 00:59:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbVKNX7h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 18:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbVKNX7h
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 18:59:37 -0500
Received: from terminus.zytor.com ([192.83.249.54]:47060 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932251AbVKNX7g
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2005 18:59:36 -0500
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jAENxRni007243
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 14 Nov 2005 15:59:28 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vlkzrx84p.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11869>

Junio C Hamano wrote:
> 
> Thanks; I am OK with what you are trying to do with this change,
> except that:
> 
>  - I suspect closing stderr is still needed (the "workaround"
>    was about inetd connection sending output to both fd 1 and 2
>    to the client, which would corrupt the protocol conversation
>    when exec'ed program writes anything to its standard error
>    stream).
> 
>  - I would have preferred the removal of needless else as a
>    separate cleanup patch (this is minor).
> 
> Peter, I am CC'ing this to you because I do not know how you run
> the daemon on kernel.org machines -- I suspect you use --syslog
> already and am hoping you are OK with this change.

Yeah, I use --inetd --syslog.

	-hpa
