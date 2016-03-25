From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: Re: [PATCH v10 2/2] pull --rebase: add --[no-]autostash flag
Date: Fri, 25 Mar 2016 23:40:04 +0530
Message-ID: <CA+DCAeTNv-2RkbGo+ciKP_bfCvThKjGAsJEr=xuBYBFgrTvGtg@mail.gmail.com>
References: <1458584283-23816-1-git-send-email-mehul.jain2029@gmail.com>
	<1458591170-28079-1-git-send-email-mehul.jain2029@gmail.com>
	<vpqshzfuduv.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Paul Tan <pyokagan@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Mar 25 19:10:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajWBa-0006QU-It
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 19:10:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752859AbcCYSKI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 14:10:08 -0400
Received: from mail-qg0-f49.google.com ([209.85.192.49]:36257 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751521AbcCYSKG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 14:10:06 -0400
Received: by mail-qg0-f49.google.com with SMTP id u110so65972069qge.3
        for <git@vger.kernel.org>; Fri, 25 Mar 2016 11:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=DN04HkBCJMjwBtgBhl4s5owN6JmxkEKJ3HWGPDW/u7w=;
        b=KUso1FubljRgijw7ZVqTaObz85ALDWzddUSLnH4PYpoI79r5te6bI3OcffKOT5S0OR
         V026/IqYIJpl6w9zlwPPvh8Jjx8v6QZc1NiEQ2FS9P7kj1tC2SsVgd70s8SrLTV2dkFp
         5UQ6VyKRCtkNd/d8AoU6+GQh1aHPQreEHjyiTVSJf6n50OvD/EOyZeVZ7Qz/F/tPSf5F
         Ype59SXvL0QkJt96Sx2msL9a6ZKtcF1zxSPlYOO7NgGEE+R/tqPRNC9KL4zeSuRzgT6i
         21PhrcxT2t0LvsXw7ecfhqNi77Iu1boa0OSX5en26f5u2qcFPJQNWKZyO4pFC0abB3WI
         W0SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=DN04HkBCJMjwBtgBhl4s5owN6JmxkEKJ3HWGPDW/u7w=;
        b=lQM8kF7AqriANox2B0O6BKzf4UOFbCGjqVC0J+pMD/QlDoKn7O/Bpzoe8GijVVtZzY
         /t1hLcpSTKu8+GSZIMdEnXrV15bUwP+deG47TC45UN3FQjJ6b4ZhxfIrCkytsJcmVUmD
         f/C21DsMBB2paepjKwW6EVMn5PNjE1lmJu8Kj2AVeW8Uty41rQs3JkxoqwCBtMMn6pZU
         sPafvbsbVttYqMGQGkYC85ZJj8GtHnuHBu6xNAcLUy88Mv4Uv2nUO4Rgd/D0S4kkKKXR
         2wHOHR0L5E6koJBpwSXUHjV8g8HfmdJwn/qpog1+IbIQRYc8tzGXYpLkspIPlzlDKTvq
         BWjg==
X-Gm-Message-State: AD7BkJIwothYWRRupFeGMbzCD7exjDzWXBqDhZb6mm1nEpfnkj41GUnPM/HBuQa1WWVHnBcLxhSIxS0RbT0iwA==
X-Received: by 10.140.248.197 with SMTP id t188mr19998200qhc.50.1458929404935;
 Fri, 25 Mar 2016 11:10:04 -0700 (PDT)
Received: by 10.55.188.7 with HTTP; Fri, 25 Mar 2016 11:10:04 -0700 (PDT)
In-Reply-To: <vpqshzfuduv.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289925>

On Fri, Mar 25, 2016 at 2:35 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Mehul Jain <mehul.jain2029@gmail.com> writes:
>
>> +--autostash::
>> +--no-autostash::
>> +     Before starting rebase, stash local modifications away (see
>> +     linkgit:git-stash[1]) if needed, and apply the stash when
>> +     done. `--no-autostash` is useful to override the `rebase.autoStash`
>> +     configuration variable (see linkgit:git-config[1]).
>> ++
>> +This option is only valid when "--rebase" is used.
>
> This does not have to be added to this series (I don't want to break
> everything at v10 ...), but I think it would be nice to allow "git pull
> --autostash" even without --rebase if pull.rebase=true.

This is a nice observation. As current patch allow "git pull --autostash"
to be run without --rebase if pull.rebase=true, hence correct
documentation should be something like this

    This option is only valid when "--rebase" is used or pull.rebase=true.

But OTOH users who knows about pull.rebase understands that
pull.rebase=true means "git pull --rebase ..." will be executed whenever
"git pull ..." is called, thus for those users it might be easy to deduce that
need of "--rebase" for validity of "--autostash" is not necessary if
pull.rebase=true.

I will correct it in the re-roll.

Thanks,
Mehul
