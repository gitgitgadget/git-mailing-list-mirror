From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Usage of isspace and friends
Date: Thu, 13 Oct 2005 06:27:07 -0700
Message-ID: <434E60AB.8030607@zytor.com>
References: <118833cc0510111840k715e1190l54ad65f821c77848@mail.gmail.com> <7vachd6hdx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Morten Welinder <mwelinder@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 13 15:28:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EQ37D-0006S1-Uh
	for gcvg-git@gmane.org; Thu, 13 Oct 2005 15:27:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751549AbVJMN1U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Oct 2005 09:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751525AbVJMN1U
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Oct 2005 09:27:20 -0400
Received: from terminus.zytor.com ([192.83.249.54]:51078 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751531AbVJMN1U
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2005 09:27:20 -0400
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j9DDR6mA017075
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 13 Oct 2005 06:27:08 -0700
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vachd6hdx.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.9 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10071>

Junio C Hamano wrote:
> 
> Huh?  isspace is "int isspace(int)".  Presumably standard
> integral promotion rules applies here whether char is signed or
> unsigned, doesn't it?
> 
> The snippet you quoted is from apply.c, and I would say what is
> more problematic is that we do not force C locale while parsing
> the diff (see another thread -- we would want to process diffs
> as byte streams).
> 

The problem is that isspace() is defined to operate on an integer which 
can be an unsigned char value promoted to int or EOF (-1).

	-hpa
