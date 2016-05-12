From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2 00/94] libify apply and use lib in am
Date: Thu, 12 May 2016 20:02:02 +0200
Message-ID: <CAP8UFD1ukOMi_VDKzZErwSu1OBU5h1hVOxd7mPu1ytzFr11VGA@mail.gmail.com>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
	<5734B805.8020504@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu May 12 20:02:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0uw5-00066A-Nx
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 20:02:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752546AbcELSCF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 14:02:05 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35990 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752532AbcELSCE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 14:02:04 -0400
Received: by mail-wm0-f68.google.com with SMTP id w143so17178298wmw.3
        for <git@vger.kernel.org>; Thu, 12 May 2016 11:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=i3QS12utG55lYG9XhVnKptIUHcucVjyl1gqlLVNpIXA=;
        b=fdiFosQcuE23Kfj8gmdwx6rL32GlIt2chdAApXHok2HEe/uUcXTKvJWF1UvhVw9TRm
         zBwo2dZc3kbJ0Tpklj2UrkJ8aIbreY11etk1Tz6+zJwzRmkUVZQ419o3oNXlLZFXiOP/
         +8rokpRh8XakzqkHNtuCE8IgYCY3cjF2qTRCYRfyizDybJPg46OgNP6B0gDUOg1btDhL
         c/OgFTSy2x97eG54uWOHT51G0hlaO9+iqtl0X7EzuB0sKWgsWzUU3eUXlEfvxp3AdVM0
         TC5UYl6BbEWQ7KLq06MML2Kbs5pJl9JvAzOdD86td91qmnCDw8WfFYDeKAjfRf+afxN3
         lstQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=i3QS12utG55lYG9XhVnKptIUHcucVjyl1gqlLVNpIXA=;
        b=KkswsPlOFA1tp2csqxDFNfW9BAQZ+TyLkZ21NCSZQahhe5fF6ehB2OffyRgKZJf0bI
         PfbsN7e1dVQsx/ikenvU9VpLRigJ9rv5uxZtK0gGSNiv11NJ9CQLTh89UmPj3+mhOI/o
         06pJ3iEDU0AqkWlwICUcyusM0wIh4XGxiFwJ+G9cPMJhEYwrRnZXWxi2SFoCBkNKzVb9
         77s8va7De0HoXWcBV7Ird1iRtbIs86ptnIT6Nns/MegypJmmuzA+WE6U3XEURNLBWIE4
         5IT2q2gEsqF2MR1h+Mz37/FocSnisDILuGtTFNOnwUZeQ5wv3EATAEbJYu30FTuOAAdq
         /TRQ==
X-Gm-Message-State: AOPr4FXmlBDwUmBrAuqxf80uKGkFTznOgCNWiJC9EgBW9y25T4ZfOTA6JSayPCwp+ack0XGpgpgTbPSPqPvd0Q==
X-Received: by 10.28.129.22 with SMTP id c22mr8102776wmd.89.1463076122499;
 Thu, 12 May 2016 11:02:02 -0700 (PDT)
Received: by 10.194.246.4 with HTTP; Thu, 12 May 2016 11:02:02 -0700 (PDT)
In-Reply-To: <5734B805.8020504@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294423>

On Thu, May 12, 2016 at 7:06 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 11.05.2016 um 15:16 schrieb Christian Couder:
>>
>> This is a patch series about libifying `git apply` functionality, and
>> using this libified functionality in `git am`, so that no 'git apply'
>> process is spawn anymore. This makes `git am` significantly faster, so
>> `git rebase`, when it uses the am backend, is also significantly
>> faster.
>
>
> I'm including this in my build on Windows. It passes the test suite.

Great! Thanks for the report!

> I'll also use it in production for a while, although I am not a git-am
> consumer nor do I use git-rebase without -i, hence, my tests will probably
> only show that there is no bad fall-out.

Thanks anyway,
Christian.
