From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Resumable clone/Gittorrent (again)
Date: Sun, 9 Jan 2011 10:34:27 +0700
Message-ID: <AANLkTi=KPVMEviQhyJeWHynPa2q6NJpQ2VyAhbRcmQ1D@mail.gmail.com>
References: <AANLkTinUV9Z_w85Gz13J+bm8xqnxJ9jBJXJm9bn5Y2ec@mail.gmail.com>
 <alpine.LFD.2.00.1101061956470.22191@xanadu.home> <AANLkTikKn1+2OX1KPy+9US_yX=E6+CiaCTTB6yqnAWwW@mail.gmail.com>
 <AANLkTimgn2_BWYjbGKbGoeGJ=erKundX4umfy=s16dB1@mail.gmail.com> <AANLkTim2A4=y=XcuPuPiYGDGZyKAUEk-yv2cZVEGhQ3C@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Git Mailing List <git@vger.kernel.org>
To: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 09 04:35:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pbm3r-0004ya-2S
	for gcvg-git-2@lo.gmane.org; Sun, 09 Jan 2011 04:35:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751497Ab1AIDe7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Jan 2011 22:34:59 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:33476 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751114Ab1AIDe7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Jan 2011 22:34:59 -0500
Received: by wwa36 with SMTP id 36so19731859wwa.1
        for <git@vger.kernel.org>; Sat, 08 Jan 2011 19:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=SjOhWbDfEIDiRNEfGn8SHHB7J2vn/8U6aCAFbZqubfk=;
        b=selHOVWVaAMmuAgXofuHmlnpV2rqg15ATEOCtHdB0toCYJEfDeJ+ggzYM/mleWpzHX
         1lYi77oyd9UEC9X8fbsC9RfyrRViwtRyCoXyPTJzxWX+tHPFC9nw/Oedco0v+BNsgu37
         xoOGe7qKSkdf2MKj2YimGodtHB9Lfr4uD3Qdg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=b1LflKsS9h20+SBaTdstLfBnAO24vkOcLXjVwx6TNnjlcnKFpzcDDsCwR8ufhEj+vz
         cfLHfaqa+FnBKCPEwhX90hf6PeSfk6pkB+hlIaXYq6O9oN0/+HJ9bq1wy1DH1SOGd67T
         QWvFuxMggH0jCZIdUWtgB68ZWQaKos86M7UdY=
Received: by 10.216.52.206 with SMTP id e56mr26241102wec.19.1294544097926;
 Sat, 08 Jan 2011 19:34:57 -0800 (PST)
Received: by 10.216.63.14 with HTTP; Sat, 8 Jan 2011 19:34:27 -0800 (PST)
In-Reply-To: <AANLkTim2A4=y=XcuPuPiYGDGZyKAUEk-yv2cZVEGhQ3C@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164843>

On Sun, Jan 9, 2011 at 12:21 AM, Luke Kenneth Casson Leighton
<luke.leighton@gmail.com> wrote:
> =C2=A0ok - you haven't answered the question: are the chains perfectl=
y
> fixed identical sizes?

No.

> =C2=A0if so they can be slotted into the bittorrent protocol by simpl=
y
> pre-selecting the size to match. =C2=A0with the downside that if ther=
e are
> a million such "chains" you now pretty much overwhelm the peers with
> the amount of processing, network traffic and memory requirements to
> maintain the "pieces" map.

No, there are thousands of them only (less than 100k for repos I
examined). It's precisely the reason I stay away from commits as
pieces because commits can potentially go up to millions.

> =C2=A0if not then you now need to modify the bittorrent protocol to c=
ope
> with variable-length block sizes: the protocol only allows for the
> last block to be of variable-length.

Ah I see. I do not reuse bittorrent code out there. Just its ideas,
adapted to git model. If you don't want to modify bittorrent protocol
at all, seed a bundle (as mentioned in another thread).
--=20
Duy
