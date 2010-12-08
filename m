From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/2] [RFD] Using gitrevisions :/search style with other operators
Date: Wed,  8 Dec 2010 21:58:37 +0700
Message-ID: <1291820319-12455-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Kevin Ballard <kevin@sb.org>, Yann Dirson <dirson@bertin.fr>,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 08 16:00:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQLUx-0003lY-J5
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 16:00:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755449Ab0LHO7p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Dec 2010 09:59:45 -0500
Received: from mail-iw0-f172.google.com ([209.85.214.172]:39265 "EHLO
	mail-iw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755444Ab0LHO7o (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Dec 2010 09:59:44 -0500
Received: by iwn40 with SMTP id 40so1747326iwn.3
        for <git@vger.kernel.org>; Wed, 08 Dec 2010 06:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=QscJwTzojfYqTQH2WziiOtN8AFX4/RF9bhBRZd5W8tE=;
        b=rDc2WR/iiHKJQIIp7QFD0l15C/CQ0rwSTgFsUH7Z1XW7wUkM07mYDTB5uUEIwdm+C2
         D7Nmf0JYlDZB1jlrg3G9Oal35QN4W/Fodye7UlHxZE5L7NxddWUd+DT5PTjWEf03dny7
         t53XAXEH0BBuY3A7jeYMTwGtSZ4zYQM1t+kk8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=huvC71dzh0iqojH84HKCaaIVMvWWL21RmH0zrCSasiPzi5w3c/MwgSGXkR5+uHOnIQ
         oOV5AwsKE4KMyaQm5yGRDnVqSx46rEMfqSLCXCU0Us7Y0qWHYU1i/mvLTIGRoEtCI8XD
         gXoFG/ReNmBKS8tB8CE8BhZ9Mohrgi1dMPOXk=
Received: by 10.231.31.1 with SMTP id w1mr9387678ibc.7.1291820383104;
        Wed, 08 Dec 2010 06:59:43 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.222.178])
        by mx.google.com with ESMTPS id gy41sm650101ibb.17.2010.12.08.06.59.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 08 Dec 2010 06:59:41 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 08 Dec 2010 21:58:46 +0700
X-Mailer: git-send-email 1.7.3.2.316.gda8b3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163195>

Let's start off from where the previous discussion [1] stopped. People
seem to agree ref^{/regex} is a good choice. But we have not come to
conclusion how to specify the count yet. Possible suggestions are

 - ref^{/foo}2
 - ref^{2/foo}
 - ref^{:2/foo}
 - ref^{2nd/foo}

=46or whatever syntax chosen, :/ should benefit too. I notice that :/!
is reserved for future use. Perhaps :/!2/regex is not too cryptic?

I'd also like to do case-insensitive regex, by the way. :/!2i/regex
looks a bit ugly.

[1] http://mid.gmane.org/9D675671-693D-4B59-AF2A-0EFE4C537362@sb.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (2):
  get_sha1_oneline: allow to input commit_list
  get_sha1: support ref^{/regex} syntax

 Documentation/revisions.txt |    7 ++++++
 sha1_name.c                 |   45 ++++++++++++++++++++++++++++++++---=
-------
 2 files changed, 41 insertions(+), 11 deletions(-)

--=20
1.7.3.2.316.gda8b3
