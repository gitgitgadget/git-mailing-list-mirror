From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: [PATCH 0/2] MSVC generator fixups
Date: Mon, 28 Sep 2009 13:34:19 +0200
Message-ID: <cover.1254137149.git.mstormo@gmail.com>
References: <4ABB84F4.7080403@gmail.com>
Cc: msysgit@googlegroups.com, Marius Storm-Olsen <mstormo@gmail.com>
To: git@vger.kernel.org, spearce@spearce.org, sschuberth@gmail.com
X-From: git-owner@vger.kernel.org Mon Sep 28 13:35:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MsEVG-0001sp-OS
	for gcvg-git-2@lo.gmane.org; Mon, 28 Sep 2009 13:34:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752716AbZI1Lel (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2009 07:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752689AbZI1Lek
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Sep 2009 07:34:40 -0400
Received: from mail-ew0-f211.google.com ([209.85.219.211]:36293 "EHLO
	mail-ew0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752514AbZI1Lek (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2009 07:34:40 -0400
Received: by ewy7 with SMTP id 7so4324421ewy.17
        for <git@vger.kernel.org>; Mon, 28 Sep 2009 04:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=TMt1K0EdSzvkAWAwcDhfDWhzNL3yb+9dnVdqsGEKwnw=;
        b=jQ+78AkiF5OdPmeJFBLTEtq9VwUgiN+t4vtkHtX5mmXMJTDEtDGbPGrUVyvfaG/VpU
         Jeo7NJK5iGyYuazNAU5GKnTC9HH/c3ByOXWWZS1Itkm363a9EK7i2XebtvnttJxSBULo
         qkwOw5ubnyQm3o96I/owTx46QjzAFQkY7aYl4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=oHEIu/NPxzBezkISL/Hz6o3VmWAk4NlRIiHH/j8YARRIwu3ROo8XmzMc5KYCkzfVMz
         JONimSG6/HY6XfhIC7bQpsseEvEjZ606Cwmx9cqyDrWpHhyIcQD+waDmIQSTmxLPjSeu
         j4iPEsXml4mBnHpdweVfP8QxyMjK8tyT1onP4=
Received: by 10.210.93.27 with SMTP id q27mr3616203ebb.9.1254137682921;
        Mon, 28 Sep 2009 04:34:42 -0700 (PDT)
Received: from localhost.localdomain ([62.70.27.104])
        by mx.google.com with ESMTPS id 5sm755655eyh.35.2009.09.28.04.34.41
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 28 Sep 2009 04:34:42 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.rc2.177.ga9dd6
In-Reply-To: <4ABB84F4.7080403@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129252>

The generated solution file was valid, but not exactly in the way the
2008 IDE wanted them, so the IDE would query to save the solution file
even though the user never touched the solution/projects.
These two patches ensures that the solution file is in the way the IDE
wants them, so we avoid the naging.

The two patches didn't apply for me in the way they were sent. I
manually applied them ontop of master, and added an Acked-by.

Thanks!

Sebastian Schuberth (2):
  Make generated MSVC solution file open from Windows Explorer
  Make just opening the generated MSVC solution file not modify it

 contrib/buildsystems/Generators/Vcproj.pm |   47 +++++++++-------------------
 1 files changed, 15 insertions(+), 32 deletions(-)
