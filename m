From: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v3] Add an explicit GIT_DIR to the list of excludes
Date: Thu, 29 May 2014 12:34:20 +0200
Message-ID: <CANQwDwfC93uG7+mv0XpxuRWQP+yGS0F94OHk7AUcy_WfQ7VtQQ@mail.gmail.com>
References: <1400866411-14584-1-git-send-email-pasha.bolokhov@gmail.com>
 <CACsJy8CDeTn8h8uUn_=6ek7BJueN_1i01TB_AeH03RKnf6tNSw@mail.gmail.com>
 <CAKpPgvfqTBxFXOaStEyyS7wAdR5aUsEOX_M2gPvGz4_dJYvTOA@mail.gmail.com>
 <5386309E.3070003@gmail.com> <CAKpPgvcMJCYS9jfq+XhfZzT6w4RgBvMypqo2BsAWK2XYt2BPBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Duy Nguyen <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Pasha Bolokhov <pasha.bolokhov@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 29 12:35:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wpxfv-0005b7-Td
	for gcvg-git-2@plane.gmane.org; Thu, 29 May 2014 12:35:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756782AbaE2KfB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 May 2014 06:35:01 -0400
Received: from mail-oa0-f42.google.com ([209.85.219.42]:62285 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755934AbaE2KfA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 May 2014 06:35:00 -0400
Received: by mail-oa0-f42.google.com with SMTP id j17so123884oag.1
        for <git@vger.kernel.org>; Thu, 29 May 2014 03:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=w6AT0Yk4Aponjr2p+IcxduMx62ZZIaNMXR+xzHkB9O0=;
        b=0S1DVAVQ9N9f/ntzn9aCHOYdwJtfdGvUGqS4EC+TquqHb0MZSAB3YuhAixoQvGs3ja
         +5+K48UXCNNjLYckOo2KdfeFeyfC/PQhGzTYHKfmma++VHZQ+iTArma4B76JjYXbTEe1
         dryAf5U/logRwTqXE6k3XdSocUBDUb9YJ1mpAgReZeCmc5a0AQtXE7WmFLt22SbG9sUa
         a1niqQRQ8C5h2uVelP6oyvgbaV10Z8lvSdFhR5zbf4+HuPB8GhnCqVZyiCO8cD55vWK9
         z9wBzdtjLPak8efUxSo9f5zriohNR2GZ1/inY1A678A/2H6chjS38XdlYXARxgJkK6BU
         k32Q==
X-Received: by 10.182.199.5 with SMTP id jg5mr3673193obc.75.1401359700111;
 Thu, 29 May 2014 03:35:00 -0700 (PDT)
Received: by 10.76.129.202 with HTTP; Thu, 29 May 2014 03:34:20 -0700 (PDT)
In-Reply-To: <CAKpPgvcMJCYS9jfq+XhfZzT6w4RgBvMypqo2BsAWK2XYt2BPBg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250355>

On Thu, May 29, 2014 at 4:33 AM, Pasha Bolokhov
<pasha.bolokhov@gmail.com> wrote:
>
> Agree, but "partial" here means... what? just a little doc?

I'm sorry, I tried to be cute and failed :$

This is not official name for documentation files that are meant for in=
clusion
and not as standalone manpages.  I think they are similar to 'partial t=
emplates'
http://guides.rubyonrails.org/layouts_and_rendering.html#using-partials
- usually just called "partials" - hence my use of this name.

Example: date-formats.txt included in git-commit(1), git-commit-tree(1)
and git-tag(1).

> On Wed, May 28, 2014 at 11:53 AM, Jakub Nar=C4=99bski <jnareb@gmail.c=
om> wrote:
>> W dniu 2014-05-27 19:16, Pasha Bolokhov pisze:
[...]
>>>      I suggest this. There appears to be a notion of "standard
>>> excludes" both in the code (dir.c) and in the man pages (git-grep,
>>> git-ls-files). However, it doesn't actually appear to be defined
>>> strictly speaking. So my suggestion is to define those "standard
>>> excludes" in one place (say "gitignore(5)"), and make other man pag=
es
>>> (git-config, git-grip, git-ls-files) have references to that place
>>> instead of explaining every time in detail what is being excluded.
>>
>>
>> Or define those "standard excludes" in standard-excludes.txt "partia=
l",
>> and include said file from git-grep(1), git-ls-files(1), and perhaps
>> gitignore(5).

--=20
Jakub Nar=C4=99bski
