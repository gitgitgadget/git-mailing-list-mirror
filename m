From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Re: Your branch and 'origin/master' have diverged
Date: Tue, 14 Aug 2012 15:15:54 -0700
Message-ID: <CAE1pOi3a9ZMFfJ2qjkaZ_O-DuQa3xkKtsMU5GYYUuiwcRoFjbg@mail.gmail.com>
References: <CAE1pOi1WTbMSK8dOus6pFCa2C9vGA8QNE3+8w0LFmGkvcfq5fg@mail.gmail.com>
 <87zk5x6fox.fsf@thomas.inf.ethz.ch> <CAE1pOi1YFe9GB1L_==RTecEAipdTKj2-ixpwTnrmOgkkV8rkYw@mail.gmail.com>
 <7v628lbdcw.fsf@alter.siamese.dyndns.org> <CAE1pOi2DZNkYYwkH1MFh0m708T=DEdJawZCQgvk1HTGrqjkz2w@mail.gmail.com>
 <87lihh8c7s.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git Users <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Aug 15 00:16:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1PPU-0005GH-GY
	for gcvg-git-2@plane.gmane.org; Wed, 15 Aug 2012 00:16:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751787Ab2HNWQS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Aug 2012 18:16:18 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:47065 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751304Ab2HNWQR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2012 18:16:17 -0400
Received: by bkwj10 with SMTP id j10so314508bkw.19
        for <git@vger.kernel.org>; Tue, 14 Aug 2012 15:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=nP7ciE+/Ri8tp0arHFRbBjTa2S8ZlpblqMttXuwJldc=;
        b=jT8iL0DxTg8Xp1GOkwsAEe2vHxegmbRndxGQXmTSsTS7j0CAc0ZT8qMwYT/lG90075
         5J7OBQ5wwzLNPLP3p3e6ww0/A48Bvx62zmt74j918+rwyKtQMpYQf/SkAG530XNz5GZ+
         2KRGV3tvC7eAQ555lzsa1rxcQEOfv6djwLeI9bZOmfC2VSl/gHlUwjUqYKmEUTpRiBkm
         XueNxtwkYpw34B+BVI5F9yyeDIY8nacmrW/z60TgJv0EEXqdaIPClsfnGuPahq2RTrhF
         jxUaVXCWRKzSlEHkEadBPV0dTEfCGTE2EnX43DMrY3efxHn34h8EshYHGIykarhyDsAF
         DGoA==
Received: by 10.204.152.220 with SMTP id h28mr6944475bkw.30.1344982576035;
 Tue, 14 Aug 2012 15:16:16 -0700 (PDT)
Received: by 10.204.132.72 with HTTP; Tue, 14 Aug 2012 15:15:54 -0700 (PDT)
In-Reply-To: <87lihh8c7s.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203455>

On 14 August 2012 13:12, Thomas Rast <trast@student.ethz.ch> wrote:
> Hilco Wijbenga <hilco.wijbenga@gmail.com> writes:
>
>> On 14 August 2012 10:19, Junio C Hamano <gitster@pobox.com> wrote:
>>> Hilco Wijbenga <hilco.wijbenga@gmail.com> writes:
>>>
>>>> On 14 August 2012 01:27, Thomas Rast <trast@student.ethz.ch> wrote:
>>>>> [git pull with two args] it's ok if you use it with an URL instead
>>>>> of a remote nickname
>>>>
>>>> Why would that be okay? What is the difference? Isn't the nickname
>>>> just an alias for a URL?
>>>
>>> As long as you tell what refspecs to use on the command line, the
>>> remote nickname behaves as "just an alias for a URL", so yes,
>>> because Thomas is discussing "two-arg pull or fetch", one arg being
>>> either nickname or URL and the other is an explicit refspec on the
>>> command line, it would be okay because there is no difference in
>>> that case.
>>
>> I suppose I'm not entirely clear on how this two step process is
>> "safer". Doing "git fetch" would seem to be harmless, right? So the
>> problem is with "git merge" but master should always be "behind"
>> origin/master so that "git merge" should just FF to origin/master
>> which *should* be completely safe. Does that make sense? Especially
>> given our use of master as an integration branch?
>>
>> [Given the trouble I have with getting people to use Git properly, I
>> prefer things as simple as possible. :-) ]
>
> I meant something else than Junio hinted at.  Saying
>
>   git fetch origin master
>   # or by extension
>   git pull origin master
>
> does not update the origin/* namespace, not even origin/master.  All
> fetching happens only into FETCH_HEAD.  This leads to confusion such as
> yours because origin/master and thus the upstream tracking displays will
> not know about the change.

I'll say. Now I'm really confused.

If what you say is true then what is updating origin/master? I've been
using "git pull" daily for over a year and origin/master is definitely
getting updated (at least according to gitk).

Mmm, just to make sure we are all talking about the same
origin/master: I mean my local reference to the SHA1 of the commit
that is master's HEAD on origin. After I have run "git pull",  *my*
master and *my* origin/master point to the same commit. Or I'm
*really* confused. Or I've confused you by using incorrect
terminology. :-) Or by using the right terminology incorrectly. ;-)
