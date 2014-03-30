From: Marat Radchenko <marat@slonopotamus.org>
Subject: [PATCH v4 0/3] Take four on fixing OPT_SET_PTR issues
Date: Sun, 30 Mar 2014 15:08:20 +0400
Message-ID: <cover.1396177207.git.marat@slonopotamus.org>
References: <7vtxago359.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marat Radchenko <marat@slonopotamus.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 30 13:08:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUDbf-0001sF-2k
	for gcvg-git-2@plane.gmane.org; Sun, 30 Mar 2014 13:08:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753208AbaC3LIn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Mar 2014 07:08:43 -0400
Received: from seldon.slonopotamus.org ([94.242.204.247]:46963 "EHLO
	slonopotamus.org" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1752834AbaC3LIm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Mar 2014 07:08:42 -0400
Received: from [176.57.72.72] (helo=noblesse.home.ru)
	by slonopotamus.org with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1WUDbO-0000Hw-UF; Sun, 30 Mar 2014 15:08:35 +0400
X-Mailer: git-send-email 1.9.0
In-Reply-To: <7vtxago359.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245459>

Patches summary:
1. Fix initial issue (incorrect cast causing crash on 64-bit MSVC)
2. Improve OPT_SET_PTR to prevent same errors in future
3. Purge OPT_SET_PTR away since nobody uses it

*Optional* patch =E2=84=963 is separated from =E2=84=961 and =E2=84=962=
 so that if someone someday
decides to return OPT_SET_PTR back by reverting =E2=84=963, it will be =
returned
in a sane state.

Decision of (not) merging =E2=84=963 is left as an exercise to the read=
er due to
my insufficient knowledge of accepted practices in Git project.

Marat Radchenko (3):
  MSVC: fix t0040-parse-options crash
  parse-options: add cast to correct pointer type to OPT_SET_PTR
  parse-options: remove unused OPT_SET_PTR

 Documentation/technical/api-parse-options.txt | 4 ----
 parse-options.c                               | 5 -----
 parse-options.h                               | 5 +----
 t/t0040-parse-options.sh                      | 7 +++----
 test-parse-options.c                          | 2 --
 5 files changed, 4 insertions(+), 19 deletions(-)

--=20
1.9.0
