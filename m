From: =?UTF-8?B?5oOg6L22576k?= <huiyiqun@gmail.com>
Subject: Re: [PATCH/RFC/GSoC 3/3] t0301: test credential-cache support of XDG_RUNTIME_DIR
Date: Fri, 18 Mar 2016 14:02:08 +0800
Message-ID: <CAKqreuwpjhLnttP4Z_KmYwjiRYxBVC6gLShKLAcjox1VVqfm7w@mail.gmail.com>
References: <CAKqreux4aYhXTE9kUHKoKCJ2-4KDWyi58ioCm-CWqXhUYCtEEw@mail.gmail.com>
	<1458122865-29447-1-git-send-email-huiyiqun@gmail.com>
	<1458122865-29447-3-git-send-email-huiyiqun@gmail.com>
	<20160316171535.GC4039@sigill.intra.peff.net>
	<CAKqreuw7Am_wZQjYYjvsxx0Ccr4OOwoF=EnLvMTK9jxeBUFv5Q@mail.gmail.com>
	<20160318050017.GA22327@sigill.intra.peff.net>
	<CAKqreuywzU2i42WzFCOOZWYfgeLXwQA_Ok1E4rZ94RcEaH_abA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Your friend <pickfire@riseup.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 18 07:04:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agnWd-00035p-Gt
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 07:04:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbcCRGCL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Mar 2016 02:02:11 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:34852 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756736AbcCRGCJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Mar 2016 02:02:09 -0400
Received: by mail-ob0-f180.google.com with SMTP id fp4so106577910obb.2
        for <git@vger.kernel.org>; Thu, 17 Mar 2016 23:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-transfer-encoding;
        bh=L/aXcLHQOAGc3FVCYOlwAFfCVKFk4ewyjmtjyaTLxJY=;
        b=bKbyI3PQz0LjcLhC9TrzHESvYtAQnaTYbh7xn8HIQFN19w7ZKZ8EJ+YttpMf58yvvk
         k8oWDko+ng2l9xLnbl4ZwMDO+TPeIBy+VAiWr4jcvuipDqDiiObUzh6Q0k12w146rb/O
         EuuSPKBEZdukBdmhfhv01XeNWi1LP54PiP4d+aRQ3+Ktl6s0rp02NbsSrAE8zRYoB02i
         CuTATiKDZOvX59jFGvduvdvkjaXdStdua1ZKYrPE6uS6xQy+y1x9aMibwLeKIGkyl+nJ
         w3QfG49nIQCdnzRRwr15a6CH6BD+7VUc6JaIecrAGVsENxVHlSbRFDKVty/9BE7PjSnO
         AjAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=L/aXcLHQOAGc3FVCYOlwAFfCVKFk4ewyjmtjyaTLxJY=;
        b=Je5HzBbddjnVQsq2uIvGQCpGnjZ36AY7tcuzUHwxCoCBDF2s7M+MSicw9QpAjyBbNs
         yRHVS5oN/gyIvzjMMF0Dd+O4yr8Mxs5vChz3xZiJWSgRDzmC1P7TrJh79zbgt0IHs0G3
         VzNdizmyjyt7cMeOmuv6sGjFEpSH0fBe8rogAAEXMiu1fwX+BoHcEvTGYb47HyAfY/Ea
         y9DkmM7lPpVbWTC8PnuzeGg1thOstfuLZHeYKhhmB4j832lP+eRLG5+04rjW0KzkApsG
         5FDRoAjEUSyUYzqBm652ecvjfMVcs/oWIIY4lTyjnzV7F/m2pTgS4gd/EyeLFxZjNhJA
         VVFw==
X-Gm-Message-State: AD7BkJLOpT92Gk025Y9CGZXqi6oOXmnVqajl02kjjJg+WZuTO1Va5hTYrowNm9lqbBiYzH/p7HUx7AoFLKMgEg==
X-Received: by 10.60.150.163 with SMTP id uj3mr8560223oeb.67.1458280928141;
 Thu, 17 Mar 2016 23:02:08 -0700 (PDT)
Received: by 10.157.43.68 with HTTP; Thu, 17 Mar 2016 23:02:08 -0700 (PDT)
In-Reply-To: <CAKqreuywzU2i42WzFCOOZWYfgeLXwQA_Ok1E4rZ94RcEaH_abA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289199>

