From: =?ISO-8859-1?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
Subject: Re: How to make git diff-* ignore some patterns?
Date: Sun, 22 Nov 2009 16:51:49 +0100
Message-ID: <4B095E15.9040209@dirk.my1.cc>
References: <4B0817EE.1040000@dirk.my1.cc> <20091121180738.GA14919@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>, git@drmicha.warpmail.net
To: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Sun Nov 22 16:51:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCEjG-0008Dr-O1
	for gcvg-git-2@lo.gmane.org; Sun, 22 Nov 2009 16:51:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755214AbZKVPvr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Nov 2009 10:51:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755182AbZKVPvq
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Nov 2009 10:51:46 -0500
Received: from smtprelay04.ispgateway.de ([80.67.31.38]:54268 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755136AbZKVPvq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Nov 2009 10:51:46 -0500
Received: from [84.176.75.20] (helo=[192.168.2.100])
	by smtprelay04.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1NCEj8-0002F7-2z; Sun, 22 Nov 2009 16:51:50 +0100
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <20091121180738.GA14919@atjola.homenet>
X-Df-Sender: 757646
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133434>

Am 21.11.2009 19:07 schrieb Bj=F6rn Steinbrink:
> On 2009.11.21 17:40:14 +0100, Dirk S=FCsserott wrote:
>> is there a way to tell "git diff-index" to ignore some special
>> patterns, such that /^-- Dump completed on .*$/ is NOT recognized as
>> a difference and "git diff-index" returns 0 if that's the only
>> difference?
>=20
> If you don't mind losing that line, you could use a clean filter via
> .gitattributes:
>=20
> echo '*.sql filter=3Dmysql_dump' >> .gitattributes
> git config filter.mysql_dump.clean "sed -e '/^-- Dump completed on .*=
$/d'"
>=20
> That way, git will filter all *.sql paths through that sed command
> before storing them as blobs, dropping that "Dump completed" line fro=
m
> the data stored in the repo.
>=20
> Bj=F6rn
>=20

Thank you Bj=F6rn and Michael,

Your suggestions were really helpful. I decided to use Bj=F6rn's 'clean
filter' approach. It works great.

-- Dirk
