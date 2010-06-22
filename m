From: Pascal Obry <pascal@obry.net>
Subject: Re: [PATCH] Do not decode url protocol.
Date: Tue, 22 Jun 2010 13:46:46 +0200
Message-ID: <AANLkTilFfA4Gf4UK64b67O5ey-vwH7Yby8eH8ypFI8HX@mail.gmail.com>
References: <AANLkTinK99krA-16qUO8nWYbZ7w6o632jLTTW5WyaKOk@mail.gmail.com>
	<vpqiq5bb8rx.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 22 13:46:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OR1wJ-0005sw-DZ
	for gcvg-git-2@lo.gmane.org; Tue, 22 Jun 2010 13:46:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755881Ab0FVLqt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jun 2010 07:46:49 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:51068 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755655Ab0FVLqr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jun 2010 07:46:47 -0400
Received: by gye5 with SMTP id 5so2818430gye.19
        for <git@vger.kernel.org>; Tue, 22 Jun 2010 04:46:46 -0700 (PDT)
Received: by 10.101.192.27 with SMTP id u27mr4909516anp.230.1277207206659; 
	Tue, 22 Jun 2010 04:46:46 -0700 (PDT)
Received: by 10.100.171.12 with HTTP; Tue, 22 Jun 2010 04:46:46 -0700 (PDT)
In-Reply-To: <vpqiq5bb8rx.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149478>

Matthieu,


> Are you sure the URL contains a / at this point? That would be a user
> error if it doesn't, but has this been validated (with a clean error
> message if needed) earlier in the code?

Yes, all calls are either from http-backend.c (here we have a protocol
specified, http://) or in connect.c where a test is done to make sure
we have an url (and not a simple path):

	if (is_url(url_orig))
		url = url_decode(url_orig);
	else
		url = xstrdup(url_orig);

Pascal.

-- 

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|              http://www.obry.net
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver wwwkeys.pgp.net --recv-key C1082595
