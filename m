From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: Git Rebase blows away GIT_AUTHOR_NAME
Date: Tue, 18 Jan 2011 20:33:42 -0500
Message-ID: <AANLkTi=aTbm_Wic=7sMuz1rTd69enRUioX13kWuJJoEF@mail.gmail.com>
References: <AANLkTikqfX3jhSdP5xhFj=VktqW2S6AeGL_MF18g8ZA_@mail.gmail.com>
 <AANLkTimf2rwKqyWwQbdj7cjS8YcQwCXYGRCvQbZ5HZ19@mail.gmail.com>
 <AANLkTik15iV9SOv6rRL5+DQkAZ4JwBGTS+gqS3nXy2hN@mail.gmail.com>
 <AANLkTikk7Xdiey76Dmy848_B4qNX2-Vbis7p=E8vtNL9@mail.gmail.com>
 <AANLkTimONqL4=E4Unrsj9PU5u57KGXrmO6xWUOCLorgs@mail.gmail.com>
 <AANLkTi=PTgmOSC7pRLjujO5fi9Wdp69Jmj4zCkhGSYSz@mail.gmail.com>
 <AANLkTiksAZSi-Yo8yJv5ca9XWWvB3iVQhZOJtTs-F8gk@mail.gmail.com>
 <AANLkTi=Z6Dx6m68zi7Q1eRVxX3DXOyKj+Ff177UCQrAj@mail.gmail.com>
 <AANLkTimZF+r2aNzrXsUuHVZR65N5wpOYLutFgGAGoci_@mail.gmail.com>
 <20110114162144.GA867@sigill.intra.peff.net> <20110117222128.GA30869@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: JT Olds <jtolds@xnet5.com>, Junio C Hamano <gitster@pobox.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Tor Arntsen <tor@spacetec.no>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 19 02:34:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfMwZ-0007pv-G3
	for gcvg-git-2@lo.gmane.org; Wed, 19 Jan 2011 02:34:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753325Ab1ASBeV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jan 2011 20:34:21 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:65008 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753289Ab1ASBeM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jan 2011 20:34:12 -0500
Received: by iyj18 with SMTP id 18so273622iyj.19
        for <git@vger.kernel.org>; Tue, 18 Jan 2011 17:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=+/t0QqPbsrjD4x3Dghr+UuYBGMliM7MwGl359fVsLkk=;
        b=kKPwlExVagWBCTtYUX7jnTFETIPPITspLcODNoUih8wQZf/qR+yRdkh0zAUgu9C7Fl
         zRO8bo9V7XyEmndu2qPVy5gPpRvdWA0r2uUU7Nl1mXONdvDjXrjrfX3mqoK2RTvFSfnr
         1BU3vwUd1Wsoyk38g0b7mYAMSLUguILMAHAuQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=N+d3Sykql1w1nqPSLLukzm+xbHGSv843ug1ZvKSepFhh66Ueqp5YlDlqj8L79KNPt8
         OdAN9UtznUDyxW+7SpqYEtpYCO8vWtRdS85GYDcp7+bPjiLzSMJFyJWLbcCrfdVWxWHi
         03Wz9sN+JQKgF8EQAaBBvM4lMLnbWAFN5jpeU=
Received: by 10.231.36.5 with SMTP id r5mr52664ibd.134.1295400852197; Tue, 18
 Jan 2011 17:34:12 -0800 (PST)
Received: by 10.231.167.78 with HTTP; Tue, 18 Jan 2011 17:33:42 -0800 (PST)
In-Reply-To: <20110117222128.GA30869@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165235>

On Mon, Jan 17, 2011 at 5:21 PM, Jeff King <peff@peff.net> wrote:
> I bisected to 43c2325 (am: use get_author_ident_from_commit instead of
> mailinfo when rebasing, 2010-06-16), which was written to handle exactly
> this sort of thing.

Wow. Well, I apologize for not short-circuiting this thread much
sooner, but believe it or not, I didn't even remember writing that
till you just pointed it out. I'm too young to be losing my memory.
:-(

j.
