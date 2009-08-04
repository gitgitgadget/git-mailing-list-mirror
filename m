From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: Please make git-am handle \r\n-damaged patches
Date: Tue, 4 Aug 2009 22:59:47 +0200
Message-ID: <40aa078e0908041359p79b111eo2f389dde25bb0876@mail.gmail.com>
References: <4A7735B0.2040703@zytor.com>
	 <81b0412b0908032335s3363849aj32a0e93efa15c012@mail.gmail.com>
	 <7v7hxk5b4y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alex Riesen <raa.lkml@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 04 22:59:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYR6y-00064a-AR
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 22:59:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932459AbZHDU7s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Aug 2009 16:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753255AbZHDU7s
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 16:59:48 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:48958 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752680AbZHDU7s convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Aug 2009 16:59:48 -0400
Received: by bwz19 with SMTP id 19so3323740bwz.37
        for <git@vger.kernel.org>; Tue, 04 Aug 2009 13:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=CvQqpTSAONGbJHOtpJ4teYRJGhew7kb28ZGubwM7AsM=;
        b=Rs38B9rma0FPTt0IzRy+xMU5JmGZW+0N/JitJhk7KCqwEjXCYukAwcTsJANnOe5AOJ
         UHfz38sL+DHqAtvaUSd1fIbUtJxYIuQK8j4gMTRDTQzCTy1KBORZ98YoLnIU1JWoIlhw
         IPheAxm81aQrTJ6iFl1vofZ1BeJ+9roKHZ6k0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=q/3FpVB8H1cJQ2B2vTSGPQHhPmmr/KJylU862jpjvk1Y/sx9+CP/kNjQ6Nr1BsNUK7
         t4uVrlPv0ehpf0/k8H8/BXtdGVSE3r24+jCkioCVSew8PlpAMHUDr8I0kxa7JsDRUa6m
         oEsmb+nz0kb3vXqteHVq+z2PtcursELNblKu0=
Received: by 10.204.54.16 with SMTP id o16mr93785bkg.146.1249419587060; Tue, 
	04 Aug 2009 13:59:47 -0700 (PDT)
In-Reply-To: <7v7hxk5b4y.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124809>

On Tue, Aug 4, 2009 at 8:46 AM, Junio C Hamano<gitster@pobox.com> wrote=
:
> I thought about this approach, but it made me worried about a case wh=
ere
> an otherwise sane piece of e-mail has \r at the end of one line as th=
e
> real payload.=A0But as long as we are talking about a text e-mail (an=
d we
> are talking about mailsplit here and a binary payload with a CTE appl=
ied
> counts as text), I think we can safely use an approach like this.

RFC 2822, section 2.3 explicitly states that a CR should not occur
without a LF (and vice versa, but the e-mail client might convert CRLF
to LF when saving to file), so I think this should be safe.

--=20
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656
