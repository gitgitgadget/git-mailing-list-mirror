From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 07/10] ref-filter: make %(upstream:track) prints
 "[gone]" for invalid upstreams
Date: Mon, 12 Oct 2015 01:08:59 +0530
Message-ID: <CAOLa=ZT5ADOY0x_rFRWVx5DtWtOBH3MvqBgh8v4COC1a1ND3NA@mail.gmail.com>
References: <1444295885-1657-1-git-send-email-Karthik.188@gmail.com>
 <1444295885-1657-8-git-send-email-Karthik.188@gmail.com> <vpqa8rtnqzp.fsf@grenoble-inp.fr>
 <CAOLa=ZTvD5cXduPH3G0bGDba_hevLQsuwYsoZFtmfTd2SS4Prw@mail.gmail.com>
 <vpqa8rp2xku.fsf@grenoble-inp.fr> <CAOLa=ZRvTUpz2Ey9ZLwe_iqVGPaFZGJ2_HiASpn=txAgV57otg@mail.gmail.com>
 <vpqvbadz37a.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Oct 11 21:39:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZlMSz-0005PM-RL
	for gcvg-git-2@plane.gmane.org; Sun, 11 Oct 2015 21:39:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752450AbbJKTja (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Oct 2015 15:39:30 -0400
Received: from mail-vk0-f41.google.com ([209.85.213.41]:36690 "EHLO
	mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751793AbbJKTj3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Oct 2015 15:39:29 -0400
Received: by vkgc187 with SMTP id c187so12991355vkg.3
        for <git@vger.kernel.org>; Sun, 11 Oct 2015 12:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=fVSTu65puPvCKfGSkLU4QP/AoxknZjJBPWEV+oHVnTY=;
        b=iWVV5xQ9MpyOie3dLKIEUDW5tM3a+l1PIebyvEuQfG/7Uj2VKSv5J0qBs/ztvedJFX
         GPoGwFF423SpdTgFdzBhQuJ6KBrH7NtOg0I4uxCJZOWhAcJYIRo3Kr4yxWTkquhD1qQr
         L7mkKi1ern60FlFFmRL1Ab81N7gDAjRSE91QQ7aRe6xqjUE6kHL86EzQEtUCkFxPdQdZ
         SN67R3umsQ9eUVnEDzuHu5XRbBojm3VNNaWUm78eN9jdRNAxPBmBlCLhjLqmg1rt3VYR
         IsQQSwO4T2w3w4NrvBhFjZPCzTPwY59Qa+dlH0A5DV4k9gMGK2JFiCsgXZCoK7HoBHvy
         ztxw==
X-Received: by 10.31.15.69 with SMTP id 66mr16231577vkp.142.1444592368553;
 Sun, 11 Oct 2015 12:39:28 -0700 (PDT)
Received: by 10.103.23.193 with HTTP; Sun, 11 Oct 2015 12:38:59 -0700 (PDT)
In-Reply-To: <vpqvbadz37a.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279357>

On Sun, Oct 11, 2015 at 11:40 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> A little blurry on how this works, as in how translation takes place,
>> probably need to look at some code.
>
> What you really need to understand is: _("foo") is translated, "foo" is
> not and will always be "foo". Technically, _ is a macro, it could be
> called get_the_translated_string_for(...) but that would be too long.
>
> In git, _("foo") should be used when talking to a user (porcelain), and
> "foo" when talking to a program (plumbing). This way a user running
>
> git <plumbing-command> | grep "some-plumbing-message"
>
> will always get the same result regardless of the current locale.

That helped a lot, thanks a bunch.

-- 
Regards,
Karthik Nayak
