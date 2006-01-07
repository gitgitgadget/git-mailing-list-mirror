From: "David S. Miller" <davem@davemloft.net>
Subject: Re: [ANNOUNCE] GIT 1.0.7
Date: Sat, 07 Jan 2006 00:29:04 -0800 (PST)
Message-ID: <20060107.002904.87767885.davem@davemloft.net>
References: <7vhd8go71t.fsf@assigned-by-dhcp.cox.net>
	<20060107.021614.94523887.yoshfuji@linux-ipv6.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 07 09:29:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ev9Rm-00065X-E6
	for gcvg-git@gmane.org; Sat, 07 Jan 2006 09:29:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932700AbWAGI3H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jan 2006 03:29:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932701AbWAGI3G
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jan 2006 03:29:06 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:33211
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932700AbWAGI3F (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jan 2006 03:29:05 -0500
Received: from localhost ([127.0.0.1] ident=davem)
	by sunset.davemloft.net with esmtp (Exim 4.60)
	(envelope-from <davem@davemloft.net>)
	id 1Ev9Rg-0000xa-RN; Sat, 07 Jan 2006 00:29:04 -0800
To: yoshfuji@linux-ipv6.org
In-Reply-To: <20060107.021614.94523887.yoshfuji@linux-ipv6.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14241>

From: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
Date: Sat, 07 Jan 2006 02:16:14 -0600 (CST)

> @@ -43,6 +43,7 @@ static void add_to_known_names(const cha
>  	struct commit_name *name = xmalloc(sizeof(struct commit_name) + len);
>  
>  	name->commit = commit;
> +	name->path = sizeof(*name);
>  	name->prio = prio; 
>  	memcpy(name->path, path, len);
>  	idx = names;

Why are you assigning an integer to a pointer? :-)
Probably you meant something like:

	struct commit_name *name = xmalloc(sizeof(struct commit_name) + len);

	...
	name->path = xmalloc(len);
	...
