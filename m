From: Eugene Sajine <euguess@gmail.com>
Subject: Re: Help creating git alias
Date: Wed, 30 Oct 2013 21:26:52 -0400
Message-ID: <CAPZPVFarK_jKpM2f62mErAmL+mck6EN1QPfHDHqqfJbJ2AfzXg@mail.gmail.com>
References: <CAPZPVFbiSx8n0W1kcczCdC6ioVuWpwuUQ_pc9T=7i4X_FuZNhg@mail.gmail.com>
	<CAN0XMOKMF235S-23QcMj5cBup+Lh4vQs7QcOqXQ-MgafsAMKNg@mail.gmail.com>
	<CAPZPVFZ9WujUCQ1O9VfV83XUu_6g7Vp_MmYRCCO+GptOoSyvcg@mail.gmail.com>
	<xmqq61sebhh3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ralf Thielow <ralf.thielow@gmail.com>, git <git@vger.kernel.org>,
	Andrew Ardill <andrew.ardill@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 31 02:26:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vbh2H-0004VS-V3
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 02:26:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771Ab3JaB0y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 21:26:54 -0400
Received: from mail-wi0-f181.google.com ([209.85.212.181]:59172 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750730Ab3JaB0x (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Oct 2013 21:26:53 -0400
Received: by mail-wi0-f181.google.com with SMTP id ex4so2318802wid.2
        for <git@vger.kernel.org>; Wed, 30 Oct 2013 18:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=jdKw1cfVmeX1EYy2PhnUldY4Kz6xgLC45ITVv17o4UY=;
        b=t7tGHX3mGH91/M5p6g4Idu19seV3wjT3vXj+CgtmkiOyYPBIZmJNYIO1mGn3NSi4Um
         EEZi4DsyWDHOlObKZLuwzpsZMUewa/QT+4GTcqWbUc1lo6KxsnF5E8GZeYJQSRLvNtds
         B23FezjYNd1UGcuIc5xtIQ78jxCapeKvNfcpbPprJE1UFQDNH+1/JgbNd+Si//CO14V8
         zbeg9HV7r5k2+2JviAdZWPx+QjVoiWr9NGcMSE/qV7dE5/HkJ72bBo0vGfuLZW0zQ5DV
         hQoVNfWC+y1PLoanu+mPd19rNWhl33GDKpeW3RSmQo+vMsSHYuqlKobjcFc5SgmYH4uR
         9ydQ==
X-Received: by 10.194.178.166 with SMTP id cz6mr413105wjc.53.1383182812126;
 Wed, 30 Oct 2013 18:26:52 -0700 (PDT)
Received: by 10.216.123.145 with HTTP; Wed, 30 Oct 2013 18:26:52 -0700 (PDT)
In-Reply-To: <xmqq61sebhh3.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237076>

On Wed, Oct 30, 2013 at 5:02 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eugene Sajine <euguess@gmail.com> writes:
>
>> On Wed, Oct 30, 2013 at 3:57 PM, Ralf Thielow <ralf.thielow@gmail.com> wrote:
>>> lg=!git log --pretty=format:'%h %ad %ae %s' --date=short | sed 's/@\\S*//g'
>>>
>>> should work.
>>
>>
>> It did! thanks! I didn't know that "!sh -c" is not needed
>
> "sh -c" is often used when you pass arguments to your scriptlets,
> e.g. to allow
>
>         git lg master..next
>
> you would want
>
>         sh -c 'git log ... "$@" | sed ...' -
>
> so that
>
>         git lg master..next
>
> turns into
>
>         sh -c 'git log ... "$@" | sed ...' - master..next
>
> which makes $1="master..next" and fed to "git log".

Junio,

That was my initial intention, because I would like to be able to pass
parameters like to git log or git blame correctly without the explicit
use of $1. Could you please advise about how to make it work with the
!sh -c ?

Because the same exact (sed 's/@\\S*//') syntax didn't work with "sh -c".

Thanks,
Eugene
