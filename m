From: Bill Lear <rael@zopyra.com>
Subject: Re: Feature request: Store comments on branches
Date: Wed, 21 Oct 2009 10:05:11 -0500
Message-ID: <19167.8999.927157.455014@lisa.zopyra.com>
References: <20091021133702.GA470@lisa>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Patrick Schoenfeld <schoenfeld@debian.org>
X-From: git-owner@vger.kernel.org Wed Oct 21 17:06:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0ckm-00074s-Fm
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 17:05:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754070AbZJUPFV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2009 11:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754055AbZJUPFT
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 11:05:19 -0400
Received: from 75-27-130-60.lightspeed.austtx.sbcglobal.net ([75.27.130.60]:60241
	"EHLO zopyra.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753954AbZJUPFR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2009 11:05:17 -0400
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id n9LF5J032131;
	Wed, 21 Oct 2009 09:05:19 -0600
In-Reply-To: <20091021133702.GA470@lisa>
X-Mailer: VM 8.0.11 under Emacs 21.1.1 (i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130926>

On Wednesday, October 21, 2009 at 15:37:03 (+0200) Patrick Schoenfeld writes:
>Hi,
>
>I regulary work with various branches, that I call by the number
>of an associated bug tracking / support tracking number. That
>makes it clear to which ticket a given branch belongs.
>In this case I would find it very useful, if I could associate
>short comments with a branch, which would be shown when
>doing a 'git branch'. This way I could see what this branch
>about, without looking up the ticket information.
>
>Obvious the workaround is to name the branches different,
>but this is sometimes not convenient and may result in quiet
>long branch names.

For now, we do just this.  We use Jira for bug reporting.  When we
create a new Jira bug, we use the Jira Id as the base and then tack on
a short suffix:

% git checkout -b ADM-417_service_deploy_race_condition

We are also working on tools that would, among other things, obviate
this.  For example:

% git branch
* ADM-417
ADM-312
master

% jira describe
ADM-417: Service deployments have logging race condition on first start

% jira describe -l ADM-312
ADM-312: Portal permissions set incorrectly for WEP users
Description: The portal permissions get whacked whenever ...
Assigned To: John Smith <jsmith@ourhouse.com>
Status: In Progress
[...]

The 'jira' command just connects to our Jira server and performs
actions directly on the Jira server for current or whichever branch,
etc.


Bill
