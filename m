From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH 2/2] git-gc: skip stashes when expiring reflogs
Date: Wed, 11 Jun 2008 23:36:48 +0200
Organization: glandium.org
Message-ID: <20080611213648.GA13362@glandium.org>
References: <OLvkESB0JjBNs9kF8Q2M5UFNBJqq4FjbgGeQVyWstGwcXqCOq16_oomM0y-utOBbV7BnndyrICE@cipher.nrlssc.navy.mil> <5vuJsx6Kidj7e8EABk_d63dLAYuWF-S880RrJKu83cJo_ejU3VN-VA@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Jun 11 23:39:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6Y2V-0008UN-AV
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 23:39:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752972AbYFKViV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 17:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752859AbYFKViU
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 17:38:20 -0400
Received: from vuizook.err.no ([194.24.252.247]:55662 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751510AbYFKViT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 17:38:19 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1K6Y0i-0004Dc-QI; Wed, 11 Jun 2008 23:37:47 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1K6Xzs-0003Uq-SA; Wed, 11 Jun 2008 23:36:48 +0200
Content-Disposition: inline
In-Reply-To: <5vuJsx6Kidj7e8EABk_d63dLAYuWF-S880RrJKu83cJo_ejU3VN-VA@cipher.nrlssc.navy.mil>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84668>

On Wed, Jun 11, 2008 at 04:29:56PM -0500, Brandon Casey wrote:
> The stash makes use of git's reflog mechanism, but it is not a reflog
> in the traditional sense. Each entry is a state that the user explicitly
> requested git to remember. The stash is generally short-lived, but the
> user probably expects that a stash will continue to exist until it is
> explicitly deleted. So we should not expire stash entries.

I wonder if it wouldn't make sense to have git reflog expire not expire
stashes *at all*. I mean, you don't necessarily cleanup your repo with
git gc, and you may end up killing your stashes with git reflog yourself
if you don't use the "magic" --exclude...

Mike
