From: demerphq <demerphq@gmail.com>
Subject: Re: git add without whitespace
Date: Tue, 31 May 2016 18:27:21 +0200
Message-ID: <CANgJU+WZHes1-d2GXT9p+Up4e6_aA-Q5r1A8EEmCEOXjsOyuXw@mail.gmail.com>
References: <CAHd499Agn=vLBxDpHi2dy1HMy-_58PZGs7VNtFJnBfP5zXatTA@mail.gmail.com>
	<xmqqlh2r8ixu.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Robert Dailey <rcdailey.lists@gmail.com>, Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 31 18:27:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7mVr-0001JY-Ja
	for gcvg-git-2@plane.gmane.org; Tue, 31 May 2016 18:27:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754980AbcEaQ1X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2016 12:27:23 -0400
Received: from mail-oi0-f53.google.com ([209.85.218.53]:32877 "EHLO
	mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754959AbcEaQ1W (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2016 12:27:22 -0400
Received: by mail-oi0-f53.google.com with SMTP id k23so305266367oih.0
        for <git@vger.kernel.org>; Tue, 31 May 2016 09:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=bQGd9EU2ZhGN6Vfiu595BVmKwrasrK+nQngpqpUvzfk=;
        b=iJj5Gb3mp+5L7ubkTpC+w3qmCwzHMiuqflJSrjwIEpLCPMEXSUWIWXR/vS21GR5yxr
         kp0CR663aEMLuCDDW7PoJTvJYVgobkzfsFu0cIyOcquBkExpqkJY8RrHB5m/6PI63k6d
         UtLhPYSg0mZ9ehsUGGWXTGbW2pvGc8fUaOYmrOchUfoL0Xgj8/YGv6Zvqk2YVpCDXz1R
         XyEspvmE/neH+py3js1SdmrPXLhLNAFOJ+m2wNhT9DxW220m1KVOj5tMUTmy6PD1Jdtl
         768AjC/cuSTkxhPrlpzNxeKnSCKMuPivVy146/08ZBB8uDYtJKD0+S4HP4tUMM1/m3XV
         SVoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=bQGd9EU2ZhGN6Vfiu595BVmKwrasrK+nQngpqpUvzfk=;
        b=EJB0kp+FCrUmR10pQRdA2R8YcoJ6t+9tVQfOpNMjoZoe7pxbW/OTUZmULuhWsWsn7R
         DdOZVLO9BJlkOijAPEc8MfJ3Dm1GnXMbaq9s2A1q0fYwmRWe69vyGiAbZ/fv3tWskvsW
         /oiruAZtKSFCa/uQJKQwipFQwMV5jUbQpv5BRy3F4bSKs2eIxpdz/PDdv53BeBxnwWSn
         KwvGCBQJvsaFJrQtn2jBx90+p6uc6pVXN9gF05IwK2oulndDloa3GO/+0MloP9stFrno
         FlfyFtKZqCJ3flWiefwLAYaFmXlMnQ/sfbNqcP8CaRLwXhd7meT9KrHpg1C6EllIJs+0
         wU9Q==
X-Gm-Message-State: ALyK8tJiILCQ3z2h5Mj7SonOFckR48t+1L1gcfmG5fU/JdC1S/JbNF1IiIPj+ULYa1hsTT/QRoHLKeVs+6XPgQ==
X-Received: by 10.157.11.28 with SMTP id a28mr19396747ota.128.1464712041635;
 Tue, 31 May 2016 09:27:21 -0700 (PDT)
Received: by 10.202.75.19 with HTTP; Tue, 31 May 2016 09:27:21 -0700 (PDT)
In-Reply-To: <xmqqlh2r8ixu.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295995>

On 30 May 2016 at 21:06, Junio C Hamano <gitster@pobox.com> wrote:
> Robert Dailey <rcdailey.lists@gmail.com> writes:
>
>> $ git diff -U0 -w --no-color | git apply --cached --ignore-whitespace
>> --unidiff-zero
>>
>> This command explicitly leaves out context because it can sometimes
>> cause the patch to fail to apply, I think due to whitespace being in
>> it, but I'm not completely sure myself.
>
> I have had this in my ~/.gitconfig for a long time.
>
> [alias]
>         wsadd = "!sh -c 'git diff -- \"$@\" | git apply --cached --whitespace=fix;\
>                 git co -- ${1-.} \"$@\"' -"
>
> That is, "take what's different from the _index_ and the working
> tree, apply that difference while correcting whitespace errors to
> the index, and check the result out to the working tree".  This
> would _not_ touch existing whitespace-damaged lines that you are not
> touching, and honours the customized definition of what is
> considered whitespace breakage for each paths (which you set up with
> the attributes system).


That is very very cool. I have a perl script that does the same thing
from git-blame output. This is MUCH nicer.

cheers,
Yves


-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
