From: Samuel Bronson <naesten@gmail.com>
Subject: Re: [PATCH 3/3] Makefile: add commented out 's for Emacs here, too
Date: Sat, 30 May 2009 14:37:14 -0400
Message-ID: <db65a1cd0905301137o482d9b14se0c438678fb4e4dd@mail.gmail.com>
References: <1243289231-32500-1-git-send-email-naesten@gmail.com>
	 <1243289231-32500-2-git-send-email-naesten@gmail.com>
	 <1243289231-32500-3-git-send-email-naesten@gmail.com>
	 <200905301505.38016.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org
To: markus.heidelberg@web.de
X-From: git-owner@vger.kernel.org Sat May 30 20:37:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MATQq-0003uY-2Z
	for gcvg-git-2@gmane.org; Sat, 30 May 2009 20:37:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762313AbZE3ShP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 May 2009 14:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761962AbZE3ShO
	(ORCPT <rfc822;git-outgoing>); Sat, 30 May 2009 14:37:14 -0400
Received: from an-out-0708.google.com ([209.85.132.243]:60118 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761920AbZE3ShN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 May 2009 14:37:13 -0400
Received: by an-out-0708.google.com with SMTP id d40so13931702and.1
        for <git@vger.kernel.org>; Sat, 30 May 2009 11:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=feOmGIAzznswoXPEeklS/PGeKbu4bG6vx05/WWYsSGQ=;
        b=Dx/MqTBc365CNmV2gs4zEB58MMGculIwMXHbevVaK2n4xOnyEPaZOFOgcJreZ0mJh6
         BT34d1nvRk7SOYdxnITXq2MhAGcICG9D918SvAMF9zPCF9vK4eTE7Fi7ZXFGOy0WjT2O
         sDHlkgpdSIjmK2IUT71SQqoxdsILBfevAv3WM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=VEn1/5VhDVzNYVWYRTIoQR8/wQu9Y2zcmKWeZKZK4KAB9rDEvSI/VAaEb9MGC1M0pO
         N75DgI3QeMubCVl7frtPBP/i7n923Iv9WvenatmS5o9LvUxpFIjuOfrNXeJlzqt7sSbr
         RCffu2/sJlfGUAfJ74v6jmRRTDBCQgPPjfe0A=
Received: by 10.100.213.13 with SMTP id l13mr5319900ang.110.1243708634674; 
	Sat, 30 May 2009 11:37:14 -0700 (PDT)
In-Reply-To: <200905301505.38016.markus.heidelberg@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120362>

On Sat, May 30, 2009 at 9:05 AM, Markus Heidelberg
<markus.heidelberg@web.de> wrote:

>> +# The above comment is in case there is an odd number of _SQ
>> +# definitions above, since they seem to confuse Emacs. If there is =
an
>> +# even number of such definitions, it does no harm, since emacs
>> +# doesn't recognize string delimiters inside recognized comments.
>
> This doesn't only confuse Emacs, so the subject should be changed to
> something like "... to unconfuse editors' syntax highlighting" and be
> squashed with Patch 1/3, since this is exactly the same issue.
>
> I think this is way too much comment and would prefer none at all. I
> also would remove the global 4-line comment.

Okay. I guess I'll save it for the commit message (rewritten to match
the changes suggested below), maybe keep two words for the first one
in each Makefile ...

> But Vim for example is not satisfied with your fix above. It needs th=
is
> workaround for every line and additionally needs a closing parenthesi=
s,
> because the real one is hidden in the string. So this would work for
> Vim:
>
> =C2=A0PERL_PATH_SQ =3D $(subst ','\'',$(PERL_PATH))
> +#')
> =C2=A0TCLTK_PATH_SQ =3D $(subst ','\'',$(TCLTK_PATH))
> +#')

Yeah, emacs would work better that way too -- I was going for a
low-disruption patch, and was mostly interested in making sure
unrelated portions of the Makefile didn't get swallowed by
string-coloring. I didn't particularly care about the parentheses --
does Vim care about that for indentation, or just paren-matching?

I wonder why emacs and vim both have the same problem with that
construct ... and how hard it would be to fix. (Thankfully, this
approach to dealing with the breakage will not confuse corrected
versions, since they will basically ignore the contents of the
comments for syntax highlighting purposes :-).

> Maybe even behind the concerned line to avoid clutter, if this doesn'=
t
> cause other problems:
>
> -PERL_PATH_SQ =3D $(subst ','\'',$(PERL_PATH))
> +PERL_PATH_SQ =3D $(subst ','\'',$(PERL_PATH))#')
> -TCLTK_PATH_SQ =3D $(subst ','\'',$(TCLTK_PATH))
> +TCLTK_PATH_SQ =3D $(subst ','\'',$(TCLTK_PATH))#')

That should at least work a lot better than my initial attempt at 1/3,
where I had a space before the # -- the space broke the build, which
is actually how I ended up noticing the need for 2/3 .
