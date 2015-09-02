From: larsxschneider@gmail.com
Subject: [PATCH v5] git-p4: add config git-p4.pathEncoding
Date: Wed,  2 Sep 2015 22:39:14 +0200
Message-ID: <1441226355-61103-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: luke@diamand.org, gitster@pobox.com, tboegi@web.de,
	sunshine@sunshineco.com, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 02 22:39:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXEoX-0004c2-AM
	for gcvg-git-2@plane.gmane.org; Wed, 02 Sep 2015 22:39:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756018AbbIBUjU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 16:39:20 -0400
Received: from mail-wi0-f171.google.com ([209.85.212.171]:33541 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755671AbbIBUjT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 16:39:19 -0400
Received: by wicmc4 with SMTP id mc4so78317663wic.0
        for <git@vger.kernel.org>; Wed, 02 Sep 2015 13:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=jbLOenvBn5zU05Pdh3BdOTtj5Ud6GH2r5h3tk2Kxq3o=;
        b=j819Ir1CyIolTRkmpW178Jgpks1lZAqF9ohGkLNxd5ACKy930KfKx0xxTTO9hUNYjp
         +Tm/sA3ZEkZ3vjVZDHB48HHM/dKb4qV6bDQsQ6aWe5/vLBXAJuiK8JySj2+vvkMYYvzd
         t5R5HQ/IuYBvLQgyGU8q0KG7nQzJ0qsQ9neJRGvMIkTmtp+H2G+tLSIUb5TNtgAX6GYK
         QxlynfOemJ0qNvLq9d9AtgAJ8Z2/PzH3cuJs2l346UoM9YkAmXkRQMdmxOBO5rAmz+5h
         pmts5/JMX4jw8v+0vLa3ftqUUqpAiC5GewLn3RN7Es5gDfxrE+6VjVprdk1G6UgUVIQk
         AGVg==
X-Received: by 10.180.80.138 with SMTP id r10mr7022111wix.18.1441226358511;
        Wed, 02 Sep 2015 13:39:18 -0700 (PDT)
Received: from slxBook3.fritz.box (dslb-188-106-110-072.188.106.pools.vodafone-ip.de. [188.106.110.72])
        by smtp.gmail.com with ESMTPSA id ny7sm5363001wic.11.2015.09.02.13.39.16
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Sep 2015 13:39:17 -0700 (PDT)
X-Mailer: git-send-email 1.9.5 (Apple Git-50.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277122>

From: Lars Schneider <larsxschneider@gmail.com>

Diff to v4:
* add verbose output
* reword help text
* remove comment how to generate encoded sequence
* use ascii characters in encoded sequence where possible
* wrap 'cd' in TC in a subshell

Thanks to Eric, Torsten, and Junio for feedback!

Cheers,
Lars

Lars Schneider (1):
  git-p4: add config git-p4.pathEncoding

 Documentation/git-p4.txt        |  7 +++++
 git-p4.py                       | 11 ++++++++
 t/t9822-git-p4-path-encoding.sh | 60 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 78 insertions(+)
 create mode 100755 t/t9822-git-p4-path-encoding.sh

--
1.9.5 (Apple Git-50.3)
