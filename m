From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/2] Move sequencer
Date: Fri,  7 Jun 2013 17:16:47 -0500
Message-ID: <1370643409-3431-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 08 00:18:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul4zc-0004Cr-NO
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 00:18:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756102Ab3FGWSk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 18:18:40 -0400
Received: from mail-oa0-f50.google.com ([209.85.219.50]:38289 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753181Ab3FGWSk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 18:18:40 -0400
Received: by mail-oa0-f50.google.com with SMTP id l20so3852818oag.37
        for <git@vger.kernel.org>; Fri, 07 Jun 2013 15:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=lC1w8KraoVybYr+d8ONgYkT5cczvOYchykcAMChTVcA=;
        b=j9eQzN8B/HkXwLrZLUiNLUHOCLiQJxj0gFle+qKlz1531CmuVsbwgOheiGoV4jzxDW
         0ojXgQwqmQ0VeOFpRGvxIW9X1dI0TNwjTQwz/zT9r/z7yqLmuA+uXuo5D7hk9ujUu46/
         S00MaRbQ4jr7PHe+LM9RxyZQUQUAHVgvyCTwGPiNT/WOksvigcXXbNaMwqOQGZecNej3
         7Zj6wdfvUTY8wvFPcEUaazp7pRfZyANUw2cABjnDbbvmWzbhsHcxInfJ3AGIrIUH6jzp
         LkuNElDpjn6npOYTxsi9B2jx3cscJm0ASZyk/tGXL4r2BXzsrqtGEqDY/XzDKClcZx+4
         buPg==
X-Received: by 10.60.43.35 with SMTP id t3mr573289oel.13.1370643519749;
        Fri, 07 Jun 2013 15:18:39 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id nt17sm879243obb.13.2013.06.07.15.18.37
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 07 Jun 2013 15:18:38 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226751>

Hi,

This patch series moves the sequencer code which is only useful for builtin
commands, to builtin. This also creates the concept of 'builtin helpers'.

Felipe Contreras (2):
  log-tree: remove dependency from sequencer
  Move sequencer to builtin

 Makefile                           |   9 ++-
 sequencer.c => builtin/sequencer.c | 160 +-----------------------------------
 sequencer.h => builtin/sequencer.h |   4 -
 log-tree.c                         | 161 ++++++++++++++++++++++++++++++++++++-
 log-tree.h                         |   3 +
 5 files changed, 172 insertions(+), 165 deletions(-)
 rename sequencer.c => builtin/sequencer.c (87%)
 rename sequencer.h => builtin/sequencer.h (88%)

-- 
1.8.3.698.g079b096
