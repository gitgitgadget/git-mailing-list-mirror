From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/4] t0024, t5000: use test_lazy_prereq for UNZIP
Date: Mon, 7 Jan 2013 00:45:10 -0800
Message-ID: <20130107084509.GH27909@elie.Belkin>
References: <7vwqw7mb09.fsf@alter.siamese.dyndns.org>
 <50E9B82D.50005@lsrfire.ath.cx>
 <50E9B90C.2060200@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git discussion list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon Jan 07 09:45:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ts8Kw-0000OY-D9
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jan 2013 09:45:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753744Ab3AGIpQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Jan 2013 03:45:16 -0500
Received: from mail-pb0-f45.google.com ([209.85.160.45]:65489 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753590Ab3AGIpP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Jan 2013 03:45:15 -0500
Received: by mail-pb0-f45.google.com with SMTP id mc8so10475272pbc.32
        for <git@vger.kernel.org>; Mon, 07 Jan 2013 00:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=M/CAWiAT5trPbA95D0lHPzkEZSfVzhOYXu0VGOYIO2E=;
        b=he9TvQkhVCxgwnG7691oqCJ4FEBZ/4XUDM6DKRpZnsXEAQjdjdP85lSLDj962q2tyA
         nWjUba/VJbPIboz0EWU5z0Wer7xMAvxpNLNh3DuOuj38MA3AY5/YOlYWda8MUVvlDrRq
         umS3LYzeeGKvDmwn4KwdNMDXM/rHeoaAb9/hb9JlQ1NDsdH/c7Uiqy34xMrt0V2xazwh
         qqK5QfAUnpq2CJzSV07x/Lilto6rUlUBVMNu9vCTK+T6Ty1zRiaBrxaSA8rsxFxsh56a
         DlOkBqQt0eL1BdrOMyd5aV/pbE50RAzGxvX4wQvI0vgZ/0gc+W/x+njoC1rNp0/pjFQn
         poaA==
X-Received: by 10.68.135.98 with SMTP id pr2mr18720635pbb.101.1357548314940;
        Mon, 07 Jan 2013 00:45:14 -0800 (PST)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id oj5sm37272798pbb.47.2013.01.07.00.45.12
        (version=SSLv3 cipher=OTHER);
        Mon, 07 Jan 2013 00:45:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <50E9B90C.2060200@lsrfire.ath.cx>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212886>

Ren=C3=A9 Scharfe wrote:

> --- a/t/t0024-crlf-archive.sh
> +++ b/t/t0024-crlf-archive.sh
> @@ -5,6 +5,11 @@ test_description=3D'respect crlf in git archive'
>  . ./test-lib.sh
>  GIT_UNZIP=3D${GIT_UNZIP:-unzip}
> =20
> +test_lazy_prereq UNZIP '
> +	"$GIT_UNZIP" -v >/dev/null 2>&1
> +	test $? -ne 127

Micronit: now that this is part of a test, there is no more need to
silence its output.  The "unzip -v" output could be useful to people
debugging with "t0024-crlf-archive.sh -v -i".

With or without that change, this is a nice cleanup and obviously
correct, so
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
