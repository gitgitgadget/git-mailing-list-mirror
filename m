From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 0/6] Better ref summary alignment in "git fetch"
Date: Sun,  5 Jun 2016 10:11:35 +0700
Message-ID: <20160605031141.23513-1-pclouds@gmail.com>
References: <20160603110843.15434-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	marcnarc@xiplink.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 05 05:12:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9OU1-0004PM-Gf
	for gcvg-git-2@plane.gmane.org; Sun, 05 Jun 2016 05:12:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370AbcFEDL4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Jun 2016 23:11:56 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36295 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751325AbcFEDLz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Jun 2016 23:11:55 -0400
Received: by mail-pf0-f196.google.com with SMTP id 62so15001507pfd.3
        for <git@vger.kernel.org>; Sat, 04 Jun 2016 20:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1VqokyqTBJd9iUhxGTB+7XNPctQJxiHX2uYvVs8lLGE=;
        b=ilEshunF+VeFUJBhUzrl1Cff6Hj3xh1wf1KQmJLm+wdQb87lShRiENx8OBiY9T4ZAh
         BFxd6IuLgTCMy/AEXr4WsBSHYZL8xEA6tjowDQ7mxuq0FudmmOMGHlUMqcMaDWqVMjbS
         AYGHtIUFUwsMdTAZEohojfmFy1pzVEZeeohcaPkLTtaoqe5kZKlzhv7qgdNv/hl022Gw
         ZqGvbBPD7YVwaLnBxF492p49KVZI2A+SywpZb/GeATlLxTwAwwq4e9P26o9m2feTRtpT
         MZWXmW2Thakwffa2P9rBpya7bICDoX6GW29tBaiLXwwRimP9yTt3hVmg4as1LDzDvuei
         G+Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1VqokyqTBJd9iUhxGTB+7XNPctQJxiHX2uYvVs8lLGE=;
        b=RwhnzwSnBO1M4dZLLfeKHwaEvIJrPDl9+PY/B/vJDgrQ5p/p02RlkEtrYAbUdE6oeL
         c1EEEFQEjimbpomZU/oq20ieKdcDJL00pAscF7TDNgw0XRyaLa7O+2eTo5xyhfuzw/2G
         Tqbugk6sD2zcFxdnso1Bo2tswfmWr+uHsQiwp0wXhNklgAltC5UVpqjQIR+W0pJqGLJL
         /hSRDcCJuCmQJEzJRj37wDW1uAs/2idYN0AVtN9gALJVIo0tX06OQuXRXCfK3JuaCrfO
         jvI8qo91ddDGFduervvLZ75FVn/b+3Gtpv3q3G9i0vJ2zAXP+rlaefZVIzY4v8J0frv+
         zhNQ==
X-Gm-Message-State: ALyK8tIy+WmA8E8FJoxvFnZDwyH2Ap326M6GLHrsP9hdyUwUn6N3ADIy00QLKSTh6EBcKA==
X-Received: by 10.98.89.213 with SMTP id k82mr16277635pfj.99.1465096314575;
        Sat, 04 Jun 2016 20:11:54 -0700 (PDT)
Received: from ash ([115.76.150.26])
        by smtp.gmail.com with ESMTPSA id ez6sm15648573pab.12.2016.06.04.20.11.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Jun 2016 20:11:53 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 05 Jun 2016 10:11:49 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160603110843.15434-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296451>

This is so people can play with new output format... v3 adds one extra
pass to calculate width (4/6) and swap flag code 'x' and '-' with '-'
and 't' to align with push flag code (3/6). These are definitely good
improvements.

5/6 and 6/6 add two new formats "{ -> origin}/abc" and "abc -> origin/$=
".
=46ormat output is selected by config key fetch.output. I'm tempted to
replace '$' with '&' as it usually means "what was matched" in s///

I don't think we'll want both new formats in the end. One of them (or
a new format) will win as the optional format. The aligned "remote ->
local" should stay default format. And later on we could break lines
at "->" for very long lines as Marc suggested.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (6):
  git-fetch.txt: document fetch output
  fetch: refactor ref update status formatting code
  fetch: change flag code for displaying tag update and deleted ref
  fetch: align all "remote -> local" output
  fetch: reduce duplicate in ref update status lines with { -> }
  fetch: reduce duplicate in ref update status lines with placeholder

 Documentation/config.txt    |   4 +
 Documentation/git-fetch.txt |  54 ++++++++++
 builtin/fetch.c             | 233 ++++++++++++++++++++++++++++++++++++=
--------
 3 files changed, 251 insertions(+), 40 deletions(-)

--=20
2.8.2.524.g6ff3d78
