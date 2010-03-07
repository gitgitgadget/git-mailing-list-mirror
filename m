From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 0/4] format-patch and send-email ignoring config settings
Date: Sun,  7 Mar 2010 13:33:14 -0800
Message-ID: <1267997598-20815-1-git-send-email-bebarino@gmail.com>
References: <7vk4torn8j.fsf@alter.siamese.dyndns.org>
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Steven Drake <sdrake@xnet.co.nz>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 07 22:33:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoO6J-0003Lv-G3
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 22:33:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754884Ab0CGVdW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Mar 2010 16:33:22 -0500
Received: from mail-yx0-f174.google.com ([209.85.210.174]:55462 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754802Ab0CGVdV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Mar 2010 16:33:21 -0500
Received: by yxe4 with SMTP id 4so122087yxe.33
        for <git@vger.kernel.org>; Sun, 07 Mar 2010 13:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=RiTRMqbyJmBm0FhWsHqHGOGBfu0bA9khtPu48Ut9+uo=;
        b=k7LLlsRXPjFUcRm+iiDDf8ZHZR+h8AsFL8k7e5Dg+HeVfKsmK2o32BK2quaL61uDEo
         x8tavMMElpBp50iyy8pRq9cwcanbdE2WaKiJga1+SnKpcbQWj4ca6hlqJl3dYsyTxH5t
         gQ61AjV4NuolmzVmPuUExxya42PVTLto2iXPk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Tj/JU1PNwNtiuRNsunmsNts0k5EzcPOzizU7f5HGXf5qdSzxhOA39GjSc7qcBgeZP9
         fotGjrrH1aNg6i6UVydbE9Jfke8F4DQzsFEIUBjvxgwyp7Za8StSydooLyOyDJdaQKf+
         p7CyPNKQaj2ydlRmhzk9Q5BXWJ4BNy8C07IC0=
Received: by 10.150.119.33 with SMTP id r33mr3410093ybc.304.1267997601027;
        Sun, 07 Mar 2010 13:33:21 -0800 (PST)
Received: from localhost (user-0c9haca.cable.mindspring.com [24.152.169.138])
        by mx.google.com with ESMTPS id 36sm1124804yxh.49.2010.03.07.13.33.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Mar 2010 13:33:20 -0800 (PST)
X-Mailer: git-send-email 1.7.0.1.171.geb5ee
In-Reply-To: <7vk4torn8j.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141731>

Ok this does the --no-* thing to allow the user to say "I want to ignore
the config settings this time". I couldn't think of a better way to
implement appending and overriding without having to say --no-to and --to
in the same command line invocation. Seems to work ok though.

My perl is pretty bad so please check send-email. 

You get an ancient bugfix for free too. Enjoy.

Stephen Boyd (4):
  send-email: actually add bcc headers
  format-patch: use a string_list for headers
  format-patch: add --no-cc, --no-to, and --no-add-headers
  send-email: add --no-cc, --no-to, and --no-bcc

 builtin-log.c           |   91 ++++++++++++++++++++++++----------------------
 git-send-email.perl     |   19 ++++++++--
 t/t4014-format-patch.sh |   38 +++++++++++++++++++
 t/t9001-send-email.sh   |   39 ++++++++++++++++++++
 4 files changed, 139 insertions(+), 48 deletions(-)
