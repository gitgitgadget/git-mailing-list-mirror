From: Nathan Gray <n8gray@n8gray.org>
Subject: Re: Is there any way to make hooks part of the repository?
Date: Tue, 1 May 2012 17:10:02 -0700
Message-ID: <CA+7g9JzvN+5RsSF+bRFtaMafZeY+TyFkXeq-6OSAW3qJ99JqKg@mail.gmail.com>
References: <CAE1pOi2hr7ewjo5WVDoW0ipYxDVTckr5M_sHNoOQ323=_k754Q@mail.gmail.com>
	<7vipgf8wve.fsf@alter.siamese.dyndns.org>
	<86r4v3mxf7.fsf@red.stonehenge.com>
	<7vaa1r8vhy.fsf@alter.siamese.dyndns.org>
	<CAE1pOi00Mr4dOj2ChTJU9XWypUAaVUDDa36-M7LA+9BixW0nKw@mail.gmail.com>
	<CAJsNXT=niP2Ja-pSbvj-OGi5t0x0-Zxm3CdcY0nLs9ROdCG8hg@mail.gmail.com>
	<CAE1pOi02_u9j2oHy-RJ-XbrCmDiUWd4-=50f-v+iaK1GLaLQZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: PJ Weisberg <pj@irregularexpressions.net>,
	Junio C Hamano <gitster@pobox.com>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Git Users <git@vger.kernel.org>
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 02 02:10:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPN96-0004dp-8B
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 02:10:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757340Ab2EBAKH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 May 2012 20:10:07 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:34472 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757334Ab2EBAKF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 20:10:05 -0400
Received: by bkcji2 with SMTP id ji2so42406bkc.19
        for <git@vger.kernel.org>; Tue, 01 May 2012 17:10:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-originating-ip:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type:x-gm-message-state;
        bh=q13W2EjfMBbkr/76oSthvTyxZJ6F5UONgo/fI3sJrno=;
        b=lZp3jxieqIU8yADYynYvEcIYytNArua/NE0Owbw4aC1rf72C1AuAHCj6Xo3W+QrM43
         elpWoZ2bc9ER0Mjo5v9TECTDutM27SI6yuw3LYwS0zFKYFyKh+kZKj4uziQSaEc8TLIf
         12SnRYzPuxubqttqCSXkzhni3eHIif0RACYrFYU0fMavS2+GKTE1lLAspg4vnT6zr/Ui
         v1fJO21d/YIPCHfirK5uxq10LfnDWcd/+6+OiW88ogYlpWrupn+vP1a1DZqYOw2Gtyy1
         RaantImU4vye2W5VD+sEU5dOJ8yu+vdkp4yX9kKaGXvQm/H9NLqTeQGlcPlGPFx4xD0z
         SThA==
Received: by 10.204.128.75 with SMTP id j11mr1649442bks.2.1335917402584; Tue,
 01 May 2012 17:10:02 -0700 (PDT)
Received: by 10.205.42.6 with HTTP; Tue, 1 May 2012 17:10:02 -0700 (PDT)
X-Originating-IP: [184.182.186.242]
In-Reply-To: <CAE1pOi02_u9j2oHy-RJ-XbrCmDiUWd4-=50f-v+iaK1GLaLQZw@mail.gmail.com>
X-Gm-Message-State: ALoCoQmJYVwOvB6k+HsYmAPUFv/54Lhc9DAAGtr9+uIXm5Nr7Luen/YMhFPeWxnCdlH6lg5PIeyZ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196772>

On Tue, May 1, 2012 at 3:21 PM, Hilco Wijbenga <hilco.wijbenga@gmail.com> wrote:
> On 1 May 2012 14:59, PJ Weisberg <pj@irregularexpressions.net> wrote:
>> On Tue, May 1, 2012 at 2:09 PM, Hilco Wijbenga <hilco.wijbenga@gmail.com> wrote:
>>
>>> On 1 May 2012 14:03, Junio C Hamano <gitster@pobox.com> wrote:
>>>
>>>> We've talked about something like that a few times in the past, but as far
>>>> as I (am concerned / remember) the conclusion has always been that is not
>>>> worth "standardizing", i.e. nothing a ./setup script in-tree or a Makefile
>>>> target cannot offer the same convenience.
>>>
>>> This would not keep things up-to-date, though, would it? It seems like
>>> yet another thing developers need to remember and do. I would prefer
>>> something more automatic.
>>
>> Once your hooks are installed, couldn't your post-checkout and
>> post-merge hooks keep all the others up to date?
>
> Excellent point. Yes, that would certainly work.

But beware, this has the effect of making your hooks
version-dependent.  Check out a different branch and you can
potentially end up with a different hook.

IMHO things like this belong in a separate "admin" repo -- policy may
change over time, but going back to an old version of your code
shouldn't take you back to a correspondingly old version of your
policy.

Cheers,
-n8

-- 
HexaLex: A New Angle on Crossword Games for iPhone and iPod Touch
http://hexalex.com
On The App Store: http://bit.ly/8Mj1CU
On Facebook: http://bit.ly/9MIJiV
On Twitter: http://twitter.com/hexalexgame
http://n8gray.org
