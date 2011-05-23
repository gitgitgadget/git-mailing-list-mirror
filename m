From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: combined diff does not detect binary files and ignores -diff attribute
Date: Mon, 23 May 2011 19:31:02 -0400
Message-ID: <BANLkTikAS63wZ=VP9s6LE44MBd5T1X3gMA@mail.gmail.com>
References: <BANLkTi=FtkiUjwAa7e3KAC5FF3GNxWzd3Q@mail.gmail.com>
	<4DDA618E.4030604@drmicha.warpmail.net>
	<BANLkTinu3AbTmtswn6DLQKAWdLL=gBvAqA@mail.gmail.com>
	<20110523181147.GA26035@sigill.intra.peff.net>
	<20110523201529.GA6281@sigill.intra.peff.net>
	<BANLkTikvPjO=bbhAoPCftdXzGSYtryNvzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 24 01:34:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOedX-000845-72
	for gcvg-git-2@lo.gmane.org; Tue, 24 May 2011 01:34:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756956Ab1EWXbG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 May 2011 19:31:06 -0400
Received: from mail-px0-f173.google.com ([209.85.212.173]:35246 "EHLO
	mail-px0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755773Ab1EWXbE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 May 2011 19:31:04 -0400
Received: by pxi16 with SMTP id 16so4088475pxi.4
        for <git@vger.kernel.org>; Mon, 23 May 2011 16:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=UgkPp4ITwfAw655NsZ40O9yjgcubNXLnBwPUT9dVUp0=;
        b=xD9RApAtn3h2bX13PEkNqze0yxf721ExQFX/Pazy437AOYVTxCFeBugPRE8hrVhRWv
         vGEF2w0fDc+l8phpVs5YmzmeGATb8SU80CwrhE564zok+gBNhVQnbzU+uGNquDkgRREN
         54EcBRFovimnOHm0c6Xy7FmNqdtQV0xm9i9Ys=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=We7CnFrwpSkqdGSsGOt/IeK0OkTfKDMVti61NDbA2ydr6axxBOzTP+D6W7fXrG7Flt
         ep0t0nzLX5ReaVR2JYiJMhsQ9yPZPWmd8+3mgZnzDnIjelETfyFMsXbFnx9s6w6yx8md
         pbOVjw1YzfXhD2vZz6KfcFSgOQTRYhXL5KA8E=
Received: by 10.142.107.12 with SMTP id f12mr963342wfc.226.1306193462962; Mon,
 23 May 2011 16:31:02 -0700 (PDT)
Received: by 10.142.13.8 with HTTP; Mon, 23 May 2011 16:31:02 -0700 (PDT)
In-Reply-To: <BANLkTikvPjO=bbhAoPCftdXzGSYtryNvzw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174291>

On Mon, May 23, 2011 at 6:55 PM, Jay Soffian <jaysoffian@gmail.com> wro=
te:
>> =C2=A0[4/5]: refactor get_textconv to not require diff_filespec
>> =C2=A0[5/5]: combine-diff: respect textconv attributes
>
> Didn't test explicitly, but don't see anything obviously wrong.

Okay, tested these now. I noticed two tiny issues unrelated to this
series, but rather since this is the first time I've used textconv.

1. The temporary path git generates loses the original file extension.
At least in the case of Mac OS X, ibtool gets angry when the ".xib"
isn' there. I worked around this with a wrapper, but maybe git could
preserve the extension.

2. It's not really clear to me when one should use textconv vs a
custom diff driver. (Also, --no-textconv isn't documented...).

Thanks,

j.
