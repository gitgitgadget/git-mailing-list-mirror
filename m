From: Nelson Elhage <nelhage@MIT.EDU>
Subject: Re: [PATCH] reflog documentation: -n is an alias for --dry-run
Date: Sun, 13 Sep 2009 08:53:13 -0400
Message-ID: <20090913125313.GQ4275@mit.edu>
References: <1252813314-14408-1-git-send-email-nelhage@mit.edu> <20090913094032.GC14438@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Sep 13 14:55:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmocB-00007t-J0
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 14:55:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753421AbZIMMxR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 08:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753374AbZIMMxQ
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 08:53:16 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:61593 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753001AbZIMMxP (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Sep 2009 08:53:15 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id n8DCrFTl007123;
	Sun, 13 Sep 2009 08:53:15 -0400 (EDT)
Received: from LUNATIQUE.MIT.EDU (LUNATIQUE.MIT.EDU [18.208.0.153])
	(authenticated bits=0)
        (User authenticated as nelhage@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id n8DCrEUl020264
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sun, 13 Sep 2009 08:53:14 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20090913094032.GC14438@coredump.intra.peff.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128357>

Oh, I see. I was reading builtin-reflog.c, which, in both
cmd_reflog_expire and cmd_reflog_delete, does check for -n as
synonymous to --dry-run:

if (!strcmp(arg, "--dry-run") || !strcmp(arg, "-n"))
    cb.dry_run = 1;

but I missed that 'reflog show' aliases for git-log, and that that
accepts -n.

Patch withdrawn -- I'd send one documenting that -n works for delete
and expire, but it'd probably just complicate the documentation more
than clarify anything.

- Nelson

On Sun, Sep 13, 2009 at 05:40:32AM -0400, Jeff King wrote:
> On Sat, Sep 12, 2009 at 11:41:54PM -0400, Nelson Elhage wrote:
> 
> >  static const char reflog_expire_usage[] =
> > -"git reflog (show|expire) [--verbose] [--dry-run] [--stale-fix] [--expire=<time>] [--expire-unreachable=<time>] [--all] <refs>...";
> > +"git reflog (show|expire) [--verbose] [-n | --dry-run] [--stale-fix] [--expire=<time>] [--expire-unreachable=<time>] [--all] <refs>...";
> 
> Really? I think "git reflog show -n" is not about dry-run at all...
> 
> -Peff
