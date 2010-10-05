From: Thomas Moschny <thomas.moschny@gmx.de>
Subject: RFE: execute post-receive hook on fetch
Date: Tue, 5 Oct 2010 13:03:12 +0200
Message-ID: <20101005130312.500cc4c4@andromeda.ipd.uni-karlsruhe.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 05 13:23:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P35c2-0002aJ-Ue
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 13:23:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932979Ab0JELXJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Oct 2010 07:23:09 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:59334 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932894Ab0JELXI (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Oct 2010 07:23:08 -0400
X-Greylist: delayed 1188 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Oct 2010 07:23:07 EDT
Received: from irams1.ira.uni-karlsruhe.de ([141.3.10.5])
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	id 1P35Ie-0005ZM-O0
	for <git@vger.kernel.org>; Tue, 05 Oct 2010 13:03:18 +0200
Received: from i41pc3.ipd.uni-karlsruhe.de ([141.3.49.143] helo=andromeda.ipd.uni-karlsruhe.de)
	by irams1.ira.uni-karlsruhe.de with esmtp port 25 
	for <git@vger.kernel.org>
	id 1P35Ie-0000Iw-IK; Tue, 05 Oct 2010 13:03:12 +0200
X-Mailer: Claws Mail 3.7.6 (GTK+ 2.20.1; x86_64-redhat-linux-gnu)
X-ATIS-AV: ClamAV (irams1.ira.uni-karlsruhe.de)
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-AV: Kaspersky (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1286276598.373567000
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1286277785.948581000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158186>

Hi,

It would be nice, if git could execute the "post-receive" hook (or a
hook wit a new name but similar functionality) when doing a fetch.

This would be really useful in setups where e.g. a buildbot has its own
(bare) mirror of a project's repository, polls on the main repo and
now needs to know what was fetched. Currently it has to record old refs
and compare them with the refs itself. It could also inspect
FETCH_HEADS to see what was fetched, but still, this file doesn't
record old values for each ref.

The post-receive hook is executed when pushing stuff to the buildbot's
mirror, but not when it fetches new stuff itself. This is kind of
asymmetrical, and I didn't expect that no hook is executed in that case.

- Thomas

-- 
Thomas Moschny  <thomas.moschny@gmx.de>
