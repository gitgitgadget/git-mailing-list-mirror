From: Jon Seymour <jon.seymour@gmail.com>
Subject: RFC: what should git rev-parse --flags HEAD do?
Date: Sat, 25 Sep 2010 20:11:19 +1000
Message-ID: <AANLkTimEToibgpUS1KTSruFRdggi3kbAJU5tfk9r6d2U@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	Brandon Casey <drafnel@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 25 12:16:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzRnl-0004Zk-TI
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 12:16:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755666Ab0IYKLU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Sep 2010 06:11:20 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:49250 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755486Ab0IYKLU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Sep 2010 06:11:20 -0400
Received: by qyk33 with SMTP id 33so5162796qyk.19
        for <git@vger.kernel.org>; Sat, 25 Sep 2010 03:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=7+CutJ0iXkoAcYCwWKanooZbyHwVPb2Mo5nnA3zi54s=;
        b=DSORPHDtjy18NERtIu0g32MxHqQUx1e4ukV3H8+BOGEsT5whZZuKdc41ZW41kaBmBs
         229jEHxuJn6pa9aMzxQtynCINBV9HwEL+0rVqMGNqTSzwp+Jq2Ezynv9IKDyQtLOWt9D
         0zQ3EUJxIErzz0PHJkYiH7d6wyVDdYBm0Tyio=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=s/VI6gdOMaQSf0wJvUimppU1D7XdJ49ywLEp3st2ClOsWhTIaO3EIpAyDpk6CdhQe9
         gD3/jKH3KWH39q4YM2dXZ4ybDxlDcCTGefw7nQtKVroORhKBrLz/9rxGtfhVLTjwback
         fVCuItf10smY55/10tDMbKWpBtVRwPx6chUBA=
Received: by 10.229.247.16 with SMTP id ma16mr3431158qcb.90.1285409479489;
 Sat, 25 Sep 2010 03:11:19 -0700 (PDT)
Received: by 10.229.219.196 with HTTP; Sat, 25 Sep 2010 03:11:19 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157140>

The documentation for git rev-parse --flags currently states:

    Do not output non-flag parameters.

Therefore, one might expect:
  $ git rev-parse --flags HEAD

to produce no output.

In fact, it outputs the sha1 hash of HEAD.

Can anyone see a reason why git rev-parse --flags should not be
modified to match the documentation?

If there is agreement that this should change, I can re-roll my
current rev-parse series to include such a change.

jon.
