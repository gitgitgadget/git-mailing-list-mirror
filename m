From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2] completion: add new git_complete helper
Date: Mon, 16 Apr 2012 13:49:56 +0300
Message-ID: <CAMP44s0PWAV=nD1xnAFMx8OPby88W2jKwDGtiUFY4LA93D-gAw@mail.gmail.com>
References: <1334524814-13581-1-git-send-email-felipe.contreras@gmail.com>
	<20120415213718.GB5813@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 16 12:50:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJjVT-0002bx-AA
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 12:50:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752884Ab2DPKt6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Apr 2012 06:49:58 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:43650 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752042Ab2DPKt5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Apr 2012 06:49:57 -0400
Received: by eekc41 with SMTP id c41so1253924eek.19
        for <git@vger.kernel.org>; Mon, 16 Apr 2012 03:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=KDS7hygyB+UIMRlDmToqF5o5sZ54bTjyVLr8/tBes4M=;
        b=NKWIOicbf+R93DHSICzvy7QUqlvNLhhCCgrBShtqFBHxiFgu8yBImhOcKfwRMaNLE5
         2RMXhvk7VvRiT3hgPzIkQvqnvZdz4s0TFImhokLmRlGELMG986Il5DqifFvM2Jv34vR/
         6rreq2ge0sAbPD/XY15VJ9E2Z6DrAeWql20Z+VuokjCktXTETNI2bMxKhU6tb1LedDab
         qrMZM8khZsnLfP9V/lsy4kSe0jvSoxb5hJh9ywrvV+OgJA68jkOrM4yEePmbNTgkXXAQ
         z4VUiaZumSnLxiOvYTg+huUcwDOeg2xP8Zcq8xu77Y0/jqj4catxb8yTczM7dIWx/7wi
         4I0w==
Received: by 10.14.39.197 with SMTP id d45mr1461310eeb.89.1334573396487; Mon,
 16 Apr 2012 03:49:56 -0700 (PDT)
Received: by 10.213.19.67 with HTTP; Mon, 16 Apr 2012 03:49:56 -0700 (PDT)
In-Reply-To: <20120415213718.GB5813@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195619>

On Mon, Apr 16, 2012 at 12:37 AM, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
> Felipe Contreras wrote:
>
>> This simplifies the completions, and makes it easier to define alias=
es:
>>
>> =C2=A0git_complete gf git_fetch
>
> Sounds neat. =C2=A0Unfortunately users could already be using a funct=
ion
> with some other purpose named git_complete in their .profile and this
> would override it. =C2=A0The completion script has so far stuck to a
> limited namespace:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0_git_* =C2=A0(completion functions)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0__git_* (everything else, including public=
 interfaces like __git_ps1)
>
> A name like __git_complete should work, presumably.

Perhaps it's time to avoid the __ prefix for public interfaces;
otherwise how would people know they are public?

--=20
=46elipe Contreras
