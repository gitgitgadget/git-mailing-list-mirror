From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: GLib
Date: Sun, 15 May 2011 11:06:25 -0700 (PDT)
Message-ID: <m3aaen3klg.fsf@localhost.localdomain>
References: <1305477377.3612.5.camel@mamburu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Zganyaiko Dmitry <zdo.str@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 15 20:06:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLfiB-0005qv-H1
	for gcvg-git-2@lo.gmane.org; Sun, 15 May 2011 20:06:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279Ab1EOSG3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2011 14:06:29 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:57340 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751242Ab1EOSG2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2011 14:06:28 -0400
Received: by bwz15 with SMTP id 15so3207131bwz.19
        for <git@vger.kernel.org>; Sun, 15 May 2011 11:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=ux5QmMwtgJ9WN6CjwxU22fLb+6b2/B8+b5QSIMG8XaQ=;
        b=Uv2b9Ue4XsQks9w1GDwJH+V31qU+AXWB013bkft8U9AkNiBsWvJK+FgS+QgcdFxt89
         xlGdwSc09V2KzXl4ZbprZVEtmyH9ZTSlNG7zHjiPydobG/HNEUcddAZggddDhMFso3bT
         eRD7Zv51pYJUVWj0DmGEXk/I/lTxbSXOueowA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=lpHvdsQ7LYGsT/9xMFgzG4B7Xj2QaAHsEftg2i6DJZs/KnkJug2ZZIrRqRQtjTgUkA
         SK+uE/I2Wuz2b4Rj54a0CvB3ePi6G4RUivuA89Nun5lzxHcnXBXXcppJHIFIFaoRJVmE
         KsSeiOxdJR8ALKSLG5+lg47RzxPHTeKfrixBs=
Received: by 10.204.19.80 with SMTP id z16mr3345524bka.198.1305482786801;
        Sun, 15 May 2011 11:06:26 -0700 (PDT)
Received: from localhost.localdomain (aeho161.neoplus.adsl.tpnet.pl [79.186.196.161])
        by mx.google.com with ESMTPS id l1sm2543086bkl.13.2011.05.15.11.06.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 15 May 2011 11:06:25 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p4FI5xBi012818;
	Sun, 15 May 2011 20:06:09 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p4FI5m9M012812;
	Sun, 15 May 2011 20:05:48 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1305477377.3612.5.camel@mamburu>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173643>

Zganyaiko Dmitry <zdo.str@gmail.com> writes:

> My question is very simple:
> why git doesn't use glib as base C framework? For example, in git there
> are xmalloc, xrealloc functions that duplicates glib functionality, and
> these routines are only small piece of all duplicated code that already
> exists in glib.
> 
> So, why git was designed and is developing now without mature stable C
> library like glib?

Note that git is very performance conscious.  For example a while ago
some of git commands were split off from /usr/libexec/git-core/git so
that only those need to link against libcurl (if I remember it
correctly).

Besides it all started very simple, with a few wrappers: git
developers thought that requiring GLib is overkill for those few
wrappers.  strbuf, parseopt etc. it all came later.

At least it is what I think (what I guess).


BTW how portable GLib is?
-- 
Jakub Narebski
Poland
ShadeHawk on #git
