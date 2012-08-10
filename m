From: Sven Strickroth <sven.strickroth@tu-clausthal.de>
Subject: git archive --format zip utf-8 issues
Date: Fri, 10 Aug 2012 23:58:12 +0200
Message-ID: <502583F4.8030308@tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 11 00:17:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzxVy-00077X-4v
	for gcvg-git-2@plane.gmane.org; Sat, 11 Aug 2012 00:17:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760132Ab2HJWQz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Aug 2012 18:16:55 -0400
Received: from mailrelay1.rz.tu-clausthal.de ([139.174.2.42]:24670 "EHLO
	mailrelay1.rz.tu-clausthal.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755194Ab2HJWQq (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Aug 2012 18:16:46 -0400
X-Greylist: delayed 1113 seconds by postgrey-1.27 at vger.kernel.org; Fri, 10 Aug 2012 18:16:46 EDT
Received: from hades.rz.tu-clausthal.de (mailrelay1.rz.tu-clausthal.de [139.174.2.42])
	by mailrelay1.rz.tu-clausthal.de (Postfix) with ESMTP id F10B442D985
	for <git@vger.kernel.org>; Fri, 10 Aug 2012 23:58:11 +0200 (CEST)
Received: from hades.rz.tu-clausthal.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id C8D98422169
	for <git@vger.kernel.org>; Fri, 10 Aug 2012 23:58:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:subject:content-type
	:content-transfer-encoding; s=dkim1; bh=UAOLiAt5tlRh8XxXMCOrt+Jx
	Fjw=; b=jOufqFMFynjQmKoOZz0yNx/cJMJmyWuozVF8dWttRcTalRIs266Dxpm+
	ghW+VoRTjY6n/QjqRkaqVRfBFU9FDgNz78VgRzpkIotJyyB34qgfDVK7siSjs0B9
	udfCnMM0U4QM21UFZr841vJ7Gt+8QUEzvzzveL5SZkiXTx9BAX0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:subject:content-type
	:content-transfer-encoding; q=dns; s=dkim1; b=6LOMY0kDwyXwzlKjVD
	+xLi1t79eMGxSUZYPWvqeBwe9119tJK+z93QpvBTL/8idAeFPv3PgffP6Ra6YAZL
	aZI1WjNoMI1IkmugDCfC+NFN9sVshI5tch81SRG49I4r1kmqRjBMDXZOzHUid3wB
	HL+ahbCE76+kBgMcUY6IKv1po=
Received: from tu-clausthal.de (hathor.rz.tu-clausthal.de [139.174.2.1])
	by hades.rz.tu-clausthal.de (Postfix) with ESMTP id 0530F422155
	for <git@vger.kernel.org>; Fri, 10 Aug 2012 23:58:11 +0200 (CEST)
Received: from [91.3.168.40] (account sstri@tu-clausthal.de HELO [192.168.178.20])
  by tu-clausthal.de (CommuniGate Pro SMTP 5.4.6)
  with ESMTPSA id 36105157 for git@vger.kernel.org; Fri, 10 Aug 2012 23:58:10 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:14.0) Gecko/20120713 Thunderbird/14.0
X-Enigmail-Version: 1.4.3
X-Virus-Scanned: by Sophos PureMessage V5.6 at tu-clausthal.de
X-Spam-Level: (10%, '
 TO_IN_SUBJECT 0.5, HTML_00_01 0.05, HTML_00_10 0.05, BODYTEXTP_SIZE_3000_LESS 0, BODY_SIZE_1000_LESS 0, BODY_SIZE_2000_LESS 0, BODY_SIZE_5000_LESS 0, BODY_SIZE_600_699 0, BODY_SIZE_7000_LESS 0, NO_URI_FOUND 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __FRAUD_CONTACT_NAME 0, __HAS_FROM 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __MOZILLA_MSGID 0, __SANE_MSGID 0, __SUBJ_ALPHA_END 0, __SUBJ_ALPHA_START 0, __SUBJ_ALPHA_START_END 0, __TO_MALFORMED_2 0, __TO_NO_NAME 0, __USER_AGENT 0')
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203272>

Hi,

when I create a git repository, add a file containing utf-8 characters
or umlauts (like =F6=E4=FC.txt), commit and then export the HEAD revisi=
on to a
zip archive using "git archive --format zip -o 1.zip HEAD", the zip fil=
e
contains incorrect filenames:

$ unzip -l 1.zip
Archive:  1.zip
4490a6dab1df5404f91ab3eb871f133154bff0bf
  Length      Date    Time    Name
---------  ---------- -----   ----
        6  2012-08-10 23:41   +?+?++.txt
---------                     -------
        6                     1 file
--=20
Best regards,
 Sven Strickroth
 PGP key id F5A9D4C4 @ any key-server
