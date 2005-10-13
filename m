From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Usage of isspace and friends
Date: Thu, 13 Oct 2005 09:07:44 -0700
Message-ID: <434E8650.7060604@zytor.com>
References: <118833cc0510111840k715e1190l54ad65f821c77848@mail.gmail.com> <7vachd6hdx.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0510130756550.15297@g5.osdl.org> <434E8117.3090102@zytor.com> <Pine.LNX.4.64.0510130847190.15297@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Morten Welinder <mwelinder@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 13 18:15:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EQ5dI-0003PB-NR
	for gcvg-git@gmane.org; Thu, 13 Oct 2005 18:08:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbVJMQIG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Oct 2005 12:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932088AbVJMQIG
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Oct 2005 12:08:06 -0400
Received: from terminus.zytor.com ([192.83.249.54]:48858 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932085AbVJMQIE
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2005 12:08:04 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j9DG7l9u022435
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 13 Oct 2005 09:07:47 -0700
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510130847190.15297@g5.osdl.org>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10081>

Linus Torvalds wrote:
> 
> Yeah, and I agree, that was a mistake. It could have been fixed by making 
> EOF be MIN_INT (or any other value outside the range of either "unsigned 
> char" or "signed char" - preferably still negative), but there are 
> probably programs that depend on it being -1. 
> 
> The stupid thing I just posted doesn't care. It happens to return 0 for 
> EOF for all cases, but that's a side effect of (a) not doing locales (so 
> 255 is never printable or alpha) and (b) not even implementing iscntrl().
> 

Given that for isprint() et al are useless for non-ASCII UTF-8 anyway, 
might as well (they are not defined to be able to take wide character 
values.)

	-hpa
