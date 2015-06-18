From: Alistair Lynn <alistair@othernation.com>
Subject: Bug report: `git revert` on empty commit fails silently
Date: Thu, 18 Jun 2015 16:27:41 +0100
Message-ID: <A18BC2A3-C9A6-4D03-B929-D821E90B812D@othernation.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 18 17:28:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5bjP-0004jO-FF
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 17:27:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755816AbbFRP1u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Jun 2015 11:27:50 -0400
Received: from mail-wg0-f49.google.com ([74.125.82.49]:33042 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755825AbbFRP1p convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Jun 2015 11:27:45 -0400
Received: by wgez8 with SMTP id z8so66930245wge.0
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 08:27:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:content-type:content-transfer-encoding
         :subject:message-id:date:to:mime-version;
        bh=nt1UiOg8aFylgJLee1yx6xehqbIz5tfc9+oizbZvvjo=;
        b=Vqcsxtf7X8mx4Yw+2x7HyXZjGUS/P7eoqpSb1dFOL1bSgBtgxQY9U+wr6CPWOVFczw
         4zTrRvrCBLw9CP/l9DkFlmZGzVTWC48m3D/BsFdfyw4Woicq7eRC0O1j2fEMXNcCSbrt
         dc4ODExZMLgi/no66jPKqnM3Sd1KS0ddoynCrk/Zvrvl/v8B8jS2kmzoKAwbqAljcR4l
         AQUbvwB69iAq2DWvk5o2hPhtW4kIzqkyLSapdHRj/G08nRtpEbltItSgx37O0w5DyP3f
         AahFm4ObV1VM5anlGXNkGOxQEE15HDbXKU7tJvj1jhNjc8e5A7JYse6oh+MrV0wVQ8sC
         e1og==
X-Gm-Message-State: ALoCoQmNaNkFUi6boYuEbXSq2TKII8re1XmEy+3KNkjiIrZMFAsrRFDdW0AMUgeplas4/4dPsEXB
X-Received: by 10.180.93.170 with SMTP id cv10mr28574930wib.44.1434641263359;
        Thu, 18 Jun 2015 08:27:43 -0700 (PDT)
Received: from [192.168.1.71] ([46.247.5.77])
        by mx.google.com with ESMTPSA id bc9sm12746194wjc.28.2015.06.18.08.27.42
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 18 Jun 2015 08:27:42 -0700 (PDT)
X-Mailer: Apple Mail (2.2098)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272015>

Hello gitters

Steps to reproduce:

$ git commit --allow-empty -m =E2=80=98test=E2=80=99
$ git revert HEAD

The latter fails silently, leaving HEAD pointing at the commit created =
by the first command.

A subsequent `git commit --allow-empty` has the revert message as the d=
efault commit message when starting the editor.

Hope this is the right place for bugs.

Alistair
