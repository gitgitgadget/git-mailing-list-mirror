From: Timur Tabi <timur@freescale.com>
Subject: Re: How can I tell if a file has been updated upstream?
Date: Fri, 5 Feb 2010 10:57:47 -0600
Message-ID: <ed82fe3e1002050857h300de908n5f3e4497c9ec2460@mail.gmail.com>
References: <ed82fe3e1002050823gec57827j184c9c4cff4f4a45@mail.gmail.com> 
	<7vk4urbp9u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 17:58:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdRVf-0002gU-NW
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 17:58:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244Ab0BEQ6T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Feb 2010 11:58:19 -0500
Received: from mail-fx0-f211.google.com ([209.85.220.211]:55077 "EHLO
	mail-fx0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755871Ab0BEQ6S convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Feb 2010 11:58:18 -0500
Received: by fxm3 with SMTP id 3so4224975fxm.39
        for <git@vger.kernel.org>; Fri, 05 Feb 2010 08:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:from:date:x-google-sender-auth:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=iMUWizhMEAr2sHS6hDVQ+R77KsitzoT8AdC5N1B73xw=;
        b=K/4iCWYm2Fhfaw1BGjSBi1G9Sm4EMvUdmPMZ0ZpL/je3qQ6IFj2E5pQtnz+8PI07+d
         lEjTllBM2zliJbul2ErKZOojk+XwzSIJEHRQkrSci2Ati5rylIlL+6dsQK9XuWP4V125
         h43ACAsNs3s5g45I4E98IDLFfzoN0nzTPKoYY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=scMrU300896UXSnREh1X7isL6VkK4pgCAN7dSoijn+Qwf+vTqIkKrS96aasTnt7KuC
         MumdQ20wvewsJ95o7DH9pK2kSxnVPJ1+RSTW62NpTJUPd5T439QAo1Px8rheRKmRl6NA
         eU3uj7e9t3oMRan+l/JbEnmE51CUatrAvVubg=
Received: by 10.239.186.80 with SMTP id f16mr321853hbh.125.1265389096715; Fri, 
	05 Feb 2010 08:58:16 -0800 (PST)
In-Reply-To: <7vk4urbp9u.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: bb3017b842b9690b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139059>

On Fri, Feb 5, 2010 at 10:50 AM, Junio C Hamano <gitster@pobox.com> wro=
te:

> So whenever I run your script it calls home, spend a roundtrip time, =
and
> nags me to update?

Yes.  Fortunately, it's all on an internal network, so the overhead is =
low.

>=A0I don't want to be working with you unless I can go
> without running that script less often than once a week ;-)

That's about how often most people will run the script.

> You need to teach it how to call home. =A0How do your users "clone"?

git clone git://....

Only I have ssh access to my repository.

> Also how do they run the script? =A0Directly out of the
> repository work tree, or is there a "make install" step involved?

Directly out of the repository.  It's just a Python script.

> If your users are running from the work tree copy unmodified, then yo=
u
> would need to look at sys.argv[0] to find out where it is, use that t=
o
> find the repository, and using its .git/config learn how the user pul=
ls
> from your repository (i.e. git config remote.origin.url), and at the =
same
> time which version it is (i.e. git rev-parse HEAD).

Ok.

> At runtime, you would run "ls-remote HEAD" and compare with the versi=
on
> you are running. =A0It may be stale, or it may not be.

Ok.

> How big is the script? =A0It _might_ be faster to distribute a launch=
er that
> downloads the real script every time it runs and runs that fresh copy=
 that
> is guaranteed to be the latest than doing all the hassle of the above=
=2E

I don't want to force an update, and I don't want to have to email
everyone whenever there is an update.   This seems to be the least
intrusive approach.

--=20
Timur Tabi
Linux kernel developer at Freescale
