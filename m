From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH 1/2] send-email: refactor and ensure prompting doesn't 
	loop forever
Date: Mon, 30 Mar 2009 10:17:43 -0400
Message-ID: <76718490903300717x5cc5e33ax1cf91471efd242bd@mail.gmail.com>
References: <1238290751-57461-1-git-send-email-jaysoffian@gmail.com>
	 <vpqd4bzjlk1.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Mar 30 16:19:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoIKd-0003Rp-2h
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 16:19:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752262AbZC3ORr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Mar 2009 10:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752160AbZC3ORr
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 10:17:47 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:48649 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751594AbZC3ORq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Mar 2009 10:17:46 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1984851ywb.1
        for <git@vger.kernel.org>; Mon, 30 Mar 2009 07:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=s2olS7taIWCBhxwwkNxZpkbLD/nbJETmKdAx4K/4JSQ=;
        b=fe0IAy06gzCl0FR1ryXZLm44UUiY3KFSlOmowVwb5svlyNsYtLW+TGRr1MY+QV5mqa
         mUuia0AwpiKSA7m4duEeccpIbDFJaBvUoAlF7NvMieu8yGR8Wj153GIWa8XW38m+7Q+B
         3Q/uMHTi1wkbqLG1+71QsEQDpNIerjLRedJoc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=n7Z+t2XDPLLc3PXRYDrCvzukAc4idphlqVu30QSbB+1A7p/b3V9PqMumHbxfbzslgZ
         TWmvb7cPUmtemWvrOQdQccEAVIyJvCRdxjmqlFZlz21JrQXiqlZdffGEbDUmEcrAynqz
         hsGRwjW7g8SfFcCyf8DvsEDTPUClo/aqXBf00=
Received: by 10.150.185.14 with SMTP id i14mr10569440ybf.114.1238422663612; 
	Mon, 30 Mar 2009 07:17:43 -0700 (PDT)
In-Reply-To: <vpqd4bzjlk1.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115156>

On Mon, Mar 30, 2009 at 7:29 AM, Matthieu Moy <Matthieu.Moy@imag.fr> wr=
ote:
> Minor problem: I still (harmless) get error messages in my log:
>
> =C2=A0print() on closed filehandle FOUT at /usr/share/perl/5.8/Term/R=
eadLine.pm line 193.
> =C2=A0readline() on closed filehandle FIN at /usr/share/perl/5.8/Term=
/ReadLine.pm line 395.
> =C2=A0print() on closed filehandle FOUT at /usr/share/perl/5.8/Term/R=
eadLine.pm line 203.
>
> But I can very well live with them!

perl send-email ... 2>/dev/null :-)

Seriously though, I am unable to reproduce the messages you are
getting from Term::ReadLine, and I tried really hard.

What does:

$ perl -e 'use Term::ReadLine; print "$Term::ReadLine::VERSION\n"'

tell you?

Also, thank you for confirming the fix.

j.
