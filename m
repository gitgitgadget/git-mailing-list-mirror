From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: Re: [PATCH] build: get rid of the notion of a git library
Date: Sun, 09 Jun 2013 19:30:31 +0200
Message-ID: <51B4BBB7.8060807@lyx.org>
References: <1370712574-27688-1-git-send-email-felipe.contreras@gmail.com> <CALkWK0mA7MXQv1k5bFpZLARDOHxU5kzKFXzcyUfb6NLZZY-=FA@mail.gmail.com> <CAMP44s0cozMsTo7KQAjnqkqmvMwMw9D3SZrVxg48MOXkH9UQJQ@mail.gmail.com> <CALkWK0=7PRndNc7XQ-PCPbVCp9vck909bA561JhQG6uXXj1n4g@mail.gmail.com> <20130609151235.GA22905@serenity.lan> <CAMP44s0L9nQxp5OeK8uT4Ls5WUerCjVpR9uONUcOwvTD6k7Jfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: John Keeping <john@keeping.me.uk>,
	Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 09 19:30:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UljRv-0004Sz-Su
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 19:30:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459Ab3FIRaf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 13:30:35 -0400
Received: from mail-wi0-f182.google.com ([209.85.212.182]:54431 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002Ab3FIRae (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 13:30:34 -0400
Received: by mail-wi0-f182.google.com with SMTP id m6so314955wiv.15
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 10:30:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=hTywISl5HXT56ETCb0hWdjl9wKDMfzCfQS4W57opPsg=;
        b=gtjUVeUOnEgZ8T3DQ6YXStrVyIRulS+mpzxz8NDub8xjhxl73DvDW1HrEzO/u2r50m
         J3uG/waQMcadDpPbvHsobl4kwc4QwyG1IK61zwctZUnpkU3nV2JspZxLGSvp5qv0858S
         FiDCBbbwF6FS4fq5wSJ7v6TOEdGYUiKWe87SthOH2OVDtAMt/EkrKcbQcRBvPpbcYO1w
         kSKlrV5mM1yI5q5KzFkJwsC3IWNUJnqj3jlF97ThAqhRzRH6Qz9dPPGQ9ZMvgjxc1pZl
         2TNpj2FL4fwVFwaaY0VU+O0czGyyrIK6sRzN4k2eAFz6XQN3Bdv7fFANHo6aOjArBoi/
         BCvA==
X-Received: by 10.180.13.5 with SMTP id d5mr1476153wic.56.1370799032925;
        Sun, 09 Jun 2013 10:30:32 -0700 (PDT)
Received: from [192.168.1.5] (g245184.upc-g.chello.nl. [80.57.245.184])
        by mx.google.com with ESMTPSA id en3sm7099436wid.1.2013.06.09.10.30.31
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 10:30:32 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
In-Reply-To: <CAMP44s0L9nQxp5OeK8uT4Ls5WUerCjVpR9uONUcOwvTD6k7Jfg@mail.gmail.com>
X-Gm-Message-State: ALoCoQl9dMhMZdj5SQ1h5F+MBWQ37A1dU+pAGgFjuSxxlVqWqiHBJMwwnb/PLZU+vEIDF9nP61C1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227038>

Op 9-6-2013 17:40, Felipe Contreras schreef:
> On Sun, Jun 9, 2013 at 10:12 AM, John Keeping <john@keeping.me.uk> wrote:
>> On Sun, Jun 09, 2013 at 08:26:32PM +0530, Ramkumar Ramachandra wrote:
>>> Felipe Contreras wrote:
>>>> The plan is simple; make libgit.a a proper library, starting by
>>>> clarifying what goes into libgit.a, and what doesn't. If there's any
>>>> hopes of ever having a public library, it's clear what code doesn't
>>>> belong in libgit.a; code that is meant for builtins, that code belongs
>>>> in builtins/lib.a, or similar.
>>>>
>>>> Give this a try:
>>>>
>>>> --- a/sequencer.c
>>>> +++ b/sequencer.c
>>>>
>>>> libgit.a(sequencer.o): In function `copy_notes':
>>>> /home/felipec/dev/git/sequencer.c:110: undefined reference to
>>>> `init_copy_notes_for_rewrite'
>>>> /home/felipec/dev/git/sequencer.c:114: undefined reference to
>>>> `finish_copy_notes_for_rewrite'
>>> This is a good example: yes, I'm convinced that the code does need to
>>> be reorganized.  Please resend your {sequencer.c ->
>>> builtin/sequencer.c} patch with this example as the rationale, and
>>> let's work towards improving libgit.a.
>> Why should sequencer.c move into builtin/ to solve this?  Why not pull
>> init_copy_notes_for_rewrite and finish_copy_notes_for_rewrite up into
>> notes.c?
> Because finish_copy_notes_for_rewrite is only useful for builtin
> commands, so it belongs in builtin/. If there's any meaning to the
> ./*.o vs. builtin/*.o divide, it's for that. Otherwise we should just
> squash all objects into libgit.a and be done with it.
>
I think that libgit.a should contain all code to be able to carry out 
all functions of git. The stuff in builtin/ is just a command-line user 
interface. Whether or not sequencer should be in builtin depends on 
whether the sequencer is only part of this command-line user interface.

I think that the sequencer code is at the moment unusable if you do not 
use the code in builtin/ so that would advocate to move it into 
builtin/. If sequencer is in libgit, and I write my own (graphical) user 
interface, I expect to be able to use it.

Vincent
