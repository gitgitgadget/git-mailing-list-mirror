From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/4] Re: [PATCH 3/4] t: rev-parse-parents: avoid yoda conditions
Date: Sat, 7 Sep 2013 23:14:50 -0500
Message-ID: <CAMP44s1gAfvBfcoStEB=U=dGHHxBPXXTbOXjELqDj17G6Tiumw@mail.gmail.com>
References: <CAMP44s112mwgs=8n0XCnTtPM2V-O5RYE2ns+fjCvgkxj+kEY8Q@mail.gmail.com>
	<20130903111006.GJ29840@goldbirke>
	<CAMP44s349-v6xtCvbDzycVj1wBwTdAgLmuGxB0pYn6CmHYkM1Q@mail.gmail.com>
	<20130903150855.GK29840@goldbirke>
	<20130903170419.GA29921@google.com>
	<xmqqli3co7ov.fsf@gitster.dls.corp.google.com>
	<20130904171356.GD2582@serenity.lan>
	<xmqq1u54o5c4.fsf@gitster.dls.corp.google.com>
	<20130904183559.GA3465@sigill.intra.peff.net>
	<CAMP44s3O=cHAtHOj41MccBDOausukb49MV-E6jib6n6czs+p3Q@mail.gmail.com>
	<20130908040615.GA14019@sigill.intra.peff.net>
	<CAMP44s16RZ9JguL=NPcD8TE-gdG7vGEa5KLHzv4bf_VLLEhPRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Sep 08 06:14:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIWOm-00011g-IL
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 06:14:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273Ab3IHEOx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 00:14:53 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:43523 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933Ab3IHEOw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 00:14:52 -0400
Received: by mail-la0-f46.google.com with SMTP id eh20so3879835lab.5
        for <git@vger.kernel.org>; Sat, 07 Sep 2013 21:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=UNqx8PxUWpr1mWD/QvMgD7EWP1SrrNK1iIjfiqdSpTs=;
        b=yHLzfs8IMjd82JgeK+Z2eumVfC8jsjp5QfugOoTG/UejVcfi5RPQ+qpEsmgB9tuvBM
         5yWM5b3PbqKpQDJxgITkL6FQuYHIOgcrHc7tdrjf7nldE94v00N2KpyUrVAt/1IAv21D
         NYM87SY+GUY22a8ZSKBhpnuGLv43SOKVmuNBcSI7zlxXXfd+zMWX0vzHjdAlXOCCNLqo
         TIcrE1MGM76cTTPKbCZjyvjU3hg/cCa1PzeWqj0Sr6OFOAkM1teYP7fHtMMlA7GufLcV
         hXfGctttAXlQEPjyO9vqMvwG4k3K8Vq00FvdBCN1tajuEfWt34brNfct3rD+y1QSGUkE
         ldfw==
X-Received: by 10.152.45.106 with SMTP id l10mr10111764lam.12.1378613691046;
 Sat, 07 Sep 2013 21:14:51 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Sat, 7 Sep 2013 21:14:50 -0700 (PDT)
In-Reply-To: <CAMP44s16RZ9JguL=NPcD8TE-gdG7vGEa5KLHzv4bf_VLLEhPRw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234173>

On Sat, Sep 7, 2013 at 11:13 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Sat, Sep 7, 2013 at 11:06 PM, Jeff King <peff@peff.net> wrote:
>> On Sat, Sep 07, 2013 at 10:11:49PM -0500, Felipe Contreras wrote:
>>
>>> > Though I prefer the current, I can certainly live and adapt to a changed
>>> > standard, and I do not mind doing so if there is a good reason. But I've
>>> > yet to see any argument beyond "it is not what I like". Which to me
>>> > argues for the status quo as the path of least resistance.
>>>
>>> Didn't Junio already provided reasoning?
>>
>> If the reasoning is "cmp(actual, expect) makes more sense to humans"
>> then I do not think it is universal.
>
> No.
>
> ---
> A(ny) sanely defined "compare A with B" function should yield the
> result of subtracting B from A, i.e. cmp(A,B) should be like (A-B).
> That is what you feed qsort() and bsearch() (it is not limited to C;
> you see the same in "sort { $a <=> $b }").  The definition naturally
> makes "cmp(A,B) < 0" like "A < B" and "cmp(A,B) > 0" like "A > B".
> ---
>
>> Otherwise why would so many
>> existing test frameworks do it the other way?
>
> Which many existing frameworks do it the other way?
>
>>> Here's more; human semantics:
>>>
>>> Computer, compare A with B
>>> cmp(A, B)
>>>
>>> Why would I write?
>>>
>>> cmp(B, A)
>>>
>>> Could you even construct an English sentence that starts with B, and then A?
>>
>> "Computer, given that we expect B, how does A differ?". Or "Computer, we
>> expect B; does A match it?"
>>
>> Or any number of variations. I'm sure you will say "but those seem
>> awkward and unlike how I think about it". But that was my point; it
>> seems to be a matter of preference.
>
> Really? You think any sane human being would prefer:
>
> Computer, given that we expect B, how does A differ?

And btw, that could barely be translated to cmp(B, A), probably cmp_given(B, A).

-- 
Felipe Contreras
