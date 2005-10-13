From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Usage of isspace and friends
Date: Thu, 13 Oct 2005 08:45:27 -0700
Message-ID: <434E8117.3090102@zytor.com>
References: <118833cc0510111840k715e1190l54ad65f821c77848@mail.gmail.com> <7vachd6hdx.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0510130756550.15297@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Morten Welinder <mwelinder@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 13 17:56:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EQ5Hm-0008Pt-06
	for gcvg-git@gmane.org; Thu, 13 Oct 2005 17:46:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343AbVJMPp7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Oct 2005 11:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbVJMPp7
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Oct 2005 11:45:59 -0400
Received: from terminus.zytor.com ([192.83.249.54]:20426 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751343AbVJMPp6
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2005 11:45:58 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j9DFjVLF021757
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 13 Oct 2005 08:45:32 -0700
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510130756550.15297@g5.osdl.org>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10077>

Linus Torvalds wrote:
> 
> So Morten is right - if you have a "char *", it should not be dereferenced 
> and used directly, although I think glibc does the right thing (and, in 
> fact, I can't understand why the standards haven't been updated to do the 
> right thing: it's _not_ that hard. In fact, it should be trivial apart 
> from the special case of "255" that looks undistinguishable from EOF in 
> signed char representation).
> 

Because of the special case of 255 which looks indistinguishable from 
EOF, therefore making it required?

The original mistake, of course, was allowing EOF to be passed to the 
various isxxx() macros.

	-hpa
