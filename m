From: David Aguilar <davvid@gmail.com>
Subject: Re: Running vimdiff in read-only mode with git-difftool?
Date: Sun, 17 May 2009 22:42:25 -0700
Message-ID: <20090518054224.GA32259@gmail.com>
References: <9e00fd550905172201n6c95dc1bia48c9ac25d8ec98f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Nick Welch <nick@incise.org>
X-From: git-owner@vger.kernel.org Mon May 18 07:42:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5vcZ-0002b6-4P
	for gcvg-git-2@gmane.org; Mon, 18 May 2009 07:42:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752334AbZERFme (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2009 01:42:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751700AbZERFme
	(ORCPT <rfc822;git-outgoing>); Mon, 18 May 2009 01:42:34 -0400
Received: from mail-pz0-f115.google.com ([209.85.222.115]:62946 "EHLO
	mail-pz0-f115.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751379AbZERFmd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2009 01:42:33 -0400
Received: by pzk13 with SMTP id 13so1839842pzk.33
        for <git@vger.kernel.org>; Sun, 17 May 2009 22:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=tIAcVwYkK8ffSQE/XgqsGOHheiZF43uRnC/q+sxfab4=;
        b=iD378EB9psK3eHn9vhUL7tGg6DO3JbTG5Qd6amiJzRtLALucWQsTlpzIBZrslpRAHF
         32JIBi5blO9jMZ5C5XoIpJoLhfqHoupLYHUoNFQH7fSAt9xkp3buwRZHw/VMyvGhiMPZ
         j296XjfdoYjAoM/ujK1XyucZPGDqJeQcvQE/Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=rILHFDaSwmsyWjsHd76r37AXK9sHR5u3lF4KnKuaUfkfucnt0vLxQqAwL7Azd+EZmK
         buBAnRGQ9viX3ktkUZwuipdqihn5lueHro9t+s6nFXw/pn5k4NHh+elOMk9Nd/Nq2knE
         dbTZka/p0T7KlPGxCeeAopeak29eYlrhanPog=
Received: by 10.114.208.20 with SMTP id f20mr10318672wag.225.1242625355052;
        Sun, 17 May 2009 22:42:35 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id n6sm4478514wag.39.2009.05.17.22.42.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 17 May 2009 22:42:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <9e00fd550905172201n6c95dc1bia48c9ac25d8ec98f@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119415>

On Sun, May 17, 2009 at 10:01:02PM -0700, Nick Welch wrote:
> 
> According to the git-difftool manpage, what I'm trying to do
> should work:
> 
>   Instead of running one of the known diff tools,
>   git-difftool can be customized to run an alternative
>   program by specifying the command line to invoke in a
>   configuration variable difftool.<tool>.cmd.


Custom difftool.<tool>.cmd settings only work for custom
(i.e. alternative/non-built-in) tools.

If you rename that to something like "myvimdiff"
(or anything != "vimdiff") then it'll work as expected.

I wouldn't be opposed to a patch making
{diff,merge}tool.<tool>.cmd work for built-in tools as
well as long as it had a testcase and didn't end up
making the code unnecessarily complex.

-- 

	David