2016-03-18 13:11 GMT+08:00 =E6=83=A0=E8=BD=B6=E7=BE=A4 <huiyiqun@gmail.=
com>:
> 2016-03-18 13:00 GMT+08:00 Jeff King <peff@peff.net>:
>> On Fri, Mar 18, 2016 at 12:34:04PM +0800, =E6=83=A0=E8=BD=B6=E7=BE=A4=
 wrote:
>>
>>> >> +test_expect_success 'set $XDG_RUNTIME_DIR' '
>>> >> +     XDG_RUNTIME_DIR=3D$HOME/xdg_runtime/
>>> >> +'
>>> >
>>> > Doesn't this need to export the variable so that credential-cache=
 can
>>> > see it?
>>>
>>> I'm not sure, but it seems that a little clean up code added before
>>> send-email
>>> make the test fail. At that time, I run test without building. I've=
 send
>>> PATCH v2
>>> which runs well on my computer. However, $XDG_RUNTIME_DIR is still =
not
>>> exported, but that just works.
>>>
>>> I will try to dig deeper into the bash script to see why.
>>
>> I suspect it is because you have $XDG_RUNTIME_DIR defined in your
>> environment, which causes the shell to automatically export it. I do=
n't,
>> so an explicit "export" is required to for the variable to make it t=
o
>> its children.
>
> Yes, that's the problem. the explicit "export" is new knowledge for m=
e, thanks.
>
>> I think we should actually be unsetting it in test-lib.sh for all te=
sts,
>> as we do for XDG_CONFIG_HOME. That makes sure the tests are running =
with
>> a known state.
>
> Well, I seems a good choice.
>
>> For the non-XDG_RUNTIME_DIR tests, does this mean we are creating th=
e
>> socket in /tmp? I'm not entirely happy with that, as we usually try =
to
>> have the test suite avoid touching anything outside of its trash
>> directories.
>>
>>> > This runs the full suite of tests twice (once here, and once for =
the
>>> > original helper_test invocation you left below). Shouldn't we jus=
t do it
>>> > once (making sure that $XDG_RUNTIME_DIR is respected)?
>>>
>>> I'd like to test the behavior of git-credential-cache when $XDG_RUN=
TIME_DIR
>>> is unset.
>>>
>>> In `t/t0302-credential-store.sh`, helper_test is also run multiple =
times.
>>> That's why I do so.
>>
>> OK. My main concern was just that the tests would take too long, but=
 the
>> slow one is the cache test at the end, which is not repeated. So I t=
hink
>> this is fine.
>>
>>> > I wondered if this might be racy. credential-cache tells the daem=
on
>>> > "exit", then waits for a response or EOF. The daemon sees "exit" =
and
>>> > calls exit(0) immediately. We clean up the socket in an atexit()
>>> > handler. So I think we are OK (the pipe will get closed when the =
process
>>> > exits, and the atexit handler must have run by then).
>>> >
>>> > But that definitely was not designed, and is just how it happens =
to
>>> > work. I'm not sure if it's worth commenting on that (here, or per=
haps in
>>> > the daemon code).
>>>
>>> I'm still confused.
>>>
>>> What do you mean by "pipe"? should it be "socket" instead?
>>
>> Sorry, yes, I used "pipe" and "socket" interchangeably there.
>>
>>> What is not designed? cleanup being done, my tests passing or the
>>> synchronization?
>>
>> The synchronization. If the daemon were implemented as:
>>
>>   if (!strcmp(action.buf, "exit")) {
>>         /* acknowledge that we got command */
>>         fclose(out);
>>         exit(0);
>>   }
>>
>> for example, then the client would exit at the same that the daemon =
is
>> cleaning up the socket, and we may or may not call test_path_is_miss=
ing
>> before the cleanup is done.
>>
>> I think it's OK to rely on that, but we may want to put a comment to
>> that effect in the daemon code so that it doesn't get changed.
>
> The current implementation is natural for me. But having additional c=
omment
> is better.

I believe git-credential--daemon is a better place to comment on, but
I'm not sure
whether the comment should be included in this patch set. Above all, th=
ey are
not quite related.

>
>>
>> -Peff
