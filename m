From: Ivan Chernyavsky <camposer@yandex.ru>
Subject: Re: Which branch(es) contain certain commits? (was Re: (unknown))
Date: Sat, 22 Aug 2015 13:32:35 +0300
Message-ID: <1097541440239555@web20h.yandex.ru>
References: <349031438778845@web22j.yandex.ru>
	<CACsJy8Be-kY49CxAJTx2R2XG-c_WeuU=yLFT8-XSoaDkTScPGg@mail.gmail.com>
	<xmqqh9nxerfv.fsf@gitster.dls.corp.google.com>
	<5570041440192599@web21j.yandex.ru> <xmqqio88466l.fsf@gitster.dls.corp.google.com> <2689531440235153@web22m.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 22 12:39:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZT6DA-0003nG-OY
	for gcvg-git-2@plane.gmane.org; Sat, 22 Aug 2015 12:39:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753442AbbHVKj0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 22 Aug 2015 06:39:26 -0400
Received: from forward5h.mail.yandex.net ([84.201.186.23]:37583 "EHLO
	forward5h.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753405AbbHVKjZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Aug 2015 06:39:25 -0400
X-Greylist: delayed 406 seconds by postgrey-1.27 at vger.kernel.org; Sat, 22 Aug 2015 06:39:25 EDT
Received: from web20h.yandex.ru (web20h.yandex.ru [IPv6:2a02:6b8:0:f05::30])
	by forward5h.mail.yandex.net (Yandex) with ESMTP id CD40DD00F96;
	Sat, 22 Aug 2015 13:32:36 +0300 (MSK)
Received: from 127.0.0.1 (localhost [127.0.0.1])
	by web20h.yandex.ru (Yandex) with ESMTP id F113813211D3;
	Sat, 22 Aug 2015 13:32:35 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1440239556; bh=QQJsxRxTDgyjrQIi6p1sokMnp2s5abZa+nIKNg6Edhk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=HwQU1hFLkhQb5GGerysH8znxNUOLYRUj5qkcYfJJWvEY0I5FbIYGZl4xD/9X8e5jp
	 g+/dZU7+zTLuduyewhK0eDksfOEJv8/k3FZJCOkZcdge6VcWyKOvg9zCy+hW64K65u
	 rSuZIV1RdNRE/7rxBa/zggTC0wFCzB9bzKCs8Oag=
Received: by web20h.yandex.ru with HTTP;
	Sat, 22 Aug 2015 13:32:35 +0300
In-Reply-To: <2689531440235153@web22m.yandex.ru>
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276387>



22.08.2015, 12:19, "Ivan Chernyavsky" <camposer@yandex.ru>:
> =9A=9AOne thing I'm worried about is that git-branch already has opti=
on --all. So we'll get a semantics conflict with setup_revisions() ("al=
l branches" vs "all refs"). This will have to be treated carefully, e.g=
=2E retrace and fix effects of --all after setup_revisions() to include=
 just branches but not other refs. Will such mangling be ok? Or could I=
 prepare the call of setup_revisions() in a way that only branches will=
 be included by --all? Anyway the semantics of --all will be different =
for git-branch and git-rev-list, but I believe more important is to kee=
p it unchanged for git-branch.
>

Please disregard this part. I should just gobble --all with the existin=
g parse_options() and do not provide it to setup_revisions() altogether=
=2E

--=20
  Ivan
