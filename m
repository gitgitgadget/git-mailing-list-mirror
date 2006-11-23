X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Martin Langhoff (CatalystIT)" <martin@catalyst.net.nz>
Subject: Re: [PATCH] git-cvsimport: add suport for CVS pserver method HTTP/1.x
  proxying
Date: Fri, 24 Nov 2006 11:09:58 +1300
Message-ID: <45661C36.9010101@catalyst.net.nz>
References: <11642344172790-git-send-email-iarenuno@eteo.mondragon.edu> <7v64d5keke.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Thu, 23 Nov 2006 22:10:23 +0000 (UTC)
Cc: Inaki Arenaza <iarenuno@eteo.mondragon.edu>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.7.12) Gecko/20050915
X-Accept-Language: en-us, en
In-Reply-To: <7v64d5keke.fsf@assigned-by-dhcp.cox.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32162>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnMlq-000437-Ex for gcvg-git@gmane.org; Thu, 23 Nov
 2006 23:10:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934178AbWKWWKK convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Thu, 23 Nov 2006 17:10:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934182AbWKWWKK
 (ORCPT <rfc822;git-outgoing>); Thu, 23 Nov 2006 17:10:10 -0500
Received: from godel.catalyst.net.nz ([202.78.240.40]:1453 "EHLO
 mail1.catalyst.net.nz") by vger.kernel.org with ESMTP id S934178AbWKWWKJ
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 23 Nov 2006 17:10:09 -0500
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=[192.168.2.69])
 by mail1.catalyst.net.nz with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
 (Exim 4.50) id 1GnMlZ-0000jx-Q5; Fri, 24 Nov 2006 11:09:57 +1300
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:
> Except that this statement made me go "huh?" wondering what it
> would do to the $filehandle to evaluate <$filehandle> in a void
> context:
>=20
> +			# Skip the empty line of the proxy server output
> +			<$s>;

It's a perl idiom that will discard one line of the $filehandle. If we=20
are 200% certain that it is empty, then it's fine. OTOH, it may well be=
=20
a bug in the particular proxy implementation I=C3=B1aki is using -- I d=
on't=20
know enough about CVS proxying to tell.

> The "I/O Operators" section talks about evaluating <$s> in a
> scalar context (i.e. "$rep =3D <$s>"), which we all know would
> return a single line, and in list context, which swallows

This is in scalar context, and that's safe to rely on. Whether it is=20
clear enough in this non-Perl-native project... is a good flamewar=20
waiting to happen :-)

cheers,


martin
--=20
-----------------------------------------------------------------------
Martin @ Catalyst .Net .NZ  Ltd, PO Box 11-053, Manners St,  Wellington
WEB: http://catalyst.net.nz/           PHYS: Level 2, 150-154 Willis St
OFFICE: +64(4)916-7224                              MOB: +64(21)364-017
       Make things as simple as possible, but no simpler - Einstein
