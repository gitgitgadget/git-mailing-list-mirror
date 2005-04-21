From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] Improve usage messages
Date: Thu, 21 Apr 2005 18:25:05 +0200
Message-ID: <20050421162505.GE30991@pasky.ji.cz>
References: <20050421124152.A28137F87D@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 18:23:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOeRz-0004jC-Tw
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 18:22:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261513AbVDUQ0v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 12:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261512AbVDUQ0v
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 12:26:51 -0400
Received: from w241.dkm.cz ([62.24.88.241]:58242 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261518AbVDUQZS (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Apr 2005 12:25:18 -0400
Received: (qmail 1095 invoked by uid 2001); 21 Apr 2005 16:25:05 -0000
To: Matthias Urlichs <smurf@smurf.noris.de>
Content-Disposition: inline
In-Reply-To: <20050421124152.A28137F87D@smurf.noris.de>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Thu, Apr 21, 2005 at 02:41:52PM CEST, I got a letter
where Matthias Urlichs <smurf@smurf.noris.de> told me that...
> This patch adds somewhat-improved usage messages to some of Linus' programs.
> Specifically, they now handle -? / --help.

-? is pretty non-standard. Any problem with going for -h?

> Signed-Off-By: Matthias Urlichs <smurf@smurf.noris.de>
> 
> Index: check-files.c
> ===================================================================
> --- 42a073eb6b5bb397a3e8768a032463a7fa02e6b9/check-files.c  (mode:100644 sha1:7d16691aa9d51b5b4670d5837b3527ee7c7da79c)
> +++ 265515f9c4f089b1b61e9d2312c4b3babe189618/check-files.c  (mode:100644 sha1:be904b13659a60eab31787b010a64f2274048a9f)
> @@ -40,6 +40,8 @@
>  {
>  	int i;
>  
> +	if(argc == 2 && (!strcmp(argv[1],"-?") || !strcmp(argv[1],"--help")))

(style-education-hat
+	if (argc == 2 && (!strcmp(argv[1], "-?") || !strcmp(argv[1], "--help")))
)

> +		usage("check-files filename...");

Let's either do <filename>* or FILE..., this mixing doesn't look good.

>  	read_cache();
>  	for (i = 1; i < argc ; i++)
>  		check_file(argv[i]);
> Index: diff-tree.c
> ===================================================================
> --- 42a073eb6b5bb397a3e8768a032463a7fa02e6b9/diff-tree.c  (mode:100644 sha1:b0122e42631410fa579115f025efc3cab777cde6)
> +++ 265515f9c4f089b1b61e9d2312c4b3babe189618/diff-tree.c  (mode:100644 sha1:03fcc2fae2f0b06f3834f0b6e0d8762e70f49f51)
> @@ -193,6 +193,11 @@
>  	}
>  }
>  
> +static const char diff_tree_usage[] = 
> +	"diff-tree [ -r (recurse) | -z (\\0-terminate) ]"
> +		"\n\t<tree sha1> <tree sha1>";

I'd say this is pretty confusnig. Just describe the parameters on
folowing lines in more detail, if you must.

> +
> +
>  int main(int argc, char **argv)
>  {
>  	unsigned char old[20], new[20];

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
