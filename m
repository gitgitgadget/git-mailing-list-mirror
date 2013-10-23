From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH] remote-hg: unquote C-style paths when exporting
Date: Wed, 23 Oct 2013 10:38:50 +0200
Message-ID: <CALWbr2zzT47e_B0moy0a5gpWfhberp9B3TEwkGFBBm19iGfQBw@mail.gmail.com>
References: <1382115821-12586-1-git-send-email-apelisse@gmail.com>
	<xmqq4n89t8yw.fsf@gitster.dls.corp.google.com>
	<CALWbr2zsOYNN45d+qHDQ88eLj82iV4QxJ_9ro+RGk7upBJVATA@mail.gmail.com>
	<CAMP44s37-R0u4oLnuRfdghx-Tk3X9eer0MVTcAGmPZ3Bu32dug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 23 10:38:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VYtxy-0007KX-B2
	for gcvg-git-2@plane.gmane.org; Wed, 23 Oct 2013 10:38:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751790Ab3JWIiy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Oct 2013 04:38:54 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:54461 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750847Ab3JWIiw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Oct 2013 04:38:52 -0400
Received: by mail-lb0-f172.google.com with SMTP id c11so454460lbj.31
        for <git@vger.kernel.org>; Wed, 23 Oct 2013 01:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=D3p6UU+mkBpJ6iYn+kc/2nmND51c/SKbBoKg/SpsKvA=;
        b=AIzMPW4fbnfR47BqcYVRS84Su75SPRB8S6pwC+TQj8iXZ48GcClc15ZsFWHisnwlwv
         oUEyS6w4ihDtxyZOl2f1yl3JE75T31rzhqC/HCR2M3ErE9VMMyjZr2ssK8zne2u+LSuT
         SDEpivRYhWW1Iik1boMGA9RQBTMhMgIBTvtA+8fUcBlV4qp6zuNiobxsaBijtU/dHo9C
         l1QX3ZmTIQjrb0lXMkE6Md7g/OAtKeaZHort2DTm4X8crp+Rv38LOgQvM2mPgDSqoEeE
         DyoWLfPJcZPdhqR4/SIiMetqlRiPIewnOxXuwzOsDZFpiD/ePrbGpAhEGr23dkaEi8I5
         9Msg==
X-Received: by 10.112.136.163 with SMTP id qb3mr1298532lbb.14.1382517530933;
 Wed, 23 Oct 2013 01:38:50 -0700 (PDT)
Received: by 10.112.50.240 with HTTP; Wed, 23 Oct 2013 01:38:50 -0700 (PDT)
In-Reply-To: <CAMP44s37-R0u4oLnuRfdghx-Tk3X9eer0MVTcAGmPZ3Bu32dug@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236503>

On Wed, Oct 23, 2013 at 2:45 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Tue, Oct 22, 2013 at 3:49 PM, Antoine Pelisse <apelisse@gmail.com> wrote:
>
>> It is true that I have expected "valid output" from git-fast-export.
>> And I don't have in mind any easy solution to detect that the output
>> is broken, yet still accepted as a valid string by python. We could
>> obviously write a unquote_c_style() equivalent in python if needed.
>
> Something like this?
>
> def c_style_unescape(string):
>     if string[0] == string[-1] == '"':
>         return string.decode('string-escape')[1:-1]
>     return string
>
> It's in git-remote-bzr.py.

Yeah, that's certainly better,

Thanks,
