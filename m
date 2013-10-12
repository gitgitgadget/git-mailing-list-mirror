From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 1/5] pull: rename pull.rename to pull.mode
Date: Fri, 11 Oct 2013 21:08:00 -0500
Message-ID: <CAMP44s3669E7JyEjP_ErYt7JN2eHv0mX4+p_=ZP4_LDatnw2vg@mail.gmail.com>
References: <1378689796-19305-1-git-send-email-felipe.contreras@gmail.com>
	<1378689796-19305-2-git-send-email-felipe.contreras@gmail.com>
	<522E3C6A.3070409@bbn.com>
	<CAMP44s1OyST3S1HEdS38WPsjq6w9SekuwT4DRUgVvduATox9tw@mail.gmail.com>
	<20130910022152.GA17154@sigill.intra.peff.net>
	<CAMP44s1FfQ-1pAK8T1cmiZk4i17HnpvzPwuZrzHiiXSmGzbrRw@mail.gmail.com>
	<vpqmwnljdmn.fsf@anie.imag.fr>
	<52589027a4851_5dc4c2be742754f@nysa.mail>
	<20131012005035.GA27939@sigill.intra.peff.net>
	<CAMP44s2y0UZ9uS8xtG2WDD=k5pHSG+K+_WM2dj-DVaUDy4djdA@mail.gmail.com>
	<20131012012515.GA1778@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Richard Hansen <rhansen@bbn.com>, git@vger.kernel.org,
	Andreas Krey <a.krey@gmx.de>,
	John Keeping <john@keeping.me.uk>,
	Philip Oakley <philipoakley@iee.org>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Oct 12 04:08:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUoci-0006EH-Ic
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 04:08:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752433Ab3JLCID (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Oct 2013 22:08:03 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:65387 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751821Ab3JLCIC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Oct 2013 22:08:02 -0400
Received: by mail-la0-f51.google.com with SMTP id es20so4145668lab.10
        for <git@vger.kernel.org>; Fri, 11 Oct 2013 19:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=fsL1NUH0ts780PCytOJXfIxhv1mkK6S2sJZrXBB8bN4=;
        b=hbOmhva3kL0Yabd8zHnfDqbDUeCrjmhJ85CAeBZz2gnX+SkqaBs791LuhU0BxxLVOi
         591nRbTFkoEo7GKnmP+zb68cA/i/JjnRgnwp0pb8b94+yvt9syjuVxhjYOsCOrNcULsL
         qpC9jGVspIFTw00Hq3TDOQ7mIuCE2MhDBA5UQxRxVj5jPSoNerIAr7bR/Gxf45VrQE5F
         XFoWhzs551rT9aIOHsNUqOAO4YaFOGFiBDPmQEPyOzWG0HkpzN+bblcDjP5eYdL5+Uir
         DndISp42l83XB5y7i/QUxI+iEkyOLtz5PQQj0pjh4FRm6JtTvWYQTmbnHNwTiJo0f9Qq
         a8yQ==
X-Received: by 10.112.172.137 with SMTP id bc9mr19246520lbc.21.1381543680331;
 Fri, 11 Oct 2013 19:08:00 -0700 (PDT)
Received: by 10.114.91.230 with HTTP; Fri, 11 Oct 2013 19:08:00 -0700 (PDT)
In-Reply-To: <20131012012515.GA1778@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235938>

On Fri, Oct 11, 2013 at 8:25 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Oct 11, 2013 at 08:15:46PM -0500, Felipe Contreras wrote:
>
>> >> You are free to go ahead and implement 'warning ()' in git-sh-setup.sh, in the
>> >> meantime no shell script does that, and that's no reason to reject this patch
>> >> series.
>> >
>> > You are completely missing Matthieu's point that we attempt to be
>> > consistent in the format of messages, as well as where they are output,
>> > and from a user's perspective it does not matter what language the tool
>> > is implemented in.
>>
>> If we truly did that, there should be a warning () function, like in C.
>
> Or people could hand-code them to look similar, which is exactly what
> has happened.

And by doing that be prone to make mistakes, like using 'WARNING',
instead of 'warning'. But I guess you don't care about consistency
_that much_.

> If you want to factor out a warning function to clean up the code, be my
> guest. But the lack of one does not provide an argument that you should
> break consistency.

Consistency is already broken.

>> > -               echo "The configurations pull.rebase and branch.<name>.rebase are deprecated."
>> > -               echo "Please use pull.mode and branch.<name>.pullmode instead."
>> > +               echo >&2 "warning: The configurations pull.rebase and branch.<name>.rebase are deprecated."
>> > +               echo >&2 "Please use pull.mode and branch.<name>.pullmode instead."
>> [...]
>>
>> Are you sure you want me to squash that in? Because the warnings
>> wouldn't be consistent. Some would be "WARNING: " and others would be
>> "warning: ". Personally I don't care, but if your argument is
>> consistency, you should. If we had a warning () function, we could
>> truly be consistent.
>
> It is significant in the most important ways, which are labeling it at
> all, and sending it to stderr. Capitalization is less important, in my
> opinion.

It's still inconsistent.

> Using a lowercase version is much more consistent with the warnings
> produced by C code, which is why I chose it over the capitalized
> version. Again, if you want to change the existing WARNING cases in the
> shell scripts to be consistent with C output, be my guest.

It seems you are not that interested in consistency after all.

> Do you actually have some reason for wanting to output to go to stdout?

I'm fine with 'echo "warning: foo" >&2', but still, if you really
cared about consistency, there would be a warn() function, precisely
to avoid the mistakes of WARNING vs. warning which are already there,
plus future ones.

-- 
Felipe Contreras
