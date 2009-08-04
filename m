From: Adam Brewster <adambrewster@gmail.com>
Subject: [PATCH/RFC] svn manipulate refs ourside refs/remotes
Date: Mon,  3 Aug 2009 21:40:36 -0400
Message-ID: <1249350039-7338-1-git-send-email-adambrewster@gmail.com>
Cc: normalperson@yhbt.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 04 03:42:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MY92j-0004Pg-Nu
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 03:42:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbZHDBlx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2009 21:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754405AbZHDBlw
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Aug 2009 21:41:52 -0400
Received: from qw-out-2122.google.com ([74.125.92.26]:51828 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754494AbZHDBlu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2009 21:41:50 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1924264qwh.37
        for <git@vger.kernel.org>; Mon, 03 Aug 2009 18:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=amf99ku6iK6mht5e7jvpLL3F5DDZMePIDp2Y1WLI34c=;
        b=T4ODR70KTOxfqfw2yu4L2ug85vIaLTclfSfXLtLlNNPCnsDgq2eeQQ1D0num/fZbUF
         yxk/K0VOWIKyKlQgBcUFxVT0e6QHExuSbitvNJ2VWgu65ySUKCeAF90UPCkeksz7AX0C
         iaRi3fHlidpnboz70OT+T/IxNiHmzW/5ZqTTU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Uv5ZxkEjzOZ6MrAhUQ7rlQzX6yaVpOBSm3rXobN5jPoqza2CSYUEv+WEM3CPaWHWhF
         7634Wb/OlZy8Mh0By2u8OxO3QPjCkleUDCfP9Ul1WX/XLZPYJg0SYqvAaYic4yWcuqce
         JuGUv2GpbTl8KPboQkiuVnTIA8rQ2Ti59v4bM=
Received: by 10.224.19.207 with SMTP id c15mr5448755qab.98.1249350110609;
        Mon, 03 Aug 2009 18:41:50 -0700 (PDT)
Received: from MBE.internal (c-24-61-131-49.hsd1.nh.comcast.net [24.61.131.49])
        by mx.google.com with ESMTPS id 7sm14130557qwf.8.2009.08.03.18.41.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 03 Aug 2009 18:41:49 -0700 (PDT)
Received: by MBE.internal (Postfix, from userid 1000)
	id A088521C0A6; Mon,  3 Aug 2009 21:40:39 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124743>

I took some time this weekend and tried to allow git-svn to manipulate
branches outside of refs/remotes.  Along the way I came across a couple
of other issues that may or may not be bugs.

I'd appreciate it if somebody could take a look at the following
patches.  The first two are small and well described by their respective
commit messages.  The third has the bulk of the changes I made.

Note that make t/t9107-git-svn-migrate.sh fails when the first or third
patches are applied.  I can't tell if this is a false alarm or if the
code is really doing something it shouldn't.

 - Adam Brewster
