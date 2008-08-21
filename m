From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH 3/4] Convert git_id() to the new id format
Date: Thu, 21 Aug 2008 22:39:04 +0100
Message-ID: <b0943d9e0808211439x748b7b02s8c2fe21c2e9ea719@mail.gmail.com>
References: <20080713113853.18845.37686.stgit@localhost.localdomain>
	 <20080713114047.18845.34899.stgit@localhost.localdomain>
	 <20080714070739.GG20751@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 23:40:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWHt5-0001Ea-6M
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 23:40:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754270AbYHUVjG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Aug 2008 17:39:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753850AbYHUVjF
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 17:39:05 -0400
Received: from wa-out-1112.google.com ([209.85.146.182]:31929 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753696AbYHUVjE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Aug 2008 17:39:04 -0400
Received: by wa-out-1112.google.com with SMTP id j37so57921waf.23
        for <git@vger.kernel.org>; Thu, 21 Aug 2008 14:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=CptWcWO/jw3Aio45u5W73tLZxaqoenNoMoL9k4CjFXs=;
        b=ecUzLk3YHu5jRZe/la+ExYi2UNlNRR4UEo9/FToKAIfyFn0rj8GjKaTfcjgn8LQr4F
         0e2U4lExb2fprE1/4mBgwIsJ8SKhVo1JFDjJ8jJdpgggFAoQfH5I/76uWIyM4cpZPfRb
         TaaMtMmjSQp1GIptgNDVDlhZr30A7mbETKWaY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=vCkIoHzGSMGeMGIephFvq0B2OMGs1XsD7Jd+27j6Scf5L0BzFIy5HpAuhOSq9eJYNs
         PYn+M+2o9MM0NMoBBBK91u2QtUT2cWadXEfzWCYo2deYFf53RXaeHV7kQmIc7pUvBUcF
         xkLtDiUHUlR7Gc8LISxJVq7EWLmBYP6XOSzag=
Received: by 10.114.201.1 with SMTP id y1mr356896waf.216.1219354744099;
        Thu, 21 Aug 2008 14:39:04 -0700 (PDT)
Received: by 10.114.193.12 with HTTP; Thu, 21 Aug 2008 14:39:04 -0700 (PDT)
In-Reply-To: <20080714070739.GG20751@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93215>

2008/7/14 Karl Hasselstr=F6m <kha@treskal.com>:
> On 2008-07-13 12:40:48 +0100, Catalin Marinas wrote:
>
>> @@ -67,8 +64,8 @@ def func(parser, options, args):
>>                  rev =3D strip_suffix('/', rev)
>>                  if rev.endswith('/'):
>>                      rev =3D strip_suffix('/', rev)
>> -                rev1 =3D rev + '//bottom'
>> -                rev2 =3D rev + '//top'
>> +                rev1 =3D rev + 'HEAD^'
>> +                rev2 =3D rev + 'HEAD'
>
> This looks bogus. You probably want to s/HEAD// here.

Actually, the full "if" block here is useless. This was to specify
diff -r patch/ to show a patch but we now have the "show" command.

> I guess the test suite doesn't cover this? :-(

And it shouldn't, I removed it :-)

--=20
Catalin
