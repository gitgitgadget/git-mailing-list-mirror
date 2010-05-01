From: Dmitrijs Ledkovs <dmitrij.ledkov@ubuntu.com>
Subject: Re: git fast-import crashes importing commits with more than one 
	author
Date: Sat, 1 May 2010 18:28:44 +0100
Message-ID: <y2m86ecb3c71005011028t7f581ce7t98256aa8f8bbb0bf@mail.gmail.com>
References: <1272728636.27562.12.camel@localhost.localdomain> 
	<m2ocgztw7z.fsf@igel.home> <g2x86ecb3c71005010947x662aad8bn1fc2950d741b07e7@mail.gmail.com> 
	<7vbpcz5ylz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Giedrius Slavinskas <giedrius.slavinskas@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 01 19:29:16 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8GV9-0001SN-Rn
	for gcvg-git-2@lo.gmane.org; Sat, 01 May 2010 19:29:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752833Ab0EAR3J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 May 2010 13:29:09 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:33398 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751887Ab0EAR3I convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 May 2010 13:29:08 -0400
Received: by pwj9 with SMTP id 9so673054pwj.19
        for <git@vger.kernel.org>; Sat, 01 May 2010 10:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received
         :in-reply-to:references:from:date:x-google-sender-auth:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=SSLh+awHSaWCFbLX6IurPjzLDF/N44TYAZEXsyQhfUg=;
        b=rfDdOALAZ5ORB0llkZePrYJWKK4tdaY+K+gkeBuENXvAi94+Ucrp/SRsfUMMf0jHd/
         YrywPh8wk3A0Ox+Q9buMLnl07FHZf7D+Ma5hbkEzsYHSYfTO4VZ+S4DAjfHXgN+uBtmX
         LDGZEo3iHyYPDNulmVDtfMNeg80a967sVtSXM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=fDCGVMlPSFxLuKPe8+d0tlIg7BJftHVLrd5hI2PAcZGuygfsTWguw59r7yskjjvkvo
         GNOEJ4+qyjwgFygQzO+xB8yL7DLngnOjzcx+WV2QG3wPSDOg8oGQt3cu56nTBbjMuES/
         qQkPrBHDNClw2It8U0uZ8XVdZ+anBpOHLCzMw=
Received: by 10.142.152.8 with SMTP id z8mr7691995wfd.28.1272734944099; Sat, 
	01 May 2010 10:29:04 -0700 (PDT)
Received: by 10.142.191.1 with HTTP; Sat, 1 May 2010 10:28:44 -0700 (PDT)
In-Reply-To: <7vbpcz5ylz.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: 4280b9fa9d5bf977
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146102>

On 1 May 2010 18:19, Junio C Hamano <gitster@pobox.com> wrote:
> Dmitrijs Ledkovs <dmitrij.ledkov@ubuntu.com> writes:
>
>> On 1 May 2010 17:36, Andreas Schwab <schwab@linux-m68k.org> wrote:
>>> Giedrius Slavinskas <giedrius.slavinskas@gmail.com> writes:
>>>
>>>> git fast-import does not support commits with more than one author=
=2E I
>>>> try to import bzr repository and it crashes.
>>>
>>> You can find a patch here:
>>> <http://bazaar.launchpad.net/~schwab-linux-m68k/bzr-fastimport/fast=
import.dev/revision/262>
>>>
>>> Andreas.
>>
>> Although this is fine shouldn't we put the additional authors to the
>> signed-off: lines in the git commit message?
>
> If an author didn't sign-off in the log message, a tool shouldn't add=
 it
> automatically. =C2=A0Doing so makes S-o-b meaningless.
>

=46air enough. I'm justing thinking on how to support round-tripping to
bzr with import/export cause there are a few other properties bzr
needs to recreate identical repository. Is it more appropriate for the
marks format revision (bzr side of it)?
