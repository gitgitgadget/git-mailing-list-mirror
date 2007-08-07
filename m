From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] (Really) Fix install-doc-quick target
Date: Tue, 07 Aug 2007 15:55:39 +0200
Message-ID: <46B879DB.4090504@lsrfire.ath.cx>
References: <7vmyx6fohv.fsf_-_@assigned-by-dhcp.cox.net>	<11864401942772-git-send-email-mdl123@verizon.net>	<Pine.LNX.4.64.0708062349460.14781@racer.site>	<7vzm149s8s.fsf@assigned-by-dhcp.cox.net> <46B7B10F.4060402@gmail.com>	<7vhcnc9lpm.fsf@assigned-by-dhcp.cox.net> <46B7D108.20606@gmail.com> <7vd4y09f07.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Levedahl <mlevedahl@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mark Levedahl <mdl123@verizon.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 07 15:56:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIPXi-0001vz-A6
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 15:56:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760761AbXHGN4A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 7 Aug 2007 09:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759120AbXHGN4A
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Aug 2007 09:56:00 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:37690
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753881AbXHGN4A (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Aug 2007 09:56:00 -0400
Received: from [10.0.1.201] (p508EBFB8.dip.t-dialin.net [80.142.191.184])
	by neapel230.server4you.de (Postfix) with ESMTP id 1C0E38B008;
	Tue,  7 Aug 2007 15:55:58 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7vd4y09f07.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55257>

Junio C Hamano schrieb:
> Mark Levedahl <mlevedahl@gmail.com> writes:
>=20
>> +    printf "$mandir/%s\n" $(git ls-tree -r --name-only $head) | xar=
gs
>> gzip -f
>=20
> No risk that ls-tree output is too long to fit within the exec
> args limit to run printf?

Perhaps this instead?

   git ls-tree -r --name-only $head | (cd "$mandir" && xargs gzip -f)

Ren=E9
