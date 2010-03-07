From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCHv2 0/3] format-patch and send-email ignoring config settings
Date: Sun,  7 Mar 2010 14:46:45 -0800
Message-ID: <1268002008-13426-1-git-send-email-bebarino@gmail.com>
References: <1267997598-20815-1-git-send-email-bebarino@gmail.com>
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Steven Drake <sdrake@xnet.co.nz>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 07 23:53:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoPMA-00013X-G3
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 23:53:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919Ab0CGWxt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Mar 2010 17:53:49 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:61009 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839Ab0CGWxs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Mar 2010 17:53:48 -0500
Received: by gwb15 with SMTP id 15so2712474gwb.19
        for <git@vger.kernel.org>; Sun, 07 Mar 2010 14:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=ErnFWZ5TAWd+yMofWDLs3/Hd8NeMXCu9iuRwDS+aKA0=;
        b=DkK4US1VJswPdDfvvePUGZbQTf4yWbJlqg5c1Zs5WZSX8mEXkN8ah+h5ZpCc2cXMGS
         kRRdk1qfMPedEtSZSFi7JFb59LuW+3zKam6NH89LVVRw0mjUIyLRY2r5wbAyDB0VgZ67
         AgD9D0hLhxQ9jt9C523VY4Mssk9YLmmTk1Zxg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=f+1Vcv+DDh0vrnajkFeF/J9AHNfJ3WiMgcrf7Yd9daQVp3dE8K7Z7Fav2lR5e9JmTT
         V7aPBmjhgDu1KDP9C1oO6/bIUsrZZcSPmvo/FI8+itX7IFVTHzU3ZR+cSubvBH3Qsbm6
         k6xHinCvlEasG2mfvjM37Df5WhYMjjOc6GS2k=
Received: by 10.100.75.12 with SMTP id x12mr7936472ana.29.1268002012006;
        Sun, 07 Mar 2010 14:46:52 -0800 (PST)
Received: from localhost (user-0c9haca.cable.mindspring.com [24.152.169.138])
        by mx.google.com with ESMTPS id 9sm1548503ywe.37.2010.03.07.14.46.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Mar 2010 14:46:51 -0800 (PST)
X-Mailer: git-send-email 1.7.0.1.171.geb5ee
In-Reply-To: <1267997598-20815-1-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141746>

Changes since v1:
 * No more initializers 
 * Better tests for send-email
 * Dropped first patch

Stephen Boyd (3):
  format-patch: use a string_list for headers
  format-patch: add --no-cc, --no-to, and --no-add-headers
  send-email: add --no-cc, --no-to, and --no-bcc

 builtin-log.c           |   94 +++++++++++++++++++++++++----------------------
 git-send-email.perl     |   14 +++++--
 t/t4014-format-patch.sh |   38 +++++++++++++++++++
 t/t9001-send-email.sh   |   66 +++++++++++++++++++++++++++++++++
 4 files changed, 164 insertions(+), 48 deletions(-)
