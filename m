From: Luke Diamand <luke@diamand.org>
Subject: [PATCH] Correction to git-p4 "exclude" change
Date: Wed, 28 Jan 2015 06:08:03 +0000
Message-ID: <1422425284-5282-1-git-send-email-luke@diamand.org>
Cc: Junio C Hamano <gitster@pobox.com>, Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 28 07:08:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YGLnW-0008VI-7R
	for gcvg-git-2@plane.gmane.org; Wed, 28 Jan 2015 07:08:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761271AbbA1GIN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2015 01:08:13 -0500
Received: from mail-pd0-f179.google.com ([209.85.192.179]:43434 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752992AbbA1GIL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2015 01:08:11 -0500
Received: by mail-pd0-f179.google.com with SMTP id v10so23603541pde.10
        for <git@vger.kernel.org>; Tue, 27 Jan 2015 22:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ixb54IslEWUY/7Znj+uRmfUn9AIzu1fhMQO+GVZ61jM=;
        b=INGljhFECqhuj2+LUUx7ZL0+GL+MvIuJ/tqHp0xE2Jsej2MjyyNx0ExILEIpIYva3x
         cFDZ4HHi9dWFshibaVbI1lI3a+5zGRB+HP+l745QlPT1GEBmbSQIpUW+j9GIQ2fWnKFV
         nQDyh8i6KZ1kA37ZnuVgBiUMEMBfAvgUFirLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ixb54IslEWUY/7Znj+uRmfUn9AIzu1fhMQO+GVZ61jM=;
        b=IPrVqtsov/lOj8ANFJClo/PLVe5HAfXv6l3yR0x31Rt3hMaCn9fm+Z2P0iKy/MdWce
         cO9BdYdgMH3cBCNMDZ2eHfr7mB0zaFOrjD6bkCGvqTpHe2CQlKPlgFp7pen0klQW5mDo
         GEyGX4EUpOERXwxHqGlj/IoxzH/U4VOqgguByGUaZPfxYibFwLzQDsIeiATc3LNK2UF9
         AzkiX3csST7iZ9rCpnZOCGubGTMQsBUNwiSXopuoXtJy9p2yEpvbnKm28sMpD9AMYfUY
         bJXTIXDLjGnvymlyawYf5zQJ14YLFNEccrT8guH27a2ALJlpKA74J3xbNEmpW8CQkfBH
         iDLQ==
X-Gm-Message-State: ALoCoQnDvzEetAgLx+l5mVBktgqcVSejsu2X6VxcIXY/y9w/181DERXUd38Ch5pya0e6e/rLzKc6
X-Received: by 10.66.236.36 with SMTP id ur4mr2794881pac.107.1422425291339;
        Tue, 27 Jan 2015 22:08:11 -0800 (PST)
Received: from lgd-kipper.corp.roku ([216.38.147.4])
        by mx.google.com with ESMTPSA id fg6sm3441182pdb.24.2015.01.27.22.08.09
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Jan 2015 22:08:10 -0800 (PST)
X-Mailer: git-send-email 2.3.0.rc2.188.g4b64765.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263099>

My previous change for adding support for "exclude" to git-p4 "sync"
was incorrect, missing out a comma, which stopped git-p4 from working.
This change fixes that.

I've also noticed that t9814-git-p4-rename.sh has stopped working; I'm
going to follow up with a fix for that once I've worked out what's
wrong with it. There's a small shell syntax problem (missing "esac")
but after fixing that it still fails, so I'm not sure what's happening
yet. It was discussed a while back.

Luke Diamand (1):
  git-p4: correct "exclude" change

 git-p4.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.3.0.rc2.188.g4b64765.dirty
