From: =?UTF-8?Q?Felipe_Gon=C3=A7alves_Assis?= <felipeg.assis@gmail.com>
Subject: Re: [PATCH 3/5] merge-recursive: test rename threshold option
Date: Sun, 21 Feb 2016 15:55:07 -0300
Message-ID: <CALMa68qhCBJ5MnT7i6UT989OKKzzOF_bTqo38thSPMwq0mbj6g@mail.gmail.com>
References: <1456067358-19781-1-git-send-email-felipegassis@gmail.com>
	<1456067358-19781-4-git-send-email-felipegassis@gmail.com>
	<CAPig+cTpngfi6EF+MbD-fQ1nM_9TTeVZJ_fBviD5=4Q9uN-8aA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Felipe_Gon=C3=A7alves_Assis?= <felipegassis@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Feb 21 19:55:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXZA3-0003Ld-9D
	for gcvg-git-2@plane.gmane.org; Sun, 21 Feb 2016 19:55:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbcBUSzJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Feb 2016 13:55:09 -0500
Received: from mail-io0-f180.google.com ([209.85.223.180]:33994 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750985AbcBUSzI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Feb 2016 13:55:08 -0500
Received: by mail-io0-f180.google.com with SMTP id 9so157941311iom.1
        for <git@vger.kernel.org>; Sun, 21 Feb 2016 10:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=aDJ3E/IwGpSs0cXF+4ApqD3MOoIX3RCX1C03sVZmasA=;
        b=ndpBpxI+yH7yDpM9ajiGonDZotN4VfkbHPAHY2ExmNHVZOErnZ6H9HJOa/GjBTQzjd
         qnmlTQYvJb0kUOgcbjmBDt0Rnf2s7l1cKxJYS2tBAaEvN3XMpip03NDTd0Xprx3Fb536
         bYF9pXNlYb4LE4ueX6ZR4FziiLEBM/9VqNaHhfo1bsl2RoS3Inslf/gvCpl8msSUo0DT
         B3EjOYiAOV56VbKodTFFwo8SnJw8fMgG3DjWK5hlcX2hF4YMEbWW5dH7sdNddDkGsmpp
         ED3Zv+AR9v2gq0wDoHFRcMlZPDYaC8B75Q8QAL8x81C50zgvI7C+xeETzcUf/8bOO+WC
         /oUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=aDJ3E/IwGpSs0cXF+4ApqD3MOoIX3RCX1C03sVZmasA=;
        b=OBiwd6+vnb59xE6qNdPofviyECBNWVUO+2PeHgp1CZPMh8hQ+LuoX25cedXsL4L+BD
         RBjn0q6yBL4lcI0d0BdoB/324q0cNgafWNXaDaPZjcSX84HHTGFDnA6hNVxIhB1xfVmp
         ku+jFYHOwPMYCWREqxtOfj5V24jFbOuMi+VTzdEqnUNFwPPwdFqarYdlz+DVUU/iYJQP
         iRTkiIxtK3pNNsi5QFYDyJnPJFV7yxoHI+frLi6/kR7tsdUsaXcVyqX9T/ookdc2vKXn
         0Kj4v0BEovN9fjiyJ+5pbysoEAlghJLBovAK7WWW6sLwGv4hAIDtiZxyIg5jfIcf8EXQ
         fLOQ==
X-Gm-Message-State: AG10YORtmVPc/mos0gkjKHqEZTBqpaviO4vhahU0Wv8fcIlsB3W2EJcJwK7TyEEJuDrgiNDIqeSlRDxJDBpsaQ==
X-Received: by 10.107.19.193 with SMTP id 62mr28029068iot.41.1456080907833;
 Sun, 21 Feb 2016 10:55:07 -0800 (PST)
Received: by 10.107.3.94 with HTTP; Sun, 21 Feb 2016 10:55:07 -0800 (PST)
In-Reply-To: <CAPig+cTpngfi6EF+MbD-fQ1nM_9TTeVZJ_fBviD5=4Q9uN-8aA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286825>

On 21 February 2016 at 14:52, Eric Sunshine <sunshine@sunshineco.com> w=
rote:
> On Sun, Feb 21, 2016 at 10:09 AM, Felipe Gon=C3=A7alves Assis
> <felipeg.assis@gmail.com> wrote:
>> merge-recursive: test rename threshold option
>
>> +       git read-tree --reset -u HEAD &&
>> +       test_must_fail git merge-recursive HEAD^ -- HEAD master &&
>> +       check_find_renames_50
>> +'
>> +
>> +test_expect_success 'low rename threshold' '
>> +       git read-tree --reset -u HEAD &&
>> +       test_must_fail git merge-recursive --rename-threshold=3D25 H=
EAD^ -- HEAD master &&
>> +       check_find_renames_25
>> [...]
>> +       check_find_renames_75
>> [...]
>> +       check_find_renames_100
>> +'
>> +
>> +test_expect_success 'rename threshold is truncated' '
>> +       git read-tree --reset -u HEAD &&
>> +       test_must_fail git merge-recursive --rename-threshold=3D200%=
 HEAD^ -- HEAD master &&
>> +       check_find_renames_100
>> +'
>
> Is this truncation documented behavior or is it just a detail of the
> current implementation. (Genuine question; I haven't checked the
> documentation or source.) If just an implementation detail, then it
> might not be desirable to formalize it via a test.
>

Not documented. I will remove this. If you prefer to have it
documented and the test added back later, I can do that.

>> +test_expect_success 'last wins in --rename-threshold=3D<m> --rename=
-threshold=3D<n>' '
>> +       git read-tree --reset -u HEAD &&
>> +       test_must_fail git merge-recursive --rename-threshold=3D25 -=
-rename-threshold=3D75 HEAD^ -- HEAD master &&
>> +       check_find_renames_75
>> +'
>
> Would it make sense to add tests checking that invalid
> --rename-threshold=3D arguments, such as negative and non-numbers,
> correctly error out?
>

I guess so. Can I ask you for a suggestion on how to check this?

Given that merges here usually fail anyway because of the conflicts,
what is the best way of checking the effect of an argument rejection?
1. Check that the merge fails but the index is not changed
2. Check for a specific exit code
3. Use another setup so that the merges succeed


Thanks for the detailed review. Already working on the other comments.
