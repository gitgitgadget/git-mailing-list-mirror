From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2] completion: add new git_complete helper
Date: Tue, 17 Apr 2012 23:53:08 +0300
Message-ID: <CAMP44s0w40ViecQsF8AeQLLxAEShC54TTyvcPVMabpOZ+DYDqQ@mail.gmail.com>
References: <1334524814-13581-1-git-send-email-felipe.contreras@gmail.com>
	<20120415213718.GB5813@burratino>
	<20120416221531.GA2299@goldbirke>
	<CAMP44s2N9wFg5kx7jw2w6G6BQ1riX-W9cKt8kBPaofugm0OV1g@mail.gmail.com>
	<7vty0inys6.fsf@alter.siamese.dyndns.org>
	<CAMP44s1sj27U_s3Y3nLL6pkMrPMVvTo982c85x-hH5szvprK0g@mail.gmail.com>
	<7v4nsins1j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 22:53:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKFOn-0004Ve-1W
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 22:53:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751680Ab2DQUxN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Apr 2012 16:53:13 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:53562 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751211Ab2DQUxK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2012 16:53:10 -0400
Received: by eaaq12 with SMTP id q12so1700056eaa.19
        for <git@vger.kernel.org>; Tue, 17 Apr 2012 13:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=NidKMvQsBNs6WH4qiCqaPJx+VpvWc3Pm5OdARXDM8rA=;
        b=JIMO80/ypcx9rHaQwZjdkQqZIvBQjvswXk2KhgFBh/t2g3RLY3D6FrgJDgf6R40XrE
         1csDHEXYssxlM5lSVNpVgBenyoyazLLn9bxWeEuiDHAgHBrBU/8OoJ4KGWutuMCsYKyz
         bFvmUXte2Oo0I/92UspkPE8jyf5GuNHfpscNywUlR+Aa6JiM5Pn4R2jWTB/4ydDhBjik
         zsoUyQD1uQW/UK8p1c7o/DNhqQy6KmdolAtM1wwcKLTQyHYq9b2oBVYHqR17yqRSEO2c
         3cuBltrdlpx8uay0u++6FghIqRhHfmfr43NzK2LVp6DbQEyBPrrRxRKedsrb3RwszObv
         tF1w==
Received: by 10.14.39.197 with SMTP id d45mr2438753eeb.89.1334695988748; Tue,
 17 Apr 2012 13:53:08 -0700 (PDT)
Received: by 10.213.19.67 with HTTP; Tue, 17 Apr 2012 13:53:08 -0700 (PDT)
In-Reply-To: <7v4nsins1j.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195807>

On Tue, Apr 17, 2012 at 9:15 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Tue, Apr 17, 2012 at 6:50 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>> ...
>>>>> And foo_wrap() should also fit into those namespaces.
>>>>
>>>> Yeah, I don't have a problem with that, just forgot about it.
>>>>
>>>> But git_complete I think is different.
>>>
>>> Is git_complete something the user types interactively, or is it meant to
>>> be used in their .bashrc to help them complete arguments to their custom
>>> scripts that take arguments similar to Git Porcelains?
>>
>> It's meant for their .bashrc, but can be used interactively, exactly
>> like 'complete'. You can type 'complete -o bashdefault -o default -o
>> nospace -F _git git' in the command like, but that would rarely
>> happen.
>
> OK, then I do not think "as a public interface it looks somewhat ugly"
> (which I happen to think, and I am guessing that you agree with) matters.
> It looks to me that it would be sane to follow the convention

But that convention is for *private* functions.

> to avoid
> accidental name clashes with userspace names by naming it "__git_complete"
> in that case.

What if there are no clashes?

Are you saying that even if there are no real clashes, only
hypothetical ones, you would still prefer __git_complete?

How are people going to distinguish between public and private functions?

-- 
Felipe Contreras
