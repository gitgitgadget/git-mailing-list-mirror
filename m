From: "=?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?=" 
	<felipeg.assis@gmail.com>
Subject: [PATCH v3 0/2] merge-recursive: option to disable renames
Date: Tue, 16 Feb 2016 23:11:33 -0200
Message-ID: <1455671495-10908-1-git-send-email-felipegassis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes.Schindelin@gmx.de, gitster@pobox.com,
	=?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?= 
	<felipegassis@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 17 02:13:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVqgB-0004ZZ-QN
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 02:13:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964829AbcBQBNQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Feb 2016 20:13:16 -0500
Received: from mail-qg0-f48.google.com ([209.85.192.48]:33868 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964793AbcBQBNP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 20:13:15 -0500
Received: by mail-qg0-f48.google.com with SMTP id b67so1383896qgb.1
        for <git@vger.kernel.org>; Tue, 16 Feb 2016 17:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=PRfBCP2IjaZXiVCtQ9H65jkiSPdQuS3rmEdiOqEXC7M=;
        b=M0Scs05YR18KX3osc6mReyu4DmdgMgEqTsBRiPSkUQS+NzcQJXLP2mmw8s4rrSabTi
         CHmelwiTfTezsYWnE0Dm3hR8BjYQm1XuYgzZGX7oSSXgeCMbto7bt8a92AXTpdqJxiIH
         PCEpdJUXmf5A6IbWN06HYvPkcKVYLDZJuBzS9hXdTQT4MODRoUV4rfLJ2WMQosRlAzBT
         tZI5Y80qq5t5zcNr+uvT/5sHZrz86i6uhjGDufYWBOXt8U4S3ywK1rQbktl39NWjW5KG
         gYHpFjtcuWhh6jnND1yuB28ZqfEC8eMNtZlf7HE2hmLJPu4Yi8dX54Uujc+PEL429hfq
         z68w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=PRfBCP2IjaZXiVCtQ9H65jkiSPdQuS3rmEdiOqEXC7M=;
        b=ZfcM6ebAqbF6Ypye6qbaRQHCyiDbSTUl/TIdhSlNEbVTb1lpn7eK7aziRiqD+4VZ6I
         sQ1U7tCKJ5rKfc8ZSULqWPyLMDNMomiCy/A+Q6wa/VZPIK/oF5W0M18RpEC0J6sYujOX
         MiGyI3L1g6BnoBaPp0qdASBYmseY1otqMh42+bZxpdjoTYKQXmjBEvYwzypVmHij5G4h
         m+bWWYnHjHXNMOuKGImMRFjb/gHtyn/VBc2rJuUVu2NTutCEcPL3voo0HnxQGk2ceJl0
         TuLKLxJcYAR662IGD0YocdY6walUS3MBerKJM4VdstRf3oZktmrhCJ/87tiT5qR3kaGQ
         2iOg==
X-Gm-Message-State: AG10YOQlDo84o1yi1c78C+MA/nUevJMI6JuoJ6xvtwa0B6SlAv1jz3J99N17ZTeMf1x+dQ==
X-Received: by 10.140.133.133 with SMTP id 127mr32857665qhf.42.1455671594411;
        Tue, 16 Feb 2016 17:13:14 -0800 (PST)
Received: from traveller.moon ([187.34.45.132])
        by smtp.gmail.com with ESMTPSA id a88sm14361238qkj.32.2016.02.16.17.13.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Feb 2016 17:13:13 -0800 (PST)
X-Google-Original-From: =?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?= <felipegassis@gmail.com>
X-Mailer: git-send-email 2.7.1.288.gfad33a8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286469>

No more renames option. rename-threshold enables renames.

detect_rename is now a simple boolean. Its value is no longer linked to
DIFF_ANYTHING symbol.

A second optional patch is included, teaching merge-recursive to take
"find-renames[=3D<n>]" as well, for consistency.

=46elipe Gon=C3=A7alves Assis (2):
  merge-recursive: option to disable renames
  merge-recursive: more consistent interface

 Documentation/merge-strategies.txt | 14 ++++++++++++--
 merge-recursive.c                  | 12 +++++++++++-
 merge-recursive.h                  |  1 +
 3 files changed, 24 insertions(+), 3 deletions(-)

--=20
2.7.1.288.gfad33a8
