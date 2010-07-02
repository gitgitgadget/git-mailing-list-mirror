From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: global hooks - once again
Date: Fri, 2 Jul 2010 13:03:55 -0500
Message-ID: <20100702180355.GA1770@burratino>
References: <AANLkTikXJS5QCXMXgsOfkYn9cMBQV6o23tds5YG3A_OI@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 02 20:04:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUkbO-0005I7-4c
	for gcvg-git-2@lo.gmane.org; Fri, 02 Jul 2010 20:04:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759427Ab0GBSEc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jul 2010 14:04:32 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:58361 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758884Ab0GBSEb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jul 2010 14:04:31 -0400
Received: by iwn7 with SMTP id 7so3500725iwn.19
        for <git@vger.kernel.org>; Fri, 02 Jul 2010 11:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=q0JxtSH+4egANfDZIByGeExD1UVQfnMebF71ZUlB3j0=;
        b=vH06XEYOoYJFJB0b+cwe4MiCW04V/dNYKcY88OoOF7K7KxwZdI9RJE782y/d7QQVsz
         OA9awOxF2n8PCpmLqpHIe1h4iNtM0/MfJ1bZ90dTCN4VAXxGhirmWGB/KV920qVy9lrJ
         NH+VJFncEAIQ4GDZQYwERpR5A7yO5cxn7yQgo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Kfv3zV4eDS4Ni1VzMwQaOPie3F3gWvDE0vsR62eQPASgjITAnmCk2DMgm5iPKEMuHq
         rwBE3eKfxcCdAl1y3z3S7bnbFG7Y5DUb2LO1c5zVVUnaRaDZgcvegO4kL7VPLhRav5Bg
         pK6PUKsL10POJlJKJvZSpzQ/a6GXyK39E2SgA=
Received: by 10.231.160.205 with SMTP id o13mr1215807ibx.111.1278093865382;
        Fri, 02 Jul 2010 11:04:25 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id g31sm4049137ibh.16.2010.07.02.11.04.24
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 02 Jul 2010 11:04:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTikXJS5QCXMXgsOfkYn9cMBQV6o23tds5YG3A_OI@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150144>

Eugene Sajine wrote:

> I have found a thread dated March 2008 about the subject, but there
> was no acceptable solution provided.

Link?

> If there is no better way now Is it possible to create a git config
> property specifying where the global hooks folder is and then look for
> hooks there first and then in the repo or vice versa?

Well, I like the idea[1].  The design issues are not very complicated;
the main thing is to implement it.

 $ git grep -l -F -e 'hooks/' -- \*.c \*.sh \*.perl | egrep -v '^(contrib/(examples|hooks))|t/'
 builtin/commit.c
 builtin/init-db.c
 builtin/receive-pack.c
 git-am.sh
 git-cvsserver.perl
 git-rebase--interactive.sh
 git-rebase.sh
 run-command.c

Hope that helps,
Jonathan

[1] e.g., for http://bugs.debian.org/514651
