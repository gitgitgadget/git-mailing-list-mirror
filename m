From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [RESEND][PATCH 00/15] Towards a more awesome git branch
Date: Tue,  9 Jul 2013 16:02:11 +0530
Message-ID: <1373365946-9230-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 09 12:36:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwVHM-0006iG-1H
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 12:36:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753211Ab3GIKgM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Jul 2013 06:36:12 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:46886 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752673Ab3GIKgL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 06:36:11 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so5401448pbb.33
        for <git@vger.kernel.org>; Tue, 09 Jul 2013 03:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=VwJURLbSLiotpi0Og/feiV/piVmVA7o5bIWduzN1pKs=;
        b=05XwH3lUKvqXjJ1Gsy/ajevk2xCrPERI6fTMhg84ffh2ylJyHnuQfYBdPnGGYaOmMq
         iSOHnQEtTrSq93+Bl/uMz0XFYcfzrKZlLRKh9QGYYSdzXumYRe+kCUHLx0ADLbydKyR0
         vjyMW35bgkZh2GZnsoNhR4AnnoN/yfyhds1bqXfyCJR9VQqwy0IsW+rX91yCHeJhLR9P
         YCzojh7zhWkLQ8UWLw2zI57hyhF2VPNizQDoXeeMHkn/UEhJ0R91rXR3LGCySuPDziIC
         R3oQ1rXpfpCFymPkQ1mNbN+6bO3ThdXpVnJh3sGDe/EFVbecsTUNVNmxzVQ6IEYZ7Za+
         EQaw==
X-Received: by 10.66.2.164 with SMTP id 4mr27570661pav.55.1373366170997;
        Tue, 09 Jul 2013 03:36:10 -0700 (PDT)
Received: from localhost.localdomain ([122.174.59.189])
        by mx.google.com with ESMTPSA id fr1sm27553398pbb.26.2013.07.09.03.36.08
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 09 Jul 2013 03:36:10 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2.736.g869de25
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229928>

Hi,

I'm sending this out in the hope of attracting some reviews.  It's an
unedited resend, and there were zero conflicts from the rebase.

Thanks.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (8):
  for-each-ref, quote: convert *_quote_print -> *_quote_buf
  for-each-ref: don't print out elements directly
  pretty: extend pretty_print_context with callback
  pretty: allow passing NULL commit to format_commit_message()
  for-each-ref: get --pretty using format_commit_message()
  for-each-ref: teach verify_format() about pretty's syntax
  for-each-ref: introduce format specifier %>(*) and %<(*)
  for-each-ref: improve responsiveness of %(upstream:track)

Ramkumar Ramachandra (7):
  tar-tree: remove dependency on sq_quote_print()
  quote: remove sq_quote_print()
  pretty: limit recursion in format_commit_one()
  for-each-ref: introduce %(HEAD) marker
  for-each-ref: introduce %(upstream:track[short])
  pretty: introduce get_pretty_userformat
  for-each-ref: use get_pretty_userformat in --pretty

 Documentation/git-for-each-ref.txt |  43 +++++-
 builtin/for-each-ref.c             | 279 +++++++++++++++++++++++++++++=
+-------
 builtin/tar-tree.c                 |  11 +-
 commit.h                           |   9 ++
 pretty.c                           |  77 +++++++++-
 quote.c                            |  61 +++-----
 quote.h                            |   8 +-
 t/t6300-for-each-ref.sh            | 143 +++++++++++++++++++
 8 files changed, 521 insertions(+), 110 deletions(-)

--=20
1.8.3.2.736.g869de25
