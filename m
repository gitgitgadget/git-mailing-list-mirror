From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: /bin/sh portability question
Date: Fri, 23 Sep 2005 12:48:39 -0700
Message-ID: <43345C17.7060402@zytor.com>
References: <20050923075058.GA25473@bohr.gbar.dtu.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 23 21:50:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EItXp-000778-72
	for gcvg-git@gmane.org; Fri, 23 Sep 2005 21:49:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbVIWTtD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Sep 2005 15:49:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbVIWTtD
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Sep 2005 15:49:03 -0400
Received: from terminus.zytor.com ([209.128.68.124]:4063 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751193AbVIWTtC
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2005 15:49:02 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j8NJmfZZ025794
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 23 Sep 2005 12:48:42 -0700
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: Peter Eriksen <s022018@student.dtu.dk>
In-Reply-To: <20050923075058.GA25473@bohr.gbar.dtu.dk>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-5.8 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9197>

Peter Eriksen wrote:
> 
> 2) In many of the shell scripts there is the idiom:
> 
>       #!/bin/sh
>       
>       cmd=
>       path=$(dirname $0)
>       case "$#" in
>       0)      ;;
>       *)      cmd="$1"
>               shift
>  
>    When run, this gives the error:
> 
>       ./git.sh: syntax error at line 4: `path=$' unexpected
> 
>    I think it's because (on my Solaris at least), sh is really 
>    sh and is not symlinked to bash, and sh doesn't like that 
>    syntax.  Are there any good solutions to this other than
>    making the administrators actually change sh to a symlink,
>    (which I tried)?
> 

I think $(foo) is required by POSIX.

	-hpa
