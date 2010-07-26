From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3-24/24] Documentation: include configuration options
 in manpages
Date: Mon, 26 Jul 2010 14:55:52 -0500
Message-ID: <20100726195552.GA1451@burratino>
References: <cover.1280169048.git.trast@student.ethz.ch>
 <a0be121e0b89f010273f3a3de9ad054bcec26d6c.1280169048.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Jul 26 22:03:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdTtH-00048L-2X
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 22:03:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755142Ab0GZT5H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jul 2010 15:57:07 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:52551 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752538Ab0GZT5E (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jul 2010 15:57:04 -0400
Received: by wyf19 with SMTP id 19so2464382wyf.19
        for <git@vger.kernel.org>; Mon, 26 Jul 2010 12:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=A50fuGuvuii1UmyogDXyxnMdlgzs0skW7YHXuPQ0Ebs=;
        b=cvSdA68KWAC4wbtEgu0FQPDayJjDEzNQtzfm7nJiCUVTng5sn0xlAaorf2EaJnXRwn
         KDie6BPAXH/6IoHbMi4ey5icL1M9xJXStlpt00rCoIIrPu8nA25kh7VLVNmiB2W1cten
         KhZ1AnQm7iE9vE1hF7v3JAZWsPZyUT0DlH/hc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=r2bYxXz554kOJsA0GDqEp4evVD8Au1bIsP8JTBpPfP7EXw5oom3i5a4Vsd/3lyH+H2
         /h0dlvX1JVA6nHacO/yC5PReoRDorcJ15uISrAlLj/0N2j3qmkjZ3TXQF9buE+z7K945
         4n358rLpl/VF4lzxqdjWDi9B81Y6lM35FE2cA=
Received: by 10.227.68.145 with SMTP id v17mr3757271wbi.159.1280174222859;
        Mon, 26 Jul 2010 12:57:02 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id i25sm3463498wbi.4.2010.07.26.12.57.00
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 26 Jul 2010 12:57:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <a0be121e0b89f010273f3a3de9ad054bcec26d6c.1280169048.git.trast@student.ethz.ch>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151889>

Thomas Rast wrote:

> +++ b/Documentation/git-add.txt
> @@ -148,10 +148,8 @@ subdirectories.
>  Configuration
>  -------------
>  
> -The optional configuration variable `core.excludesfile` indicates a path to a
> -file containing patterns of file names to exclude from git-add, similar to
> -$GIT_DIR/info/exclude.  Patterns in the exclude file are used in addition to
> -those in info/exclude.  See linkgit:gitrepository-layout[5].
> +@@CONFIG(add.ignore-errors)@@
> +@@CONFIG(core.excludesfile)@@

Hmm, the packrat in me does not like cavalierly throwing away text like
this. :)

[...]
> +++ b/Documentation/git-archive.txt
> @@ -93,12 +93,8 @@ zip
>  CONFIGURATION
>  -------------
>  
> -tar.umask::
> -	This variable can be used to restrict the permission bits of
> -	tar archive entries.  The default is 0002, which turns off the
> -	world write bit.  The special value "user" indicates that the
> -	archiving user's umask will be used instead.  See umask(2) for
> -	details.
> +@@CONFIG(tar.umask)@@
> +

Can this genre of change be automated?

[...]
> +++ b/Documentation/git-branch.txt
> @@ -222,6 +222,14 @@ but different purposes:
>  - `--no-merged` is used to find branches which are candidates for merging
>    into HEAD, since those branches are not fully contained by HEAD.
>  
> +
> +CONFIGURATION
> +-------------
> +
> +@@CONFIG(branch.autosetupmerge)@@
> +@@CONFIG(branch.autosetuprebase)@@
> +

Obviously a good thing.

Thanks.
Jonathan
