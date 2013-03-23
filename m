From: =?ISO-8859-1?Q?Sebastian_G=F6tte?= <jaseg@physik.tu-berlin.de>
Subject: [PATCH v2 0/4] Verify GPG signatures when merging and extend %G?
 pretty string
Date: Sat, 23 Mar 2013 02:57:37 +0100
Message-ID: <514D0C11.1080905@physik.tu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 23 02:58:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJDix-0004pW-5R
	for gcvg-git-2@plane.gmane.org; Sat, 23 Mar 2013 02:58:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423044Ab3CWB5n convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Mar 2013 21:57:43 -0400
Received: from mail.tu-berlin.de ([130.149.7.33]:26818 "EHLO mail.tu-berlin.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423010Ab3CWB5n (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 21:57:43 -0400
X-tubIT-Incoming-IP: 130.149.58.163
Received: from mail.physik-pool.tu-berlin.de ([130.149.58.163] helo=mail.physik.tu-berlin.de)
	by mail.tu-berlin.de (exim-4.75/mailfrontend-3) with esmtp 
	id 1UJDiH-0005Qr-G3; Sat, 23 Mar 2013 02:57:42 +0100
Received: from [192.168.0.103] (cable-124-189.zeelandnet.nl [82.176.124.189])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.physik.tu-berlin.de (Postfix) with ESMTPSA id 9838311401;
	Sat, 23 Mar 2013 02:57:38 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130221 Thunderbird/17.0.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218873>

As suggested by Junio I split the preivous patch into four parts.

Sebastian G=F6tte (4):
  Move commit GPG signature verification to commit.c
  merge/pull: verify GPG signatures of commits being merged
  merge/pull Check for untrusted good GPG signatures
  pretty printing: extend %G? to include 'N' and 'U'

 Documentation/merge-options.txt    |   4 +++
 Documentation/pretty-formats.txt   |   3 +-
 builtin/merge.c                    |  33 +++++++++++++++++-
 commit.c                           |  55 +++++++++++++++++++++++++++++
 commit.h                           |   9 +++++
 git-pull.sh                        |  10 ++++--
 gpg-interface.h                    |   6 ++++
 pretty.c                           |  69 ++++-------------------------=
--------
 t/lib-gpg/pubring.gpg              | Bin 1164 -> 2359 bytes
 t/lib-gpg/random_seed              | Bin 600 -> 600 bytes
 t/lib-gpg/secring.gpg              | Bin 1237 -> 3734 bytes
 t/lib-gpg/trustdb.gpg              | Bin 1280 -> 1360 bytes
 t/t7612-merge-verify-signatures.sh |  61 +++++++++++++++++++++++++++++=
+++
 13 files changed, 184 insertions(+), 66 deletions(-)
 create mode 100755 t/t7612-merge-verify-signatures.sh

--=20
1.8.1.5
