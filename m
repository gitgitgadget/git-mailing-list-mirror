From: "David A. Wheeler" <dwheeler@dwheeler.com>
Subject: Re: [PATCH GIT 0.6] make use of register variables & size_t
Date: Mon, 25 Apr 2005 14:06:19 -0400
Message-ID: <426D319B.2040805@dwheeler.com>
References: <426CD1F1.2010101@tiscali.de> <426CD703.5040009@exactcode.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Apr 25 20:02:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQ7tj-0004Ld-9x
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 20:01:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262678AbVDYSGZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 14:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262685AbVDYSGZ
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 14:06:25 -0400
Received: from aibo.runbox.com ([193.71.199.94]:64162 "EHLO cujo.runbox.com")
	by vger.kernel.org with ESMTP id S262678AbVDYSGU (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Apr 2005 14:06:20 -0400
Received: from [10.9.9.110] (helo=snoopy.runbox.com)
	by greyhound.runbox.com with esmtp (Exim 4.34)
	id 1DQ7yM-0003KS-6I; Mon, 25 Apr 2005 20:06:18 +0200
Received: from [129.246.254.27] (helo=[129.246.80.140])
	by snoopy.runbox.com with asmtp (uid:258406) (Exim 4.34)
	id 1DQ7yL-0002CM-U8; Mon, 25 Apr 2005 20:06:18 +0200
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
To: Rene Rebe <rene@exactcode.de>,
	Matthias-Christian Ott <matthias.christian@tiscali.de>,
	git@vger.kernel.org
In-Reply-To: <426CD703.5040009@exactcode.de>
X-Sender: 258406@vger.kernel.org
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
> register storage specification for those loop counters will not make 
> any change. You have not looked into the resulting binary?

Indeed, register was ALWAYS a non-binding hint. Today,
unless you have specific measurements showing that adding "register"
at some point improves the performance for a (somewhat common) situation,
you're better off NOT including "register" nowadays.  Today's compilers
are generally better at allocating registers than 
people-who-have-little-time.
Premature optimization is the root of all kinds of evil...

> Also // is valid C99 ...

It's not, strictly speaking, okay on old pre-C99 compilers.
But in practice, practically all C compilers from the last 10+ years
have accepted // comments as a very popular extension.
So using "//" is unlikely to be a portability problem, even on semi-old 
compilers.

--- David A. Wheeler

