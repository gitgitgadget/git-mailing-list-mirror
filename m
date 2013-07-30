From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 0/3] Remove sq_quote_print() in favor of *_buf
Date: Tue, 30 Jul 2013 14:01:24 +0530
Message-ID: <1375173087-2164-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 30 10:35:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V45Ol-0003M2-5i
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jul 2013 10:35:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758058Ab3G3IfI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Jul 2013 04:35:08 -0400
Received: from mail-pb0-f45.google.com ([209.85.160.45]:33307 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754524Ab3G3IfG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jul 2013 04:35:06 -0400
Received: by mail-pb0-f45.google.com with SMTP id mc8so5690988pbc.18
        for <git@vger.kernel.org>; Tue, 30 Jul 2013 01:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=fO7u8c+K3DzlTIYb04X1fiFzoi+CxhvAKmXLnjgBLrw=;
        b=YrlUr5LyWyL+oi2yn0YpcXOY5hLRlpnvB1MebNp4THKqhlHzUA/Uvp0M2mAG0NG5F5
         y244dX9PlIn10LTM5qdNIRaxRx8VsKiCttAWyGtoKehEVp+0i+6FgsBx7gnVfR4sF00X
         1f5/bB0qWxPh2tEqOtbXrVv/FLReMD0LwAaqYjxTHcmzOMOMm+eAISlly02aT2p8+Kue
         iodsq0GzIQmBr2Wg2v7vnoZz/K28xgzo3/9/LB0ZapI7zQQze4NEZXwT20mfv4RlIg+e
         O6eD6LPJuDVFWzbGGDWIJ/CSE399F/eWRPPqpvghVwPGTgEZvGTCOsiPs2AWJ1FFuuin
         vywA==
X-Received: by 10.66.190.198 with SMTP id gs6mr42396234pac.49.1375173304740;
        Tue, 30 Jul 2013 01:35:04 -0700 (PDT)
Received: from localhost.localdomain ([122.164.159.87])
        by mx.google.com with ESMTPSA id qb15sm25641801pab.13.2013.07.30.01.35.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 30 Jul 2013 01:35:03 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc0.4.g4634265
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231353>

Hi,

While going through the for-each-ref-pretty series that Duy and I were
developing, I noticed that this cleanup was independent and good
as-it-is.

So here it is.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (1):
  for-each-ref, quote: convert *_quote_print -> *_quote_buf

Ramkumar Ramachandra (2):
  tar-tree: remove dependency on sq_quote_print()
  quote: remove sq_quote_print()

 builtin/for-each-ref.c | 13 +++++++----
 builtin/tar-tree.c     | 11 +++++----
 quote.c                | 61 ++++++++++++++++++------------------------=
--------
 quote.h                |  8 +++----
 4 files changed, 39 insertions(+), 54 deletions(-)

--=20
1.8.4.rc0.4.g4634265
