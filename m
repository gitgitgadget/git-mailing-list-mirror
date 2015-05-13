From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv2 0/2] fix handling of multi-word P4EDITOR
Date: Wed, 13 May 2015 08:36:13 +0100
Message-ID: <1431502575-2176-1-git-send-email-luke@diamand.org>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Chris Lasell <chrisl@pixar.com>,
	Junio C Hamano <gitster@pobox.com>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 13 09:37:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsRDz-0001q5-7r
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 09:37:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932378AbbEMHg6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 03:36:58 -0400
Received: from mail-wi0-f169.google.com ([209.85.212.169]:36321 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933031AbbEMHg4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 03:36:56 -0400
Received: by wizk4 with SMTP id k4so186031261wiz.1
        for <git@vger.kernel.org>; Wed, 13 May 2015 00:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=scR+c+uAEn4RONVcE2/r7iYHD+fJd60AQm4u2xuSBzQ=;
        b=TzHSIbY1K3aDvdEbDp55dvkFGCMJ8SFe270762dp0vat55dm8II+eMLTD2Qd8vZ3Ki
         uaUDhb+Y2Ci7dVCEyHhz3efYQXuRByyXRXODqdKfzROD5bJR83dyLR/kKDZRuwLNx2W2
         cQ8G7hUff7uRw8ezPZD1p1huAbkA9qqeuHRE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=scR+c+uAEn4RONVcE2/r7iYHD+fJd60AQm4u2xuSBzQ=;
        b=G5nec0eYUwCD338EmtM7xbEakk4oGzDVAoBxc5vYvlXpHVYzHb06pnxlHoKLWqUNhK
         fKYWgi3F41qpHPR9FHQsszaR8gfI1W/g2XpQvWOJynpVEnHoogtBT62fJOwsPL0zJJPy
         TyPPL6ZI0flsNWw8qI+tKzAubOYNzfxqsilIxK52BJ6Rf8cf5GYos+wHoqx/quN8+pRs
         FuonvpVu9GD7VVQSJsorEzXYHMSk9UDWzv3Q7DoJ6nNX2g1nvEHwXAerakEdVIGcgnW6
         9u82brvr7L/hnwyRxyN0eStUB/NgRlrfwgqPDauUstY4MagBOKDTgGF8anwsmnurHC2f
         oziw==
X-Gm-Message-State: ALoCoQlxPd2+giGqU5fNWD31zqGtRa8LIq3A5sXotaSv3fk5npSaooVSb9mNsOOu4Kyu+cen0eJT
X-Received: by 10.194.57.11 with SMTP id e11mr35521404wjq.19.1431502615236;
        Wed, 13 May 2015 00:36:55 -0700 (PDT)
Received: from ethel.local.diamand.org. (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by mx.google.com with ESMTPSA id nb9sm6579871wic.10.2015.05.13.00.36.53
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 May 2015 00:36:54 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.rc3.380.g8e2ddc7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268941>

This is an updated version of the earlier P4EDITOR multi-word shell
expansion fix. It updates test 9805 to match the new behavior (the
other tests also all pass).

I still haven't incorporated Junio's fix for the Windows platform;
that's next (once I've figured out how to build git on that platform).

Thanks
Luke

Luke Diamand (2):
  git-p4: add failing test for P4EDITOR handling
  git-p4: fix handling of multi-word P4EDITOR

 git-p4.py                          |  2 +-
 t/t9805-git-p4-skip-submit-edit.sh |  2 +-
 t/t9820-git-p4-editor-handling.sh  | 38 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+), 2 deletions(-)
 create mode 100755 t/t9820-git-p4-editor-handling.sh

-- 
2.4.0.rc3.380.g8e2ddc7
