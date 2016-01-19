From: Jean Delvare <jdelvare@suse.de>
Subject: git gc leaved my disk 100% full
Date: Tue, 19 Jan 2016 17:09:57 +0100
Organization: SUSE Linux
Message-ID: <20160119170957.6e69ebb8@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 19 17:10:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLYr9-0000oS-TT
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jan 2016 17:10:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755547AbcASQKE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2016 11:10:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:43361 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754317AbcASQKC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2016 11:10:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 928D8AC2E
	for <git@vger.kernel.org>; Tue, 19 Jan 2016 16:09:59 +0000 (UTC)
X-Mailer: Claws Mail 3.10.1 (GTK+ 2.24.23; x86_64-suse-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284359>

Hi git developers,

Earlier today my desktop environment warned me that my /home was almost
full. I thought that running "git gc" on my git trees would maybe save
some disk space.

Unfortunately the opposite happened. "git gc" failed on me with:

fatal: sha1 file '.git/objects/pack/tmp_idx_XW7opV' write error: No space left on device
error: failed to run repack

and at that point the partition was 100% full. My git repository went
from 2.2 GB to 3.3 GB in the process, this is why.

While I understand the value of preserving temporary files for
debugging purpose, I don't think it makes sense in the context of the
"gc" command which precisely should get rid of such temporary files.

So please consider fixing "gc" so that it cleans up any temporary file
in case of failure.

Thanks,
-- 
Jean Delvare
SUSE L3 Support
