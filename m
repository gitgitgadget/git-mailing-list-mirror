From: Edward Thomson <ethomson@edwardthomson.com>
Subject: Re: [PATCH] add: add --chmod=+x / --chmod=-x options
Date: Thu, 26 May 2016 23:41:12 -0500
Message-ID: <20160527044112.GA31742@zoidberg>
References: <20160525020609.GA20123@zoidberg>
 <xmqqh9dm37xk.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 27 06:41:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b69aR-00067C-U2
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 06:41:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753802AbcE0ElU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2016 00:41:20 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:33795 "EHLO
	mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188AbcE0ElR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2016 00:41:17 -0400
Received: by mail-it0-f65.google.com with SMTP id k76so4004940ita.1
        for <git@vger.kernel.org>; Thu, 26 May 2016 21:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edwardthomson-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LiRdoub+mAiakqejyvIVh3U6CnS0BJs5LKd9owWjieQ=;
        b=I69RJlJUUxDQ4vUWzzH2j3hQ5CZnvhFMKFT9CZqUFZiXHmAGUMHiIaBvVVPawNsjUA
         5HcyJ6Mlw8C+7eSlVTxDQ2kLTxooUh6jea5OuD6ID3tgz/PtFbBDm/Bc7rrNMDDuhmlC
         kbnOFhheZHnvqCHnaazbTEKS9NQwGnXUx8e2l7Y/+jvh+658W5szlATqekJU9DFXl8HG
         4mE3HvxVhSWtNGwQKeINGHp13NDqopbjlnpolFDguEr93kYVxI6fyxtPiOn5DHrOMJO5
         Uh2dyzNOS4pcH5puQHrSk1ta7ivCRZIFkD4NtzyOb2hXF77rLeUrIi/OhsHOvIqii1Fn
         7VCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LiRdoub+mAiakqejyvIVh3U6CnS0BJs5LKd9owWjieQ=;
        b=QN3mc0yk2vu8KYaEoQSbdDe9428aiuQw8BQACOTairlT7utPjrO/QqxRNKjeo8OTdX
         +a4XSJGtErp1TNlFoIs4q4MkdpLUwptpwGFLn238eQoxMhSSqu+6T+qmCB0ADWumjN4I
         aXLkLh8GlTOigdfoMmAv2/XHgVF+NDSraUu0THQqXkJ07QuCRZj+EQlT+ZtYna+tM2aQ
         KUoLKyZxIked4fI3Ks1pHNvKDDdxUxCA+8OarXPCw6x9dhR6Zo1bP8aqxlwySNpJ7D0p
         X8D0ZuFAzZcPlqAQZMbN3PL+eSMZ5gv7gWur3A7xPzsn65BI5G5agIhJw7XSoBU9lucB
         Lzxw==
X-Gm-Message-State: ALyK8tLYKUm0IcRZP4Tap+k3Ejvpd4PNi5VN55yMf5NRwcb0ckdt8EGZe5tvlQ64Y6rQEA==
X-Received: by 10.36.137.87 with SMTP id s84mr6359636itd.93.1464324076870;
        Thu, 26 May 2016 21:41:16 -0700 (PDT)
Received: from zoidberg ([2601:249:1000:6850:3125:f490:e3f1:e1d])
        by smtp.gmail.com with ESMTPSA id g73sm2303373iog.6.2016.05.26.21.41.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 May 2016 21:41:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqh9dm37xk.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295730>

On Wed, May 25, 2016 at 12:36:55AM -0700, Junio C Hamano wrote:
> 
> At the design level, I have a few comments.

Thanks, I will submit a new patch that incorporates your (and dscho's)
comments.

>  * This is about a repository with core.filemode=0; I wonder if
>    something for a repository with core.symlinks=0 would also help?
>    That is, would it be a big help to users if they can prepare a
>    text file that holds symbolic link contents and add it as if it
>    were a symlink with "git add", instead of having to run two
>    commands, "hash-objects && update-index --cacheinfo"?

I think that this is much less common and - speaking only from personal
experience - nobody has ever asked me how to stage a symlink on a
Windows machine.  I think that this is due to the fact that symlinks on
Windows are basically impossible to use, so people doing cross-platform
development wouldn't even try.

On the other hand, it's quite common for cross-platform teams to use
some scripting language since those do work across platforms, and
Windows users would want to add new scripts as executable for the
benefit of their brethren on platforms with an executable bit.

>  * I am not familiar with life on filesystems with core.filemode=0;
>    do files people would want to be able to "add --chmod=+x" share
>    common trait that can be expressed with .gitattributes mechanism?

Perhaps...  It would not be things like `*.bat` or `*.exe` - Windows
gets those as executable "for free" and would not care about adding the
execute bit on those files (since they're not executable anywhere else).
It would be items like `*.sh` or `*.rb` that should be executable on
POSIX platforms.

However I do not think that this is a common enough action that it needs
to be made automatic such that when I `git add foo.rb` it is
automatically made executable.  I think that the reduced complexity of
having a single mechanism to control executability (that being the
execute mode in the index or a tree) is preferable to a gitattributes
based mechanism, at least until somebody else makes a cogent argument
that the gitattributes approach would be helpful for them.  :)

Thanks again for the comments, an updated patch is forthcoming.

-ed
