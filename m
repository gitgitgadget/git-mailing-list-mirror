From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Fix ptrdiff_t vs. int
Date: Fri, 27 May 2005 10:58:53 -0700
Message-ID: <42975FDD.9050901@zytor.com>
References: <42971EB4.2050403@oberhumer.com> <Pine.LNX.4.58.0505271013260.17402@ppc970.osdl.org> <Pine.LNX.4.58.0505271024280.17402@ppc970.osdl.org> <42975C1F.8070102@oberhumer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 27 19:57:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dbj59-00086b-6k
	for gcvg-git@gmane.org; Fri, 27 May 2005 19:57:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261905AbVE0R7S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 May 2005 13:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261949AbVE0R7S
	(ORCPT <rfc822;git-outgoing>); Fri, 27 May 2005 13:59:18 -0400
Received: from terminus.zytor.com ([209.128.68.124]:55016 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261905AbVE0R7P
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2005 13:59:15 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j4RHwwdf000616
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 27 May 2005 10:58:59 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
To: "Markus F.X.J. Oberhumer" <markus@oberhumer.com>
In-Reply-To: <42975C1F.8070102@oberhumer.com>
X-Virus-Scanned: ClamAV version 0.85.1, clamav-milter version 0.85 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.3
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Markus F.X.J. Oberhumer wrote:
> 
> Many thanks. BTW, this is probably completely irrelevant on all 
> real-world machines and calling conventions, but still, lying on the 
> number of arguments in vararg-functions is not my favourite practice.
> 

Bullshit.

Think about the way stdarg works, and you should quickly figure out that 
it is perfectly safe to pass extra arguments.

However, this code can also be rewritten:

	fputs(header, stdout);
	if (diff_output_format == DIFF_FORMAT_MACHINE)
		putchar('\0');

... which is probably faster anyway.

	-hpa
