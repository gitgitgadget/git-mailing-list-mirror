From: Sebastien Gross <seb-git@chezwam.org>
Subject: sync() slowdown
Date: Mon, 26 May 2008 16:26:07 +0200
Message-ID: <20080526142607.GA3082@kali.thurne.chezwam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 26 16:27:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0dfE-0007is-3Y
	for gcvg-git-2@gmane.org; Mon, 26 May 2008 16:27:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755328AbYEZO0M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 May 2008 10:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755349AbYEZO0L
	(ORCPT <rfc822;git-outgoing>); Mon, 26 May 2008 10:26:11 -0400
Received: from thurne.chezwam.org ([82.245.152.156]:38554 "EHLO
	kali.thurne.chezwam.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755324AbYEZO0K (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2008 10:26:10 -0400
Received: from sjg by kali.thurne.chezwam.org with local (Exim 4.69)
	(envelope-from <seb@chezwam.org>)
	id 1K0deJ-0007pV-Lh
	for git@vger.kernel.org; Mon, 26 May 2008 16:26:07 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82937>

Hi git users,

I use git (a very basic usage) every day and I noticed a big slowdown
when I do a "git repack -a -d".

I noticed that it only happens when I do backup to an usb stick.

After a few investigation, I noticed that sync() is call when repacking
objects (from both builtin-prune.c and builtin-prune-packed.c).

I do understand that syncing filesystem is usefull and needed.

But is there a good idea to add a --no-sync option to prevent that
behaviour ?

I think this might be useful if you repack many repositories.
If you call the sync command before looping the repacks I guess this
could be equivalent (modulo changes done in repositories during that
time).

Any idea suggestions ?


Thanks lot

Cheers.

--=20
S=C3=A9bastien Gross
