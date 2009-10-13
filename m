From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: backup git repo on every commit
Date: Tue, 13 Oct 2009 11:18:13 -0700
Message-ID: <20091013181813.GY9261@spearce.org>
References: <194a2c240910120641sccf0e55xef4226269df78864@mail.gmail.com> <20091012141544.GF9261@spearce.org> <194a2c240910120725u72cdb588p3c66bc730e6953d@mail.gmail.com> <20091012143043.GJ9261@spearce.org> <194a2c240910130943j40c12902o760e463e7a8ce8fa@mail.gmail.com> <20091013174913.GV9261@spearce.org> <194a2c240910131114q19b6c822t5806d20005341cb4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Israel Garcia <igalvarez@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 13 20:25:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mxm3F-0006Ju-2F
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 20:24:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760857AbZJMSSu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2009 14:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760819AbZJMSSu
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 14:18:50 -0400
Received: from george.spearce.org ([209.20.77.23]:60432 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754282AbZJMSSu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 14:18:50 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 01E94381FE; Tue, 13 Oct 2009 18:18:13 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <194a2c240910131114q19b6c822t5806d20005341cb4@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130179>

Israel Garcia <igalvarez@gmail.com> wrote:
> BTW, is there any git-dump or git-backup command to do some kind of
> backup I'm looking for?

No, you backup git by making a clone.  E.g. `git clone --bare`.
Since this leaves you with a directory, you need to then perhaps
use some sort of file combiner tool like tar or zip to produce a
single file for backup to tape.

You can incrementally update that backup clone using git push to
write into it, or you can just blow it away and recreate it each
time you make a backup.

One could also use `git bundle` to create backup file that had
everything packaged in one neat file, but this can be slightly
harder to work with since a bundle is not a git repository.
 
-- 
Shawn.
