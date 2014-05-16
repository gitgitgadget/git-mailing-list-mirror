From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: [PATCH v2 0/2] Reroll patch series. Pretty print truncate does not work
Date: Fri, 16 May 2014 19:40:31 +0400
Message-ID: <cover.1400254654.git.Alex.Crezoff@gmail.com>
References: <CACsJy8B20XMiNqtG9c-cLERd8-zahcvWU=UnY80ZJUmLD91ZKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alexey Shumkin <Alex.Crezoff@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 16 17:41:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlKFm-0001lf-2J
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 17:40:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932729AbaEPPkx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 May 2014 11:40:53 -0400
Received: from mail-la0-f43.google.com ([209.85.215.43]:36119 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932589AbaEPPkx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 11:40:53 -0400
Received: by mail-la0-f43.google.com with SMTP id mc6so2089564lab.2
        for <git@vger.kernel.org>; Fri, 16 May 2014 08:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=p0maejtfn/6y3TZJs3SjtczT9IATXI57Odi5DX8Ae1Y=;
        b=v9+WS1xhDDUcXnTGt9Kkp3R9zsZpW+vCebj4e8+SyPRTAzUjjhNDOTsdtqQifSvA1g
         3i1B5hK4C1Bba32xdM58Kdr/VLo1O/jCMPbriCNhEAHIOgxYtOsDJJF3NJ8f0KMxJnjn
         W1jegeEj8HaEr0kbqjvfTy+FWxhvSE/tLqgbnpF5rwTpYzH+NqrC3Zh3Q2eM6qg+LM15
         bZFuxgPCaY6HZtItIhEDtK5JTeeqX8/6KzkcRkV40MBpxGBD7c0k6TQ/bQG3VTuFhOH6
         tmjqY+3usrkvLRa+OhjHESoNfxvo1VpzpBrxvgYSJTpMCVRUPvicMiIA25VY/rYOWkUy
         zvDA==
X-Received: by 10.152.42.234 with SMTP id r10mr2069881lal.66.1400254851292;
        Fri, 16 May 2014 08:40:51 -0700 (PDT)
Received: from localhost ([193.9.244.4])
        by mx.google.com with ESMTPSA id g6sm9878095laa.10.2014.05.16.08.40.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 May 2014 08:40:50 -0700 (PDT)
X-Google-Original-From: Alexey Shumkin <Alex.Crezoff@gmail.com>
X-Mailer: git-send-email 1.9.2-17
In-Reply-To: <CACsJy8B20XMiNqtG9c-cLERd8-zahcvWU=UnY80ZJUmLD91ZKg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249350>

In this reroll (against v1) remarks of Nguy=E1=BB=85n are respected.
Comments style changed from C++ to C. variable declaration moved back t=
o
the beginning of a function.
Also, added tests for the same case for git rev-list
(see t6006-rev-list-format.sh)

Alexey Shumkin (2):
  t4205, t6006: Add failing tests for the case when
    i18n.logOutputEncoding is set
  pretty.c: format string with truncate respects logOutputEncoding

 pretty.c                      |   7 +-
 t/t4205-log-pretty-formats.sh | 169 ++++++++++++++++++++++++++++++++++=
++++++++
 t/t6006-rev-list-format.sh    |  75 ++++++++++++++++++-
 3 files changed, 248 insertions(+), 3 deletions(-)

--=20
1.9.2-17
