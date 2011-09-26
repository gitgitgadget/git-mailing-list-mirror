From: Roy Liu <carsomyr@gmail.com>
Subject: [PATCH] git-submodule: a small fix
Date: Mon, 26 Sep 2011 18:00:21 -0400
Message-ID: <CAOOg04z0UjOQCBMTuii37y3ykNU17hDTcD9E81C+r1whFpMaCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 27 00:00:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8JE5-0001I6-EW
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 00:00:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752257Ab1IZWAY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Sep 2011 18:00:24 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:46174 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750741Ab1IZWAV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Sep 2011 18:00:21 -0400
Received: by gyg10 with SMTP id 10so4569888gyg.19
        for <git@vger.kernel.org>; Mon, 26 Sep 2011 15:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=n0kXMv19IBHOPywMqj/BnMHq/M9WfWCFvjYfzhqypS8=;
        b=sE+brYWpcAthYFC6RLDK6FulCD7CBzwP+gXm029zl5clGm+LohfkafQVuKFEay/U6p
         9/XjRCPK1PWLgdGLbD0lSlll9+sPkXBLBEbY2pwT+DECw/EwU4b8+z4UfxgPdgJRyL0I
         4Z5CXe2hoNhQtRKHFg9R7cH6mZ7KOB48BJouw=
Received: by 10.151.14.8 with SMTP id r8mr5568737ybi.131.1317074421214; Mon,
 26 Sep 2011 15:00:21 -0700 (PDT)
Received: by 10.150.205.11 with HTTP; Mon, 26 Sep 2011 15:00:21 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182173>

In git-submodule.sh, the "url" variable may contain a stale value from
the previous loop iteration, so clear it.

--- git-submodule.sh.orig =A0 2011-09-26 17:50:45.000000000 -0400
+++ git-submodule.sh =A0 =A02011-09-26 17:51:18.000000000 -0400
@@ -370,6 +370,8 @@
=A0 =A0 =A0 =A0 =A0 =A0esac
=A0 =A0 =A0 =A0 =A0 =A0git config submodule."$name".url "$url" ||
=A0 =A0 =A0 =A0 =A0 =A0die "Failed to register url for submodule path '=
$path'"
+ =A0 =A0 =A0 =A0else
+ =A0 =A0 =A0 =A0 =A0 =A0url=3D""
=A0 =A0 =A0 =A0fi

=A0 =A0 =A0 =A0# Copy "update" setting when it is not set yet
