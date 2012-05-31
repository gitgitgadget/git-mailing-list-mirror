From: David Michael Barr <davidbarr@google.com>
Subject: Re: [PATCH 5/7] vcs-svn: fix cppcheck warning
Date: Thu, 31 May 2012 21:17:03 +1000
Message-ID: <CAFfmPPPZpH7WMLtE9YVOfzO2pjU8Scudg4hVp-ot+SAFxKLs3Q@mail.gmail.com>
References: <1337868259-45626-1-git-send-email-davidbarr@google.com>
	<1337868259-45626-6-git-send-email-davidbarr@google.com>
	<20120524142058.GA3732@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 31 13:17:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sa3NO-0001wh-VM
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 13:17:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753550Ab2EaLRG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 May 2012 07:17:06 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:60370 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752773Ab2EaLRF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 May 2012 07:17:05 -0400
Received: by gglu4 with SMTP id u4so669896ggl.19
        for <git@vger.kernel.org>; Thu, 31 May 2012 04:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding:x-system-of-record;
        bh=vPJK6FYtP92eMBligbb+s/lt1W2AL7NORIyk0PLvIQ8=;
        b=eJP3EVWW3qhG6/Q4R/ZlZVL9F+SsKsoSClgO7zzTULhP9vQQPYKtofv+I7KO9ny8Fz
         ZIh1y5P68NMNLy/2PzjP4GNSTG9K0TLBgTgQ1uUpqr9LyXRteGGwxDnH3UhGF9APOLXz
         vX7RU0tos2EAbQ2WwWW4x0DbVvw2wkH2exfY16Bd59gH1txyjOoo3Jj13yAvPNSWJp5v
         jToQzZpm0DNLA3tXU45ynVtEyxoAWs4V7YhoCX7zXPa3XoOfJHdwehd8YOhPadDZMEz6
         2JOx/xy9mKsF2uOUNfgt/Tf4qtRBzST4Qo1wVu6zQ8F7SIiRp7zMk4JP0GY7647Bx3u6
         fm9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding:x-system-of-record
         :x-gm-message-state;
        bh=vPJK6FYtP92eMBligbb+s/lt1W2AL7NORIyk0PLvIQ8=;
        b=FFNTzT8gqbwy/ga0Svm1+5iLDWM7L/An04+upPGdYdmHq7TgdfNGNqftWyrDbYWkmK
         u2kv22YX/KjSXaKiLQ9vbTvKsyGyU0QWONwBmeya2xNQg3mNGOI4dBLeQjmNDszEPH1V
         GA3wEMh/WyJxWp+gg2JMJ1VihATxDQ6psaQD//QOvzNG9pWEG3b4Yy+ZgTQRHQVyUQhV
         49nphNCvn4GciLNrFZleoIJjz0nsmRm4cNOtt+9OAVEA4Ciu7SRUO1/w98bNOy7i5PTK
         +SxOc1NnHoMaglMy9omRaFuBCp5anXxF7B2oyeG1uCDjpfgesAdzkHccHFCVILtde27t
         dIhQ==
Received: by 10.236.77.201 with SMTP id d49mr1867481yhe.85.1338463023752;
        Thu, 31 May 2012 04:17:03 -0700 (PDT)
Received: by 10.236.77.201 with SMTP id d49mr1867466yhe.85.1338463023589; Thu,
 31 May 2012 04:17:03 -0700 (PDT)
Received: by 10.101.155.23 with HTTP; Thu, 31 May 2012 04:17:03 -0700 (PDT)
In-Reply-To: <20120524142058.GA3732@burratino>
X-System-Of-Record: true
X-Gm-Message-State: ALoCoQm3ySFAkGtyWioPP/FhCPGTNBze7javQ5fiQSq0XPWnXkjydnecnkJaxnr1FoSG4ck/a2T4UYAc9iCIjZCcj1pHsqNfIYc2GG2pMa5LTMUn+y0e4L/rjjnXfTlNcfnKewRdJgDWSzxFLirSEuH2LjpdeV/okA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198881>

On Fri, May 25, 2012 at 12:20 AM, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
> Hi,
>
> First, thanks much for this series! =A0I especially like patch #4.
>
> David Barr wrote:
>
>> [vcs-svn/fast_export.c:211]: (warning) Using sizeof with a numeric c=
onstant
>> as function argument might not be what you intended.
> [...]
>> - =A0 =A0 =A0 =A0 =A0 =A0 assert(!signed_add_overflows(preimage.max_=
off, 1));
>> + =A0 =A0 =A0 =A0 =A0 =A0 assert(!signed_add_overflows(preimage.max_=
off, (off_t) 1));
>
> I think this is due to a typo in the compat-util.h compatibility laye=
r
> you are using. =A0In git.git there is
>
> =A0 =A0 =A0 =A0#define signed_add_overflows(a, b) \
> =A0 =A0 =A0 =A0 =A0 =A0((b) > maximum_signed_value_of_type(a) - (a))
>
> so the sizeof() operator is applied to preimage.max_off and all is we=
ll.
> By contrast, in svn-dump-fast-export.git it says
>
> =A0 =A0 =A0 =A0#define signed_add_overflows(a, b) \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0((a) > maximum_signed_value_of_type(b)=
 - (b))
>
> Though the comment describing signed_add_overflows() does say that "a=
"
> and "b" should have the same type, I like being able to ask if
> signed_add_overflows(n, 1) in a non-fussy way that does not introduce
> subtle bugs when the type of "n" changes, so I'd prefer not to take
> this patch.

Thank you for the review. I will queue the typo fix upstream and drop
this patch.

--
David Barr
