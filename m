From: Karl Stenerud <kstenerud@gmail.com>
Subject: Re: notify alternative to auto gc?
Date: Mon, 28 Jun 2010 12:52:13 -0400
Message-ID: <5D3639C2-2528-4125-91E0-8D78D4844511@gmail.com>
References: <EA7717AE-DA72-48D7-A27E-C958896FD158@gmail.com> <AANLkTil8sHZrfvHetwzjhOsyprsqrf7-XRS3B8qKH7cs@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 28 18:52:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTHZI-0007Yn-8R
	for gcvg-git-2@lo.gmane.org; Mon, 28 Jun 2010 18:52:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751530Ab0F1QwS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Jun 2010 12:52:18 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:34449 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750838Ab0F1QwR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Jun 2010 12:52:17 -0400
Received: by gxk23 with SMTP id 23so183730gxk.19
        for <git@vger.kernel.org>; Mon, 28 Jun 2010 09:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:content-type:mime-version
         :subject:from:in-reply-to:date:content-transfer-encoding:message-id
         :references:to:x-mailer;
        bh=vgNlF5xnCOpCuHGXpsIWBaAnC8pOFX8g6CO71D/RTIc=;
        b=V2lPVsMoheHbjI9K+FTeKZKfmq6XqFAVBnhwlHxWJJ0UY1zYcPgctsOhNIE3Svh5mU
         sxuJvvPLnm1M8pnkODXByRUAd6/qeT6LPHs6I8uYxL8JrDitdeZW5CiVnuDW6lKkfYb8
         +8EIgBAzbHHYArLVT7b53OSdh1KZoDbUsMFpI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=content-type:mime-version:subject:from:in-reply-to:date
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=NvRYjkmzPcxYk2aYYSzFWImZkuizBf2gIOUi/T68cJgXQUcTGzKm9l3Au3EmS2GpaP
         8t3irneMbVYce4WQQAMkRib3dnar9iYuTwQSIRZfqBw6PjR2vBIEvX2nLaiKL7x8n5rg
         fEA6A/+Z7YvQnAFIhkxlZuSjlsglSI1HBFgTs=
Received: by 10.229.211.81 with SMTP id gn17mr1289082qcb.83.1277743935799;
        Mon, 28 Jun 2010 09:52:15 -0700 (PDT)
Received: from [192.168.3.101] ([38.98.193.18])
        by mx.google.com with ESMTPS id i20sm19600648qci.21.2010.06.28.09.52.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 28 Jun 2010 09:52:15 -0700 (PDT)
In-Reply-To: <AANLkTil8sHZrfvHetwzjhOsyprsqrf7-XRS3B8qKH7cs@mail.gmail.com>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149839>


On 2010-06-28, at 12:26 PM, =C6var Arnfj=F6r=F0 Bjarmason wrote:

> On Mon, Jun 28, 2010 at 16:10, Karl Stenerud <kstenerud@gmail.com> wr=
ote:
>> The git help tells me I can disable it by setting gc.auto to 0, whil=
e the mailing list archive tells me I also have to set gc.autopacklimit=
 to 0.  This is fine, but if I do that, I won't know when the repo is i=
n need of cleanup.  Is there any option I can set to instruct it to sim=
ply TELL me when it's in need of gc?
>=20
> Anything that tells you whether you need to gc would incur much of th=
e
> speed penalty that running gc itself does.

Actually, no it wouldn't.  If checking did incur much of the speed pena=
lty, then git, in general, would already be horribly slow all the time =
because it automatically does a gc-check with most commonly used comman=
ds, according to the documentation.

In the case which I observed, the time from typing "git pull" until the=
 auto-gc notification was a few seconds.  The time from the notificatio=
n until gc completion, however, was 3-4 minutes.
