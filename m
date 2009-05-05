From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Two problems on alias of git
Date: Tue, 5 May 2009 19:01:36 +0200
Message-ID: <200905051901.38151.jnareb@gmail.com>
References: <op.utgiv92f6f2obg@i220-99-253-139.s27.a098.ap.plala.or.jp> <200905051742.51163.jnareb@gmail.com> <op.utgs86ta6f2obg@i220-99-253-139.s27.a098.ap.plala.or.jp>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Kana Natsuno" <kana@whileimautomaton.net>
X-From: git-owner@vger.kernel.org Tue May 05 19:02:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1O1g-0005SH-0M
	for gcvg-git-2@gmane.org; Tue, 05 May 2009 19:01:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754467AbZEERBo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2009 13:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754361AbZEERBn
	(ORCPT <rfc822;git-outgoing>); Tue, 5 May 2009 13:01:43 -0400
Received: from mail-ew0-f224.google.com ([209.85.219.224]:45309 "EHLO
	mail-ew0-f224.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752996AbZEERBm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2009 13:01:42 -0400
Received: by ewy24 with SMTP id 24so5153442ewy.37
        for <git@vger.kernel.org>; Tue, 05 May 2009 10:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=hvCKxgVFHV+7RS22MDZPvR7AjI6I9pMt43KkhYCF4o8=;
        b=D2i+uI+GlRvjsZ75GNFCKDw7LsYjkGDOVjrFqzfm/0lmZ5pxKFLQ3sezDriHEfYZVK
         kUjRlFSqSo2Jvwsil6qfqoyDeXT1h+ed313ezoOxPr3kDa9I/ZfWjh+rARV8Uh12ljr4
         w4OP4yIRYxfozMqeVf03HZIcY5uhcjXxXSjlc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=RzxfiZbkgxwbaTJwJ4WPjRQiBlyEiut/PQKTe5wzf3nbWexz+Vn1a5BbJECWmBdQXF
         WKc7P8qDTp9zIr/+v2AvUTk8BoHUAuA/r+ziYwo+n9FEsSrEiSzpknH/mBJ7JXjPVZlm
         1TA5Kcjbj2MPLtmGA0e7mEPFUk72pdyM0VCkM=
Received: by 10.216.25.209 with SMTP id z59mr350681wez.204.1241542901595;
        Tue, 05 May 2009 10:01:41 -0700 (PDT)
Received: from ?192.168.1.13? (abwa249.neoplus.adsl.tpnet.pl [83.8.224.249])
        by mx.google.com with ESMTPS id t2sm120227gve.12.2009.05.05.10.01.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 05 May 2009 10:01:40 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <op.utgs86ta6f2obg@i220-99-253-139.s27.a098.ap.plala.or.jp>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 5 May 2009 (yes, different timezones), Kana Natsuno wrote:
> On Wed, 06 May 2009 00:42:49 +0900, Jakub Narebski <jnareb@gmail.com> wrote:

> > By the way, you can use continuation-of-line character (end line
> > with '\') and/or can embed newlines using C escape sequence, i.e. "\n".
> >
> > So your code can look like this (although I am not sure it is worth it):
> >
> >   [alias]
> >         lr = "!$SHELL -c '                               \n\
> >                 n=10;                                    \n\
> >                 1=\"${1:-$n}\";                          \n\
> >                 if ! [ \"${1##[0-9]*}\" = \"\" ]; then   \n\
> >                   t=\"$1\";                              \n\
> >                   1=\"${2:-$n}\";                        \n\
> >                   2=\"$t\";                              \n\
> >                 fi;                                      \n\
> >                 git --no-pager l1 --reverse -\"$1\" \"${2:-HEAD}\" \n\
> >               ' __dummy__"
> 
> Thank you again, I didn't know that.  It is better than what I wrote.

By the way, "\n" is there only for nice looking output of git-config
for this variable.  For config file you need only to escape end of line. 
 
> > BTW. you need to quote value because it contains comment character '#'
> > in 4th line of script.
> 
> Really?  As far as I read the code of git, especially parse_value() in config.c,
> it is not necessary to escape '#'s because they are inside of the outermost
> doublequotes and they should not be escaped, because \# is an unknown escape
> sequence and git rejects them.  If #s are escaped, it causes an error as follows:
> 
> $ git config --get alias.lr
> fatal: bad config file line 29 in /Users/kana/.gitconfig

Errrr... what I meant is that you have to _quote_ value if it contains
comment character, compare

  [string]
  	unquoted =  a # b
  	quoted   = "a # b"

not that you have to escape comment character '#'. But I forgot about
the fact that ## in your example is inside quotes anyway.

-- 
Jakub Narebski
Poland
