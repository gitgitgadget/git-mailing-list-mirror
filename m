From: =?UTF-8?Q?Milan_Dav=C3=ADdek?= <davidek.ateli@gmail.com>
Subject: Fwd: BUG: absolute paths on windows
Date: Mon, 18 Apr 2016 14:09:16 +0200
Message-ID: <CA+Mudr7nGNb74kTrdoWMsST7vPNi2p5mOE+qrrD6x0kqWtxxQw@mail.gmail.com>
References: <CA+Mudr6L3-yVoyDTc+wsww5TCVu_hFBi5R_DKxBop4NHrt_Ysw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 14:09:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1as7zW-00060o-JT
	for gcvg-git-2@plane.gmane.org; Mon, 18 Apr 2016 14:09:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbcDRMJS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Apr 2016 08:09:18 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:33269 "EHLO
	mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751036AbcDRMJR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Apr 2016 08:09:17 -0400
Received: by mail-io0-f193.google.com with SMTP id g185so23155134ioa.0
        for <git@vger.kernel.org>; Mon, 18 Apr 2016 05:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-transfer-encoding;
        bh=Q8GfcnDwD3SLOpwmKNJvTSVo1WBldpifT8nzlDpjL6o=;
        b=IbAtc87EBotuaSipDBZf/cB0XvGBU0bkYAxRyZre4QoKUDPyE/bbiGLiPtYdk4+LL2
         Zwsi0u75wHK9YHTUm3zuJMhpD1uoNhys7C/Dgcbj8YLU/3xd86nK+X7mY0oBIh+Rovvh
         9dWKFSxFThHxBb2scIwv998xqfBfU2ArWUlQI3wT0xjUcCXsXYBOLNC1PIg2SLG+SwoW
         zcs9l+hRXFUt5QyTxcRZpeDQ3lTcPbgHzqRIrukS/lwQ+oSuJt2NLjZ59plC6lVbr4y+
         VaV7zaB5POFf+aPx3zvKlvq2+++9vIXkUAi/QF2S3DCzxPy9XxyCgG3OEHZZRUDEih2L
         p//A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:content-transfer-encoding;
        bh=Q8GfcnDwD3SLOpwmKNJvTSVo1WBldpifT8nzlDpjL6o=;
        b=k8sLC4C+qAQuGfWbUD4gU4jq3qq+tz/ryAM1jNlVJ3bRcCqhG/lBqza5/WlAgHBphh
         vlcinabOU/AOT5qfQZVvfM+V/4erC1FNmJSsfCISK0SS/5+Gg5qmA8ayxzvj7nDnV2qF
         IquAKbXJ8ekh3LTdu8fN6sapEOrHlKlVoHd9ro5jH4UfF7uWfuXyuV111kcMQOZvFkde
         lPErVIglRnZFCXyl+mfO70Uhbu+xGfBEVVYAX/jhW7eHbvROGEfMt42Mq2HTx8E0C6fo
         MefPQJhqF9OMk1TYC6eBKqYIwhjnv/Ckm3ILDj8N+sa3jyLr+5uEfPaksSe4MvTa1QLq
         C+ng==
X-Gm-Message-State: AOPr4FX51dHrDW4VxJs1Zp6NhGcKrnju67pjJPe3/Z+89b3TD+fYanFAg0lK1r1nKKqm70Z9iSEvHDkO6dOpmw==
X-Received: by 10.107.143.23 with SMTP id r23mr35582016iod.54.1460981356584;
 Mon, 18 Apr 2016 05:09:16 -0700 (PDT)
Received: by 10.79.65.88 with HTTP; Mon, 18 Apr 2016 05:09:16 -0700 (PDT)
In-Reply-To: <CA+Mudr6L3-yVoyDTc+wsww5TCVu_hFBi5R_DKxBop4NHrt_Ysw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291805>

Hello,

I've discovered bug in git. I'm used to add files by copying absolute
path from my IDE. Now on Windows 10 I discovered bug. Git says: "is
outside repository" when I use "git add C:\repo\file.txt". For "git
add c:\repo\file.txt" (drive letter is lower-case) it works like it
worked before on previous windows. I think it's bug because windows
file paths are case insensitive and both of them should work. My git
version is "git version 2.8.0.windows.1".

Milan Dav=C3=ADdek
