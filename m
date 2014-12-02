From: Yi EungJun <semtlenori@gmail.com>
Subject: [PATCH v5 0/1] http: Add Accept-Language header if possible
Date: Tue,  2 Dec 2014 21:12:35 +0900
Message-ID: <1417522356-24212-1-git-send-email-eungjun.yi@navercorp.com>
References: <1405792730-13539-1-git-send-email-eungjun.yi@navercorp.com>
Cc: Yi EungJun <eungjun.yi@navercorp.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	Peter Krefting <peter@softwolves.pp.se>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 02 13:12:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvmK7-00044l-7s
	for gcvg-git-2@plane.gmane.org; Tue, 02 Dec 2014 13:12:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932943AbaLBMMv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2014 07:12:51 -0500
Received: from mail-pa0-f52.google.com ([209.85.220.52]:51836 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932837AbaLBMMu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2014 07:12:50 -0500
Received: by mail-pa0-f52.google.com with SMTP id eu11so13327685pac.11
        for <git@vger.kernel.org>; Tue, 02 Dec 2014 04:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1IfvDYGsMqnM6uQgowRK+mLugs3wgNe152ZEsP01tNM=;
        b=WMxV1N7Oa0Moh5yMvru5AsnAG0LMBDl7P0WcwNzlwQy1SuToC99E696A6vvi+3PMJ7
         wkjVzdywHh9sSt3JURAPdyu589zSBWPZiSPNxyBLwfRVfF+rWJ5D8cwDH8q4kAWFVEQh
         puCYbm+NZYRpZq5JWFyBLzpyW3NfeXf3MoKlpFnWIXqfmSviiurXkyUhmRlSE/aJ+UH/
         2nv2mWO2oJo2gQjbBtA84Tw9HsiKVd5YEfIjTjGrcs83gQYTquQgbP/6WzI27ldBvHxL
         aavXpGenJYJ9dyfmYayFSlAQWrP+AVSsZ7IsPpMSImd4mpGFFNYdEwikm8gQXFFdU2Y0
         +PiA==
X-Received: by 10.70.43.176 with SMTP id x16mr109943156pdl.31.1417522370383;
        Tue, 02 Dec 2014 04:12:50 -0800 (PST)
Received: from gmail.com ([111.91.137.66])
        by mx.google.com with ESMTPSA id f12sm17905394pat.43.2014.12.02.04.12.47
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Dec 2014 04:12:49 -0800 (PST)
X-Google-Original-From: Yi EungJun <eungjun.yi@navercorp.com>
X-Mailer: git-send-email 2.2.0
In-Reply-To: <1405792730-13539-1-git-send-email-eungjun.yi@navercorp.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260559>

Changes since v4

* Fix styles as Junio C Hamano suggested.
* Limit number of languages and length of Accept-Language header.

Yi EungJun (1):
  http: Add Accept-Language header if possible

 http.c                     | 154 +++++++++++++++++++++++++++++++++++++++++++++
 remote-curl.c              |   2 +
 t/t5550-http-fetch-dumb.sh |  31 +++++++++
 3 files changed, 187 insertions(+)

-- 
2.2.0
