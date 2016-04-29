From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH 2/2] http: expand http.cookieFile as a path
Date: Fri, 29 Apr 2016 08:55:32 -0700
Message-ID: <20160429155532.GA57118@google.com>
References: <20160429062357.12647-1-computersforpeace@gmail.com>
 <20160429062357.12647-2-computersforpeace@gmail.com>
 <20160429141212.GB26643@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 29 17:55:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awAlY-0006M3-IF
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 17:55:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753874AbcD2Pzg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 11:55:36 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33450 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753637AbcD2Pzf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 11:55:35 -0400
Received: by mail-pf0-f176.google.com with SMTP id 206so49911741pfu.0
        for <git@vger.kernel.org>; Fri, 29 Apr 2016 08:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=g2x+/abFwDr0kTj3VwFgxfppco6lsqxeovIowuG80Ug=;
        b=HmTY7tvT2fAhKCu9Toe7RaZLI4YJFJxEJ7kBRmfc/t1ygA9MnFsYqMVgYlnzopnuPA
         1myVto2j3JCs+aMDQL29GHNaHSqMRAj2k/l3otiS+R+YSMsBEg+XIVtJtPLI51cq4wDI
         luDbyucjrIgzTYS5e3DXp80Z/WnSw8oYBkLCox/qnM+QoFxmcVoObD6ZS1GGyxmq3Mm/
         zdcr/DstKhigbI7NkSV31I9picBOpA2xL1VNQR5tOYSjHLsFsEq6Kp7oExL4L3YX7gG+
         nhyJn3piblQeaK1yICEdV091HFt+/gjSp3EWAxNg14wI32J4Tyo+bwB3SmpnovZ4KibK
         GF2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=g2x+/abFwDr0kTj3VwFgxfppco6lsqxeovIowuG80Ug=;
        b=JsOnejXl8ZB6pwihJaw78+GfrwI8pllrl0B/1GJkLQ7vU6vLgaLHZDJnIi1FtjYYp8
         B4TJnITIgYL8HP5fjtaSprM4OjQ4l/4VVY1uJNtnkTniZSYCxj3zkjYtkCe924WrqbDm
         2AbryxSnpcH5OH8833JHqrJ16KAbCmxUBuXwFh9lo+/9fONKVdjs/d8U9ref3+M0HNY9
         NgZDn3lLVBf0yS8jG8LdoDK1AA5i72DzGJBEh3R/HEn100Pzi4hnzrVcaGiuXk5YrPY/
         5h0NDVHfTIUHLmWIBA5U1OkQvzDANfrQWbGo0DG+mn6HN58F6E5HqhQuBCx3z1r2y6s5
         Jcrg==
X-Gm-Message-State: AOPr4FVP9f2KOZqYE36ftPhB0DUHR3t8ZGJAl5VvvE/CDgjvotUb6XwoS0Skx3/uFTb92A==
X-Received: by 10.98.28.84 with SMTP id c81mr30257658pfc.131.1461945335049;
        Fri, 29 Apr 2016 08:55:35 -0700 (PDT)
Received: from google.com ([2620:0:1000:1301:8d40:703e:9507:1fcf])
        by smtp.gmail.com with ESMTPSA id g84sm24415589pfj.42.2016.04.29.08.55.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 29 Apr 2016 08:55:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160429141212.GB26643@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293020>

On Fri, Apr 29, 2016 at 10:12:12AM -0400, Jeff King wrote:
> On Fri, Apr 29, 2016 at 12:23:57AM -0600, Brian Norris wrote:
> 
> > This should handle .gitconfig files that specify things like:
> > 
> > [http]
> > 	cookieFile = "~/.gitcookies"
> 
> Seems like a good idea, and the implementation looks obviously correct.
> 
> For the documentation:
> 
> > diff --git a/Documentation/config.txt b/Documentation/config.txt
> > index a775ad885a76..d3ef2d3b5d13 100644
> > --- a/Documentation/config.txt
> > +++ b/Documentation/config.txt
> > @@ -1660,6 +1660,9 @@ http.cookieFile::
> >  	in the Git http session, if they match the server. The file format
> >  	of the file to read cookies from should be plain HTTP headers or
> >  	the Netscape/Mozilla cookie file format (see linkgit:curl[1]).
> > +	The value of `http.cookieFile` is subject to tilde expansion: `~/` is
> > +	expanded to the value of `$HOME`, and `~user/` to the specified user's
> > +	home directory.
> >  	NOTE that the file specified with http.cookieFile is used only as
> >  	input unless http.saveCookies is set.
> 
> I'm not sure if it's a good idea to go into so much detail about
> expand_user_path() here. There are a lot of options that use the same
> rules, and we probably don't want to go into a complete explanation
> inside each option's description. Is there a canonical definition of how
> we do expansion in config.txt that we can just reference (and if not,
> can we add one)?

I mostly just copied from boilerplate on another option. IIRC, there
were at least two other options that were documented similarly.

I think it's very important to note this somehow in the documentation.
For months, I've just had to keep a delta among the (otherwise
identical, shared) .gitconfig on my various machines just to account for
the different home directories. I thought that the "no-expansion" thing
was an intentional policy, since there are various blogs/forums that
mention the lack of this kind of expansion when you search for related
problems. But apparently this was a bug/oversight. So having clear
documentation to state the reality is imperative, IMO.

The best kind of documentation might mention that all paths can be
expanded in this way, and then just include "path" language on the
relevant options. But then we'd have to do a quick audit to make sure
that every path-based option does indeed use this path-expansion helper.
(As this patch proves, we haven't been very consistent so far.)

If you have a good overall recommendation for this, I can try to send a
new patch sometime next week.

Brian
