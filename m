From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Sun, 22 Oct 2006 21:57:15 +0200
Message-ID: <200610222157.16086.jnareb@gmail.com>
References: <45357CC3.4040507@utoronto.ca> <200610212141.51829.jnareb@gmail.com> <1161544685.22276.127.camel@zepto.home.zettazebra.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: "Matthew D. Fuller" <fullermd@over-yonder.net>,
	Andreas Ericsson <ae@op5.se>,
	Linus Torvalds <torvalds@osdl.org>,
	Carl Worth <cworth@cworth.org>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 22 21:57:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbjRU-0003SD-Lx
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 21:57:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbWJVT5F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Oct 2006 15:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbWJVT5E
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 15:57:04 -0400
Received: from qb-out-0506.google.com ([72.14.204.236]:9903 "EHLO
	qb-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751222AbWJVT5C (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Oct 2006 15:57:02 -0400
Received: by qb-out-0506.google.com with SMTP id p36so366233qba
        for <git@vger.kernel.org>; Sun, 22 Oct 2006 12:57:01 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=OOMf8jpDfW3Tm/en8W37nkAiTrrzfbBJqkB/oaCXmP7Qlmb3lkrKZ5WM1YuWT481JQCibknDuCTxzDQ4bJ1/Gm3RSZaTpfiDAbMumo1qXigaJbKVJGth2m/MfTu2VpTVeI470gCTOS57s7OsHwhdpjJASIpdbtfOZ/B7WMim0+4=
Received: by 10.66.221.19 with SMTP id t19mr6063097ugg;
        Sun, 22 Oct 2006 12:57:00 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110])
        by mx.google.com with ESMTP id b23sm1258705ugd.2006.10.22.12.57.00;
        Sun, 22 Oct 2006 12:57:00 -0700 (PDT)
To: David Clymer <david@zettazebra.com>
User-Agent: KMail/1.9.3
In-Reply-To: <1161544685.22276.127.camel@zepto.home.zettazebra.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29781>

David Clymer wrote:
> Bzr: Branches and all shared history may be stored locally in disparate
> locations, and all VCS functions are available locally.

Branches in bzr are both one-source (one head) DAG (of parents), and
the "mainline" i.e. track of commits commited in this branch-as-place.
Bazaar-NG tries to keep both information in DAG by using first parent
to mark commits on current branch-as-place.

Additionally bzr by default uses revnos, numbering commits on branch,
which needs maintaining mainline identity for revnos not to change
even for one branch-as-place.

This leads to the need to use "merge" if you want to maintain revnos
unchanged, and "pull" if you are not interested in that.


Git correctly realizes that mainline identity is local information,
and instead of trying to save local information in DAG which is shared,
it uses reflog.

[That's of course totally biased view.]
 
> Git: Same thing, except that all shared history must also be identically
> ordered.
That is the EFFECT of preferring fast-forward over preserving
"first parent is my branch" property. So the RESULT is that
shared history is identically ordered.

-- 
Jakub Narebski
Poland
