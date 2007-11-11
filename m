From: "Yin Ping" <pkufranky@gmail.com>
Subject: Re: Dose git-fetch need --reference option like git-clone?
Date: Sun, 11 Nov 2007 19:38:37 +0800
Message-ID: <46dff0320711110338t74d654a3h8811ae9d22f25870@mail.gmail.com>
References: <46dff0320711110009y713c7d38q7b1457c92daecef6@mail.gmail.com>
	 <7vsl3dgovv.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 12:39:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrB9X-0001O6-7V
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 12:38:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754147AbXKKLij (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 06:38:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754146AbXKKLij
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 06:38:39 -0500
Received: from py-out-1112.google.com ([64.233.166.179]:23707 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754140AbXKKLii (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 06:38:38 -0500
Received: by py-out-1112.google.com with SMTP id u77so614625pyb
        for <git@vger.kernel.org>; Sun, 11 Nov 2007 03:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ImyzXB0G4zpn8Y0IP0pEhiugl3FS8d9U3oX6O6UkHY0=;
        b=Dag+KKFgVUPDwf3z4PdsMckZ3l1VBqku0tWyTZO5insqZVtdvTzWonITFjvHoU0KZqrHfugVMf48+uvkFE6YvEqO2VWtnkNX9DVA0fTBw33J3TQzbiMt0RH3tA3aSVRf9sIIObT5TWMlwRIoxI1luPcZjo9iXVwRW9outEkHHEw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=scFV4beYTJaZvKYgihWRmkTmHPQ3kpNTjEIhsC07mN1HZ0Y81745wk/L/Qm/6L9XGKr50VqyAkqGOlj531i8AR2zsJs7p4lJLZF/i5gq0I98dxi7Vc+IFm7vAvisNcA5hJ0W8Xg6GeSxdk6Gz6lhJx1cTquVm/Q+gp8tSXnQVV4=
Received: by 10.35.103.6 with SMTP id f6mr4642172pym.1194781117455;
        Sun, 11 Nov 2007 03:38:37 -0800 (PST)
Received: by 10.35.108.1 with HTTP; Sun, 11 Nov 2007 03:38:37 -0800 (PST)
In-Reply-To: <7vsl3dgovv.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64448>

On Nov 11, 2007 4:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> No, there is no such thing.
>
> I think what you are talking about is a reasonable thing to
> want.  It would have been easier to hack in back when git-fetch
> was a script, but now you would need to work a bit harder in the
> C code.  On the other hand, however, I suspect the resulting
> code would be cleaner without having to actually create and
> delete temporary refs in refs/reference-tmp/ namespace but fake
> them only in-core, with a proper transport API enhancements.
>
> But if you only want a quick-and-dirty workaround, you can
> manually do refs/reference-tmp and objects/info/alternates dance
> that is done by git-clone before running a git-fetch from such
> "nearby" remote.

Now my workaround is
$ git remote add remoteA path/to/remoteACloned
$ git fetch remoteA
Then update .git/config to let remote.remoteA.url=git://remoteAUrl
$ git fetch





-- 
Ping Yin
