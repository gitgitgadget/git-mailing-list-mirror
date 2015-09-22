From: Josh Boyer <jwboyer@gmail.com>
Subject: Re: Specifying N revisions after the initial commit
Date: Tue, 22 Sep 2015 16:11:23 -0400
Message-ID: <CA+5PVA6zUXGs2R-MOoj5sBxwUqM7HP=tx-0WZJzPf71MsjH9MA@mail.gmail.com>
References: <CA+5PVA40x8bxW63X+b77FDO8btRBaVOg=fq+ZyX=bdJ+uEm9gA@mail.gmail.com>
	<20150922214037.b6b48059f051fcd4060a5a85@domain007.com>
	<CA+5PVA6YWJizRjseeJ4EpRya0Mpyrv3DoNsB3=Gi=dOiAoDfHg@mail.gmail.com>
	<xmqqpp1a2pql.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Konstantin Khomoutov <kostix+git@007spb.ru>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 22 22:11:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeTui-0001gp-D6
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 22:11:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934628AbbIVUL1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2015 16:11:27 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:35940 "EHLO
	mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933591AbbIVULY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2015 16:11:24 -0400
Received: by ioii196 with SMTP id i196so25866283ioi.3
        for <git@vger.kernel.org>; Tue, 22 Sep 2015 13:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=/85UIO7boY8vs9jYeGhPjCapkidmz/rjj/bvGEiRVKc=;
        b=GEWG6tvRnS3pBVWkEuKFtPg02yqwpWO+AfetCl7ELZG/HNsyV58b8kfL7hq0PFhR4R
         BVq5K5UjjMWzB2lrVZvjhVi2JCcLMVm86aMrKpgjcYWzYqu8VRIXYathegtfsn3zycVu
         jN6ZK/IzEG0CeZ+tua6qPg2yR3WPo6f/z4/2VRU4yK0QiDFHE0TIFMCqI0VdkY77YUIg
         O3orlX8cMOpHtWFxImfHayIJV1lXlyix2Cp2ABElshwCPRFdae584VuXgr6QmRbCkXug
         GAchKBHjH5UrFfAXGccakGYCmNMLjDv+s0MnJ55fZtNaynNYGh9ANDcja14vZePE6jyL
         w9pg==
X-Received: by 10.107.11.154 with SMTP id 26mr38069975iol.105.1442952684065;
 Tue, 22 Sep 2015 13:11:24 -0700 (PDT)
Received: by 10.64.132.167 with HTTP; Tue, 22 Sep 2015 13:11:23 -0700 (PDT)
In-Reply-To: <xmqqpp1a2pql.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278429>

On Tue, Sep 22, 2015 at 3:55 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Josh Boyer <jwboyer@gmail.com> writes:
>
>> On Tue, Sep 22, 2015 at 2:40 PM, Konstantin Khomoutov
>> ...
>>> Hence, given any particular commit, you're able to trace all of its
>>> ancestry, but the reverse is not possible.
>>
>> That makes sense.  I suppose I will have to resort to parsing output
>> of git-rev-list or something.  Thanks for the reminder.
>
> I think Konstantin explained why it fundamentally does not make
> sense to ask "which one is the Nth one after the root".  I am not
> sure how running rev-list and count its output would help, unless
> you are now solving a different problem (perhaps "find all the ones
> that are Nth after some root", which does have an answer).

Oh, context would help, yes.  In the case of the tree I'm parsing, I
know for a fact that the commit history is entirely linear and will
(should) always remain so.  E.g.

A - B - C - D - E - F ... {N}

So yes, finding e.g. the second commit after the root is complicated
for something resembling anything like a typical git repo, but this
isn't like that.  In other words, I can cheat.  Or at least I'm pretty
sure I can cheat :).

josh
