From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Detect renames in diff family.
Date: Thu, 19 May 2005 13:12:07 -0700
Message-ID: <428CF317.5010103@zytor.com>
References: <7vu0kz1p6k.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0505190901340.2322@ppc970.osdl.org> <7v4qcz16n6.fsf@assigned-by-dhcp.cox.net> <7vy8abys5a.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0505191148470.2322@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 22:13:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYrMw-0004zn-MI
	for gcvg-git@gmane.org; Thu, 19 May 2005 22:11:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbVESUMi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 May 2005 16:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261247AbVESUMi
	(ORCPT <rfc822;git-outgoing>); Thu, 19 May 2005 16:12:38 -0400
Received: from terminus.zytor.com ([209.128.68.124]:50406 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261244AbVESUMg
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2005 16:12:36 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j4JKCDu8014460
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 19 May 2005 13:12:13 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505191148470.2322@ppc970.osdl.org>
X-Virus-Scanned: ClamAV version 0.85, clamav-milter version 0.85 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-5.3 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.3
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
> 
> IOW, you're screwed. "execvp()" really should take an argument of type
> "const char * const *", but it doesn't for historical reasons.
> 

The real problem, IMNSHO, is that C doesn't allow a pointer to a pointer 
to a non-const object to be implicitly treated as a pointer to a pointer 
to a const object.  C should have required those two pointer classes to 
have the same representation (which they would in any sane, and pretty 
much any insane, system) and therefore a lot of functions could have the 
additional consts added to their prototypes.

At least one can do casts on sane architectures... :-/

	-hpa
