From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: What's in git.git
Date: Tue, 17 Oct 2006 19:57:42 +0100
Message-ID: <453527A6.1000201@shadowen.org>
References: <7vvemjmlo2.fsf@assigned-by-dhcp.cox.net>	<Pine.LNX.4.64.0610171005370.3962@g5.osdl.org> <7v64eikdp2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 17 20:59:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZu9Q-0002Rx-GF
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 20:58:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbWJQS6i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 14:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751449AbWJQS6i
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 14:58:38 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:4871 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1751439AbWJQS6b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 14:58:31 -0400
Received: from localhost ([127.0.0.1])
	by hellhawk.shadowen.org with esmtp (Exim 4.50)
	id 1GZu8F-00035r-9v; Tue, 17 Oct 2006 19:57:45 +0100
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v64eikdp2.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29105>

Junio C Hamano wrote:
> Linus Torvalds <torvalds@osdl.org> writes:
> 
>> There's two things to note about this:
>>
>>  - the libxdiff dependencies are broken, so it's likely that you need to 
>>    do a "make clean; make" to actually see the result of this.
> 
> Eh, stupid-and-obvious like this perhaps.
> 
> ---
> 
> diff --git a/Makefile b/Makefile
> index 2c7c338..3fed480 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -237,6 +237,7 @@ PYMODULES = \
>  
>  LIB_FILE=libgit.a
>  XDIFF_LIB=xdiff/lib.a
> +$(XDIFF_LIB): $(wildcard xdiff/*.[ch])

To combine your more succinct style with my previous patch, its the link
between the .o's and the .h's thats missing.

$(XDIFF_OBJS): $(wildcard xdiff/*.h)

-apw
