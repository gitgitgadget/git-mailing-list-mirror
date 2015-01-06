From: Mike Hommey <mh@glandium.org>
Subject: Question about the revision walking API
Date: Tue, 6 Jan 2015 11:02:30 +0900
Message-ID: <20150106020230.GA28274@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 06 03:03:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8JTl-0006EV-EY
	for gcvg-git-2@plane.gmane.org; Tue, 06 Jan 2015 03:02:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754433AbbAFCCh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jan 2015 21:02:37 -0500
Received: from ks3293202.kimsufi.com ([5.135.186.141]:47193 "EHLO glandium.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753388AbbAFCCg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jan 2015 21:02:36 -0500
Received: from glandium by zenigata with local (Exim 4.84)
	(envelope-from <glandium@glandium.org>)
	id 1Y8JTa-0007P7-TR
	for git@vger.kernel.org; Tue, 06 Jan 2015 11:02:30 +0900
Content-Disposition: inline
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262041>

Hi,

I would like to know if the revision walking API works as one would
expect with a calling sequence like the following:

- init_revisions
- add_pending_object/setup_revisions
- prepare_revision_walk
- get_revision (repeated)
- reset_revision_walk (I guess)
- add_pending_object
- prepare_revision_walk
- get_revision (repeated)

That is, do a first revision walk based on a given rev_info, then reuse that
rev_info with additional commit objects (in my case, I want to add more
UNINTERESTING commits) and redo a revision walk based on the modified
rev_info (so, avoid reinitializing a rev_info and filling it from
scratch again with the additional UNINTERESTING commits).

I guess I could try and see if that works, but I'd rather have an
informed answer than to derive my own from the fact my testcase would
happen to work by chance.

Cheers,

Mike
