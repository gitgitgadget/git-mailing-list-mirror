From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Fix cygwin install issues
Date: Mon, 10 Oct 2005 10:09:07 -0700
Message-ID: <434AA033.60308@zytor.com>
References: <20051010085259.GA18009@diku.dk>	<7vmzlh7n7h.fsf@assigned-by-dhcp.cox.net> <434A82A0.7060608@zytor.com> <7v64s571t5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 10 19:09:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EP19b-0005Or-Ia
	for gcvg-git@gmane.org; Mon, 10 Oct 2005 19:09:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750973AbVJJRJU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Oct 2005 13:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750981AbVJJRJU
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Oct 2005 13:09:20 -0400
Received: from terminus.zytor.com ([192.83.249.54]:18890 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750979AbVJJRJS
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2005 13:09:18 -0400
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j9AH973H030791
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 10 Oct 2005 10:09:07 -0700
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v64s571t5.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.8 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9899>

Junio C Hamano wrote:
> 
> OK.  It is better than dq, and the user can still work it around
> like this if she really wanted to:
> 
> 	make bindir="Anna'\\''s Home/bin"
> 
> I wish we had $(shellquote $(DESTDIR)$(bindir)) in make ;-).

Hmm... let's think about this for a second...

shellquote = '$(subst ','\'',$(1))'

$(call shellquote,$(whatever))

... seems to work just fine.

(No need to worry about ! since Make commands are always /bin/sh.)

	-hpa
