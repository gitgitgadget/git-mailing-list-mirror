From: Casey Dahlin <cdahlin@redhat.com>
Subject: Re: [RFC PATCH] Introduce git-hive
Date: Sun, 5 Sep 2010 22:25:33 -0400
Message-ID: <20100906022532.GA15150@foucault.redhat.com>
References: <1283198367-11440-1-git-send-email-cdahlin@redhat.com>
 <AANLkTikcV6f=bUBa-F44JCEFOT0dHrvgrLY-j9hvvOyX@mail.gmail.com>
 <AANLkTinx_Y1iUt9tj4io=GskwRyvK2EdWv9cO9gAbxBS@mail.gmail.com>
 <20100831143839.GC16034@foucault.redhat.com>
 <20100905194810.5940F384096@mbox.dmi.unict.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 06 04:25:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsROz-0001TL-5T
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 04:25:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755072Ab0IFCZi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Sep 2010 22:25:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:23410 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755015Ab0IFCZi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Sep 2010 22:25:38 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o862Pa0i023727
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Sun, 5 Sep 2010 22:25:36 -0400
Received: from foucault.redhat.com (vpn-8-6.rdu.redhat.com [10.11.8.6])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id o862PXxr020838
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Sun, 5 Sep 2010 22:25:35 -0400
Content-Disposition: inline
In-Reply-To: <20100905194810.5940F384096@mbox.dmi.unict.it>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155513>

On Sun, Sep 05, 2010 at 09:48:06PM +0200, Giuseppe Bilotta wrote:
> Casey Dahlin wrote:
> > 
> > So now our two peers can see each other.
> > 
> > casey@host_a$ git hive show --branches
> > Nguyen Thai Ngoc Duy <pclouds@gmail.com>
> > master
> > for_casey
> > 
> > ---
> > 
> > nguyen@host_b$ git hive show --branches
> > Casey Dahlin <cdahlin@redhat.com>
> > master
> > stable
> > v2.1
> > 
> > And we can exchange them
> > 
> > casey@host_a$ git hive fetch nguyen for_casey
> > casey@host_a$ git branch
> > * master
> > stable
> > for_casey
> > 
> > Note that the two arguments in fetch are a regex which searches through
> > user IDs and a branch name, which is why I can abbreviate to just "nguyen"
> > in all lower case.
> 
> I may be a little late into the discussion, but I must say I very much like the
> idea. I realize that this is mostly intended for local repo sharing (typically
> between coworkers), but I suspect the idea could be extended to more general
> distributed repository, ehrm, distribution.
> 
> The only thing I would object to, so far, is hive fetch bringing stuff
> directly into my local repository. I typically prefer content to remain
> fenced in its appropriate namespace (e.g. I have issues even with the way tags
> and notes are imported from remotes). For hives, it might be a better idea to
> have the hive-fetched branches plop into either refs/remotes or maybe even a
> new dedicated namespace like refs/hive/ ?

Plan is to kill hive-fetch in favor of a fetch helper so the ordinary git
retrieval commands may be used.

--CJD
