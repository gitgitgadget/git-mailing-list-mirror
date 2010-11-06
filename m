From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 8/8] Remove pack file handling dependency from wrapper.o
Date: Sat, 06 Nov 2010 19:07:43 +0100
Message-ID: <4CD5996F.6010809@lsrfire.ath.cx>
References: <20101106113905.GA27405@burratino> <20101106115237.GH27641@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	David Barr <david.barr@cordelta.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 06 19:08:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PEnBW-0007IM-1B
	for gcvg-git-2@lo.gmane.org; Sat, 06 Nov 2010 19:08:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751870Ab0KFSIH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Nov 2010 14:08:07 -0400
Received: from india601.server4you.de ([85.25.151.105]:34689 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751654Ab0KFSIG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Nov 2010 14:08:06 -0400
Received: from [10.0.1.100] (p4FC573F6.dip.t-dialin.net [79.197.115.246])
	by india601.server4you.de (Postfix) with ESMTPSA id 19C722F80A3;
	Sat,  6 Nov 2010 19:07:59 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <20101106115237.GH27641@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160853>

Am 06.11.2010 12:52, schrieb Jonathan Nieder:
> Commands that might access a git repository should discard pack
> windows when memory is tight, but helpers like show-index do not need
> to.
>=20
> So stop setting try_to_free_pack_memory as the default
> try_to_free_routine and instead set up the try_to_free handler
> explicitly in main() for callers that require it.

Ugh.  Having to remember setting this handler is tedious.

Can it be set automatically once the first pack is loaded?  A quick loo=
k
suggests that use_pack() would be the right place to do it.

Ren=E9
