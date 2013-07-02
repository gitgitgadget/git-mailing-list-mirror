From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: --follow is ignored when used with --reverse
Date: Tue, 2 Jul 2013 11:51:42 +0200
Message-ID: <87vc4t9tn5.fsf@linux-k42r.v.cablecom.net>
References: <20130524012324.295dec77@hugo.daonet.home>
	<20130702091936.GA9161@serenity.lan> <20130702093842.GA4353@blizzard>
Mime-Version: 1.0
Content-Type: text/plain
Cc: John Keeping <john@keeping.me.uk>,
	Alois Mahdal <Alois.Mahdal.1-ndmail@zxcvb.cz>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Lukas Fleischer <git@cryptocrack.de>
X-From: git-owner@vger.kernel.org Tue Jul 02 11:51:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtxFV-0000ag-Pz
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 11:51:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932493Ab3GBJvp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jul 2013 05:51:45 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:48196 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932377Ab3GBJvp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jul 2013 05:51:45 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 2 Jul
 2013 11:51:41 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS21.d.ethz.ch (172.31.51.111) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Tue, 2 Jul 2013 11:51:42 +0200
In-Reply-To: <20130702093842.GA4353@blizzard> (Lukas Fleischer's message of
	"Tue, 2 Jul 2013 11:38:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229387>

Lukas Fleischer <git@cryptocrack.de> writes:

> On Tue, Jul 02, 2013 at 10:19:36AM +0100, John Keeping wrote:
[...]
>>     $ git log --oneline --follow builtin/clone.c | wc -l
>>     125
>>     $ git log --oneline --follow --reverse builtin/clone.c | wc -l
>>     3
>
> I just wanted to point out that it works fine when specifying the *original*
> file name (which kind of makes sense given that everything is done in reverse
> order):
[...]
> However, that also doesn't seem to work for builtin/clone.c:
>
>     $ git log --oneline --follow --reverse -- builtin-clone.c | wc -l
>     65

I'm pretty sure that is simply because --follow iis a horrible hack,
known to be broken in many ways.  I have it on my longer-term todo list
to unify it with -L -M, which already does the Right Thing (more
generally, not in the --reverse interaction, which it never occurred to
me I should check).

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
