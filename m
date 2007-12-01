From: Mike Hommey <mh@glandium.org>
Subject: git pack-objects input list
Date: Sat, 1 Dec 2007 11:45:02 +0100
Organization: glandium.org
Message-ID: <20071201104502.GA1457@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 01 11:45:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyPqi-0008AE-5v
	for gcvg-git-2@gmane.org; Sat, 01 Dec 2007 11:45:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751889AbXLAKpH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Dec 2007 05:45:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751875AbXLAKpH
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Dec 2007 05:45:07 -0500
Received: from smtp25.orange.fr ([193.252.22.23]:16446 "EHLO smtp25.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751889AbXLAKpF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Dec 2007 05:45:05 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2513.orange.fr (SMTP Server) with ESMTP id 25AA81C0008C
	for <git@vger.kernel.org>; Sat,  1 Dec 2007 11:45:03 +0100 (CET)
Received: from namakemono.glandium.org (APuteaux-153-1-85-180.w86-205.abo.wanadoo.fr [86.205.43.180])
	by mwinf2513.orange.fr (SMTP Server) with ESMTP id 064911C00089
	for <git@vger.kernel.org>; Sat,  1 Dec 2007 11:45:03 +0100 (CET)
X-ME-UUID: 20071201104503258.064911C00089@mwinf2513.orange.fr
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1IyPqI-0000TV-9g
	for git@vger.kernel.org; Sat, 01 Dec 2007 11:45:02 +0100
Content-Disposition: inline
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66710>

Hi,

While playing around with git-pack-objects, it seemed to me that the
input it can take is not a simple list of object SHA1s. Unfortunately,
the man page is not very verbose about that. While I'd happily send a
patch for that, I'd prefer to actually know what kind of input it can
take, and what it uses it for.

AFAICT, it can take the output of git-rev-list --all --objects (so,
SHA1s followed by file names for blobs), which seems to be the same as
what git-pack-objects --revs does internally, but it seems to have a
string impact on how deltas are calculated (not giving file names makes
it create a smaller pack in some cases, a bigger one in other cases).

Could someone knowing the delta calculation internals enlighten me ?

Thanks

Mike
