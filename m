From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 2/2] interpret-trailers: add option for in-place editing
Date: Tue, 19 Jan 2016 19:20:28 -0500
Message-ID: <CAPig+cS_kOg6gJPW_VygzSYufTnw5Emsu88y8P=4_CTdnWCx-Q@mail.gmail.com>
References: <1452790676-11937-1-git-send-email-tklauser@distanz.ch>
	<1452790676-11937-3-git-send-email-tklauser@distanz.ch>
	<xmqqio2vki0i.fsf@gitster.mtv.corp.google.com>
	<CAPig+cRRdca7PfkqppY2X7KSFpHX0yH19fxRL+w_=u9vg7NV9A@mail.gmail.com>
	<xmqqio2pbgov.fsf@gitster.mtv.corp.google.com>
	<CAPig+cRi2knygjeaMtojAr65BE71B-z7q+s8V5rcGrV9Qja6jw@mail.gmail.com>
	<CAPig+cRozqCKdC2+nyG-UM6xFo_sSqa7OhGgcycyyDQujZHtHA@mail.gmail.com>
	<xmqqfuxt9ti3.fsf@gitster.mtv.corp.google.com>
	<CAPig+cRHTs9q4k=CqtY2j=ZtTYMU6_SPeCHkQe4m5AGXOjg_Ww@mail.gmail.com>
	<xmqqvb6p8bmm.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Tobias Klauser <tklauser@distanz.ch>,
	Christian Couder <chriscool@tuxfamily.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 20 01:20:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLgVm-0005QK-1a
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 01:20:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933316AbcATAUb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2016 19:20:31 -0500
Received: from mail-vk0-f66.google.com ([209.85.213.66]:33575 "EHLO
	mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932414AbcATAU3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2016 19:20:29 -0500
Received: by mail-vk0-f66.google.com with SMTP id n1so13519433vkb.0
        for <git@vger.kernel.org>; Tue, 19 Jan 2016 16:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=OnZfoxDKq+Cj64Iraw5g6jX+RMDcc2WJBJrvXyeTO2g=;
        b=dRlgbRDHpjuLi+3DDXobvCmX+ht343Iyobxa7i/pYcrLKRUXlpfFlz+Rla+q/qLUod
         OuqHQZNvQ2TaouDk+vh6NsxWZr5VuvYnLJcqTk1vrZKintPikv8/KqMhB4cNFcNYJfDD
         ai55Ax+MuZ/tYsssR4O9MGf3c9VWEgNzfPYQXMv3gB+nDVqvCvsUjKNfiGPb/dbGYgug
         lSEdBhk0g+myOF+b/uZFn5O+PH4CSRLX2s/gBxoMx2z+XFSQKdEX/kNUeqbAAdw1mOK/
         308/9CH9f66pkm8Gz4zzTnIrROMT4oAP43wJoiJf8dgEQiRYhc8j5ZVr5l/lewKMcZv2
         H9rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=OnZfoxDKq+Cj64Iraw5g6jX+RMDcc2WJBJrvXyeTO2g=;
        b=i2Z5PEItaE8zJxfwaxC3u4IuAtspoqtTk6khcndFnxnXJIm016qNkYgW9V6f9TI3pd
         o7i+cmjBMKlahXh2PhwTSB7C6rCzjw/MKafNlpALFRbfG3jLOt8i45/fG9LXAFKSD5oZ
         +5t8EjJ6tgLzoZUun2UXcDnHBKpEgh/oqGexh6FdG5TS602WXNbH9SKV6Gdauin1k8Os
         sb4hAALwAD0QbuiRkSJX7sIouTrEv0U9SJtu4LjYLSgAoFv3IpzbVe4/bhJ11HX2LB+H
         noUT5HnYEUgbR0XFLpH5m+8MLYVwnhSTox7Ba/bXCSmdUbxdb5T+w1lpG8ZDeuOD7xIs
         z6aQ==
X-Gm-Message-State: ALoCoQmqC3g0krnJTGEcNcIKdQ8b8ARMWkrdo+W0Sr/L99NjDU2PLFU6DKwBC5He/8ii7Ia4aaq1JPQt8dsXCNb87o5eg5ktkg==
X-Received: by 10.31.150.76 with SMTP id y73mr22376612vkd.84.1453249228538;
 Tue, 19 Jan 2016 16:20:28 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Tue, 19 Jan 2016 16:20:28 -0800 (PST)
In-Reply-To: <xmqqvb6p8bmm.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: ea0oDJjemvBrn5jnZ6PWdKpe23M
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284401>

On Tue, Jan 19, 2016 at 5:09 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Subject: test-lib: clarify and tighten SANITY
>
> f400e51c (test-lib.sh: set prerequisite SANITY by testing what we
> really need, 2015-01-27) improved the way SANITY prerequisite was
> determined, but made the resulting code (incorrectly) imply that
> SANITY is all about effects of permission bits of the containing
> directory has on the files contained in it by the comment it added,
> its log message and the actual tests.
>
> By the way, while we are on the subject, POSIXPERM is more about "if
> we do chmod, does filesystem remember it so that ls -l reports the
> same?"  Output from "git grep POSIXPERM t" shows that some users of
> it also assume that it requires "we can make something executable by
> doing chmod +x and unexecutable by doing chmod -x" (and that is
> fine--running tests as root would not make an unexecutable file
> executable).  The tests that require POSIXPERM but not SANITY can be
> run by root (I am not saying that running tests as root is safe or
> sane, though) and are expected to produce the same result as they
> were run by a non-root user.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> +# SANITY is about "can you correctly predict what the filesystem would
> +# do by only looking at the permission bits of the files and
> +# directories?"  A typical example of !SANITY is running the test
> +# suite as root, where a test may expect "chmod -r file && cat file"
> +# to fail because file is supposed to be unreadable after a successful
> +# chmod.  In an environment (i.e. combination of what filesystem is
> +# being used and who is running the tests) that lacks SANITY, you may
> +# be able to delete or create a file when the containing directory
> +# doesn't have write permissions, or access a file even if the
> +# containing directory doesn't have read or execute permissions.

This makes the intent much clearer. Thanks.

>  test_lazy_prereq SANITY '
>         mkdir SANETESTD.1 SANETESTD.2 &&
>
>         chmod +w SANETESTD.1 SANETESTD.2 &&
>         >SANETESTD.1/x 2>SANETESTD.2/x &&
>         chmod -w SANETESTD.1 &&
> +       chmod -r SANETESTD.1/x &&
>         chmod -rx SANETESTD.2 ||
>         error "bug in test sript: cannot prepare SANETESTD"
>
> +       ! test -r SANETESTD.1/x &&
>         ! rm SANETESTD.1/x && ! test -f SANETESTD.2/x
>         status=$?
