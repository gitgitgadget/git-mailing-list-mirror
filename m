From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: Version 1.8.1 does not compile on Cygwin 1.7.14
Date: Sun, 06 Jan 2013 17:00:43 -0500
Message-ID: <50E9F40B.5000009@gmail.com>
References: <2491041.bQ51Qu8HcA@thunderbird> <1890551.8jTmplCF6O@thunderbird> <BB541ECCD3F04E479F06CA491DDB598D@black> <50E92675.4010907@web.de> <20130106093211.GB10956@elie.Belkin> <50E946EB.1000709@web.de> <20130106095757.GC10956@elie.Belkin> <50E9647F.4090209@gmail.com> <20130106120917.GC22081@elie.Belkin> <7vfw2enl2l.fsf@alter.siamese.dyndns.org> <50E9E822.4020709@gmail.com> <7vtxqum1u9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	=?ISO-8859-1?Q?Torsten_B=F6ge?= =?ISO-8859-1?Q?rshausen?= 
	<tboegi@web.de>, Stephen & Linda Smith <ischis2@cox.net>,
	Jason Pyeron <jpyeron@pdinc.us>, git@vger.kernel.org,
	Eric Blake <eblake@redhat.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 06 23:01:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TryHB-0008SH-6p
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 23:01:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753138Ab3AFWAq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2013 17:00:46 -0500
Received: from mail-qc0-f177.google.com ([209.85.216.177]:54278 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753043Ab3AFWAp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 17:00:45 -0500
X-Greylist: delayed 36747 seconds by postgrey-1.27 at vger.kernel.org; Sun, 06 Jan 2013 17:00:45 EST
Received: by mail-qc0-f177.google.com with SMTP id u28so11278422qcs.36
        for <git@vger.kernel.org>; Sun, 06 Jan 2013 14:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=R2IWP7JO7b8QXYawUGBBmIan7/rZ/CFeLibIVYxNSdQ=;
        b=Wsix8O2IDl6AmmEfbs9Ht0UcOyEwCyz/6OjiFXlL1hMc5DzLQItlJS9ap8mRoV/sUN
         6pu3vKH6F3HrMjE2V8cL+Vv1VXlbaNlYerJH2zWLsbLqi6XpG868hltIJZS1kHreL0Gw
         tEa2iwLixiea9M+lP6woDkCRzzOeXVL1kDRUnheRx/TKbszS6rncQn3tHrrZVAWVzG96
         YX4yKD5PGrg/Et5X2HVGLkVqTpSev5lHfyVm1HK02+hDBgcyoAA7I+BeWmnrbkm6sLug
         +4QL41uGm/NMNkqzNp/i7eZSzOnI0LyueFDJsP5WeaA+C3rzu+9+C0F0QReGljZr4rrj
         mrCA==
X-Received: by 10.49.127.145 with SMTP id ng17mr47011364qeb.25.1357509645042;
        Sun, 06 Jan 2013 14:00:45 -0800 (PST)
Received: from mark-laptop.lan (pool-173-79-102-236.washdc.fios.verizon.net. [173.79.102.236])
        by mx.google.com with ESMTPS id gm4sm18383881qab.12.2013.01.06.14.00.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 06 Jan 2013 14:00:44 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <7vtxqum1u9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212849>

On 01/06/2013 04:35 PM, Junio C Hamano wrote:
> Thanks; so perhaps you can give me an OK to forge your S-o-b to the
> following?
>
> -- >8 --
> From: Mark Levedahl <mlevedahl@gmail.com>
> Date: Sun, 6 Jan 2013 11:56:33 -0800
> Subject: [PATCH] Makefile: add comment on CYGWIN_V15_WIN32API
>
> There is no documented, reliable, and future-proof method to
> determine the installed w32api version on Cygwin. There are many
> things that can be done that will work frequently, except when they
> won't.
>
> The only sane thing is to follow the guidance of the Cygwin
> developers: the only supported configuration is that which the
> current setup.exe produces, and in the case of problems, if the
> installation is not up to date then updating is the first required
> action.
>
> Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
> ---
>   Makefile | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/Makefile b/Makefile
> index 4d47af5..52e298a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -273,6 +273,10 @@ all::
>   #
>   # Define NO_REGEX if you have no or inferior regex support in your C library.
>   #
> +# Define CYGWIN_V15_WIN32API if you are using Cygwin v1.7.x but are not
> +# using the current w32api packages. The recommended approach, however,
> +# is to update your installation if compilation errors occur.
> +#
>   # Define HAVE_DEV_TTY if your system can open /dev/tty to interact with the
>   # user.
>   #
Absolutely, that is ok by me.

Mark
