From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: "git stash list" shows HEAD reflog
Date: Sat, 13 Mar 2010 23:07:45 +0100
Message-ID: <4B9C0CB1.3000308@lsrfire.ath.cx>
References: <op.u9gl97fstuzx1w@cybershadow.mshome.net> <4B9BCD6E.4090902@lsrfire.ath.cx> <4B9C0713.30407@pcharlan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Vladimir Panteleev <vladimir@thecybershadow.net>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Pete Harlan <pgit@pcharlan.com>
X-From: git-owner@vger.kernel.org Sat Mar 13 23:07:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NqZUv-000742-Tl
	for gcvg-git-2@lo.gmane.org; Sat, 13 Mar 2010 23:07:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759339Ab0CMWHt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Mar 2010 17:07:49 -0500
Received: from india601.server4you.de ([85.25.151.105]:47380 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754530Ab0CMWHs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Mar 2010 17:07:48 -0500
Received: from [10.0.1.100] (p57B7E76C.dip.t-dialin.net [87.183.231.108])
	by india601.server4you.de (Postfix) with ESMTPSA id C49702F8045;
	Sat, 13 Mar 2010 23:07:46 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.1.8) Gecko/20100227 Thunderbird/3.0.3
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <4B9C0713.30407@pcharlan.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142115>

Am 13.03.2010 22:43, schrieb Pete Harlan:
> On 03/13/2010 09:37 AM, Ren=C3=A9 Scharfe wrote:
>> As Vladimir reported, "git log -g refs/stash" surprisingly showed th=
e reflog
>> of HEAD if the message in the reflog file was too long.  To fix this=
, convert
>> for_each_recent_reflog_ent() to use strbuf_getwholeline() instead of=
 fgets(),
>> for safety and to avoid any size limits for reflog entries.
>=20
> Was the old code actually unsafe?  If not, then perhaps the commit
> message would be clearer if ", for safety and" were removed.

The function silently dropped valid (if long) reflog entries on the
floor.  It's certainly debatable if not doing so is "safer" or merely
"more complete".  The sentence is already long enough in any case, so I
don't mind dropping this part.

Ren=C3=A9
