From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] upload-pack: Optionally allow fetching reachable sha1
Date: Sun, 3 May 2015 17:35:45 -0400
Message-ID: <CAPig+cShtk7Be_miSfgzXTPdWxfYmFjJ+kEg5xr+2yLyEhfLvQ@mail.gmail.com>
References: <1430604075-5951-1-git-send-email-fredrik.medley@gmail.com>
	<xmqqy4l5v9tm.fsf@gitster.dls.corp.google.com>
	<CABA5-znFVPunBxET-42jDTC00gH8VMkG280Ptyr8FUU6vfuiCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Christian Halstrick <christian.halstrick@gmail.com>,
	Dan Johnson <computerdruid@gmail.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Fredrik Medley <fredrik.medley@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 03 23:35:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yp1YF-0006dH-9H
	for gcvg-git-2@plane.gmane.org; Sun, 03 May 2015 23:35:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751555AbbECVfq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 May 2015 17:35:46 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:34054 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751278AbbECVfp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 May 2015 17:35:45 -0400
Received: by iget9 with SMTP id t9so56134069ige.1
        for <git@vger.kernel.org>; Sun, 03 May 2015 14:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=IJ8rUL59VodausmKm3K3mTCuNn0oYDzViC/YcmJSe0w=;
        b=BZ2cDh5OPiWu+zb0wudNuoJ4iqXm5/oTMqJ1+MudpBLgRkDTauTYlQ93Q5PMWBsM0i
         yAj09mfCsZqx80tF66tAXqvsfAG590jM/0S/s3UHFS5tbOiK2zdjy10sw7Jd+1GFQqeV
         cQeRqtTZooWXzY+mQfjkY8dskdw1VpB7NRf5VmxBI4ty2pyb3exGY/FSXm6OnrjSf3wE
         pAkrduV6zp0xXJPr6iGq18QXtMsPocAa5Ep9e1yDLzaRMgjlj6s/8RWPcaxn2GR0Jors
         gGQGFhLF6eLCGGe5HFHI6v+nwAhiMwV+HoppcCk15rNJdgjLLR/uj2uCuE8s7nVYI6EX
         6NeA==
X-Received: by 10.50.43.227 with SMTP id z3mr9782532igl.22.1430688945242; Sun,
 03 May 2015 14:35:45 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Sun, 3 May 2015 14:35:45 -0700 (PDT)
In-Reply-To: <CABA5-znFVPunBxET-42jDTC00gH8VMkG280Ptyr8FUU6vfuiCA@mail.gmail.com>
X-Google-Sender-Auth: BKsTX6QwAk66082eb6kVOtLhJyY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268296>

On Sun, May 3, 2015 at 4:13 PM, Fredrik Medley <fredrik.medley@gmail.com> wrote:
> 2015-05-03 19:40 GMT+02:00 Junio C Hamano <gitster@pobox.com>:
>> Fredrik Medley <fredrik.medley@gmail.com> writes:
>>> For you who don't remember the email discussion, look through the references.
>>
>> Please don't do this.  Always describe the background yourself in
>> the log message so that "git log" can be read offline.  "describe
>> yourself" can be done by summarizing earlier discussion, borrowing
>> others' words, of course.  And it is a very good idea to give
>> references like you did after your summary to optionally allow
>> people to verify your summary is correct.
>
> Okay, I understand. My intention was to recapture the old thread, but
> to keep the part under the references for the commit message. When
> I get this answer, I do see that this is impossible to understand and I
> should probably have added a cover-letter instead. (This is my first
> time every I've supplied patches to such an open-source project.)

Welcome to open-source and to git.

> Is the text under the reference enough describing or should there
> be added some more background text?
> Unless someone asks for more answers about my attempt to recap
> the old mail thread, I skip commenting on this part.

What Junio meant was that the commit message should be sufficiently
self-contained such that someone reading it should be able to
understand the problem you're solving without being familiar with past
discussions (and without having to chase down links), and why the
solution you've chosen is desirable.

In this case, the paragraph following the references in your patch,
which you had intended as the full commit message, may not be
sufficient. You might come closer to a good commit message by fleshing
out the paragraph preceding the references, and following that by the
paragraph after the references. By "fleshing out", I mean providing
salient information from the cited discussions at the points where you
referenced them via [n] notation.

Your commit message should explain the problem in the current
implementation (possibly justifying why you consider it a problem),
and an explanation of the solution. You will want to keep the
references (but move them to the bottom of the commit message), and
cite them when appropriate in your explanation.

For a single patch like this, you don't really need a cover letter.
Just make sure the commit message provides sufficient explanation and
is self-contained. If you want to provide extra commentary not
intended for the commit message, place it below the "---" line after
your sign-off and before the diffstat.
