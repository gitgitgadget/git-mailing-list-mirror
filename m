From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Solaris needs strings.h when using index().
Date: Tue, 04 Apr 2006 11:44:29 -0700
Message-ID: <4432BE8D.3030504@zytor.com>
References: <20060404123603.GA14071@bohr.gbar.dtu.dk> <7vwte56w7n.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Peter Eriksen <s022018@student.dtu.dk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 04 20:46:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQqXC-0007P4-NN
	for gcvg-git@gmane.org; Tue, 04 Apr 2006 20:45:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbWDDSpB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Apr 2006 14:45:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbWDDSpA
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Apr 2006 14:45:00 -0400
Received: from terminus.zytor.com ([192.83.249.54]:47499 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750797AbWDDSon
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 4 Apr 2006 14:44:43 -0400
Received: from [192.168.10.106] (63-207-7-10.ded.pacbell.net [63.207.7.10])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.6/8.13.4) with ESMTP id k34IiTVD014188
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 4 Apr 2006 11:44:30 -0700
User-Agent: Thunderbird 1.5 (X11/20060313)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vwte56w7n.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: ClamAV version 0.88, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18402>

Junio C Hamano wrote:
> "Peter Eriksen" <s022018@student.dtu.dk> writes:
> 
>> From: Peter Eriksen <s022018@student.dtu.dk>
>> Date: Tue Apr 4 14:33:14 2006 +0200
>> Subject: [PATCH] Solaris needs strings.h when using index().
>>
>> Signed-off-by: Peter Eriksen <s022018@student.dtu.dk>
> 
> I think somebody else noticed this the other day but I'm
> undecided if it is easier to replace use of index with strchr,
> since we include <string.h> and use strchr() everywhere.
> 

strchr() is definitely more portable.  The further away you get from BSD 
heritage, the less likely it is that you're going to see bzero, index, 
et al whereas anything even remotely modern has memset, strchr, etc.

	-hpa
