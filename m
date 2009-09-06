From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v7 0/6] fast-import: add new feature and option command
Date: Sun,  6 Sep 2009 16:35:42 +0200
Message-ID: <1252247748-14507-1-git-send-email-srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>,
	Ian Clatworthy <ian.cla
X-From: git-owner@vger.kernel.org Sun Sep 06 16:36:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkIr9-00078l-7q
	for gcvg-git-2@lo.gmane.org; Sun, 06 Sep 2009 16:36:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757958AbZIFOgK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Sep 2009 10:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756114AbZIFOgK
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Sep 2009 10:36:10 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:55913 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757957AbZIFOgJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Sep 2009 10:36:09 -0400
Received: by ewy2 with SMTP id 2so1511761ewy.17
        for <git@vger.kernel.org>; Sun, 06 Sep 2009 07:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer;
        bh=FpL/bYFszMpMp/+sKPJFNvVvcJ0bIYx9JtOzhwW9MyM=;
        b=LA+51eroHhKNuGTixqZWKOxlVCEYclc0ntXc3sA+H9VnbeI2TrWd8smLVqe3stKjhm
         H9/7wgErDu6Y+rpmSQG3hR3CTSrfpl73qcPhRddg8cJGNwt6Ww8eBQYh2uDIJNFT1w0M
         Yretpzw0D6h4Eu4LgzTjLkjnhcy9iotwffNsc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer;
        b=If9RX8l93VgH80bkk4OIo6n/92ATkRC0HqiIrlGzdczyX1dU1TuYEVA60b/gyg6hKL
         8iI11/EHsLM0uGB0kb66P5cFnJCRpM1vbiPqTlv7E1BA5i8ZH8SHlVM2wEhA02iMSjOu
         /uOi7NF8iU0+wYOZnt1an10uCHFHDpcs5NQ48=
Received: by 10.216.93.141 with SMTP id l13mr1273092wef.67.1252247770490;
        Sun, 06 Sep 2009 07:36:10 -0700 (PDT)
Received: from localhost.localdomain (ip138-114-211-87.adsl2.static.versatel.nl [87.211.114.138])
        by mx.google.com with ESMTPS id q9sm8759493gve.6.2009.09.06.07.36.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 06 Sep 2009 07:36:10 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.16.g72c66.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127855>

Only changes are in 5/6 and 6/6, as suggested by Junio we now ignore
git options that we do not recognise. If desired we could add a
feature command for each option so that the frontend can make it
required with 'feature git-option-marks'.

Sverre Rabbelier (6):
      fast-import: put option parsing code in separate functions
      fast-import: put marks reading in it's own function
      fast-import: add feature command
      fast-import: test the new feature command
      fast-import: add option command
      fast-import: test the new option command

 Documentation/git-fast-import.txt |   40 ++++++
 fast-import.c                     |  264 ++++++++++++++++++++++++++-----------
 t/t9300-fast-import.sh            |  107 +++++++++++++++
 3 files changed, 334 insertions(+), 77 deletions(-)
