From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH] gitweb: Syntax highlighting support
Date: Thu, 18 Feb 2010 14:01:12 -0800 (PST)
Message-ID: <m3sk8ymcga.fsf@localhost.localdomain>
References: <20100217212855.2014.49834.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 18 23:09:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiEYi-0005va-3S
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 23:09:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758706Ab0BRWIe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2010 17:08:34 -0500
Received: from mail-bw0-f209.google.com ([209.85.218.209]:49515 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758799Ab0BRWII (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2010 17:08:08 -0500
X-Greylist: delayed 410 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Feb 2010 17:08:08 EST
Received: by bwz1 with SMTP id 1so665525bwz.21
        for <git@vger.kernel.org>; Thu, 18 Feb 2010 14:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=S7z6LvW8dz8mJEYRShr3kSe76q20PnxsunQYdgNDCZQ=;
        b=RX6MWnadaech/uHKripGg7Xyn2eeHlhwsYdPvp38ZiWCqhPH1CQb40vDNgiBmRfTeE
         igyZT7f3Q80B9VsdjbgxjjSoTZLvB/MSsFPYlqgRmIkYCHxkI6rcEkKJPckDM8l7XKiD
         WTVls2creOzqWUq6cYy1KjvNf4CLINhuUMAhk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=xHj+kJbIG79pRxYfmSq/WVt6pe23CfEmQNbiuKSJYWXBB7QXscBCILaDQbSz4HgyEh
         uAs4RLYpvdRyTfBRCySW4Xqtc9CwDnQ6L0kAAc3ngm8D1/I5lt6RdicA/5/1jhwGvtyM
         +23gWXudFqYuHkuOBwSW3ahjEbyv1Mz2I+2KE=
Received: by 10.204.10.140 with SMTP id p12mr5766718bkp.54.1266530474990;
        Thu, 18 Feb 2010 14:01:14 -0800 (PST)
Received: from localhost.localdomain (abwu39.neoplus.adsl.tpnet.pl [83.8.244.39])
        by mx.google.com with ESMTPS id 13sm272332bwz.3.2010.02.18.14.01.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 18 Feb 2010 14:01:12 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o1IM0do6021209;
	Thu, 18 Feb 2010 23:00:49 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o1IM0LKa021194;
	Thu, 18 Feb 2010 23:00:21 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20100217212855.2014.49834.stgit@localhost.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140386>

Jakub Narebski <jnareb@gmail.com> writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> It requires the 'highlight' program to do all the heavy-lifting:
> http://www.andre-simon.de / http://wiki.andre-simon.de

[...]
> ---
> This is a RFC, because there exist other syntax highlighters that can
> function as filter (take input from STDIN, and write result to STDOUT),
> and have (X)HTML among supported output formats.  Beside 'highlight'
> by Andre Simon, there is also 'source-highlight' (GNU Source Highlight),
> and probably other programs.  

Actually GNU Source Highlight (http://www.gnu.org/software/src-highlite)
as it is now wouldn't be a good fit for gitweb, because it lacks 
equivalent of Highlight '--fragment' option; even with '--no-doc' it
prefixes contents with some comments and wraps the whole with <pre><tt>
tags.

On the other hand side one can also use Perl modules from CPAN for
syntax highlighting.  It would be nice to have this option for syntax
highlighting in gitweb.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
