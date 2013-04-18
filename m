From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 0/6] transport-helper: some clarifications and a fix
Date: Wed, 17 Apr 2013 23:14:27 -0500
Message-ID: <1366258473-12841-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Max Horn <max@quendi.de>, Jonathan Nieder <jrnieder@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 18 06:15:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USgGC-0001pC-HE
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 06:15:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752187Ab3DREPo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 00:15:44 -0400
Received: from mail-yh0-f51.google.com ([209.85.213.51]:35670 "EHLO
	mail-yh0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751333Ab3DREPo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 00:15:44 -0400
Received: by mail-yh0-f51.google.com with SMTP id q67so388310yhf.38
        for <git@vger.kernel.org>; Wed, 17 Apr 2013 21:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=uG5/F38SSKJybc9qnlKJ/T9OGf1gVqcag8x4fuOMOm8=;
        b=Rto8aDdY4jrYcYdRnkQI5BrCjccLfvQ3rmgYobbNBJLjJcqXwm6wouloMrfAFty1Jr
         IR8+ufsRgS2halp46M6h1ojEqMlzTaI/GDrnuDE9FBAiJ4kiF6ILva0KOoIolvJ/YIEu
         ZGXKsf5ChtxB1EEyNlbYZFKdhWUdR2mF9Itx9/ZwuLV4ef1paw06QKQfpWFdZgdCg4tJ
         W8CDwNcaRPj8EZYanXMDvFRvaWtr7gBr86dXaNlUSr+uwnCrmpqb36RFEJDM0puhFIxm
         nRT555Ft1LtgT73FyqErYCKDE0reOgDfsKe7UfxqmGf2c5lZOVbdRo8oPnNur1hasMIz
         0Enw==
X-Received: by 10.236.57.4 with SMTP id n4mr6460809yhc.25.1366258543846;
        Wed, 17 Apr 2013 21:15:43 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id h68sm14517113yhj.24.2013.04.17.21.15.41
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 17 Apr 2013 21:15:42 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.679.g509521a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221602>

Hi,

Same as before, but with a small bug fix, and minor test improvements.

It seems the workings of transport-helper are anything but clear, so let's try
to clarify them a bit, and after that, hopefully it would become clearer why
the last patch is actually a good fix.

Felipe Contreras (6):
  transport-helper: clarify *:* refspec
  transport-helper: update refspec documentation
  transport-helper: clarify pushing without refspecs
  transport-helper: warn when refspec is not used
  transport-helper: trivial code shuffle
  transport-helper: update remote helper namespace

 Documentation/gitremote-helpers.txt | 12 +++++------
 t/t5801-remote-helpers.sh           | 39 ++++++++++++++++++------------------
 transport-helper.c                  | 40 ++++++++++++++++++++++++++-----------
 3 files changed, 53 insertions(+), 38 deletions(-)

-- 
1.8.2.1.679.g509521a
