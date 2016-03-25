From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Re: How to use @{-1} with push?
Date: Fri, 25 Mar 2016 13:02:27 -0500
Message-ID: <CAHd499B3Z58hj--Pa0uM36A2H3Xpmayrb+RiLeOBkmnu70yW1A@mail.gmail.com>
References: <CAHd499AM-OzqiB1hOF=0BTesFxrxNj=+jr1wH6vpQXfgoXd8Ug@mail.gmail.com>
	<xmqq8u164fjv.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 19:02:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajW4B-0002RL-89
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 19:02:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754045AbcCYSCa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 14:02:30 -0400
Received: from mail-vk0-f45.google.com ([209.85.213.45]:35805 "EHLO
	mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753925AbcCYSC3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 14:02:29 -0400
Received: by mail-vk0-f45.google.com with SMTP id e6so98281180vkh.2
        for <git@vger.kernel.org>; Fri, 25 Mar 2016 11:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=ezEVuV8GPp+EnLqYymmRoXGCb20CrMZFxiP/Q3eBTwk=;
        b=DuKZrNmSSjgA37DwxeFWvGM3YCOP+yMyZv+sdFjrIOEw8oAkZ1jqZaqpfXDo+BJB0I
         cHJLHemIULHHrSIY34gVnKwlp6H+Ued5pVnGW0c+aN7DH2G2cGWykEln7Nudgn7HBt0c
         Fy+h3I36d5X4yc9WFfuE9hbSjpIvTKBR0gwgDr3ACryhXkwXeUqKNfIZkCxwccHrySU+
         99s9pk9xjbHkH3hI64xvUlYP5FOQsnMYKdRs4fox79Yn+M0BBJYEM0ElNh7is+V3oGwP
         Bpy5HkHCqWJWKN38j6qs3bsT1/m+DbdyBkd8z0A6b5cw6TZpCHZYhi7oVNsKirb7pb35
         k9bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=ezEVuV8GPp+EnLqYymmRoXGCb20CrMZFxiP/Q3eBTwk=;
        b=B9TlgnlAmWmcZFqcJKT7ktWwIl6I4x8hutqiizhf3JnEuNg5r0cm208gGyyDngeg2E
         LW6+qYi/gTwnxJSU59zwZLVp2xCrCs3Mts0c15TuS5KtcszKCuPUiuMAwosFvD5LKT8C
         ++zx87G8F1oDrdi4nfa9k69JH8INFWrnEU/UDipKjog1BAEe4vnL3VU+saCgDOshr8T9
         DhfgamU7k5U7EQwrTYEcPHc7qBkcRy4bsxKP6iZKk+ooWubqOnJm5vIObFahqSwgjLEq
         5XV87HoipzTb+iSRH7a1RwRqeZkWSuZQhtVyF6u7KUgmEkyS6rrFNAdivtmXCtgJaFpI
         7Zfg==
X-Gm-Message-State: AD7BkJLHYITi8vURjOBXSDMUMbEcfl0pwQB1MwzlcBR2c0Bhb6xHPQRWUYjX4zPdUSeLoOtyriDB+VnuvkOn3w==
X-Received: by 10.176.1.16 with SMTP id 16mr7224093uak.56.1458928948041; Fri,
 25 Mar 2016 11:02:28 -0700 (PDT)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.176.66.68 with HTTP; Fri, 25 Mar 2016 11:02:27 -0700 (PDT)
In-Reply-To: <xmqq8u164fjv.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: qiGEOKrFpBqoBtFgPO0OZCbc2nc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289923>

On Fri, Mar 25, 2016 at 12:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
> You can ask rev-parse to give you --symbolic-full-name, error out if
> it is empty (i.e. detached HEAD), and otherwise use the result, no?
>
>     $ git checkout next
>     $ git checkout master
>     $ git rev-parse --symbolic-full-name @{-1}
>     refs/heads/master
>     $ git checkout HEAD^0
>     $ git checkout master
>     $ git rev-parse --symbolic-full-name @{-1}
>     $ exit
>
> And
>
>     $ git push origin :refs/heads/master
>
> would be the fully-spelled out way to remove that branch.

Thanks Junio, I figured there was a command to do that. I tried to do
this using '-' shorthand, but that didn't work. I guess because that's
not really a revision, but a special function of git checkout only.
