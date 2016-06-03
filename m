From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 0/3] Better ref summary alignment in "git fetch"
Date: Fri,  3 Jun 2016 18:08:40 +0700
Message-ID: <20160603110843.15434-1-pclouds@gmail.com>
References: <20160522112019.26516-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 03 13:09:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8myY-0006aD-2p
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 13:09:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932645AbcFCLI4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Jun 2016 07:08:56 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:32898 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932232AbcFCLIy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 07:08:54 -0400
Received: by mail-pa0-f50.google.com with SMTP id ec8so8050823pac.0
        for <git@vger.kernel.org>; Fri, 03 Jun 2016 04:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J7QLNfzSBFflE6em7hGP3iphZb5dtdQM20Ivtth8Jyk=;
        b=kGwvuTMNJt6E2bZ0jG4PDlD6VMSXMHGmq49NX+l6bkVmi8Mc0vOn/w1AOGzqQfMwVW
         TcsNPkMqoZ+fSxev34ZHohhBNzBfHpjG3ewI508VTUAofJrNuzdFbXkvB/o2MSzByOY5
         qLpGuuCvPBcEKeFCg2JZ6BiIIambYiH3LCoM30hvajmPLXdHmLSGi3HiUGDETbonq9eT
         PofAsaugzmVx/mEgpomxb2X5zeQbNcXffPCPMS1V6NgtHhvDZJXmYnUHmEQI7ffNexUf
         XEHb7rvGt7oJNHN2KYXMCIoWrEUK8hU8fPXZHUrIOqpuV0qC/Y02hrwBapMBpjKXp0sw
         ggQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J7QLNfzSBFflE6em7hGP3iphZb5dtdQM20Ivtth8Jyk=;
        b=AGbEH/6Gwx1f5MbEhqkTqw54ZYrqiLJgP2riV9gPYi7ZUk7wlXaNt+nNWMw04WbqhV
         t1qR/xpI6tNb9AaLrhhiUWQJY+GyrxFlefmgRwmJykZXR+J7NT3ahrwbLsM0XYbpNM3B
         J/Jmx82WD6lHn56HBwVSF4DjxiLvBE1NEACBXkGEXrQIO0jod7Xp9q3GYt51szH6uJqr
         FS8vVI5hlRBYIwXkTrK90HHnZ7rQmUYd7QkNU4mJdcXzqIbXZ4M5bqLVyR5Xk5UObmQt
         /RYPUDB1qpzX3kIwYMukUeo/Cwo4ZzzTEWjPn5EagsEwoDeEDmWbnGeiKPo5+iQCIvxw
         K1PA==
X-Gm-Message-State: ALyK8tKPneiGxX8GpluHB9xBrpInHfG3bfcUEZo1bben/DwvTJrTr67Ts2k8PR/NMVh3Xw==
X-Received: by 10.66.132.11 with SMTP id oq11mr4601587pab.59.1464952133590;
        Fri, 03 Jun 2016 04:08:53 -0700 (PDT)
Received: from ash ([171.232.119.25])
        by smtp.gmail.com with ESMTPSA id o87sm7560150pfa.75.2016.06.03.04.08.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Jun 2016 04:08:52 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Fri, 03 Jun 2016 18:08:48 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160522112019.26516-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296297>

v2 reformats "abc/common -> def/common" to "{abc -> def}/common"
instead and fall back to "a -> b" when they have nothing in commmon
(e.g. "HEAD -> FETCH_HEAD"). We could add an option if a user wants to
stick with "a -> b" (and we could do some alignment there as well) but
it's not part of this series.

It's a shame that the flag '-' in these ref update lines is not the
same in fetch and push (see 1/3). Because git-fetch does not support
--porcelain option, maybe it's not too late to change its meaning... =20

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (3):
  git-fetch.txt: document fetch output
  fetch: refactor ref update status formatting code
  fetch: reduce duplicate in ref update status lines

 Documentation/git-fetch.txt |  53 +++++++++++++++++++++
 builtin/fetch.c             | 112 +++++++++++++++++++++++++++++-------=
--------
 t/t5510-fetch.sh            |   4 +-
 t/t5526-fetch-submodules.sh |  26 +++++-----
 4 files changed, 141 insertions(+), 54 deletions(-)

--=20
2.8.2.524.g6ff3d78
