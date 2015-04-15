From: karthik nayak <karthik.188@gmail.com>
Subject: [PATCH v8 0/4] cat-file: teach cat-file a '--literally' option
Date: Wed, 15 Apr 2015 22:25:50 +0530
Message-ID: <552E9816.6040502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 15 18:56:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YiQbt-0005PO-85
	for gcvg-git-2@plane.gmane.org; Wed, 15 Apr 2015 18:56:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756613AbbDOQ4J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2015 12:56:09 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:33014 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756579AbbDOQzz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2015 12:55:55 -0400
Received: by paboj16 with SMTP id oj16so57143705pab.0
        for <git@vger.kernel.org>; Wed, 15 Apr 2015 09:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        bh=aM3nGgnJj92I72u8BvYqJhfcVGbtitu79Y/DEshSqnw=;
        b=Uv3qEBpFxPDg3mJ9eiy8Imhop3Gwasc2ofyEbLfJ+ff46bwRbBqszaHJfz8ORh5uvY
         dBQ0lN7z7J9tYlDbLgVMvC9kL8WvAUM8oNF+iaroirEXfUSWxiOzkIruWM47uNjje9Qa
         v8RWl5QGvibQvpQmwSjU8PMr3TDlwXqVd1aAzsieRLJ0OSlTvpKkJSlIZJcQLLEHDeiU
         OhjxD3M6OTdWhrq0O9Z0srXE9yCWEqfZ18wG6SenUnUJzYFTxJsc8/HK3WBGR2y1RQAz
         HtpC6PcSHK/etOijIq9JkgmKAIwcEjUOJ95ye5pHM3zXnXRtSF4W4QMuJh9A4N1+7y5T
         8uKw==
X-Received: by 10.68.192.193 with SMTP id hi1mr5920834pbc.142.1429116955239;
        Wed, 15 Apr 2015 09:55:55 -0700 (PDT)
Received: from [192.168.0.103] ([103.227.98.178])
        by mx.google.com with ESMTPSA id nv13sm4671053pdb.15.2015.04.15.09.55.52
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Apr 2015 09:55:54 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267213>

Version 7 can be found here :
http://thread.gmane.org/gmane.comp.version-control.git/266761/match=patch+v7+0+4

Changes In this version :

sha1_file.c
* sha1_object_info_extended() can now accept object_info *oi with 
oi->typename without needing a oi->typep.
* Changes in parse_sha1_header_extended() to make the code more organized.

cat-file.c
* Rephrasing of the '--literally' option.
* cat_one_file() only uses oi.typename for case 't' and oi.sizep for 
case 's'.

t1006
* Changed the size of bogus type from 0 to strlen(bogus_content).

Documentation
* Rephrasing of the explanation for '--literally' option.

Suggestion's given by Eric Sunshine and Junio Hamano.
