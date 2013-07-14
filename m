From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2 1/2] send-email: squelch warning from Net::SMTP::SSL
Date: Sun, 14 Jul 2013 19:19:10 +0530
Message-ID: <CALkWK0kAfZLqyCO+e+0PH0-MmjMYX1nJmit5Qb5L3Qf6nyhC9Q@mail.gmail.com>
References: <1373025947-26495-1-git-send-email-artagnon@gmail.com>
 <1373025947-26495-2-git-send-email-artagnon@gmail.com> <51D82970.5070108@web.de>
 <20130706143256.GX862789@vauxhall.crustytoothpaste.net> <51D83C7E.8000902@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Jul 14 15:50:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyMgv-0005Z1-2m
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 15:50:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752493Ab3GNNuO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Jul 2013 09:50:14 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:54520 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752516Ab3GNNtv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Jul 2013 09:49:51 -0400
Received: by mail-ie0-f178.google.com with SMTP id u16so23915690iet.37
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 06:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=2A7ko55dfxcK4yJGEuXbLNUMfwqM8KGxokqkJy7GNmo=;
        b=leykc632hwoP2ritY09M3lNw65WK6aKN42ZOHDaw/pbwBndac1/lU7ecTOTFvii5yK
         Yme6c5uYBGDSrHquwrruttL/cpMdpYRetAdaxgJt64ra5EU3ScfJsdXDhetrTfzg2d72
         fygeRzwEr36ig1OnrkTDE+QNMuKGc8GcuhOWGbAUl8ETdKr2FMWrB6Wol6R6pHVLjLT+
         Ld/VxRPZrF0mz13hPc530UOYhBpAKO6tccnOdPlO4SG6JoIesDeweFljx2SAGE92R+He
         1296aLIyxP/YqfWEIDVS99kipAV/6JiBO45z1Hh45aK7ShI7/uO673ld6ydX96qzViEO
         oilQ==
X-Received: by 10.50.47.12 with SMTP id z12mr4686361igm.50.1373809791071; Sun,
 14 Jul 2013 06:49:51 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Sun, 14 Jul 2013 06:49:10 -0700 (PDT)
In-Reply-To: <51D83C7E.8000902@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230363>

Torsten B=C3=B6gershausen wrote:
> /usr/bin/perl -MIO::Socket::SSL -e 'print "$IO::Socket::SSL::VERSION\=
n";'
> 1.22

This is ancient!  (I have 1.84).  Is it not possible to do an
ssl-verify-peer in older versions (is it exported as something else)?
The older versions don't display the warning anyway, and this series
is about squelching the warning in newer versions.  Does

  require IO::Socket::SSL qw(SSL_VERIFY_NONE SSL_VERIFY_PEER) or print
"warning: not using SSL_VERIFY_PEER due to outdated IO::Socket::SSL"

sound reasonable?
