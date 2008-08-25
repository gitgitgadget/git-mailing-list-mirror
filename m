From: "Felipe Contreras" <felipe.contreras@gmail.com>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Mon, 25 Aug 2008 17:38:38 +0300
Message-ID: <94a0d4530808250738q241b541dpd329b972778039cb@mail.gmail.com>
References: <7vprnzt7d5.fsf@gitster.siamese.dyndns.org>
	 <1219664940.9583.42.camel@pmac.infradead.org>
	 <48B2B21B.1080203@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "David Woodhouse" <dwmw2@infradead.org>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	users@kernel.org
To: "Ben Collins" <ben.collins@canonical.com>
X-From: git-owner@vger.kernel.org Mon Aug 25 16:46:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXdEQ-0002Zr-1l
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 16:39:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753846AbYHYOik (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 10:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753838AbYHYOik
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 10:38:40 -0400
Received: from rv-out-0506.google.com ([209.85.198.226]:65475 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753825AbYHYOij (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 10:38:39 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1659993rvb.1
        for <git@vger.kernel.org>; Mon, 25 Aug 2008 07:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=lq8h6V+Kqm2Tn3/rRi5kSuXrWEykETRyIh8R2yA4nuQ=;
        b=kvqD7u+tGBQf3kKr41ArbHbE3Xxd5rXwX7l0kjNBVauk5KSIui1Xe9QXn3/hH/CTBU
         rrM1NHpDoGBwuG7pKMhoDz7lPFo7s6iQFrNw3X2ToGi+88XBKrqRlmpLRwmqs08+BRxI
         NvFsjBcjkerbVZFCzZB9APy5OFaLkgxRoMqc8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=JgUfJIXrPLsR3uyz+rfOgX8mE2RKpGXE1pHd39FPdyZU5wmR6u3UPfARqffDGxs8Hd
         Rq3kaxH6MDtauOWvO2D4SUDRKzJs1AQg2+CpPwXfqHBsi1l9MsOnDOn67fPbRwzbeyfX
         T3fHE1Um45ab5DFMOYDX8W4C+CwEYsTPMRI9A=
Received: by 10.141.161.6 with SMTP id n6mr2184533rvo.41.1219675118662;
        Mon, 25 Aug 2008 07:38:38 -0700 (PDT)
Received: by 10.140.166.19 with HTTP; Mon, 25 Aug 2008 07:38:38 -0700 (PDT)
In-Reply-To: <48B2B21B.1080203@canonical.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93631>

On Mon, Aug 25, 2008 at 4:22 PM, Ben Collins <ben.collins@canonical.com> wrote:
> David Woodhouse wrote:
>>
>> On Sat, 2008-08-23 at 20:33 -0700, Junio C Hamano wrote:
>>>
>>> There is one alternative, and one augmentation:
>>>
>>>  (A) We do not do anything.
>>>
>>>  (B) In addition to the main transition plan, outside git, prepare an
>>>     optional "git-old-style" package that installs many "git-foo"
>>>     wrappers in $PATH (i.e. /usr/bin).  Each of them exec "git foo".
>>>     People who like the dashed form can keep typing "git-foo", even
>>>     though that will cost them two exec()s.
>>
>>  (C) Just don't do it. Leave the git-foo commands as they were. They
>>      weren't actually hurting anyone, and you don't actually _gain_
>>      anything by removing them. For those occasional nutters who
>>      _really_ care about the size of /usr/bin, give them the _option_
>>      of a 'make install' without installing the aliases.
>>
>> (Oh look, my /usr/bin has 3806 files in it. And except when I
>> accidentally point the $%#@&! GNOME file dialog box at it, I don't
>> _care_.)
>>
>
> I'll second that. I've not heard a good argument against the git-foo
> commands. If they were going to be deprecated, it should have actually
> happened a long time ago.

I personally like to use the git- format in written discussions
regarding git stuff (git-status vs git status), and for man.

I rarely do ls on /usr/bin, so I don't care if there are thousands of
git-whatever files there (thought exec-path somehow feels right), but
I can see how that could be an issue for people with minimal systems
or in different platforms with no hardlinks (win32 on fat32). But in
those cases aliases can be used: git-whatever -> "git whatever".

So I agree, there's no valid reason to remove the git-whatever stuff,
actually for documentation it does makes sense to me.

Best regards.

-- 
Felipe Contreras
