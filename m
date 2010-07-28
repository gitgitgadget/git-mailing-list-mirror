From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] t/t6035-merge-dir-to-symlink.sh: Remove TODO on passing 
	test
Date: Wed, 28 Jul 2010 07:31:28 +0000
Message-ID: <AANLkTi=VBsjHJxogMiD-R+wFj6W3q2JevdfrXHWqAdKE@mail.gmail.com>
References: <1280249698-11001-1-git-send-email-avarab@gmail.com>
	<AANLkTikZO=RENz9HnHsiPoAv+fSz03p-zZPMepcX=KKK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 28 09:31:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oe171-0003bj-0z
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 09:31:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752771Ab0G1Hba convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Jul 2010 03:31:30 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:44122 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751173Ab0G1Hb3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Jul 2010 03:31:29 -0400
Received: by iwn7 with SMTP id 7so4573324iwn.19
        for <git@vger.kernel.org>; Wed, 28 Jul 2010 00:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=kssAH77DXDvuPlYvf5k34xIZfcjllmvWnQ6B018+Nh0=;
        b=Erhc8ojJO4rLw+nLcuRtjznOBU+L1zPHR7VXOulU6CeAwLsN+XdMIcxbrKWaEZOqAD
         Oo0GmhYSvr50bp7gfevMbkIUECdwjzGnUF3LeBl+VO+CtFj15T+PsljsQf7C0DDgZLeF
         EFOyU/qzYoHPLYgElyc/njGUyNe54VByc1igQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=tjPvcJboV54yk7wqXni9+PLXvN6N4wxzyRz+IY0DC6UWPuhUhxJC+peC/UE/b5SWMq
         kuRwFPIJGqlyd3ql1wP1MffZz04MorqyIKVJE8a8n/u3jtPhOvBAzi68IitPep8tGqY0
         ZYNUQYGSJUzDngIJ5y32oSrxDynMtR65/jk14=
Received: by 10.231.30.136 with SMTP id u8mr6698272ibc.19.1280302288527; Wed, 
	28 Jul 2010 00:31:28 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Wed, 28 Jul 2010 00:31:28 -0700 (PDT)
In-Reply-To: <AANLkTikZO=RENz9HnHsiPoAv+fSz03p-zZPMepcX=KKK@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152046>

On Tue, Jul 27, 2010 at 23:08, Elijah Newren <newren@gmail.com> wrote:
> Hi,
>
> On Tue, Jul 27, 2010 at 10:54 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarma=
son
> <avarab@gmail.com> wrote:
>> Various merge-recursive cases were fixed in "merge-recursive: Fix D/=
=46
>> conflicts" by Elijah Newren. Some tests were changed from
>> test_expect_failure to test_expect_success, but one fell through the
>> cracks.
>>
>> Change that test to use test_expect_success.
>
> Weird, I know I tested all of these individually and worked to make
> sure they all passed; I have no idea how I would have forgotten to
> update this particular test.

It still passes, but nothing flags unexpectedly passing TODO tests if
you use "make test", but if you use "prove" they're spotted.

On pu:

    v t (pu) $ prove ./t6035-merge-dir-to-symlink.sh
    ./t6035-merge-dir-to-symlink.sh .. ok
    All tests successful.

    Test Summary Report
    -------------------
    ./t6035-merge-dir-to-symlink.sh (Wstat: 0 Tests: 16 Failed: 0)
      TODO passed:   8
    Files=3D1, Tests=3D16,  1 wallclock secs ( 0.03 usr  0.01 sys +  0.=
10
cusr  0.53 csys =3D  0.67 CPU)
    Result: PASS

With this patch:

    v t (merge-dir-to-symlink-todo-test) $ prove ./t6035-merge-dir-to-s=
ymlink.sh
    ./t6035-merge-dir-to-symlink.sh .. ok
    All tests successful.
    Files=3D1, Tests=3D16,  1 wallclock secs ( 0.03 usr  0.02 sys +  0.=
13
cusr  0.53 csys =3D  0.71 CPU)
    Result: PASS

The default harness / aggregate-resaults *could* be fixed to deal with
it, but I haven't been motivated to do so since prove just works :)

> Anyway, thanks for cleaning up after me. =C2=A0:-)

No problem.
