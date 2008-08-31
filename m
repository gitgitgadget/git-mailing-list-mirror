From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Committing with past date?
Date: Sun, 31 Aug 2008 04:12:18 -0700 (PDT)
Message-ID: <m34p51qvzv.fsf@localhost.localdomain>
References: <1220179469.5518.5.camel@magnus-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Magnus Hjorth <magnus.hjorth@home.se>
X-From: git-owner@vger.kernel.org Sun Aug 31 13:14:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZkt6-0001zY-SE
	for gcvg-git-2@gmane.org; Sun, 31 Aug 2008 13:14:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757429AbYHaLMW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Aug 2008 07:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757322AbYHaLMV
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Aug 2008 07:12:21 -0400
Received: from mu-out-0910.google.com ([209.85.134.186]:4084 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757193AbYHaLMV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2008 07:12:21 -0400
Received: by mu-out-0910.google.com with SMTP id g7so1504151muf.1
        for <git@vger.kernel.org>; Sun, 31 Aug 2008 04:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=UIEyqnP0DoyVGGbQyr+LntpoAyNOP+ybpntzHEcsUa4=;
        b=gcQ39Ekg5ydyKP70wX0+qM7X0tQZpOoH1seuGMoT/4rBYi9iN/zikAIIdLEjJjFQTT
         RnSSzxuoxWgoluACIAKwrUPdcBComo70AN4d0wASZZvoi13ghZfw7Z9bUc36ToSziAak
         oMPvPmBzAyOZzQziKlGxbSxWnnqA8FYZanIdk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=BnxteKbIAAa1uR4cqLhZZyVfLj5ooWj9jkJS9U02u0/8it9re6sc/JyiF/SHWeA3Mc
         aGAK9babpMl8znfLYnKTEngtJE4UuCQ8Or+mSwuJBz6HwxhR41Cq7P4ep5zPBxp2aOQq
         OgCzKvS1fcRDFm6Xg4pPbVAqt/BRLzwet0Eao=
Received: by 10.103.207.11 with SMTP id j11mr3422688muq.47.1220181139277;
        Sun, 31 Aug 2008 04:12:19 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.200.211])
        by mx.google.com with ESMTPS id u26sm7082185mug.5.2008.08.31.04.12.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 31 Aug 2008 04:12:18 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m7VBC75S012007;
	Sun, 31 Aug 2008 13:12:08 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m7VBC4gL012004;
	Sun, 31 Aug 2008 13:12:04 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1220179469.5518.5.camel@magnus-desktop>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94474>

Magnus Hjorth <magnus.hjorth@home.se> writes:

> Can someone tell me how to make a git commit with a date other than the
> current. I hope there is some easier way than changing the system
> clock.. :)

See git(1), section "Environment Variables":
   git Commits
       GIT_AUTHOR_NAME, GIT_AUTHOR_EMAIL, GIT_AUTHOR_DATE,
       GIT_COMMITTER_NAME, GIT_COMMITTER_EMAIL, GIT_COMMITTER_DATE,
       EMAIL
              see git-commit-tree(1)

or you can use GIT_COMMITTER_IDENT, GIT_AUTHOR_IDENT.  See output
of "git var -l" to get form of it.
 
> I'm trying to port over old version history that I maintained manually
> (tarballs and changelogs) into a git repository. 

For that, I think it would be best to take a look at example
fast-import script: contrib/fast-import/import-tars.perl;
there is equivalent contrib/fast-import/import-zips.py if you
perfer either Pyhon over Perl, and/or zips over tarballs.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
