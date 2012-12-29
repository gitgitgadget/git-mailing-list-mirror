From: Adam Spiers <git@adamspiers.org>
Subject: Re: [PATCH v3 18/19] setup.c: document get_pathspec()
Date: Sat, 29 Dec 2012 00:52:25 +0000
Message-ID: <CAOkDyE89fm5_z2V=VW5n+8XAvB6tE+DqciXttbhX29X8mWjXTQ@mail.gmail.com>
References: <1356575558-2674-1-git-send-email-git@adamspiers.org>
	<1356575558-2674-19-git-send-email-git@adamspiers.org>
	<7v7go1j4ml.fsf@alter.siamese.dyndns.org>
	<CAOkDyE-UXGhe1aiWy_1_y7cvrmfvivSBxY9LHudOmeZD=M-12A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 29 01:52:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TokfV-0003Os-5G
	for gcvg-git-2@plane.gmane.org; Sat, 29 Dec 2012 01:52:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755172Ab2L2Aw2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Dec 2012 19:52:28 -0500
Received: from mail-wg0-f52.google.com ([74.125.82.52]:44019 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755123Ab2L2Aw1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Dec 2012 19:52:27 -0500
Received: by mail-wg0-f52.google.com with SMTP id 12so5119317wgh.7
        for <git@vger.kernel.org>; Fri, 28 Dec 2012 16:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=IwDfq0hvFP/FbyqQez/7nIbH03rPlCoHhfJt/3HLPKo=;
        b=SZPz8Xw/BoAQUHeDd7wr7Nc4E8x2QVig8cBnw69t2cW/yLXpIYaiHoz3zrMys1Dtea
         cTcX8VORn2RmyMOqg2aa7D7weGz6D1dFZhe8+gkxuMOdocxUzc293DYegD9d9mf7K5mM
         ZF7km1xWTNU6WXMBq+yN3JErvH/GcVooRzoMTjwDJKcsb08JhrfrI0TAsGGy6eBoAHIG
         jc0SgfzU/N1lVDnWYShH3N9RRI+hly+w8QmlHY1a9honnyHCBRJXV571suYv9M9aYftR
         oULlyrdMl5xO/AL6Os9jEHwLdkt320U+at8Dxftt1ns8CNxHQCY1RTb3K+T9JPuUI32F
         SkQQ==
Received: by 10.194.236.68 with SMTP id us4mr56455924wjc.11.1356742345509;
 Fri, 28 Dec 2012 16:52:25 -0800 (PST)
Received: by 10.194.84.97 with HTTP; Fri, 28 Dec 2012 16:52:25 -0800 (PST)
In-Reply-To: <CAOkDyE-UXGhe1aiWy_1_y7cvrmfvivSBxY9LHudOmeZD=M-12A@mail.gmail.com>
X-Google-Sender-Auth: PYIUjB3-yH-WniAcdVAeK5Q4gGI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212279>

On Fri, Dec 28, 2012 at 8:40 PM, Adam Spiers <git@adamspiers.org> wrote:
> On Fri, Dec 28, 2012 at 8:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Adam Spiers <git@adamspiers.org> writes:
>>
>>> Since we have just created a new pathspec-handling library, now is a
>>> good time to add some comments explaining get_pathspec().
>>>
>>> Signed-off-by: Adam Spiers <git@adamspiers.org>
>>> ---
>>
>> Yes, but we would rather not to see new users of this function added
>> to our codebase in its current form, as explained in the nearby
>> comment.  We would want to migrate everybody to "struct pathspec"
>> based interface to support magic pathspecs in the longer term.
>
> I see.  Please feel free to drop that patch from the series or amend
> as you see fit.

I've added this sentence to the top of the comments above
get_pathspec():

    /*
     * N.B. get_pathspec() is deprecated in favor of the "struct pathspec"
     * based interface - see pathspec_magic above.
     *
    [...]

That should be sufficient to discourage people from adding new users
of get_pathspec().
