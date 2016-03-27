From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v10 2/3] t7507-commit-verbose: store output of grep in a file
Date: Sun, 27 Mar 2016 19:13:41 +0530
Message-ID: <CAFZEwPN_sL7_yj=FcHynK2L5DhuSD5XSGHnGk73yAcH=+MdY3w@mail.gmail.com>
References: <CAPig+cRQ5hOLi3539Emq=YexHRXqdesf+Yo2cY+NkiPO_9Vhyg@mail.gmail.com>
	<1459085245-20658-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sun Mar 27 15:43:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akAys-0005iE-MY
	for gcvg-git-2@plane.gmane.org; Sun, 27 Mar 2016 15:43:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751832AbcC0Nnn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Mar 2016 09:43:43 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:36379 "EHLO
	mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751640AbcC0Nnm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Mar 2016 09:43:42 -0400
Received: by mail-qk0-f196.google.com with SMTP id e124so9565913qkc.3
        for <git@vger.kernel.org>; Sun, 27 Mar 2016 06:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-transfer-encoding;
        bh=8bBuo22cTdtCdPEQHzgeY0oxcO0JDGOXUoJnNGFGfXs=;
        b=dt0de9JTeKEnslcBtX1klZ2X+36sJ0uSt8M254UgunI1Y4VA3P4v0Q7J37O/LGwmar
         MrZaXm588+iHuKrp8W0FFQKRnmodd7OzUHz3aTe+W5pY31YZs3eNleteAu3lE0PB4L/q
         KbmIcKKqekXLNyB63Mwf5pKf08hCu+eKL8l6R3HpI1vOok2qPAvA30XwF5nr0PYZ606w
         KGp63VzAABTvWAqPx3EL762eObE90qaCSuNsLWvRwVlGsQyiTp967GGzrIEoBhsjdVu7
         sH6iYNuSRydut6xKzXEJ9jBvUezBcRvPV2O9NrF5dfMOBkXyPOyfR33WM1zVnw99P1XP
         HdBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=8bBuo22cTdtCdPEQHzgeY0oxcO0JDGOXUoJnNGFGfXs=;
        b=YhhF7hw2W4om8hxOKgGyEekdiClNdRyFDtMSKOkXahJCDryPSJ4bOID2mP2LUm7sFI
         2ZxY/LeH5bmwYE5Vwaeq46eZLCKY/tDhL09ca0800geO5DNvq5x6fJ+3uGel+NJAO81z
         8tR75J9ugjCfqHYuqWrbs/Xj3vIEJQi9T8YhzkUhptaOtZ6SgzkTUzlWcnV3IclQwrlb
         LcXxh5jrD1hX9YWRaNLYren7ktJPJkJGoXj+iLUL7S5vcmjUxz5krmqePV7nuHLagPdC
         1PjGi3tWlfIQZh5IH4wkuL8oeXH9Aq1kxP/6aXBo6UUnhsYrnXupRO+p/qKC4EMUdoje
         Dorw==
X-Gm-Message-State: AD7BkJJbKXWMqNAKLy036BglDm3DBfNH/dRbKHl6LLmh3Q3dJLwrcHPo1Uq+IUYB4oJMEAEZNWpv+sOVLAgUSQ==
X-Received: by 10.129.9.214 with SMTP id 205mr10920429ywj.53.1459086221637;
 Sun, 27 Mar 2016 06:43:41 -0700 (PDT)
Received: by 10.13.203.137 with HTTP; Sun, 27 Mar 2016 06:43:41 -0700 (PDT)
In-Reply-To: <1459085245-20658-1-git-send-email-szeder@ira.uka.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290007>

On Sun, Mar 27, 2016 at 6:57 PM, SZEDER G=C3=A1bor <szeder@ira.uka.de> =
wrote:
>> > +! test -s out ||
>> > +rm out &&
>>
>> Why not just "rm -f out"? But, more importantly, why do you need to
>> remove the file at all? The '>' redirection operator (used below) wi=
ll
>> overwrite the file, so no need to remove it beforehand.
>>
>> > +! grep '^diff --git' "$1" ||
>> > +grep '^diff --git' "$1" >out
>>
>> Um, what? Why two greps? I would have expected you to simply re-use
>> the existing grep (minus the backslash) while adding the redirection=
:
>>
>>     -exec grep '^diff --git' "\$1"
>>     +exec grep '^diff --git' "$1" >out
>>
>> Am I missing something obvious?
>
> In the non-verbose cases no diff is included in the commit message
> template, thus the pattern looking for it doesn't match anything, gre=
p
> exits with error code, which in turn becomes the editor's exit
> code, ultimately making 'git commit' fail.  Not good.
>
> I suppose both the explicit 'rm out' and the '! grep ... || ...' is
> there to deal with this situation.

Yes. In fact, I did this as a last resort after trying a lot of other
stuff which didn't work.

> Hmph.
>
> I think we could:
>
>   - either revive the idea of two editor scripts: one for the
>     non-verbose case checking with '! grep ...' that there are no
>     diffs in the commit message template, and one for all verbose
>     cases storing those diff lines in a file to be counted later.
>
>   - or use a fake editor that merely copies the whole commit message
>     template to a separate file, and we do the greping in the tests
>     themselves as well.
>
>   - or simply stick a 'true' at the end of the editor script ensuring
>     that it returns success even when grep can't find the pattern, bu=
t
>     I kind of feel ashamed of myself for even mentioning this
>     possibility ;)
>
> I would go for the second possibility, but don't feel strong about it=
=2E

There is one more possibility, that we could use 'test_must_fail' (as
grep exits with error code with no diff) but this will send a very
wrong interpretation as "This type of scenario is not meant to work".
Or to put it in better words, "You cannot have no diff with commit".
There is a difference between two negatives and one positive.
