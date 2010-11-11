From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/3] Support relative path in <blah>:path syntax
Date: Thu, 11 Nov 2010 21:08:01 +0700
Message-ID: <1289484484-8632-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>,
	Matthieu.Moy@grenoble-inp.fr
X-From: git-owner@vger.kernel.org Thu Nov 11 15:09:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGXqL-0001MM-Q9
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 15:09:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755247Ab0KKOJ3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Nov 2010 09:09:29 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:36457 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754925Ab0KKOJ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 09:09:28 -0500
Received: by pwi9 with SMTP id 9so183790pwi.19
        for <git@vger.kernel.org>; Thu, 11 Nov 2010 06:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=6+scTh39EKvceLAeYy2lu4zUA1hcCZXTkIzwa6LNKAA=;
        b=Z/p6G0h75CsUai6th+4hR9ktnjSln51tnVcgCHov/tT6pnRqeeTx9NJNG57ttmQunD
         frgxqVvu+TKZHuLbCjmKTZ+KDkD2T7BXXzCAUlnu2qjOzCELe5Wu+Yl7co244AJ6c3fp
         4g9Ot5jCRth+Yx3fcJlGBb65h84OGl4QvEJ2g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=IAvk+K65cW9pGuYzEVOv7l7Wwj+CuCFGB+bHPzDcPPK2f41BfL9QNbKN02LTQZAtCh
         5KpacZlxKuiToN77cLAE+Oh+hmNOuhOm6tkCAiL4Rtes8rvoOK2jhn+jVOHDPuubYfHi
         RbMWUfN+2hx4SyngGU8I7eRuYha0jmewDAxT8=
Received: by 10.142.82.8 with SMTP id f8mr538443wfb.317.1289484568107;
        Thu, 11 Nov 2010 06:09:28 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.247.75])
        by mx.google.com with ESMTPS id e14sm2408904wfg.8.2010.11.11.06.09.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Nov 2010 06:09:26 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 11 Nov 2010 21:08:04 +0700
X-Mailer: git-send-email 1.7.3.2.210.g045198
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161250>

Sorry Jonathan I lied. I did not pick up your fast-import changes.
Could not find how to test it. And it seems fast-import only cares
about commits, not the target audience of this syntax.

Document is not updated because I think it's intuitive enough.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (3):
  setup: save prefix (original cwd relative to toplevel) in
    startup_info
  Make prefix_path() return char* without const
  get_sha1: support relative path ":path" syntax

 cache.h                        |    3 +-
 setup.c                        |    6 ++-
 sha1_name.c                    |   37 ++++++++++++++++++++++--
 t/t1506-rev-parse-diagnosis.sh |   62 ++++++++++++++++++++++++++++++++=
++++++++
 4 files changed, 102 insertions(+), 6 deletions(-)

--=20
1.7.3.2.210.g045198
