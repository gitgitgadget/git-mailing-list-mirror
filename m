From: Krzesimir Nowak <krzesimir@endocode.com>
Subject: [PATCH 0/5] Show extra branch refs in gitweb v6
Date: Wed,  4 Dec 2013 14:42:58 +0100
Message-ID: <1386164583-14109-1-git-send-email-krzesimir@endocode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: gitster@pobox.com, jnareb@gmail.com, sunshine@sunshineco.com,
	Krzesimir Nowak <krzesimir@endocode.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 04 14:43:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoCjn-000750-2g
	for gcvg-git-2@plane.gmane.org; Wed, 04 Dec 2013 14:43:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932430Ab3LDNnb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Dec 2013 08:43:31 -0500
Received: from mail-ea0-f181.google.com ([209.85.215.181]:39117 "EHLO
	mail-ea0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754895Ab3LDNna (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Dec 2013 08:43:30 -0500
Received: by mail-ea0-f181.google.com with SMTP id m10so10691282eaj.40
        for <git@vger.kernel.org>; Wed, 04 Dec 2013 05:43:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=xOcB39aGqADsUfMA3JtG+dyN5QKZX6SrgFvxszaw9xE=;
        b=hs/SouBBraBRHyTZHV49enia9ZD3c+WrM2+1JI9IYB026ImldsnpdXTkDf7qyOGxSX
         UPVPXHaZrxpnTZSUPxb53E8VBTCOCwdXdTn6FLBWShj3GhyKJJ3QHoOhJqxRtHGf6D5B
         s+h4H4HlUXZnTeokNdDxeq9dRpuEnywGvFnbo6uY6q6PyAdrCR7RWABahjxg0r4/CIXV
         KwvdYqisAf2jCRYd356sjTVNPnsEvk/0ndNYE911nVSOEUjCZcEfXi9b/EghFOEk7XhV
         jZPpajD3pNnTMu/025B+acGyZ09g4W4DSrRGsxjbYGO/VJ/Qb88UkTfKvaPEeQUwvf2b
         Ywwg==
X-Gm-Message-State: ALoCoQmEeniuOvijbpjKTdyRYsDbxoR6ULZqybyVHOEHe503myW2QDKcj0pj8a9kFRlkMRxrsyuQ
X-Received: by 10.14.173.7 with SMTP id u7mr27440838eel.24.1386164609129;
        Wed, 04 Dec 2013 05:43:29 -0800 (PST)
Received: from localhost.home (95-91-240-208-dynip.superkabel.de. [95.91.240.208])
        by mx.google.com with ESMTPSA id z42sm22327433eeo.17.2013.12.04.05.43.27
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Dec 2013 05:43:28 -0800 (PST)
X-Mailer: git-send-email 1.8.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238777>

First patch just adds a comment I though would be useful when trying
to understand how config parsing is done.

Second patch splits some code to a function.

Third patch fixes validation functions to return either 0 or 1,
instead of undef or passed $input.

Fourth patch adds the extra-branch-feature and some documentation.

Fifth patch adds some visual differentation of branches from
non-standard ref directories.

Krzesimir Nowak (5):
  gitweb: Add a comment explaining the meaning of $/
  gitweb: Move check-ref-format code into separate function
  gitweb: Return plain booleans in validation methods
  gitweb: Add a feature for adding more branch refs
  gitweb: Denote non-heads, non-remotes branches

 Documentation/gitweb.conf.txt |  27 +++++++
 gitweb/gitweb.perl            | 166 +++++++++++++++++++++++++++++++++---------
 2 files changed, 160 insertions(+), 33 deletions(-)

-- 
1.8.3.1
