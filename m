From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 3/5] submodule: export sanitized GIT_CONFIG_PARAMETERS
Date: Thu, 28 Apr 2016 08:35:21 -0700
Message-ID: <CAGZ79kY+d2GV5L_aEunWMFzPURCLkqWqtQU4ibh3-7=5MEJmEQ@mail.gmail.com>
References: <20160428133534.GA19056@sigill.intra.peff.net>
	<20160428133744.GC25319@sigill.intra.peff.net>
	<CAGZ79karNW3+xiZQuoh5v-nRabs+h-5pyHDfjHS4vTVBkAyv_Q@mail.gmail.com>
	<20160428152811.GC31063@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Git Users <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 28 17:35:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avnyR-0000TS-Dk
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 17:35:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752647AbcD1PfX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 11:35:23 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:36789 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752319AbcD1PfX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 11:35:23 -0400
Received: by mail-io0-f180.google.com with SMTP id u185so93122858iod.3
        for <git@vger.kernel.org>; Thu, 28 Apr 2016 08:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=iAE/f3cC11vxfSWN+Oi6TclsgfIav8ZSK6FiMc+5y84=;
        b=ZHtr6yzeH73uiV3v5Vykw57YSIxgXRF5bfeXQn4n3ZUvmAVtoR0h/FsTqg54mdLGVA
         h7WPNOfyARXAIGFt7szLcofOKHnsuldraoIwV4Svqb2GxVBpGbLlMlU0oVZIdPu4wJg6
         EKJ4A6egosT6b+F7pM7Wr1/RTiqqX5ma5j649p6tMkJX6chHm7rLxXmC5yesOpbba1jO
         KgcMSqyBdOr0zhpZnWnxohJrgAQ22I9aUJr2Eln1Xu5ee+kJu4fiIXbU3sxD7pGupy0Q
         DX+GOx93oZOZvpcOfORZfDfXKSnybIPJOaukxgI2CQp346MVSXoTr0trosAPlug9flG+
         EbEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=iAE/f3cC11vxfSWN+Oi6TclsgfIav8ZSK6FiMc+5y84=;
        b=eMb7TY40Ekjb44eo9x/koiUqvogG0lpCKyWJlEhD5yPA8K4cVFcbDcy/duhzskiOoK
         n4GNTnT2E5cate4XV5w5utms7UuOTGpT/4H2yyKB2ArgA6dkDpcHKaNjbBZvaimKHpNi
         zDyunlkgdCh22y10nwSEJ5UwIRGxbFOooZJcHKy+eOiG8yOZbpLF8oywZI1JnswWtzQU
         8MNLlUTf1Y/S4zO/muJyZxi3yN73zK5uuCd7fH0Myf1jpXWuSAeN9JBkYQHJkaV4n4Bh
         xufWN6yG7pGCW486yh4Y0hhT5A7xZdOIenLTqJYHNU+wapApGQAxo+IlFCEcZP3BGVT2
         G0Dw==
X-Gm-Message-State: AOPr4FUwEdV2e46XPrRf1iDWodKYBbITg3bQHYhtr8aCDAi3vCqEvWwfRIfUzbyL0SsEVGb4DtCAs/RaaO/N+Ibl
X-Received: by 10.107.53.200 with SMTP id k69mr18077494ioo.174.1461857721906;
 Thu, 28 Apr 2016 08:35:21 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Thu, 28 Apr 2016 08:35:21 -0700 (PDT)
In-Reply-To: <20160428152811.GC31063@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292904>

On Thu, Apr 28, 2016 at 8:28 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Apr 28, 2016 at 08:25:29AM -0700, Stefan Beller wrote:
>
>> > +test_expect_success 'cmdline credential config passes submodule update' '
>> > +       # advance the submodule HEAD so that a fetch is required
>> > +       git commit --allow-empty -m foo &&
>> > +       git push "$HTTPD_DOCUMENT_ROOT_PATH/auth/dumb/repo.git" HEAD &&
>> > +       sha1=$(git rev-parse HEAD) &&
>> > +       git -C super-clone update-index --cacheinfo 160000,$sha1,sub &&
>>
>> The use of update-index seems elegant to me, though different than
>> any submodule test I wrote so far. :)
>
> Yeah, I actually wrestled with finding the shortest recipe to convince
> git-submodule to actually call git-fetch. Suggestions welcome if there's
> something more canonical.
>
> But I think we have to advance the submodule pointer in some way to
> convince it to want to fetch (I also tried deleting the refs in the
> cloned module, but that seemed hacky).
>
> I guess the way it would happen in real life is that the "origin" remote
> ("super" here, not "super-clone") would make the change and commit the
> submodule, and then "super-clone" would pull it.
>
> That seemed even more convoluted to me.

That's what I write in the other submodule tests, because I think we should
test closest to reality.

Instead of deleting the refs code, another hacky way would be

  echo $newsha1 > .git/module/remote/origin/refs/heads/master

but the update-index is less hacky, so let's keep that.

I did not want to point out an issue with it, just that I was pleasantly
surprised to see such a short test.

Thanks,
Stefan

>
> -Peff
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
