From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 1/3] Support for SSL client cert
Date: Mon, 26 Sep 2005 20:23:41 +0200
Message-ID: <20050926182341.GA26340@pasky.or.cz>
References: <20050926175156.GB9410@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 26 20:25:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJxdk-0008E5-Pz
	for gcvg-git@gmane.org; Mon, 26 Sep 2005 20:23:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932457AbVIZSXo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Sep 2005 14:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932458AbVIZSXo
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Sep 2005 14:23:44 -0400
Received: from w241.dkm.cz ([62.24.88.241]:47821 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932457AbVIZSXn (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Sep 2005 14:23:43 -0400
Received: (qmail 26993 invoked by uid 2001); 26 Sep 2005 20:23:41 +0200
To: Nick Hengeveld <nickh@reactrix.com>
Content-Disposition: inline
In-Reply-To: <20050926175156.GB9410@reactrix.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9319>

Dear diary, on Mon, Sep 26, 2005 at 07:51:57PM CEST, I got a letter
where Nick Hengeveld <nickh@reactrix.com> told me that...
> @@ -491,11 +495,19 @@ int main(int argc, char **argv)
>  		} else if (argv[arg][1] == 'w') {
>  			write_ref = argv[arg + 1];
>  			arg++;
> +		} else if (arg+1 < argc && !strcmp(argv[arg], "--cert")) {
> +			ssl_cert = argv[++arg];
> +		} else if (arg+1 < argc && !strcmp(argv[arg], "--key")) {
> +			ssl_key = argv[++arg];
> +		} else if (arg+1 < argc && !strcmp(argv[arg], "--capath")) {
> +			ssl_capath = argv[++arg];
> +		} else if (arg+1 < argc && !strcmp(argv[arg], "--cacert")) {
> +			ssl_cacert = argv[++arg];
>  		}
>  		arg++;
>  	}
>  	if (argc < arg + 2) {
> -		usage("git-http-fetch [-c] [-t] [-a] [-d] [-v] [--recover] [-w ref] commit-id url");
> +		usage("git-http-fetch [-c] [-t] [-a] [-d] [-v] [--recover] [-w ref] [--cert ssl-cert-file] [--key ssl-key-file] [--capath CA-dir] [--cacert CA-cert-file] commit-id url");
>  		return 1;
>  	}
>  	commit_id = argv[arg];

Could we please have at least --sslkey, if not having 'ssl' prepended to
all of them? You never know when you'll want to call something else like
that in the future... ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
