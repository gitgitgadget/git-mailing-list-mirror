From: Matthias-Christian Ott <matthias.christian@tiscali.de>
Subject: Re: [PATCH GIT 0.6] make use of register variables & size_t
Date: Mon, 25 Apr 2005 14:56:36 +0200
Message-ID: <426CE904.9010505@tiscali.de>
References: <426CD1F1.2010101@tiscali.de> <426CD703.5040009@exactcode.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 25 14:52:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQ34E-0006Eb-ED
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 14:52:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262598AbVDYM4v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 08:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262601AbVDYM4v
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 08:56:51 -0400
Received: from relay1.tiscali.de ([62.26.116.129]:2024 "EHLO
	webmail.tiscali.de") by vger.kernel.org with ESMTP id S262598AbVDYM4r
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2005 08:56:47 -0400
Received: from [169.254.101.1] (213.54.93.37) by webmail.tiscali.de (7.0.036.1) (authenticated as matthias.christian@tiscali.de)
        id 426359F50003D508; Mon, 25 Apr 2005 14:56:43 +0200
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050406)
X-Accept-Language: en-us, en
To: Rene Rebe <rene@exactcode.de>
In-Reply-To: <426CD703.5040009@exactcode.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Rene Rebe wrote:
> Hi,
> 
> Matthias-Christian Ott wrote:
> 
>> The "git" didn't try store small variables, which aren't referenced, 
>> in the processor registers. It also didn't use the size_t type. I 
>> corrected a C++ style comment too.
> 
> 
> Well, modern compilers take register as a non-binding hint. Your 
> register storage specification for those loop counters will not make any 
> change. You have not looked into the resulting binary?
> 
> Also // is valid C99 ...
> 
> Yours,
> 
But if you use only /* */ comments and there's a // comment it looks 
ugly :).

I've disassembled the code and it for me (I'm not a professional 
assembler coder) it looks like it's stored in a register because the ebp 
offsets are smaller and the gcc (4.0) wouldn't cause an error if you 
reference them.

Matthias-Christian Ott
