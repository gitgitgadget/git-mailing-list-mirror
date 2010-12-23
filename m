From: Evgeniy Ivanov <lolkaantimat@gmail.com>
Subject: Re: Using overlay filesystem for "other" files idea
Date: Thu, 23 Dec 2010 12:53:01 +0300
Message-ID: <AANLkTi=fW+spgi7YYSxEReMk4ZveEt2=Mb_1majKi6GJ@mail.gmail.com>
References: <AANLkTi=f2MXoWE_Dx_thWb3VXGu-V-9cJAC8F_RzGAg=@mail.gmail.com>
	<4D12DDD5.4050103@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Tomas Carnecky <tom@dbservice.com>
X-From: git-owner@vger.kernel.org Thu Dec 23 10:53:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PVhrA-0000M9-Jy
	for gcvg-git-2@lo.gmane.org; Thu, 23 Dec 2010 10:53:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752286Ab0LWJxD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Dec 2010 04:53:03 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:56565 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752103Ab0LWJxB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Dec 2010 04:53:01 -0500
Received: by iyi12 with SMTP id 12so4834357iyi.19
        for <git@vger.kernel.org>; Thu, 23 Dec 2010 01:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=FFfWSzW4s2VxnF7+mD8Imcv0e8n6hii0bcgLng2YRU0=;
        b=HUZa2xsS4jok5QcNUkBpPKrIsWvAi91/5jgFMoZuX9yneUl6CGaC8POMFORqHNBiJu
         afyJ90TfUZ9NZYBe44GS+12I722h2Y8/+jtTTRnOGRIrKS0rS6ZvHInam+VEiOPVyibT
         YS7bjP34PfXjEj30YVsBYcxiw0PPVy9jg3dIE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=LeBt+s7PTZBh4h5nzVk4NdDIolSmN8aKU/k5y02YmitjvmPmezjKLT0+bPBFA7jb7d
         uMInbPqsUoGmvUOrW6FBUTXiMPIN2WqPCXymYzzEo4Pf9l9o4DNSaVeVvOg7gQDCISzV
         03JeH2iPzL7XskUsiMWpWNxPvbpi9RmiCAglc=
Received: by 10.231.36.65 with SMTP id s1mr8015510ibd.4.1293097981074; Thu, 23
 Dec 2010 01:53:01 -0800 (PST)
Received: by 10.231.62.20 with HTTP; Thu, 23 Dec 2010 01:53:01 -0800 (PST)
In-Reply-To: <4D12DDD5.4050103@dbservice.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164123>

Thank you Tom, that's what I wanted.

On Thu, Dec 23, 2010 at 8:27 AM, Tomas Carnecky <tom@dbservice.com> wro=
te:
> =A0On 12/23/10 12:02 AM, Evgeniy Ivanov wrote:
>>
>> Hello,
>>
>> I got following idea.
>>
>> If different branches seriously differ and you switch branches, then
>> it's more likely you will loose most part of build files (e.g. when
>> run build).
>
> Use ccache.
>>
>> Also in projects that may have some bugs in build system (e.g. buggy
>> makefiles) there is a chance you will not get clean build environmen=
t.
>> E.g. somebody forgot to add include file as dependency in Makefile -=
--
>> oops, you're in trouble.
>
> Fix your Makefiles. Or run git clean, see below.
>>
>> Even without bugs in build system, some temp files are overwritten
>> each time you run build for a custom branch.
>>
>> I think using overlays for other files can help much to solve this
>> issue. You can have git repository in regular directory (like now) a=
nd
>> overlay fs mounted over this repository (for each branch its own
>> overlay).
>> Another benefit is clearing source tree after build.
>
> git clean -dfx.
>
>
> Or use two different working trees. See contrib/workdir/git-new-workd=
ir.
>
> tom
>
>
>



--=20
Evgeniy Ivanov
