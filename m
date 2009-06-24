From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Reason for objects still being written with a failing
	pre-receive hook?
Date: Wed, 24 Jun 2009 06:57:13 -0700
Message-ID: <20090624135713.GE11191@spearce.org>
References: <9e0f31700906240621k314b4bbehc283c8a1c673a2f1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johan S?rensen <johan@johansorensen.com>
X-From: git-owner@vger.kernel.org Wed Jun 24 15:57:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJSyX-0004VH-Te
	for gcvg-git-2@gmane.org; Wed, 24 Jun 2009 15:57:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751963AbZFXN5M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2009 09:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbZFXN5L
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jun 2009 09:57:11 -0400
Received: from george.spearce.org ([209.20.77.23]:54054 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751238AbZFXN5K (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2009 09:57:10 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 97626381FD; Wed, 24 Jun 2009 13:57:13 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <9e0f31700906240621k314b4bbehc283c8a1c673a2f1@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122139>

Johan S?rensen <johan@johansorensen.com> wrote:
> I'm wondering what the reason is that objects are still being stored,
> despite a non-zero exit code from the pre-receive hook?

The pre-receive hook is allowed to inspect the objects that have
been uploaded in order to make its access decision.  Thus those
objects must have been unpacked (or indexed into a new pack) so
git commands in the pre-receive hook can read them.
 
> If it's expected and accepted behaviour, what other options do I have
> to prevent a scenario like the above?

There currently isn't a way to stop this, other than to use something
in front of git-receive-pack, e.g. Gitosis, to deny even forking
the receive-pack binary for the user.

-- 
Shawn.
