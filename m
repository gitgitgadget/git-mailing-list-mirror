From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: User-relative paths
Date: Sun, 23 Oct 2005 18:08:55 -0700
Message-ID: <435C3427.30803@zytor.com>
References: <435ABB99.5020908@op5.se>	<7vll0l6pn7.fsf@assigned-by-dhcp.cox.net> <435B5AE0.1060400@op5.se>	<7v1x2cyplw.fsf@assigned-by-dhcp.cox.net>	<Pine.LNX.4.64.0510231427230.10477@g5.osdl.org> <7v8xwjx2f9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, Andreas Ericsson <ae@op5.se>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 24 03:09:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ETqpj-00080o-U8
	for gcvg-git@gmane.org; Mon, 24 Oct 2005 03:09:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750889AbVJXBIx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 23 Oct 2005 21:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750894AbVJXBIw
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Oct 2005 21:08:52 -0400
Received: from terminus.zytor.com ([192.83.249.54]:39814 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750889AbVJXBIw
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Oct 2005 21:08:52 -0400
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j9O18R5w004333
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 23 Oct 2005 18:08:28 -0700
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v8xwjx2f9.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.9 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10518>

Junio C Hamano wrote:
> Linus Torvalds <torvalds@osdl.org> writes:
> 
> 
>>It's incomplete and almost certainly buggy and generally broken, but 
>>here's somethign that you _could_ install as "git-shell", and then put 
>>that as somebodys shell in /etc/passwd, and it's a start. A very rough 
>>start.
>>
>>Somebody else gets to test it out ;)
>>
>>+		if (c != '\'') {
>>+			*dst++ = c;
>>+			continue;
>>+		}
>>+		switch (*++src) {
>>+		case '\0':
>>+			*dst = 0;
>>+			return arg;
>>+		case '\\':
>>+			if (*++src == '\'' &&
>>+			    *++src == '\'') {
>>+				*dst = '\'';
>>+				continue;
>>+			}
>>+		/* Fallthrough */
>>+		default:
> 
> I think this misses HPA's addition to minimally suppport csh
> braindamage (bang bang).
> 

If this is meant to dequote shell-quoted paths, it really should be modal.

	-hpa
