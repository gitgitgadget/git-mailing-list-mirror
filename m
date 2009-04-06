From: David Aguilar <davvid@gmail.com>
Subject: git-{merge,diff}tool refactor round three
Date: Mon,  6 Apr 2009 01:31:15 -0700
Message-ID: <1239006689-14695-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, charles@hashpling.org,
	markus.heidelberg@web.de
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Apr 06 10:35:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqkIC-0002l9-FA
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 10:34:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753623AbZDFIbs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 04:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752940AbZDFIbr
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 04:31:47 -0400
Received: from wa-out-1112.google.com ([209.85.146.180]:12597 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752787AbZDFIbq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 04:31:46 -0400
Received: by wa-out-1112.google.com with SMTP id j5so1642070wah.21
        for <git@vger.kernel.org>; Mon, 06 Apr 2009 01:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=YAkzNbdORlt+wdTNO4ZC6c31/Lp27L1+ZsqKweEioB8=;
        b=vGMlvckrWQlgcv9z7ogWoSkH3SMWh+58C0oMZWWQpdioDb0T0Eto1300iIASaEWrgz
         aA1huxXo1WpNqk5BYR/gdzLbh/p21GPrDieTJl8h3KKCGE/oAVijHqKbo9YDIFVl+3ZA
         gG5PDlc0+ZHfxXjiA4T4MNYlq2gJiY86EzJTk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=M7BkJJdQuucc2LlRb1PUYmW9YPdN+t5M7lheClvxHV1weTR7oFCIG67IrE+XvqlSCw
         YDP3QJHSUQ0aZNSWZTCN5hecHT+c+LP0taZpcqok6rkVEdDia18OakgySpSsoTrH0cub
         pegDYoeTEVjKMD7QpYkAnN3xKCvSn3GZbcN/c=
Received: by 10.115.89.18 with SMTP id r18mr2152030wal.111.1239006705026;
        Mon, 06 Apr 2009 01:31:45 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id c26sm5220875waa.15.2009.04.06.01.31.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 06 Apr 2009 01:31:44 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.414.g81aa9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115785>

Hopefully this is the final round =)

This series is based on top of master.

The result of this series gets us to where da/difftool in pu
arrived, but does so in a maintainer-friendly way.

I'm including Markus' patches in this series just so that it's
clear that this series is dependent on it.

Everything before "move 'git-difftool' out of contrib" can be
applied to master directly since it is not involved in the
refactor.

We'll need to revert:
	d3b8cec difftool: move 'git-difftool' out of contrib
to avoid a merge conflict in next.


In case anyone's curious, da/difftool originally
contained 25 commits.  Less is more.
