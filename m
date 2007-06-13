From: Bill Lear <rael@zopyra.com>
Subject: pull into dirty working tree
Date: Wed, 13 Jun 2007 09:14:32 -0500
Message-ID: <18031.64456.948230.375333@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 13 16:14:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyTcd-0002al-Pj
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 16:14:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754347AbXFMOOy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 10:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755433AbXFMOOy
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 10:14:54 -0400
Received: from mail.zopyra.com ([65.68.225.25]:60805 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753633AbXFMOOx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 10:14:53 -0400
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l5DEEri06088;
	Wed, 13 Jun 2007 09:14:53 -0500
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50061>

We have some CVS users who complain that they cannot do a pull
into a dirty working tree, as they could under CVS.  Here is
their scenario: they make a few changes to their code and want
to test it out; someone else pushes changes to the central repo
that they then want to add to their working tree to test also;
they then want to pull in these changes and test everything, as
if they had done 'mv stuff stuff-; git pull; mv stuff- stuff'.

They would like an option (perhaps a config option) to do a "dirty
pull".

The git-merge documentation states:

  You may have local modifications in the working tree files. In other
  words, git-diff is allowed to report changes. However, the merge uses
  your working tree as the working area, and in order to prevent the
  merge operation from losing such changes, it makes sure that they do
  not interfere with the merge. Those complex tables in read-tree
  documentation define what it means for a path to "interfere with the
  merge". And if your local modifications interfere with the merge,
  again, it stops before touching anything.

But my colleagues are still wondering: why can't git just do it as
CVS does?

I know there are workarounds: I myself documented a set of commands
to "put things on a shelf", but they still are whining.

I need a convincing argument: not a technical one, but one that is
practical (e.g. where CVS would do harm that git is preventing).

So, any explanation that I can give them why we can't have a 'git pull
--dirty' that moves things out of the way, then does the merge, then
moves thing back, aside from that it is stupid?


Bill
