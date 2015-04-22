From: Patrick Sharp <jakanapes@gmail.com>
Subject: [BUG] having 'plink' anywhere in the GIT_SSH environment variables sets putty = true
Date: Wed, 22 Apr 2015 09:36:45 -0500
Message-ID: <2A6FFC1D-5479-4DCA-A5E5-FF92DE0AA552@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 22 16:37:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ykvll-0003bI-US
	for gcvg-git-2@plane.gmane.org; Wed, 22 Apr 2015 16:36:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933365AbbDVOgt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Apr 2015 10:36:49 -0400
Received: from mail-oi0-f47.google.com ([209.85.218.47]:32780 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933164AbbDVOgs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Apr 2015 10:36:48 -0400
Received: by oica37 with SMTP id a37so178323826oic.0
        for <git@vger.kernel.org>; Wed, 22 Apr 2015 07:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:content-type:content-transfer-encoding:subject:message-id:date
         :to:mime-version;
        bh=2YkdXF3596Ndfi0ifzmbm7HxVCzPQpp7liV8dysqe6g=;
        b=eAw35+So1X771EZVErmBrbuZA1wb/2VZnqAEOAakyzUxNqG4QnPhLwRpWCzdDfHOHo
         9wEJrcl6Xs11ZNcz4CCVDYEURdxXXyKNjagw61zifELW5t6zF+qoMlejmEFper4yGwjc
         UH4MD8/7R+7G0TVspW6nl5tWKXpiHPZ5AA2R4bJ31tr2c1VuIfr5NPDlwefk9TpX0JjV
         c3mZ22Jl6Dq9lcdSFJvENjGZVoLCc8PJ5jR8wPbxY1WqfykObHqLxpzhhsIsnu6f3F+e
         SewNtm7eHXheZg6Kv3X9puXsyHz9Acmmznpc54E7c1iy1ixsLVuFiIMlc/mR/djxTxGV
         XcOg==
X-Received: by 10.60.96.137 with SMTP id ds9mr24323952oeb.56.1429713408081;
        Wed, 22 Apr 2015 07:36:48 -0700 (PDT)
Received: from [172.31.57.107] ([199.227.134.115])
        by mx.google.com with ESMTPSA id h128sm3200103oic.0.2015.04.22.07.36.46
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 22 Apr 2015 07:36:46 -0700 (PDT)
X-Mailer: Apple Mail (2.2098)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267592>

The plink string detection in GIT_SSH for setting putty to true is very=
 broad.

If plink is anywhere in the path to the shell file then putty gets set =
to true and ssh will fail trying to parse -batch as the hostname.

Wouldn=E2=80=99t searching for plink.exe be better?