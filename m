From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: [PATCH v6 0/3] Merge renormalization, config renamed
Date: Fri,  2 Jul 2010 21:20:46 +0200
Message-ID: <cover.1278093311.git.eyvind.bernhardsen@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>,
	"git@vger.kernel.org List" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 02 21:21:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUlnW-00079y-1f
	for gcvg-git-2@lo.gmane.org; Fri, 02 Jul 2010 21:21:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759718Ab0GBTVF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jul 2010 15:21:05 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:38015 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757383Ab0GBTVD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jul 2010 15:21:03 -0400
Received: by wyf23 with SMTP id 23so1280991wyf.19
        for <git@vger.kernel.org>; Fri, 02 Jul 2010 12:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=ZffDcdIplFBlWCs/N7NTcpd0GZJSIWmSuAyFk4p9Xe0=;
        b=Yk0Sk8Z3Uqql9W2XXdsChpJYLv+F/nkTx4R07AAmU4/GqitSie+EWJg9AyH2ubRO/X
         czH5jWdpKpBzZKeyKIjdmb00E9IB3xndzyRNNXhW7oPrGVFSOorcwDtIE+mDygFQ0qYX
         AJLct/ZyakcLtxScsSUV770KvyYguISeH7aQY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=DJe74x0HmS9J8ODaToDt9VxOekcTIarxAKbapCrqy93EKPZQ1OgYf7Kot5Zf/naDMy
         CDQnLAmMsOsXBIrLHUDpoL4bY8KYUG21mKDDZhoDCvqHmBztCpShrmvKnpbPSgrEgIos
         8V7/Xh8f0MGddGnTIP3kKN8C9pamKSeDXRi1c=
Received: by 10.213.26.75 with SMTP id d11mr4326956ebc.27.1278098460517;
        Fri, 02 Jul 2010 12:21:00 -0700 (PDT)
Received: from localhost.localdomain (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id v8sm8093578eeh.14.2010.07.02.12.20.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 02 Jul 2010 12:20:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.575.g383de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150151>

Here's a new version of the merge normalization series that renames the
configuration variable.  Since "merge.renormalize" got the best
response, I went with that.

Junio, I hope you don't mind that I squashed your patch to introduce the
config variable into the first patch.  It seemed a bit out-of-place as a
separate commit.

- Eyvind

Eyvind Bernhardsen (3):
  Avoid conflicts when merging branches with mixed normalization
  Try normalizing files to avoid delete/modify conflicts when merging
  Don't expand CRLFs when normalizing text during merge

 Documentation/gitattributes.txt |   34 ++++++++++++++++++++
 Documentation/merge-config.txt  |   10 ++++++
 builtin/merge.c                 |    3 ++
 cache.h                         |    2 +
 convert.c                       |   37 +++++++++++++++++++----
 environment.c                   |    1 +
 ll-merge.c                      |   15 +++++++++
 merge-recursive.c               |   51 +++++++++++++++++++++++++++++-
 t/t6038-merge-text-auto.sh      |   64 +++++++++++++++++++++++++++++++++++++++
 9 files changed, 209 insertions(+), 8 deletions(-)
 create mode 100755 t/t6038-merge-text-auto.sh

-- 
1.7.1.575.g383de
