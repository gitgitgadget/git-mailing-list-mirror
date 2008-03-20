From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: How to undo git-rm?
Date: Wed, 19 Mar 2008 17:49:46 -0700 (PDT)
Message-ID: <m31w66w76k.fsf@localhost.localdomain>
References: <20080318230441.GA664@arctrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Neil Schemenauer <nas@arctrix.com>
X-From: git-owner@vger.kernel.org Thu Mar 20 01:50:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc8zL-0003SV-Vl
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 01:50:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753147AbYCTAtx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 20:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753229AbYCTAtx
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 20:49:53 -0400
Received: from fk-out-0910.google.com ([209.85.128.185]:53192 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752903AbYCTAtv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 20:49:51 -0400
Received: by fk-out-0910.google.com with SMTP id 19so830936fkr.5
        for <git@vger.kernel.org>; Wed, 19 Mar 2008 17:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=jXuugiZTjKoNAKes5KWfQ3A7RvIH7iFUqfQz1OWPWF0=;
        b=LXw0xGlF3VmWTVg2/jy4xQyhpPe9kM7bEuMW4lbX6L5JZFnJ3MFv6Injt2bu9SenQWJiHbUTWL11OUjbs1NA4SNSzYSKgM7IaqO4qnSD4AiWsekkvYfKcIiexiCS8ndI5hoPfspxQ4/JQjyZu+uBU06KrLE6SKC2DSzgjTHidWs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=iI7o2ZX/pc8R5j4Zi4pJegneTLzuuH4W4GvhqJJbkCBHW4Hh1gfkxwtK48lY0kalz04C3hlH7D9/Dp151vUQLIlXTpdDtwVoBVNs31eAdpq2js1P4E/0Sgtn5PGp7/KQN7s2AlslCRrk0sgM8ikFZjbu5PCxOAgoJBJJrMauHKc=
Received: by 10.78.48.16 with SMTP id v16mr2853144huv.8.1205974187975;
        Wed, 19 Mar 2008 17:49:47 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.232.48])
        by mx.google.com with ESMTPS id c14sm1528577nfi.6.2008.03.19.17.49.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 19 Mar 2008 17:49:46 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m2K0ne1O001894;
	Thu, 20 Mar 2008 01:49:43 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m2K0ndLB001891;
	Thu, 20 Mar 2008 01:49:39 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080318230441.GA664@arctrix.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77604>

Neil Schemenauer <nas@arctrix.com> writes:

> Hi,
> 
> This seemingly simple operation has me stumped.  I removed something
> from my try using "git rm" and now I want it back.  With SVN I would
> use "svn cat <path> > <path>".  After some searching around, I
> though git-cat-file would do the trick.  Alas, it appears as though
> it looks up the SHA for the path in the index and so it too fails.

Direct equivalent would be

  $ git show HEAD:<path> > <path>   # from last commit
  $ git show :<path>     > <path>   # from index

but actually you would probably use

  $ git checkout -- <path>

-- 
Jakub Narebski
Poland
ShadeHawk on #git
