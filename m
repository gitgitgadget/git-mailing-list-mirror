From: Ed Santiago <santiago@redhat.com>
Subject: Re: [PATCH] git-cvsimport: strip question-mark characters in tags
Date: Wed, 14 Apr 2010 15:42:29 -0600
Message-ID: <20100414214229.GA31757@f.santiago.vpn.redhat.com>
References: <20100414133831.GA12135@f.santiago.vpn.redhat.com>
 <m27ho9sr0i.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Wed Apr 14 23:42:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2AME-0003oj-BK
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 23:42:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757044Ab0DNVmo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Apr 2010 17:42:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33897 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757026Ab0DNVmn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Apr 2010 17:42:43 -0400
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o3ELgVPi006934
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Wed, 14 Apr 2010 17:42:31 -0400
Received: from f.santiago.vpn.redhat.com (ovpn01.gateway.prod.ext.phx2.redhat.com [10.5.9.1])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id o3ELgUtU027490;
	Wed, 14 Apr 2010 17:42:31 -0400
Received: by f.santiago.vpn.redhat.com (Postfix, from userid 14904)
	id D3A8D2801EA; Wed, 14 Apr 2010 15:42:29 -0600 (MDT)
Content-Disposition: inline
In-Reply-To: <m27ho9sr0i.fsf@igel.home>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144923>

On Wed, Apr 14, 2010 at 10:44:45PM +0200, Andreas Schwab wrote:
> Ed Santiago <santiago@redhat.com> writes:
> 
> > Question mark character appears to be valid in a CVS tag,
> 
> According to the CVS docs only letters, digits, '-' and '_' are valid
> for tag names.

Poor choice of words on my part.  What I *should* have said is
something like:

   Although question marks and curly braces are not among the
   set of characters which CVS considers to be valid for a tag,
   real-world situations have been encontered in which a CVS
   comma-v file has a tag including all those characters.  This
   patch makes git-cvsimport accept and forgive that reality.

How that tag got created, I really don't know.  I can imagine
three ways it could've happened (rcs commands; broken/old version
of CVS; custom tool for mucking with comma-v files).  My goal
was to recognize that this sort of thing happens, and to make
it easier for the next person to find & fix this in the script.
With that goal in mind, removing $! and adding the comment is
the only important part of my patch.  The question mark itself
is not likely to be useful except in very rare and weird cases.

Ed
-- 
Ed Santiago             Software Engineer             santiago@redhat.com
