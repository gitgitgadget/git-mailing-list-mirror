From: "=?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?=" 
	<felipeg.assis@gmail.com>
Subject: [PATCH v2 0/3] Tests for merge-recursive rename options
Date: Tue, 23 Feb 2016 20:48:09 -0300
Message-ID: <1456271292-4652-1-git-send-email-felipegassis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes.Schindelin@gmx.de, gitster@pobox.com,
	sunshine@sunshineco.com,
	=?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?= 
	<felipegassis@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 24 00:49:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYMiK-0001SD-Bm
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 00:49:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751584AbcBWXtw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Feb 2016 18:49:52 -0500
Received: from mail-qg0-f49.google.com ([209.85.192.49]:34467 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751155AbcBWXtv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 18:49:51 -0500
Received: by mail-qg0-f49.google.com with SMTP id b67so1703539qgb.1
        for <git@vger.kernel.org>; Tue, 23 Feb 2016 15:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=PzuskH4TqI5isJUExSz/G/QB6SyDMMYZxQig22Fdn18=;
        b=oZNLVdS8FXBL/REXCWaKoLSmAuB5tc+9iH+fx/ghUXEaCizvX7G6m7z9ipSc6i0dSj
         A4VBlHb747LbQSEh1L+WJiaGdgox72JMu2HmXOOorS5NZQC2bXdqSW1Uy3XvcD4HvR/9
         ZZ2vwR4UZGPXIdPjOaJ/RvUi6RvcPpBM/KZ4oFuX9szcyx7kdqFLaapNTfIQMQRlC0GX
         Qhjv2Ux2k54uqE8zqNtFEHce8ofzHFMZOAq7dD/1EoPEeHTOC/Srq8QE0p+O98OHYjZ1
         knRgCkYXUfpt2NP549gnduc8V09gxwNKFztwk17cIu3TzoS034s95U89xP6dMvacE4IA
         W98w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=PzuskH4TqI5isJUExSz/G/QB6SyDMMYZxQig22Fdn18=;
        b=ARCbjVbQdawI1DEIKTNvqB3WTMOQ+DPG7F2VPntvP22mRsHr6p84HaI+evjcIV4UpG
         hvljq6Zs05ceuVUEVp0jSbWgi2qY4BnS64QOx6N2aTTQOJ9j4MTvu7tk00HS+0F0E+4d
         XOuYQzC3QJPkLBB/LZHP47vCOrYCKNqd2aCxzFsbp1XdaOzEYLTEv3UUiQAy3SuXqiGO
         rw+YrgibbnQQmPfAnzS/o/MnXrSmDM9qonDPXyAgOxO2ephmXRY9zc3XaCewd8jDe2oL
         VROQpvtwAF+v8/X80AqtNfDP7TBWtZA44d+OkR40OynSfIc1sVArpx7rpEAfXqhj6KEP
         zqHA==
X-Gm-Message-State: AG10YOSsb4TVAHbiYfM6Dj1/jPjtbVLzRewEmIg2ievgZCm+gand6KDMQj1cVqJVVRbN1A==
X-Received: by 10.140.35.115 with SMTP id m106mr44695962qgm.13.1456271390903;
        Tue, 23 Feb 2016 15:49:50 -0800 (PST)
Received: from traveller.moon (189-19-119-165.dsl.telesp.net.br. [189.19.119.165])
        by smtp.gmail.com with ESMTPSA id w1sm126080qha.3.2016.02.23.15.49.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Feb 2016 15:49:50 -0800 (PST)
X-Google-Original-From: =?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?= <felipegassis@gmail.com>
X-Mailer: git-send-email 2.7.1.492.gd821b20
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287146>

Get rid of blatant bash-isms in favour of simple and portable construct=
ions.

=46elipe Gon=C3=A7alves Assis (3):
  t3034: add rename threshold tests
  t3034: test option to disable renames
  t3034: test deprecated interface

 ...s.sh =3D> t3032-merge-recursive-space-options.sh} |   2 +-
 t/t3034-merge-recursive-rename-options.sh          | 309 +++++++++++++=
++++++++
 2 files changed, 310 insertions(+), 1 deletion(-)
 rename t/{t3032-merge-recursive-options.sh =3D> t3032-merge-recursive-=
space-options.sh} (99%)
 create mode 100755 t/t3034-merge-recursive-rename-options.sh

--=20
2.7.1.492.gd821b20
