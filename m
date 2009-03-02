From: Jakub Narebski <jnareb@gmail.com>
Subject: Maintainer for autoconf in git (was: [PATCH] autoconf: Add limited support for --htmldir)
Date: Mon, 2 Mar 2009 10:30:35 +0100
Message-ID: <200903021030.37491.jnareb@gmail.com>
References: <9a0027270902272323y44091bfakcb640f168c33a824@mail.gmail.com> <200902280859.52004.jnareb@gmail.com> <9a0027270902280105hcad47c0r30bdd8379932442e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: David Syzdek <david@syzdek.net>
X-From: git-owner@vger.kernel.org Mon Mar 02 10:32:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Le4VT-0000LZ-6z
	for gcvg-git-2@gmane.org; Mon, 02 Mar 2009 10:32:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756902AbZCBJas (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2009 04:30:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756844AbZCBJar
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 04:30:47 -0500
Received: from mail-fx0-f176.google.com ([209.85.220.176]:59655 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753657AbZCBJaq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2009 04:30:46 -0500
Received: by fxm24 with SMTP id 24so1879540fxm.37
        for <git@vger.kernel.org>; Mon, 02 Mar 2009 01:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=+81sNaLn7MO6hUBixadBxCQTusARsfllKkWmvGi4qAI=;
        b=fvRWrXUxtDPIJQwK9AVSpJcY83F7Cj3LKILz38uu8YFBCW+OPQFKgNq4rwVBU6vetk
         HIFQ23RMdMKwynWYkA3g/OeFDY8NDS6+GqmIcs46XbpVxbemwJqtQv+m+0ZmtbC6wtYC
         /cUxgxDMbAwbMG/u73dE2DNQFav8A1ny3PVYM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=CMjQbIxc/EjpAF+86aM2ZafPjRL0+gcJLhe0fPUTzWWsl7W9CUCf3Be6Xc6lcl6gL+
         bprOalolTwRaOBAbvUUXoowvzx49fXB+TQuEUmvRSqYdZJtto+9a0f7gBLG0+FVeJ5Ly
         59GOyY0zX6aJ68v6Lco7CEvRmtPX1CSLXikGQ=
Received: by 10.86.95.8 with SMTP id s8mr382549fgb.79.1235986243228;
        Mon, 02 Mar 2009 01:30:43 -0800 (PST)
Received: from ?192.168.1.15? (abvv234.neoplus.adsl.tpnet.pl [83.8.219.234])
        by mx.google.com with ESMTPS id l12sm7223180fgb.31.2009.03.02.01.30.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 02 Mar 2009 01:30:42 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <9a0027270902280105hcad47c0r30bdd8379932442e@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111923>

On Sat, 28 Feb 2009, David Syzdek wrote:

> Are you more or less the maintainer of the configure.ac file?  Or is
> it more of a "hive" effort?  There are a few things that could be done
> to make the file a little more readable and maintainable.  For
> instance, breaking the macro functions into acinclude.m4 instead of
> keeping them in the configure.ac file.
> 
> I'd be willing to help or take the brunt of the work, but I would like
> to coordinate with someone whom is familiar with the interaction
> between the Makefile and configure.ac.
> 
> I have a decent amount of experience with using the autotools and am
> comfortable with autoconf.
> 
> Let me know if you think this is a good idea or not.

It is true that I have added [optional] support for autoconf to git,
and I think the idea of having optional ./configure support in the form
of generating configuration file for Makefile, overriding the guesswork
based on uname, and being overridden by user's customization is mine.

But I have next to no experience (except for the work on git) with 
autotools / autoconf. Additionally keeping up configure.ac and 
config.mak.in in sync with changes to Makefile (build system) needs
time which I don't have much of. So I very much would like for someone 
with better knowledge of autotools to take over maintaining configure 
for git.

The thing to remember is that ./configure has to be entirely optional...


P.S. On of things that autoconf needs to work better is to have fallback 
install-sh script in git sources... which I think also would help in 
the case where we do not use ./configure, but are on some legacy 
system.
-- 
Jakub Narebski
Poland
