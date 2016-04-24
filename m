From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 2/3] githooks.txt: Amend dangerous advice about 'update' hook ACL
Date: Sun, 24 Apr 2016 21:26:42 +0000
Message-ID: <1461533202-10706-1-git-send-email-avarab@gmail.com>
References: <CA+P7+xqveyG7RTWb2k8UsFWRwjvM6JJkveRr3NV-bammqSkpkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 23:27:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auRYg-0004nv-9U
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 23:27:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753219AbcDXV1J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Apr 2016 17:27:09 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:38858 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753191AbcDXV1I (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 17:27:08 -0400
Received: by mail-wm0-f49.google.com with SMTP id u206so100014262wme.1
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 14:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q+i8pxd4YQBsuXkEX/5Cfv4nKSJOhNUDp7tJMe/Gwzw=;
        b=hPxP4AYe3bnVGJ0b5w+B9rmkvpAJVQPlQ2tkJKz+2eaVvL6tVANUhIgAUPecKeO2JE
         YgHPv8bi/x0JykTeDjCuk6akZ+9k8ag9xRYFUScpk3lr3K6wvo6gUxsTKgTpP70kl8kR
         LKAtCHdmV2y0V86r4F+IG1P4KgAfYCKr8PkSCB62cWxLQ32obAqVwFd1iwilT7H/JIsA
         5QrFPa9T+Yb2rWGxVY9GBAOKtwos0MP0RAYhnKu7CyDF/7E54js/cJqTSElHHhnlvPyy
         eHB2Ggn8A3L8mZQ3CY73FLicf0I0GBN0bQbsSk+j1/TBtZtCN9+pQqi8HTm4/wbb97Ch
         a6gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q+i8pxd4YQBsuXkEX/5Cfv4nKSJOhNUDp7tJMe/Gwzw=;
        b=eVdeqETVjd/gHkuqXBg3A7f17YV/QRD3QR82EpGek6dyREhoWlXBmTgkELRf1lzXdj
         B2+Sjo5EoIVjGitFKvxkxAm0Ek/Fdd2I3lPewWBFZAB5q/tuoLakKlZJnEEpzQ/EYnsQ
         A0QXGS5ndx7+QOGGikoLwxeXAX0QG7tf1QZbrp5IzuG97t2NkVk9BJK4UQ7mwGc2wweU
         53lBB+5GsGFqlSsTeo5Rklo8akuvHKDvsBVci+1UoZqbEWW1krNF814pYwhOEkE0lvjU
         kQO09zvwgPkIxFNkjmv7NAiecmxQqcNY0eyRVwji16wihs/5uP4x68FMpnor0Z94iCzb
         XCTQ==
X-Gm-Message-State: AOPr4FWR7Wx4sipdRGVA/clPyAu1kyUao8rwqt3+fay4On2lAlhrasczSF3EMtXR1uGnQA==
X-Received: by 10.194.20.193 with SMTP id p1mr31574767wje.87.1461533226810;
        Sun, 24 Apr 2016 14:27:06 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id w77sm15387563wmw.10.2016.04.24.14.27.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 24 Apr 2016 14:27:06 -0700 (PDT)
X-Mailer: git-send-email 2.1.3
In-Reply-To: <CA+P7+xqveyG7RTWb2k8UsFWRwjvM6JJkveRr3NV-bammqSkpkQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292445>

Any ACL you implement via an 'update' hook isn't actual access control
if the user has login access to the machine running git, because they
can trivially just built their own git version which doesn't run the
hook.

Change the documentation to take this dangerous edge case into account,
and remove the mention of the advice originating on the mailing list,
the users reading this don't care where the idea came up.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
> "by just using not executing the hook."

Yeah that made no sense. Fixed in this version.
 Documentation/githooks.txt | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 2f3caf7..86504ba 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -275,9 +275,13 @@ does not know the entire set of branches, so it wo=
uld end up
 firing one e-mail per ref when used naively, though.  The
 <<post-receive,'post-receive'>> hook is more suited to that.
=20
-Another use suggested on the mailing list is to use this hook to
-implement access control which is finer grained than the one
-based on filesystem group.
+Another use for this hook to implement access control which is finer
+grained than the one based on filesystem group. Note that if the user
+pushing has a normal login shell on the machine receiving the push
+implementing access control like this can be trivially bypassed by
+just not executing the hook. In those cases consider using
+e.g. linkgit:git-shell[1] as the login shell to restrict the user's
+access.
=20
 Both standard output and standard error output are forwarded to
 'git send-pack' on the other end, so you can simply `echo` messages
--=20
2.1.3
