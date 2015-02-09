From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Is there some way to suppress Cc email only to stable?
Date: Mon, 9 Feb 2015 11:42:24 -0800
Message-ID: <20150209194224.GA27482@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: mingo@kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 09 20:42:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKuE9-0006S1-IV
	for gcvg-git-2@plane.gmane.org; Mon, 09 Feb 2015 20:42:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933639AbbBITm3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2015 14:42:29 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:36372 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932406AbbBITm2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2015 14:42:28 -0500
Received: from /spool/local
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <git@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Mon, 9 Feb 2015 12:42:28 -0700
Received: from d03dlp03.boulder.ibm.com (9.17.202.179)
	by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	Mon, 9 Feb 2015 12:42:26 -0700
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
	by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id D39E219D803F
	for <git@vger.kernel.org>; Mon,  9 Feb 2015 12:33:35 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t19Jf0NH27853030
	for <git@vger.kernel.org>; Mon, 9 Feb 2015 12:41:00 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t19JgPuH022367
	for <git@vger.kernel.org>; Mon, 9 Feb 2015 12:42:25 -0700
Received: from paulmck-ThinkPad-W500 (sig-9-65-236-19.ibm.com [9.65.236.19])
	by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id t19JgOlh022345;
	Mon, 9 Feb 2015 12:42:25 -0700
Received: by paulmck-ThinkPad-W500 (Postfix, from userid 1000)
	id 7054238BAA2; Mon,  9 Feb 2015 11:42:24 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 15020919-0005-0000-0000-000008AAAA12
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263589>

Hello!

I need to be able to put the following Cc in a git commit:

Cc: <stable@vger.kernel.org>

Yet I cannot allow git-send-email to actually send email to that address,
lest I get an automated nastygram in response.  I found the --to-cmd=
option to git-send-email, but it looks to only add email addresses, never
delete them.  I also found the --suppress-cc= option to git-send-email,
but it appears to suppress all Cc emails, not just selected ones.

One approach that occurred to me is to hand-edit the files produced
by git-format-patch, removing stable@vger.kernel.org entirely prior to
using git-send-email.  However, this is a bit error-prone.  Yes, I could
script it, but with my luck, I will eventually end up having my script
mangle some patch, for example to the Linux kernel's MAINTAINERS file.
Furthermore, this approach means that people reviewing the patches
cannot see the Cc stable entries (though I could presumably comment them
out somehow).

Another approach is to add the stable Ccs just before doing the pull
request, by my upstream maintainer is not fond of that approach.  Nor am
I, as it would be all to easy to forget to add the stable Ccs.  Or to
get them wrong.

I can't be the only person wanting to do something like this.  So is
there some git option that I am missing here?

							Thanx, Paul
