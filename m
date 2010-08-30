From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Odd results writing a Git pre-receive hook to syntax check PHP files.
Date: Mon, 30 Aug 2010 11:32:40 -0500
Message-ID: <AANLkTimX4qFubV68=_0kmPpq89cafH9acqzcshSMdVVe@mail.gmail.com>
References: <AANLkTikktdPoZN8MwJD+Gxus16xBGtScCAqT9W0eiWAb@mail.gmail.com>
 <4C7B8E1E.6050708@drmicha.warpmail.net> <AANLkTimqzDO49h40b16gQ_=X42NXN-wZNV7d7f3KYygt@mail.gmail.com>
 <20100830141602.GF2315@burratino> <AANLkTim+S87KjFBstBineR02hQHzG=X2VDqgiGNbPQGS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Chris Patti <cpatti@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 30 18:33:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oq7ID-0001mj-5f
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 18:33:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755964Ab0H3QdB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Aug 2010 12:33:01 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:35404 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754676Ab0H3QdB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Aug 2010 12:33:01 -0400
Received: by gwj17 with SMTP id 17so2028867gwj.19
        for <git@vger.kernel.org>; Mon, 30 Aug 2010 09:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=IMDNY2ach4AKQeUWIKDEAsS7Q3IAIqtJKopz1jIro5s=;
        b=RlKcKHIo+r7J8bFfkV7RZYDOkVNUuxbJ+JttE0oGaCapiWj9QYkcxJ9qcvO6dxZBU9
         Ceyp82/5/8qoJExlwofe1zX0kWNmCi8KUw+/yB/DSpM43/zrLc55Wlsqw9M+GsiZgsfu
         adjELf8fKE0IFQ6wjZ9Tv70PpxYrOmeuWOMZk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=gtlPuEBoTg9R7GQKM+fmnIPu7UZcAW/szOc8YGjh8vafgg6sDbroW8uY+1C43cQLWi
         1IZAHEasiaTCrI8grNlBENLQRxdSMR4XbcqLP3cECqB5DWZHXP5DGpPhr2cZx/TN6X2I
         gmAtTdEpTWXv9EHWKXCIwtshqQFClOFF3RKzI=
Received: by 10.151.8.1 with SMTP id l1mr2004550ybi.167.1283185980228; Mon, 30
 Aug 2010 09:33:00 -0700 (PDT)
Received: by 10.151.49.17 with HTTP; Mon, 30 Aug 2010 09:32:40 -0700 (PDT)
In-Reply-To: <AANLkTim+S87KjFBstBineR02hQHzG=X2VDqgiGNbPQGS@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154829>

Heya,

On Mon, Aug 30, 2010 at 11:27, Chris Patti <cpatti@gmail.com> wrote:
> fatal: bad object 0000000000000000000000000000000000000000
> Syntax checker hook is malfunctioning. =C2=A0Can't execute git diff -=
-raw.

Check before calling 'git diff --raw' if the lhs is
0000000000000000000000000000000000000000 or not, if it is, just use
git show on all files?

--=20
Cheers,

Sverre Rabbelier
