From: =?UTF-8?B?5oOg6L22576k?= <huiyiqun@gmail.com>
Subject: Re: [PATCH/RFC/GSoC 3/3] t0301: test credential-cache support of XDG_RUNTIME_DIR
Date: Fri, 18 Mar 2016 13:11:55 +0800
Message-ID: <CAKqreuywzU2i42WzFCOOZWYfgeLXwQA_Ok1E4rZ94RcEaH_abA@mail.gmail.com>
References: <CAKqreux4aYhXTE9kUHKoKCJ2-4KDWyi58ioCm-CWqXhUYCtEEw@mail.gmail.com>
	<1458122865-29447-1-git-send-email-huiyiqun@gmail.com>
	<1458122865-29447-3-git-send-email-huiyiqun@gmail.com>
	<20160316171535.GC4039@sigill.intra.peff.net>
	<CAKqreuw7Am_wZQjYYjvsxx0Ccr4OOwoF=EnLvMTK9jxeBUFv5Q@mail.gmail.com>
	<20160318050017.GA22327@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Your friend <pickfire@riseup.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 18 06:12:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agmhf-00053d-Tm
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 06:12:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752893AbcCRFL6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Mar 2016 01:11:58 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:35097 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752740AbcCRFL5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Mar 2016 01:11:57 -0400
Received: by mail-ob0-f171.google.com with SMTP id fp4so105806179obb.2
        for <git@vger.kernel.org>; Thu, 17 Mar 2016 22:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-transfer-encoding;
        bh=CosWaCv8jISm+mKNng0lFenZcQPxLdzu7GEU2o+/j84=;
        b=1IQho1A94c6bJZ5JHf0H5jXl6Y1uBh8pT21BhRG8NM0DNNSwJUyVTdqAb+JIViQnFq
         mJwL18emL00VCnavNZQF3wVJtlEb7bRjUK333JBW5Nynv7kJKPucwFzPXXlbAE6wlwo/
         sD1r0R3KWCFacoWyTZOzRlHxPJSx7ZIvCtYLoJO/s9iR4BAey/Gxfx2Zpey03/Q9CE7s
         zz2cvStLSQo0fFUF4EpF6VvN7eQ0Tt1w6k6Ydz0N98j1Ox1F7OlyJXQ1pq+OPefBuK5u
         NQnEH3SGiP3xrhZmG/x1/pgPIdoPu1UXvn6MxITdapkatVU3w8SRnZQ7+qu43s2CLca9
         oKfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=CosWaCv8jISm+mKNng0lFenZcQPxLdzu7GEU2o+/j84=;
        b=iUx0tJF0oK4QELIIfkWBgR7Buci7427QRUxKLaI7vhWtCy7Mykn8sy+u9uRoPR3DN6
         JQdmOgPdn2o7gX6aI6H1fZaIApFka5OJenT+ZZWWQ9Z8YqVrmA7t82T1HVBqxPJEix0a
         nFSGZGr4pEu6/fWTmUe0hci8Xd6Y/8nJ5C2TuXuq9qx9SoEzOCt3BeJ98j5mnbxGpx38
         /nEJ3Fwxnjzs8VJe4rrgWGTz7oyR+JkECVgsijDt9L/FrlH+h45uCsD59zdfSTGrIfLD
         BwZmdMFisTo7m+ajIByf1sLvmGLyNeYhGdVVDqfXpS3lQLIhO6J4pMg04nR19v9jkkzL
         eEgg==
X-Gm-Message-State: AD7BkJK5y++KagoxQC/7iS+10w9/OrpqJWfXlbLbBhGBh0wrQoDeDpk1rMCmEYwlSOj63kATD9Qq4L3zyzNtzg==
X-Received: by 10.182.138.7 with SMTP id qm7mr9070120obb.58.1458277916066;
 Thu, 17 Mar 2016 22:11:56 -0700 (PDT)
Received: by 10.157.43.68 with HTTP; Thu, 17 Mar 2016 22:11:55 -0700 (PDT)
In-Reply-To: <20160318050017.GA22327@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289189>

2016-03-18 13:00 GMT+08:00 Jeff King <peff@peff.net>:
> On Fri, Mar 18, 2016 at 12:34:04PM +0800, =E6=83=A0=E8=BD=B6=E7=BE=A4=
 wrote:
>
>> >> +test_expect_success 'set $XDG_RUNTIME_DIR' '
>> >> +     XDG_RUNTIME_DIR=3D$HOME/xdg_runtime/
>> >> +'
>> >
>> > Doesn't this need to export the variable so that credential-cache =
can
>> > see it?
>>
>> I'm not sure, but it seems that a little clean up code added before
>> send-email
>> make the test fail. At that time, I run test without building. I've =
send
>> PATCH v2
>> which runs well on my computer. However, $XDG_RUNTIME_DIR is still n=
ot
>> exported, but that just works.
>>
>> I will try to dig deeper into the bash script to see why.
>
> I suspect it is because you have $XDG_RUNTIME_DIR defined in your
> environment, which causes the shell to automatically export it. I don=
't,
> so an explicit "export" is required to for the variable to make it to
> its children.

Yes, that's the problem. the explicit "export" is new knowledge for me,=
 thanks.

> I think we should actually be unsetting it in test-lib.sh for all tes=
ts,
> as we do for XDG_CONFIG_HOME. That makes sure the tests are running w=
ith
> a known state.

Well, I seems a good choice.

> For the non-XDG_RUNTIME_DIR tests, does this mean we are creating the
> socket in /tmp? I'm not entirely happy with that, as we usually try t=
o
> have the test suite avoid touching anything outside of its trash
> directories.
>
>> > This runs the full suite of tests twice (once here, and once for t=
he
>> > original helper_test invocation you left below). Shouldn't we just=
 do it
>> > once (making sure that $XDG_RUNTIME_DIR is respected)?
>>
>> I'd like to test the behavior of git-credential-cache when $XDG_RUNT=
IME_DIR
>> is unset.
>>
>> In `t/t0302-credential-store.sh`, helper_test is also run multiple t=
imes.
>> That's why I do so.
>
> OK. My main concern was just that the tests would take too long, but =
the
> slow one is the cache test at the end, which is not repeated. So I th=
ink
> this is fine.
>
>> > I wondered if this might be racy. credential-cache tells the daemo=
n
>> > "exit", then waits for a response or EOF. The daemon sees "exit" a=
nd
>> > calls exit(0) immediately. We clean up the socket in an atexit()
>> > handler. So I think we are OK (the pipe will get closed when the p=
rocess
>> > exits, and the atexit handler must have run by then).
>> >
>> > But that definitely was not designed, and is just how it happens t=
o
>> > work. I'm not sure if it's worth commenting on that (here, or perh=
aps in
>> > the daemon code).
>>
>> I'm still confused.
>>
>> What do you mean by "pipe"? should it be "socket" instead?
>
> Sorry, yes, I used "pipe" and "socket" interchangeably there.
>
>> What is not designed? cleanup being done, my tests passing or the
>> synchronization?
>
> The synchronization. If the daemon were implemented as:
>
>   if (!strcmp(action.buf, "exit")) {
>         /* acknowledge that we got command */
>         fclose(out);
>         exit(0);
>   }
>
> for example, then the client would exit at the same that the daemon i=
s
> cleaning up the socket, and we may or may not call test_path_is_missi=
ng
> before the cleanup is done.
>
> I think it's OK to rely on that, but we may want to put a comment to
> that effect in the daemon code so that it doesn't get changed.

The current implementation is natural for me. But having additional com=
ment
is better.

>
> -Peff
