From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v8 0/7] fast-import: add new feature and option command
Date: Fri,  4 Dec 2009 18:06:53 +0100
Message-ID: <1259946420-8845-1-git-send-email-srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>,
	<vcs-fast-import-devs@l
X-From: git-owner@vger.kernel.org Fri Dec 04 18:14:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGbcp-0005hr-GR
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 18:07:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbZLDRHL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 12:07:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932238AbZLDRHL
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 12:07:11 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:50369 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932212AbZLDRHK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2009 12:07:10 -0500
Received: by ewy19 with SMTP id 19so3051335ewy.1
        for <git@vger.kernel.org>; Fri, 04 Dec 2009 09:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer;
        bh=QVfJ4lPTC0Py7eqChJ480OXO8wTw4o76RVndcam/Vng=;
        b=gM5+9jn3NoGJimTB11HjiRMjf221RF68WuSqOG+vzX5XNrZpSzmqGAPWhXe8cOCTYS
         yfhhttnIq21PCis3xC/4lbqOl2Mvo0+KaU2GdI655mb9W7sXDo+myt/Pa6QW5R2hWUXM
         QRl4VpdgbuRr2PaJ65O8O2zmSJdLkmvPbNLHY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer;
        b=mbOCEeBFsLMNnuAkbHXc8a50JDxVzNb1npuKdP6qJc8TCDM2fkrhd3rAA/iKst0tPu
         xA7LnTnfw9vEBqZ/fBsLXhHGePMIA8+LGBHnD4KaQySgJAMlVPXvPvXyR5M4nX6Upow+
         vHmegFC5z6my5xKFGiUlA4iHNik3cbI4+yVIM=
Received: by 10.213.96.6 with SMTP id f6mr3430574ebn.81.1259946434065;
        Fri, 04 Dec 2009 09:07:14 -0800 (PST)
Received: from localhost.localdomain (ip138-114-211-87.adsl2.static.versatel.nl [87.211.114.138])
        by mx.google.com with ESMTPS id 16sm1980184ewy.14.2009.12.04.09.07.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 04 Dec 2009 09:07:13 -0800 (PST)
X-Mailer: git-send-email 1.6.5.3.164.g07b0c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134540>

This reroll addressess comments from Shawn and the fast-import
mailing list. It also adds a new feature, "relative-marks", which
will be very useful for remote helpers.

Apologies for taking so long with the reroll, hopefully this version
is good for next and I can finish my git-remote-hg work :).

Sverre Rabbelier (7):
      fast-import: put option parsing code in separate functions
      fast-import: put marks reading in it's own function
      fast-import: add feature command
      fast-import: add option command
      fast-import: test the new option command
      fast-import: allow for multiple --import-marks= arguments
      fast-import: add (non-)relative-marks feature

 Documentation/git-fast-import.txt |   79 +++++++++
 fast-import.c                     |  317 +++++++++++++++++++++++++++----------
 t/t9300-fast-import.sh            |  152 ++++++++++++++++++
 3 files changed, 462 insertions(+), 86 deletions(-)
