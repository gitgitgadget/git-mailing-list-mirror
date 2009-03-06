From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's in git.git (Mar 2009, #03; Fri, 06)
Date: Fri, 06 Mar 2009 01:44:17 -0800
Message-ID: <7vab7zt28e.fsf@gitster.siamese.dyndns.org>
References: <7vocwft5tx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 06 10:46:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfWcs-0002nK-RG
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 10:45:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754219AbZCFJo2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 04:44:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752702AbZCFJo0
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 04:44:26 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41725 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751468AbZCFJoZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 04:44:25 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E90509FEBA;
	Fri,  6 Mar 2009 04:44:21 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id CBAAF9FEB8; Fri,
  6 Mar 2009 04:44:19 -0500 (EST)
In-Reply-To: <7vocwft5tx.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 06 Mar 2009 00:26:34 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5EE19D8C-0A33-11DE-81D8-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112411>

Junio C Hamano <gitster@pobox.com> writes:

> Quite a many topics that have been scheduled for 'master' for some time
> have all graduated.  With this pace we may be able to have a very short
> cycle for a change before 1.6.3 final ;-).

People who have been following the 'next' branch during 1.6.2 rc period
may already know these, but here is how the tip of 'master' looks like as
of tonight (an excerpt from the draft release notes to 1.6.3).

Updates since v1.6.2 so far
---------------------------

(usability, bells and whistles)

* "--pretty=<style>" option to the log family of commands can now be
  spelled as "--format=<style>".  In addition, --format=%formatstring
  is a short-hand for --pretty=tformat:%formatstring.

* "--oneline" is a synonym for "--pretty=oneline --abbrev=commit".

* If you realize that you botched the patch when you are editing hunks
  with the 'edit' action in git-add -i/-p, you can abort the editor to
  tell git not to apply it.

* git-archive learned --output=<file> option.

* git-bisect shows not just the number of remaining commits whose goodness
  is unknown, but also shows the estimated number of remaining rounds.

* git-branch -r shows HEAD symref that points at a remote branch in
  interest of each tracked remote repository.

* git-config learned -e option to open an editor to edit the config file
  directly.

* git-format-patch can be told to use attachment with a new configuration,
  format.attach.

* git-imap-send learned to work around Thunderbird's inability to easily
  disable format=flowed with a new configuration, imap.preformattedHTML.

* git-rebase can be told to rebase the series even if your branch is a
  descendant of the commit you are rebasing onto with --force-rebase
  option.

* git-send-email learned --confirm option to review the Cc: list before
  sending the messages out.

(developers)

* Test scripts can be run under valgrind.


Fixes since v1.6.2 so far
-------------------------

All of the fixes in v1.6.2.X maintenance series are included in this
release, unless otherwise noted.

Here are fixes that this release has, but have not been backported to
v1.6.2.X series.

* .gitignore learned to handle backslash as a quoting mechanism for
  comment introduction character "#" (backport by merging dd482ee if
  needed).

* timestamp output in --date=relative mode used to display timestamps that
  are long time ago in the default mode; it now uses "N years M months
  ago", and "N years ago" (backport by picking 10edf37 if needed).

* git-add -i/-p now works with non-ASCII pathnames (backport by picking
  8851f48 if needed).

* "git hash-object -w" did not read from the configuration file from the
  correct .git directory (backport by merging 272459a if needed).

* git-send-email learned to correctly handle multiple Cc: addresses
  (backport by merging afe756c if needed).
