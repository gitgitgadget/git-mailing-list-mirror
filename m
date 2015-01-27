From: Yi EungJun <semtlenori@gmail.com>
Subject: [PATCH v8 0/1] http: Add Accept-Language header if possible
Date: Wed, 28 Jan 2015 00:51:57 +0900
Message-ID: <1422373918-14132-1-git-send-email-eungjun.yi@navercorp.com>
References: <xmqq7fwfuu62.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Yi EungJun <eungjun.yi@navercorp.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Peter Krefting <peter@softwolves.pp.se>,
	Michael Blume <blume.mike@gmail.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 27 16:52:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YG8RX-0005D1-7e
	for gcvg-git-2@plane.gmane.org; Tue, 27 Jan 2015 16:52:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932554AbbA0Pwh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Jan 2015 10:52:37 -0500
Received: from mail-pa0-f51.google.com ([209.85.220.51]:43197 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932305AbbA0Pwe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2015 10:52:34 -0500
Received: by mail-pa0-f51.google.com with SMTP id fb1so19249049pad.10
        for <git@vger.kernel.org>; Tue, 27 Jan 2015 07:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=dlb5yBcx5624yMUhxIzUoC/B1wiPBV+aysfESwsHlDA=;
        b=FNz+j6/WP5r+n7ITuLSdgbXAEsRD1X2akbBKVSCxbH6DWzGm+JTEirIamARxV21BRh
         OOqF2GvMjwys3c3RuZHNdAf6eJS7ZAgJEfw8AKySf8c5IvfxwRPDXbSi+MAI5DvnOknj
         4a0GrOJP2KQSPPV2cnyWf7RzO2y9yLuGy3YGLFrd85pW1L/XMepLk6Icf+fzagCw9zq0
         WA5eafAbChv/OY8HbpGhHNrS6Zxp8+g9CN8Dx56lLaPjmTXGnMbM0OMPfqcy+aAwdbIz
         LqFQGfqZ1cSLDT+8DT6Rhu0eXuqVuPcyyYdLHN+oIBmCDr0WrBWNoTabjfnnrdTbaB/+
         29Xg==
X-Received: by 10.70.123.10 with SMTP id lw10mr2871350pdb.161.1422373954390;
        Tue, 27 Jan 2015 07:52:34 -0800 (PST)
Received: from gmail.com ([222.234.94.10])
        by mx.google.com with ESMTPSA id c2sm2002960pdi.25.2015.01.27.07.52.31
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 Jan 2015 07:52:33 -0800 (PST)
X-Google-Original-From: Yi EungJun <eungjun.yi@navercorp.com>
X-Mailer: git-send-email 2.3.0.rc1.32.ga3df1c7
In-Reply-To: <xmqq7fwfuu62.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263073>

=46rom: Yi EungJun <eungjun.yi@navercorp.com>

Change since v7

=46rom Torsten B=C3=B6gershausen's review:

	* remove unnecessary if-statement

=46rom Eric Sunshine's review:

	* fix memory leaks and uninitialized variables
	* remove unnecessary if-statement

=46rom Junio C Hamano's review:

	* fix uninitialized variables

Yi EungJun (1):
  http: Add Accept-Language header if possible

 http.c                     | 151 +++++++++++++++++++++++++++++++++++++=
++++++++
 remote-curl.c              |   2 +
 t/t5550-http-fetch-dumb.sh |  42 +++++++++++++
 3 files changed, 195 insertions(+)

--=20
2.3.0.rc1.32.ga3df1c7
