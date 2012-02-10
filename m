From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: A note on modern git plus ancient meld ("wrong number of
 arguments")
Date: Fri, 10 Feb 2012 11:59:15 -0600
Message-ID: <20120210175915.GB19216@burratino>
References: <20120209191742.GA20703@unpythonic.net>
 <CAJDDKr58LV9EDJZP+3S0YfyTOXFgJWD6nm=AiA19MkyBF-wb_g@mail.gmail.com>
 <20120210082106.GA7871@burratino>
 <CAHGBnuPBDO=tnoDFGOcGz4nZh9O_A803STmj7KALLuhwgf=hCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Aguilar <davvid@gmail.com>,
	Jeff Epler <jepler@unpythonic.net>, git@vger.kernel.org,
	Charles Bailey <charles@hashpling.org>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 10 18:59:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rvuks-0004VK-Rt
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 18:59:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754856Ab2BJR70 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Feb 2012 12:59:26 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:37566 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751177Ab2BJR7Y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Feb 2012 12:59:24 -0500
Received: by ggnh1 with SMTP id h1so1631754ggn.19
        for <git@vger.kernel.org>; Fri, 10 Feb 2012 09:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=L0js4niZJg9UNuEts/8TuJ1PRU1Zz2GHnks9JUEbkN0=;
        b=OoDtcsf0aNRMt6WSt8TbciNBGft2THPhvL+XOluPuHKLd6ZMfJbWc6wmX/DOumYO7v
         +Ifq0s1sz6LPn+7x1bASNy/+5JQO58BKt0G0/KLa7C0tmkmmPUXErjgC31qiJdJpdRTQ
         7Ru2KoB50TTXKtgAQ7TRc7IBYoUKUpL6JxGIo=
Received: by 10.50.202.97 with SMTP id kh1mr13295562igc.19.1328896763987;
        Fri, 10 Feb 2012 09:59:23 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id e17sm13010711ibe.0.2012.02.10.09.59.22
        (version=SSLv3 cipher=OTHER);
        Fri, 10 Feb 2012 09:59:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAHGBnuPBDO=tnoDFGOcGz4nZh9O_A803STmj7KALLuhwgf=hCg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190428>

Hi,

Sebastian Schuberth wrote:
> On Fri, Feb 10, 2012 at 09:23, Jonathan Nieder <jrnieder@gmail.com> w=
rote:

>> + =C2=A0 =C2=A0 =C2=A0 meld_version=3D${meld_version#GNOME }
>> + =C2=A0 =C2=A0 =C2=A0 meld_version=3D${meld_version#* }
>
> Hmm, I might be mistaken, but aren't these string operations
> Bash-only? And AFAIK Git is striving for standard sh compatibility ..=
=2E

They are widely supported in POSIX-style shells.  See [1] and
Documentation/CodingGuidelines:

 - We use POSIX compliant parameter substitutions and avoid bashisms;
   namely:

   - We use ${parameter-word} and its [-=3D?+] siblings, and their
     colon'ed "unset or null" form.

   - We use ${parameter#word} and its [#%] siblings, and their
     doubled "longest matching" form.

A good way to catch these things is to try with dash or posh, which
are a little less full-featured than bash and ksh.

Thanks for looking it over.
Jonathan

[1] http://pubs.opengroup.org/onlinepubs/9699919799/
Search for "sh -".
