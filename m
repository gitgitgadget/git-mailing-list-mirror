From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv2] submodule deinit: require '--all' instead of '.' for
 all submodules
Date: Tue, 3 May 2016 17:47:59 -0700
Message-ID: <20160504004759.GB395@google.com>
References: <1462313499-6760-1-git-send-email-sbeller@google.com>
 <1462321992-15153-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, Jens.Lehmann@web.de, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed May 04 02:48:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axkz6-0005Ci-Nt
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 02:48:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932265AbcEDAsE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 20:48:04 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:33246 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756856AbcEDAsD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 20:48:03 -0400
Received: by mail-pf0-f173.google.com with SMTP id 206so17917736pfu.0
        for <git@vger.kernel.org>; Tue, 03 May 2016 17:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lGpj17hl1olWXyESFt+rVV5HBH+ObhJYPbY0I3kJJS4=;
        b=OxSbX0Lkm8vMaFauVcMDGh9szihArdS1mQ8JnTbV0jQLRk7gTVnUOUgeOFm1Z3Zas/
         RYeX2cHTF3UDa5RsG3QDdgkZXZVNh7YvJFT/LeQWW68wUuE7v8gBHh3kdgtnLq4FEj4Z
         MkARshaUtrKMWB1CZatdpSK9q9lyTNrLANmTIvtEQ8ePZ/bTOi2/Qa8nN0uzr9kOF3ft
         8HCMmki+96+O++xjOok3Ta4Dqr7cffDWZpqN/hoYNoZ2r6iBz5ybskEP53RMduKmlvkJ
         Cn+jNJYPY1BHg2c3tdlTxoelC2TMfzLt/JKEuyENVUM6PSnVOssm6TaGCcqxksdUwqwu
         FNDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lGpj17hl1olWXyESFt+rVV5HBH+ObhJYPbY0I3kJJS4=;
        b=TtjYDyMRdJcc/5OEulvmwurBAhuPReoS804qSbvp82mVKpD/KHCsY0J0S/CuNgz861
         q3GMyST8kbjmbqlQYJ5X/X8+x47kkKzgKW7eEJiQgzGHtmgAgf8+obyKUPTxC0y/ofk0
         baWziEgAjGEMHN+L2AO96XhlOis5jOvFGJP+yTC9bqgkM1jPywHovMiLDgWaJH+T+8eg
         hrybsKPWQBmfYrBLA4W/eXZryvMRwGhluST23e9HxiQz8wXbFWHKd1WZ8nFFK7Ar0CV4
         kwtq9NM6NnrMtqHImY3d1OJZKaLzyisFXX6/HUjkfs9x1s6fn5EYL7zRc5vG8aOk5EQ5
         xD3g==
X-Gm-Message-State: AOPr4FV6E8hfbI+/SHwhhlZX3bYP0PVvdyh4zGFuHlxyHpof6HqaefW+ZX1VgcHXdvKUCQ==
X-Received: by 10.98.69.132 with SMTP id n4mr7917365pfi.53.1462322882073;
        Tue, 03 May 2016 17:48:02 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:4851:afc:d444:8a50])
        by smtp.gmail.com with ESMTPSA id 80sm932970pfx.68.2016.05.03.17.48.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 03 May 2016 17:48:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1462321992-15153-1-git-send-email-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293483>

Stefan Beller wrote:

[...]
>>        $ rungit v2.6.6 submodule deinit .
>>        error: pathspec '.' did not match any file(s) known to git.
>>        Did you forget to 'git add'?
>>        $ >file && git add file
>>        $ rungit v2.6.6 submodule deinit .
>>        $ echo $?
>>        0
>
> So instead of a path spec add a parameter '--all' to deinit all submodules
> and add a test to check for the corner case of an empty repository.

Makes sense.

[...]
> It is a fix for a corner case, but it is renaming the switch, so I would
> expect that we'd wait for a new version at least.

The bug was that the documentation and error message gave advice that
didn't work.

[...]
> +++ b/Documentation/git-submodule.txt
> @@ -13,7 +13,7 @@ SYNOPSIS
>  	      [--reference <repository>] [--depth <depth>] [--] <repository> [<path>]
>  'git submodule' [--quiet] status [--cached] [--recursive] [--] [<path>...]
>  'git submodule' [--quiet] init [--] [<path>...]
> -'git submodule' [--quiet] deinit [-f|--force] [--] <path>...
> +'git submodule' [--quiet] deinit [-f|--force] [-a|--all] [--] <path>...
>  'git submodule' [--quiet] update [--init] [--remote] [-N|--no-fetch]
>  	      [-f|--force] [--rebase|--merge] [--reference <repository>]
>  	      [--depth <depth>] [--recursive] [--] [<path>...]
> @@ -144,6 +144,11 @@ deinit::
>  	you really want to remove a submodule from the repository and commit
>  	that use linkgit:git-rm[1] instead.
>  +
> +	To unregister all submodules use `--all` with no path spec. In
> +	version 2.8 and prior, you were advised to give '.' to unregister
> +	all submodules. This may continue to work in the future, but as the
> +	path spec '.' may include regular files, this could stop working.
> ++
>  If `--force` is specified, the submodule's work tree will be removed even if
>  it contains local modifications.

Inconsistent indentation.  Does asciidoc format this correctly?

[...]
> +++ b/git-submodule.sh
> @@ -521,6 +521,7 @@ cmd_init()
[...]
>  		shift
>  	done
>  
> -	if test $# = 0
> +	if test -n "$deinit_all" && test "$#" -ne 0
> +	then
> +		die "$(eval_gettext "'--all' is incompatible with pathspec arguments")"
> +	fi

This message is giving implementation details.  Most other git
commands just dump usage when passed too many arguments --- perhaps we
can do something more targeted like the following:

	die "$(eval_gettext "usage: $dashless [--quiet] deinit [-f|--force] (--all | [--] <path>...)")"

Speaking of which: please also update the USAGE string at the top of
git-submodule.sh.


[...]
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh

Makes sense.

Thanks for a pleasant fix.

Jonathan
