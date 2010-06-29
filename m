From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] t/t9700/test.pl: don't access private object members, use 
	public access methods
Date: Tue, 29 Jun 2010 02:19:50 +0000
Message-ID: <AANLkTik3L7VcjezVK_8PCKsSpNFaTfYNvsOAgckhv-6K@mail.gmail.com>
References: <OYRSzEHOHSti8exa5KJzWIUEyJ8xb2sfcvm4pUcvYhBXldZMw8JzP6a6cRcRRIZjiOtW9kzmnVA@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue Jun 29 04:21:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTQRz-0001db-NU
	for gcvg-git-2@lo.gmane.org; Tue, 29 Jun 2010 04:21:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751915Ab0F2CTw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Jun 2010 22:19:52 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:63242 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751286Ab0F2CTv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Jun 2010 22:19:51 -0400
Received: by iwn7 with SMTP id 7so664539iwn.19
        for <git@vger.kernel.org>; Mon, 28 Jun 2010 19:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=lmpiXczyTkO5izi5URsS4MMTT7qvC/VZ0lAg6UxIgk4=;
        b=G9ZgHoxr9RDNNKOV+T0DexOmPZn0i5TOAGxAJ3flyepZ7XrRGtzmNhpdzhxLp7ezin
         a/X4acKgTlfOv4usgewhJd1NmE58zKUjo672UguVvnnQuVnAKEgSi/ioL+/WIpotKxyX
         xzgiP7D0h4wE+kUb/S2jqyJpQkkbVNTWtf+RY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=syYNDvmb7K2aqZyGT0rw0XJNjfdQ5XVAcOhs3OHZgohrtvCBTMxS2F8jxTGc5h5j5E
         SZi7Ug0D20T8HyHB4Ra5VQFSyHhhRqr/Z4ATjqw199mK3NXS3FlL1e6BxTkxzbYYv+AL
         GpDBiyvugPEmnlYqtZ61VwufuCgaq6MfKFizs=
Received: by 10.231.161.135 with SMTP id r7mr6473334ibx.47.1277777991040; Mon, 
	28 Jun 2010 19:19:51 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Mon, 28 Jun 2010 19:19:50 -0700 (PDT)
In-Reply-To: <OYRSzEHOHSti8exa5KJzWIUEyJ8xb2sfcvm4pUcvYhBXldZMw8JzP6a6cRcRRIZjiOtW9kzmnVA@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149882>

On Mon, Jun 28, 2010 at 22:51, Brandon Casey <casey@nrlssc.navy.mil> wr=
ote:
> From: Brandon Casey <drafnel@gmail.com>
>
> This test is accessing private object members of the Test::More and
> Test::Builder objects. =C2=A0Older versions of Test::More did not imp=
lement
> these variables using a hash.
>
> My system complains as follows:
>
> =C2=A0 Can't coerce array into hash at <snip>/t/t9700/test.pl line 13=
=2E
> =C2=A0 BEGIN failed--compilation aborted at <snip>/t/t9700/test.pl li=
ne 15.

Just for the record, what version of Test::More is that:

    perl -MTest::More -le 'print $Test::More::VERSION'

> There are public access methods available for retrieving and setting =
these
> variables, so let's use them instead.
>
> Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>

This looks good, sorry for the API mistake on my part.

Acked-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
