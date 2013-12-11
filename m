From: Krzesimir Nowak <krzesimir@endocode.com>
Subject: [PATCH v7 0/4] Show extra branch refs in gitweb
Date: Wed, 11 Dec 2013 12:54:40 +0100
Message-ID: <1386762884-7564-1-git-send-email-krzesimir@endocode.com>
Cc: gitster@pobox.com, jnareb@gmail.com, sunshine@sunshineco.com,
	Krzesimir Nowak <krzesimir@endocode.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 11 12:55:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqiNz-00037Y-6f
	for gcvg-git-2@plane.gmane.org; Wed, 11 Dec 2013 12:55:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751892Ab3LKLzX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Dec 2013 06:55:23 -0500
Received: from mail-ea0-f169.google.com ([209.85.215.169]:35401 "EHLO
	mail-ea0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751773Ab3LKLzV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Dec 2013 06:55:21 -0500
Received: by mail-ea0-f169.google.com with SMTP id l9so2746346eaj.28
        for <git@vger.kernel.org>; Wed, 11 Dec 2013 03:55:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GXaEIKVwTKukFjLSHdcRC79Ba5Jbvm6J9Kpr722uNh8=;
        b=YB6ZgdzVTYtrN20BNl7wCTriCe365LElTrKeBmX1j8bbqhHd0uD42Rrh6MihRas+Cq
         wbIuZ+VYwT85isdhHe3jmrPjUSae7EhGxIFmhJ4ZD9Wo2gotm4D7C1g2t27KdOqFJJe7
         QJqkEmzRqGmvmHXlBKpvWHLnsv8NrCCkyf7pD0H436/U2qBoGDjv9JYyHLHT/bhjuNvi
         jyuQWhzmwFAC9FHjsVd/Njm+Z5JFD/6LITtR3bhlVNU3t0vl1Du2ezA6bHBus7A0/Pb6
         rt8xBC3x3MbfvNDl8lb2elHrnJLbyceFhP8rhH4l4hafDJY9O1dziVGqyYCjiQYsaTLM
         ViuA==
X-Gm-Message-State: ALoCoQkLJOnITt1ER2Xddan1dmhq3aEORwI6mHhowRDbwXPixuhAdkpCWA162pa8VLvxDLg3Lusb
X-Received: by 10.14.211.130 with SMTP id w2mr1228449eeo.111.1386762919000;
        Wed, 11 Dec 2013 03:55:19 -0800 (PST)
Received: from localhost.home (95-91-241-58-dynip.superkabel.de. [95.91.241.58])
        by mx.google.com with ESMTPSA id z42sm52742677eeo.17.2013.12.11.03.55.17
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Dec 2013 03:55:18 -0800 (PST)
X-Mailer: git-send-email 1.8.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239187>

First patch splits some code to a function.

Second patch fixes validation functions to return either 0 or 1,
instead of undef or passed $input.

Third patch adds the extra-branch-feature and some documentation.

Fourth patch adds some visual differentation of branches from
non-standard ref directories.

Krzesimir Nowak (4):
  gitweb: Move check-ref-format code into separate function
  gitweb: Return 1 on validation success instead of passed input
  gitweb: Add a feature for adding more branch refs
  gitweb: Denote non-heads, non-remotes branches

 Documentation/gitweb.conf.txt |  37 +++++++++
 gitweb/gitweb.perl            | 184 +++++++++++++++++++++++++++++++-----------
 2 files changed, 175 insertions(+), 46 deletions(-)

-- 
1.8.3.1
