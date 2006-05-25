From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-format-patch possible regressions
Date: Fri, 26 May 2006 00:18:12 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0605260014340.13003@wbgn013.biozentrum.uni-wuerzburg.de>
References: <e5bfff550605251223g2cf8cfb9vfa18d016b369188d@mail.gmail.com>
 <7vhd3dubd9.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0605252338530.31700@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marco Costalba <mcostalba@gmail.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Fri May 26 00:18:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjO9u-0005Uj-Aq
	for gcvg-git@gmane.org; Fri, 26 May 2006 00:18:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030469AbWEYWSU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 May 2006 18:18:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030483AbWEYWST
	(ORCPT <rfc822;git-outgoing>); Thu, 25 May 2006 18:18:19 -0400
Received: from mail.gmx.de ([213.165.64.20]:56011 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030469AbWEYWST (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 May 2006 18:18:19 -0400
Received: (qmail invoked by alias); 25 May 2006 22:18:17 -0000
Received: from lxweb002.wuerzburg.citynet.de (EHLO localhost) [81.209.129.202]
  by mail.gmx.net (mp001) with SMTP; 26 May 2006 00:18:17 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.63.0605252338530.31700@wbgn013.biozentrum.uni-wuerzburg.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20769>

Hi,

On Thu, 25 May 2006, Johannes Schindelin wrote:

> @@ -193,6 +201,11 @@ int cmd_format_patch(int argc, const cha
>  	}
>  	argc = j;
>  
> +	if (start_number >= 0)
> +		numbered = 1;
> +	else if (numbered)
> +		start_number = 1;
> +
>  	if (numbered && keep_subject < 0)
>  		die ("-n and -k are mutually exclusive.");
>  

Thinking about this again, it makes more sense not to imply --numbered:

	if (numbered && start_number < 0)
		start_number = 1;

Ciao,
Dscho
