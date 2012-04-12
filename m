From: Gary Wilson <gary.wilson@of-networks.co.uk>
Subject: Unexpected empty directory removal
Date: Thu, 12 Apr 2012 18:08:20 +0100
Message-ID: <4F870C04.9060304@of-networks.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 12 19:08:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SINVX-0008UB-5t
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 19:08:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756381Ab2DLRI0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Apr 2012 13:08:26 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:47148 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756165Ab2DLRI0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2012 13:08:26 -0400
Received: by eaaq12 with SMTP id q12so562085eaa.19
        for <git@vger.kernel.org>; Thu, 12 Apr 2012 10:08:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding:x-gm-message-state;
        bh=ofbltJmtlbP9l2tE10/rJDO0kZfmOpy5LCHwxN+Jiz4=;
        b=Y8NLBUc7Tyh5GHWr5H7zI7J+slHO8Y9FXTm55A5Wy8ThV0DARy4z3ptzbyeuIgsyG7
         fKyAVSBw/GENaObPOjiqPKR5wf7XYqPLPklv+id/F1Sp8F+eHe//zQZ9ZujQSm4Tsrr3
         tj8XADT3/WTZO40PytZ6h+MnVMS4+MpO2WmdyQtYwxvFhkFZd69x2cGEl5ZLFFfmtt+O
         ulngErvT6ptZHfNzlfEdJKgYYwuim12Q+rjVTN1vVyf8TlnMP7ovrfLCzssH0+LKvOgi
         Lk4KyYW4dCsaFY/trsDmhnC4SeuDw2Ff+mSkouklLTs4G++cRiStbb87MSaEfWEFSgP4
         o10A==
Received: by 10.213.28.201 with SMTP id n9mr268139ebc.215.1334250504460;
        Thu, 12 Apr 2012 10:08:24 -0700 (PDT)
Received: from [192.168.1.31] (88.Red-88-7-10.staticIP.rima-tde.net. [88.7.10.88])
        by mx.google.com with ESMTPS id r44sm30444701eef.2.2012.04.12.10.08.21
        (version=SSLv3 cipher=OTHER);
        Thu, 12 Apr 2012 10:08:22 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.28) Gecko/20120313 Thunderbird/3.1.20
X-Gm-Message-State: ALoCoQlc7Gib87nAFP0AJAkPG9RB7tc8nELhup+eeXiPGIGTMaDeUVAx71LAVoKNbDQQh4vLkAFs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195347>

Hi

I do not normally report things such as this and they are usually
"features", however this one seems overly strange to me as directories
and files are different things and I would expected a source code
versioning system to adhere to that.

Use case to replicate:

1. Have path/files/a.file exists (and/or path/files/*) on client A and
client B
2. Remove the physical files from the path/files/ directory on client A,
so that the directory is empty
3. git commit
4. git pull on client B
5. On client A an empty path/files/ directory exists on client B it has
been removed, meaning path/files/ no longer exists.

Is this the expected behaviour?  As if it is, I will definitely bear
that in mind and note that git will not make empty directories AND will
remove empty directories from all clients apart from the client that
emptied the directory.

client A: git version 1.7.0.4
client B: git version 1.7.1
git server: whatever github.com is running

Regards
Gary
