From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 82/83] environment: add set_index_file()
Date: Wed, 4 May 2016 13:50:18 +0200
Message-ID: <CAP8UFD1kfjU58cey-T9g3Nwo1RM6DN6MrgxyJQL8Ad53a+3DmQ@mail.gmail.com>
References: <1461505189-16234-1-git-send-email-chriscool@tuxfamily.org>
	<1461505189-16234-3-git-send-email-chriscool@tuxfamily.org>
	<xmqqh9efp30n.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 04 13:50:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axvJx-0007NO-RG
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 13:50:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751598AbcEDLuV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 07:50:21 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:35082 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751239AbcEDLuT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 07:50:19 -0400
Received: by mail-wm0-f42.google.com with SMTP id e201so184347122wme.0
        for <git@vger.kernel.org>; Wed, 04 May 2016 04:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=W0Lnyujc364wiBwg2U0JtViPBbubuRebs758AwIEru0=;
        b=NAmuzzjJtJZHQ8BjU7jqhzmaDZRHrO1poUYuUvdElCHBtZSY+pQSBDRA37DHsSYbnr
         /jjWOkeaCGRj5uJpQP/0MdVBEULaEOci+hGpgahuY8bkOYe3t/i0qiKKx0Gglq0sSxJe
         wAf+il30o/GunNcK89cMp6m4RUqKmDt8Z0AhDBZ5Cf3huLFO1TRpr+kE9Q2fm5XOZuYr
         /1ik4ZGorbOczlDFdepskWOV2IbnwLxIsZKzL6ZYp2E1YIrk1VB+d0sQXQqQeTc6/Ffc
         IJCurzVjZE8lvKblHC9u5lkb4Le5f5Zm+7vJTAnMhq3ZDvpjmtaC6t5eXfiyQEdK50NF
         1FHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=W0Lnyujc364wiBwg2U0JtViPBbubuRebs758AwIEru0=;
        b=aJaeL8SezmJhAkqKqDy/VytHKmDHM9o3UtncKXegtxiCD+i9m5GdBXn6vXrh0DNMKE
         yFSE0U5QVyLSIejuOdNTF5htjsWQe6OuSTHdYzg5kunjnsAqUB0EwKY4BtoSlezlIjga
         7xq5HrHE2uJ1l+c64bf+sKaDXjc9nE1wLApWzyjOQHhg31L/0Q4yjefYo0zVVevJ4pth
         qhtF79z1XdEe7TK3C3Z/sI2bzuWmPgYtsz39hREOnqpbGfwGyJQJe6GM1nSP5aL/uho1
         iQug63qng+xoXAZI+8zmeSRqHSlmPhhqTZaZ0HlkYnxpJqj8Mh6kBX5KX+rgb8MOHnBs
         T87w==
X-Gm-Message-State: AOPr4FWavAHVS2zm2jH/SMlN3lfh7ZILRCu7DlPMCjROt7Ze0Ar87G4Cv68vvwXYU7ZRhikZH1gVWQ4QqkyhHg==
X-Received: by 10.195.17.166 with SMTP id gf6mr8125692wjd.124.1462362618281;
 Wed, 04 May 2016 04:50:18 -0700 (PDT)
Received: by 10.194.246.4 with HTTP; Wed, 4 May 2016 04:50:18 -0700 (PDT)
In-Reply-To: <xmqqh9efp30n.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293540>

On Tue, May 3, 2016 at 5:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> +void set_index_file(char *index_file)
>> +{
>> +     git_index_file = index_file;
>> +}
>
> What's the rationale for this change, and more importantly, the
> ownership rule for the string?  When you call this function, does
> the caller still own that piece of memory?  When you call this
> twice, where does the old value go and who is responsible for
> taking care of not leaking it?
>
> Cannot guess any of the above with no proposed log message (that
> comment applies most of your patches in this series).

Yeah, I agree that I could have been more verbose on this one, and
some other ones too.

The reason for this is that run_apply() in builtin/am.c has a "const
char *index_file" argument.
The current version of run_apply() does:

        if (index_file)
                argv_array_pushf(&cp.env_array, "GIT_INDEX_FILE=%s",
index_file);

to pass that parameter to the `git apply` process that it launches.

I couldn't find a good way other than doing:

    if (index_file) {
        save_index_file = get_index_file();
        set_index_file((char *)index_file);
    }

    /* Call libified apply functions */
    ...

    if (index_file)
        set_index_file(save_index_file);

to do the equivalent of what was done previously.

So I guess I could have written something like the following in the
commit message of the commit that introduces set_index_file():

    Introduce set_index_file() to be able to temporarily change the index file.

    It should be used like:

        /* Save current index file */
        old_index_file = get_index_file();
        set_index_file((char *)tmp_index_file);

        /* Do stuff that will use tmp_index_file as the index file */
        ...

        /* When finished reset the index file */
        set_index_file(old_index_file);

Maybe I could also add a comment just before the function.
