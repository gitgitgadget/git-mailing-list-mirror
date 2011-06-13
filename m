From: Yann Dirson <dirson@bertin.fr>
Subject: Commit notes workflow
Date: Mon, 13 Jun 2011 09:09:40 +0200
Organization: Bertin Technologies
Message-ID: <20110613090940.664b1b97@chalon.bertin.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 13 09:33:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QW1eB-00011u-Nm
	for gcvg-git-2@lo.gmane.org; Mon, 13 Jun 2011 09:33:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753286Ab1FMHdO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2011 03:33:14 -0400
Received: from blois.bertin.fr ([195.68.26.9]:44780 "EHLO blois.bertin.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753132Ab1FMHdO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2011 03:33:14 -0400
Received: from blois.bertin.fr (localhost [127.0.0.1])
	by postfix.imss70 (Postfix) with ESMTP id 92A9754180
	for <git@vger.kernel.org>; Mon, 13 Jun 2011 09:33:11 +0200 (CEST)
Received: from yport1.innovation.bertin.fr (yport1.bertin.fr [192.168.1.13])
	by blois.bertin.fr (Postfix) with ESMTP id 6D58054172
	for <git@vger.kernel.org>; Mon, 13 Jun 2011 09:33:11 +0200 (CEST)
Received: from chalon.bertin.fr ([172.16.1.1]) by yport1.innovation.bertin.fr
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPPA id <0LMP00BXJWZADQ30@yport1.innovation.bertin.fr> for
 git@vger.kernel.org; Mon, 13 Jun 2011 09:33:11 +0200 (CEST)
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.24.4; i486-pc-linux-gnu)
X-TM-AS-Product-Ver: IMSS-7.0.0.8220-6.5.0.1024-18196.005
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175688>

We have notes merge support since a couple of releases now, but no real example
in the docs of how best to use that.  That is, no suggested mapping of remote notes,
let alone automatic setup of refspecs at clone time.

Trying to setup such refspecs, I find myself puzzled:

* if I store remote notes under refs/notes (eg. refs/notes/*:refs/notes/origin/* as fetch
  refspec), then a refs/notes/*:refs/notes/origin/* push refspec will include
  refs/notes/origin/*, which we obviously don't want

* if I store them outside of refs/notes (eg. refs/notes/*:refs/remote-notes/origin/* ),
  then "git notes" silently ignores them: no output nor any error message from "notes list"
  or "notes merge".

Do we really want to "git notes" to ignore everything not in refs/notes/ ?  I can think of
2 possibilities out of this situation:

* remove that limitation
* decide on a naming convention for remote notes, and teach "git notes" not to ignore it

A (minor) problem with the second possibility is that this naming convention could evolve,
eg. if we end up with something like was proposed in [1] for 1.8.0.  Is there any real drawback
with the first suggestion ?

[1] http://marc.info/?l=git&m=129661334011986&w=4
-- 
Yann Dirson - Bertin Technologies
