From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: Issue 323 in msysgit: Can't clone over http
Date: Tue, 8 Sep 2009 21:10:21 +0800
Message-ID: <be6fef0d0909080610j89c0a4bkf1cb0119b9b11db@mail.gmail.com>
References: <7viqfzvwf1.fsf@alter.siamese.dyndns.org>
	 <0016e6470f36315b8a0472bc75a8@google.com>
	 <20090904212956.f02b0c60.rctay89@gmail.com>
	 <7v8wgrbb9e.fsf@alter.siamese.dyndns.org>
	 <be6fef0d0909062253p1b86628et8a9f979952eebb00@mail.gmail.com>
	 <7vocpn44dg.fsf@alter.siamese.dyndns.org>
	 <20090907172751.6cf38640.rctay89@gmail.com>
	 <7v7hwatw0v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, msysgit@googlegroups.com,
	Tom Preston-Werner <tom@mojombo.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 08 15:10:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ml0Sz-0001Y3-BT
	for gcvg-git-2@lo.gmane.org; Tue, 08 Sep 2009 15:10:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753513AbZIHNK0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Sep 2009 09:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753479AbZIHNK0
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 09:10:26 -0400
Received: from mail-iw0-f175.google.com ([209.85.223.175]:53327 "EHLO
	mail-iw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753454AbZIHNKZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Sep 2009 09:10:25 -0400
Received: by iwn5 with SMTP id 5so1124954iwn.4
        for <git@vger.kernel.org>; Tue, 08 Sep 2009 06:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=jczib0CemwuOfJPjqYidK/8q4hU6JI9eZxNwVtoVzic=;
        b=xMzvEAzgnBXphCSLAm+xJ43aBPEfG4M6fL2AlBM8ypp+6Ar/SaU6/7Ek/KEYMqJrTT
         GzfLSmuyjityMrUm7DbWFcxEF0N3Bw/HWO8uCA52++LYAjK3EquxaxoHTbzpICVrYnsZ
         qra2Ni6EihcjYONLZIeja1L2f9eJp+crC5iTQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=qrYMldnEC6BtkDQyogcRH5CtCpORtzUDgGuh7MMjx9V1z4eHTHw0KXRizTvGXMkPgW
         9+DabceEP0WFmg3jqgouTJhSFUP5pGX3qBwimSc29zr8TFMaWsQn+Jg61wc+ysczAWUF
         N6BAL/I2wAvmZjULZZ49PhhBwQjy6W1LfjK0k=
Received: by 10.231.126.8 with SMTP id a8mr13248021ibs.15.1252415425881; Tue, 
	08 Sep 2009 06:10:25 -0700 (PDT)
In-Reply-To: <7v7hwatw0v.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128003>

Hi,

On Tue, Sep 8, 2009 at 3:06 AM, Junio C Hamano<gitster@pobox.com> wrote=
:
> I am torn about this.
>
> On one hand, if we are going to treat such a half failure as nothing
> conclusive, I do not see a point to keep that check to begin with.
>
> On the other hand, if a HEAD request to a URL results in an unauthori=
zed,
> what plausible excuse the server operator could give for allowing a G=
ET
> request to the same URL? =A0If we are going to keep the check if *.pa=
ck that
> corresponds to the *.idx will be available, shouldn't we trust whatev=
er
> check we perform?

I am in favour or removing this check, not just due to its
unreliability, but for the sake of consistency (we very rarely send a
HEAD request to poll data before doing a GET).

Do disregard the patch included earlier, if you haven't already done so=
=2E

--=20
Cheers,
Ray Chuan
