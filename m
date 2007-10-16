From: Sam Vilain <sam@vilain.net>
Subject: Re: git-svn has a _lot_ of metadata
Date: Wed, 17 Oct 2007 02:22:41 +1300
Message-ID: <4714BB21.3090300@vilain.net>
References: <20071016102259.GB5945@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Wong <normalperson@yhbt.net>, git list <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Oct 16 15:22:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhmNh-0005yR-9e
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 15:22:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401AbXJPNWf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Oct 2007 09:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932396AbXJPNWf
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 09:22:35 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:55722 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932335AbXJPNWe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 09:22:34 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id 7DED527C100; Wed, 17 Oct 2007 02:22:32 +1300 (NZDT)
Received: from [192.168.69.104] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id 79B9C27C0F8;
	Wed, 17 Oct 2007 02:22:25 +1300 (NZDT)
User-Agent: Thunderbird 1.5.0.12 (X11/20070604)
In-Reply-To: <20071016102259.GB5945@diana.vm.bytemark.co.uk>
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=5.0 tests=SPF_HELO_FAIL autolearn=no 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61170>

Karl Hasselstr=F6m wrote:
>     This could probably be stored _much_ more efficiently. Just
>     gzipping it with the standard options shrinks it by between a
>     factor of 4 (for one of the busiest branches) and 300 (for a tag,
>     which is written just once). But I understand that we need quick
>     random access here?
>  =20

I understand that patches to enhance git-svn to allow it to store its
metadata via DBI (as git-cvsserver currently does) would be more than
welcome.

I made an example for an old version of git-svn, which stored the
information in a DBM.  However using a set of tables would be much less
of a hack.

http://git.catalyst.net.nz/gw?p=3Dgit.git;a=3Dcommitdiff;h=3Ddbe3fa060

Treat that change as a reference only; it just shows what places in the
code would need to be touched to support a different storage format.  A
mergeable patch to fix this would probably need to support both methods=
,
detecting which is available or in use.

Sam.
