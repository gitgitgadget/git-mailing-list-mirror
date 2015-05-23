From: Allen Hubbe <allenbh@gmail.com>
Subject: Re: [PATCH v5 1/1] send-email: Add sendmail email aliases format
Date: Sat, 23 May 2015 19:01:01 -0400
Message-ID: <CAJ80savjia5ywQcUzGidBx=Jb378YjYT=ZdBt5hQ6WdReTLj0g@mail.gmail.com>
References: <49e9a95b52aa61ed4f37edf1dfa178186acb4a29.1432367540.git.allenbh@gmail.com>
	<xmqqfv6nchmf.fsf@gitster.dls.corp.google.com>
	<xmqq7frzcgx2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 24 01:01:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwIPk-0006bK-Im
	for gcvg-git-2@plane.gmane.org; Sun, 24 May 2015 01:01:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754693AbbEWXBE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 May 2015 19:01:04 -0400
Received: from mail-wg0-f46.google.com ([74.125.82.46]:33720 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754570AbbEWXBD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 May 2015 19:01:03 -0400
Received: by wgez8 with SMTP id z8so45902565wge.0
        for <git@vger.kernel.org>; Sat, 23 May 2015 16:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=hAuuJLcmUmb+wwXoKHrAsXGMciLna0250No13/WT5gs=;
        b=vMz2kyKR3lhru0P5QJIqeF7p9GO552bGfB3RT10s6tNK3tsxGEJYrLcthJ+qJEP6wb
         nQeY+7gbXYfc4l+/2c527aIO58/XiDqxNbVB8RjBvc6TKUUm7e8WpK3X3ij6+CHz7n9Z
         Y3tfhcqm2eRAh6UDAlqJeqdNs/kN8MhPuveg8ST/1tdX9+ehP3AY4dzH0soq5Yi+AWVI
         2W/7duswd4r4xR3ZPChBsSCLQ0hhPLXVyAyJ5r8KjNJ5kylBUmcqg5Z4MVdyU59TR04X
         qSy4sePunjK9o6HAaHB43gIP+sh8lpH2WVvsKE2kR1+r4fRT8xmXxAv1CD8gmWhdBN4m
         M6aQ==
X-Received: by 10.180.98.1 with SMTP id ee1mr19331740wib.86.1432422061187;
 Sat, 23 May 2015 16:01:01 -0700 (PDT)
Received: by 10.28.59.4 with HTTP; Sat, 23 May 2015 16:01:01 -0700 (PDT)
In-Reply-To: <xmqq7frzcgx2.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269821>

On Sat, May 23, 2015 at 2:00 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>>> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
>>> index 804554609def..97387fd27a8d 100644
>>> --- a/Documentation/git-send-email.txt
>>> +++ b/Documentation/git-send-email.txt
>>> @@ -383,7 +383,42 @@ sendemail.aliasesFile::
>>>
>>>  sendemail.aliasFileType::
>>>      Format of the file(s) specified in sendemail.aliasesFile. Must be
>>> -    one of 'mutt', 'mailrc', 'pine', 'elm', or 'gnus'.
>>> +    one of 'sendmail', 'mutt', 'mailrc', 'pine', 'elm', or 'gnus'.
>
> We prefer to append to an existing list of equals, not prepend.
>

I initially thought to put it last, too.  I'll move it back to the end.

I moved it to the beginning, because it seemed odd to me for only the
last thing in the list to have a further description.  If the intent
is that eventually (perhaps in an ideal world), the other formats will
have expanded documentation, too, then you are right that adding new
things to the end makes the most sense.

>>> ++
>>> +If the format is 'sendmail', then the alias file format is described below.
>>> +Descriptions of the other file formats can be found by searching the
>>> +documentation of the email program of the same name.
>
> The phrasing feels somewhat awkward.  How about dropping the first
> line, pretending as if 'sendmail' is also fully 'sendmail' format,
> and then describe the limitations (like you already did below)?  I
> have a feeling that other formats have similar limitations (e.g. I
> do not think piping to commands in any other formats would be
> supported by send-email), and other people can follow suit and
> describe the limitations.
>
> That is, drop the paragraph that describes the basics (which can be
> learned by searching the documentation of the email program of the
> same name), and dive right into the differences.
>
> IOW,
>
>         What an alias file in each format looks like can be found in
>         the documentation of the email program of the same name. The
>         differences and limitations from the standard formats are
>         described below:
>         +
>         --
>         sendmail;;
>>> +*   Quoted aliases and quoted addresses are not supported: lines that
>>> +    contain a `"` symbol are ignored.
>>> +*   Line continuations are not supported: any lines that start with
>>> +    whitespace, or end with a `\` symbol are ignored.
>>> +*   Warnings are printed on the standard error output for any explicitly
>>> +    unsupported constructs, and any other lines that are not recognized
>>> +    by the parser.
>         --

Alright.

Thanks for showing me '--'.  I had some trouble with asciidoc, where
my intention was to insert a bulleted list between two paragraphs in a
containing definition-list item.  The paragraph that I intended to be
after the bulleted list was instead nested in the last bulleted item
in the list.

The documentation for asciidoc soesn't seem to be very helpful in
describing this construct.  There is one example, that I could find,
and I didn't find a description of the syntax for it.  Perhaps I
missed it among all the other uses of a series of '-'.  I don't see
any way for this to distinguish between different levels of nesting,
like a block of --/-- in another block of --/--; that might be
syntactically indistinguishable from a block of --/-- followed by
another block of --/--.

>
> That way, limitations and deviations of other formats can be added
> later in a consistent way.
>
> Just a thought.
