From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v1 0/3] dir.[ch]: remove PATH_MAX limitation
Date: Mon, 14 Jul 2014 11:43:15 +0200
Message-ID: <53C3A633.8050304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 14 11:43:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6cn8-0004oN-Pd
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jul 2014 11:43:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753855AbaGNJnW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Jul 2014 05:43:22 -0400
Received: from mail-wi0-f179.google.com ([209.85.212.179]:48825 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753830AbaGNJnV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2014 05:43:21 -0400
Received: by mail-wi0-f179.google.com with SMTP id f8so1275666wiw.12
        for <git@vger.kernel.org>; Mon, 14 Jul 2014 02:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=vMOVZhPA/mdBQIH2uQLxGLWhVUNcYvpy87oVSK391Lk=;
        b=OMTbdDGH2etG0WPD9+zm/4EU0YNabfONAczw+fSkDC1oP1XtlemX1O1JNKSYTdv0X4
         AdpC68E2ZDt7MvCVPg7G1WVXeQrhrmDVHlay1ONe4luaZJ1luwGJguRFiCUE3epw1qud
         Y0HGWnndHq+xhbMPmd77GWbd7A26pSy5fTFtJdKxY01e1PTC+pV7rdevj33A+xArw/OA
         zB/vFTwgeJykeHjjZ3IQBOtx4OTXw+j1FAw0ljwlMODx1ylZy5pb43cuzmf7MGf5brC+
         pOhnZvcy9LJxGd9AfakmcQF7sTPWbcoJTAZh1Ytp+RC+IqtPWdupv+XWpd68sZHCVkHP
         q8qw==
X-Received: by 10.194.77.177 with SMTP id t17mr17254175wjw.55.1405330997528;
        Mon, 14 Jul 2014 02:43:17 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id de6sm24352520wjc.16.2014.07.14.02.43.16
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 14 Jul 2014 02:43:16 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253479>

As discussed in [1], here's the first three patches of Duy's untracked=20
cache series, which fixes a segfault with long paths on Windows.

[1] http://article.gmane.org/gmane.comp.version-control.msysgit/20702

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (3):
  dir.c: coding style fix
  dir.h: move struct exclude declaration to top level
  prep_exclude: remove the artificial PATH_MAX limit

 dir.c | 59 ++++++++++++++++++++++++++++++++++-------------------------
 dir.h | 44 +++++++++++++++++++++++---------------------
 2 files changed, 57 insertions(+), 46 deletions(-)

--=20
2.0.0.9646.g840d1f9.dirty
