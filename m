From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v2 0/2] peroper align of datetime filed of git-blame
Date: Mon, 21 Apr 2014 00:13:51 +0800
Message-ID: <cover.1398010052.git.worldhello.net@gmail.com>
References: <CACsJy8BTBwqFZUU3i3cuv40B6AHw5SRY9DZN2PoKL4XzgEL2eA@mail.gmail.com>
Cc: Brian Gesiak <modocache@gmail.com>, Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 20 18:14:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WbuOF-00020H-Lz
	for gcvg-git-2@plane.gmane.org; Sun, 20 Apr 2014 18:14:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbaDTQON (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2014 12:14:13 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:57274 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751046AbaDTQOL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2014 12:14:11 -0400
Received: by mail-pa0-f51.google.com with SMTP id kq14so2967869pab.38
        for <git@vger.kernel.org>; Sun, 20 Apr 2014 09:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oUlLPAWH1+N77fivzymWMhwxbWfJbOt/5YzvFHGH1nk=;
        b=yZX7fKgfNQ79yrgIJSOWYgJSqvND/YvGv1GTJ7fJzin8mQ4pxnP/FeEN10FMgSEAxL
         9YL2/d31moKzMpY8lyHj4yFVE/bMkrJFwg0+Gq9GkaL84Um7QpLAJHDq8PnPXvviHQcH
         woH6hzPfK8nWUhc9zcai3nbXFRTu5kWBb7NClKGI2UlxIDnAjTqBnpd9fNEsjrRGyurf
         xXxye78DeXt3augLrk9VHNkFdpYMO1Q4RcU23gJ5f743OLyRP94HryskAdoD4cdRgjHt
         h3jNHiIUsnSqJ6pCkanuSrEbbBSIVDzxCZ6qhi9xbAws70GmhSck9tQAt9o/Wc9PXv+L
         5wqQ==
X-Received: by 10.66.197.135 with SMTP id iu7mr41586pac.149.1398010451154;
        Sun, 20 Apr 2014 09:14:11 -0700 (PDT)
Received: from localhost.localdomain ([114.241.217.8])
        by mx.google.com with ESMTPSA id dy7sm173141497pad.9.2014.04.20.09.14.05
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 20 Apr 2014 09:14:10 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc0.3.g444188f.dirty
In-Reply-To: <CACsJy8BTBwqFZUU3i3cuv40B6AHw5SRY9DZN2PoKL4XzgEL2eA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246551>

When rewrite time_buf[128] to strbuf, find another bug from the original
implement.  See detail commit log of 1/2.

Jiang Xin (2):
  bugfix: fix broken time_buf paddings for git-blame
  blame: use different blame_date_width for different locale

 builtin/blame.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

-- 
2.0.0.rc0.3.g444188f.dirty
