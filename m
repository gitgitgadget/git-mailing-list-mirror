From: Johan Herland <johan@herland.net>
Subject: Re: git-note -C changes commit type?
Date: Wed, 12 Feb 2014 11:26:46 +0100
Message-ID: <CALKQrgfRD2_Z4u3QoqoONv_Ydp-YAv66oXrPda=YDBX-Dn145w@mail.gmail.com>
References: <1392139407.12790.7.camel@kirk>
	<CALKQrgcM7JpZCk4amjo_rwg5uuuWNg-5yd1NXB5p7EtrU9WBGg@mail.gmail.com>
	<1392195218.2546.7.camel@kirk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git mailing list <git@vger.kernel.org>
To: Joachim Breitner <mail@joachim-breitner.de>
X-From: git-owner@vger.kernel.org Wed Feb 12 11:27:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDX24-0002sT-KN
	for gcvg-git-2@plane.gmane.org; Wed, 12 Feb 2014 11:27:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751917AbaBLK1A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Feb 2014 05:27:00 -0500
Received: from mail12.copyleft.no ([188.94.218.224]:35850 "EHLO
	mail12.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751252AbaBLK0y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Feb 2014 05:26:54 -0500
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail12.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1WDX1n-00032G-Db
	for git@vger.kernel.org; Wed, 12 Feb 2014 11:26:51 +0100
Received: from mail-pd0-f175.google.com ([209.85.192.175])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1WDX1n-000CyA-4q
	for git@vger.kernel.org; Wed, 12 Feb 2014 11:26:51 +0100
Received: by mail-pd0-f175.google.com with SMTP id w10so8854259pde.20
        for <git@vger.kernel.org>; Wed, 12 Feb 2014 02:26:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=P+wgtoTAdldpnokIeDxpC2I61Fu0VEqlfzktIXQBbDo=;
        b=je0RowTEwWENRlfAWoj262BRJ/N5hrV7jRdj5/6MmHeH2XM01VlCIB6Az33flmPX3Z
         uUL8gUKEcXaDBUXlUSFC/B1uo4fdbcZaJgvr9kVnXMVD+03HAipfyEyO8NU2uiM6OK6r
         AQaPgAzfaGA8HbYDEX3zGDR1KJx2urZCvvIE+KJKIGiEgfSAjwJrDwha7X19/XQuEDp7
         0TjRzwgNstPcKPol1nfT64jq2qp0Ud4jNdqD/Ovj7nZDrqFx7e9ASgzX2AjnJFOMUWXj
         DlNBwWmm0gVIsaUMbVX+SrOOV1Zr4UXMYSHbANmLFVxewG8AB4FQ60yKCuigSqLrqHMc
         QIKQ==
X-Received: by 10.66.216.129 with SMTP id oq1mr38227999pac.75.1392200807084;
 Wed, 12 Feb 2014 02:26:47 -0800 (PST)
Received: by 10.70.48.228 with HTTP; Wed, 12 Feb 2014 02:26:46 -0800 (PST)
In-Reply-To: <1392195218.2546.7.camel@kirk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241981>

On Wed, Feb 12, 2014 at 9:53 AM, Joachim Breitner
<mail@joachim-breitner.de> wrote:
> Am Mittwoch, den 12.02.2014, 00:52 +0100 schrieb Johan Herland:
>> You would have a notes ref "refs/notes/history" whose tree would
>> contain an entry named e1bfac434ebd3135a3784f6fc802f235098eebd0
>> pointing to a _commit_ (3d7de37...). Obviously, it would not make
>> sense to use refs/notes/history while displaying the commit log ("gi=
t
>> log --notes=3Dhistory"), as the raw commit object would be shown in =
the
>> log. However, more fundamentally: a tree referring to a _commit_ is
>> usually how Git stores _submodule_ links (i.e. which revision of the
>> named submodule is to be used by this super-repo tree), and I'm (off
>> the top of my head) not at all sure that such a submodule link in a
>> notes tree is handled "sanely" by Git - or even that it makes sense =
at
>> all. For one, I'm not sure that Git requires (or even expects) the
>> commit object referenced by a tree to be present in the same object
>> DB. So if you share your notes, I don't know whether or not the
>> fetch/push machinery will include the commit object in the shared
>> notes... These are questions that should be answered before we decid=
e
>> whether using commits directly as notes makes sense.
>
> If that is the case, then my approach is indeed flawed. The main poin=
t
> of the exercise is to have a tree that follows another commit (or, as=
 a
> next-best approximation, a note attached to that commit) around.
>
>> In that case, you might be better off using an explicit
>> ref to keep that history alive; e.g. you could create
>> refs/history/e1bfac4 to point to 3d7de37 ("git update-ref
>> refs/history/e1bfac4 3d7de37"), and keep everything
>> alive/reachable/shareable that way...
>
> That=E2=80=99s an interesting idea; instead of relying on the notes f=
eature
> putting the hash in the ref name. But I wonder how that scales =E2=80=
=93 imagine
> every second feature merged into Linux=C2=B9 also having such a histo=
ry ref?

Ah, that will probably not scale very well.

> I guess having a way for a tree to reference commits in a way that is
> followed by git gc, i.e. separate from submodules, would allow a less
> noisy implementation, and possibly create the opportunity for many ot=
her
> strange uses of git :-)

Here's another way to solve your problem, which should be fairly
transparent and performant:

Whenever you want to reference "history" of a commit (I'm using quotes
here, because we're not talking about the "regular" git sense of
history, i.e. the commit graph), you perform the following two steps:

1. Append the "historical" commit SHA-1 (3d7de37 in your example) to a
note on the "current" commit (e1bfac4). E.g.:

    git notes --ref history append -m 3d7de37... e1bfac4...

2. Perform some automated merge into a "history"-tracking ref (e.g.
refs/history), to keep the "historical" commits reachable.

(You can easily wrap both steps into a script to automate things.)

Step #1 encodes the "history" of a commit in a note, but does not keep
the "history" reachable.

Step #2 keeps all "historical" commits reachable by making them part
of the history (in the git sense - without quotes) of a proper ref
(refs/history). The actual result/outcome of the merge is not
interesting. It only exists to insert the "historical" commit
(3d7de37) into the ancestry for refs/history. Since the actual merge
itself is uninteresting, you should probably use a merge strategy that
never yields conflicts, e.g. "-s ours"

You can now share the "history" by pushing/fetching the two refs
refs/notes/history and refs/history.

(In theory, you might even be able to combine the two refs, by
performing the merge directly into refs/notes/history, always taking
care to retain the notes tree contents as the result of the merge. In
other words, after you do step #1 (append the note), you manually
rewrite the just-created tip of refs/notes/history to include 3d7de37
as a second parent. This keeps 3d7de37 reachable (and it will be
shared when you share refs/notes/history), and it should not interfere
with the notes infrastructure, as they only look at the current state
of the notes tree.)


Hope this helps,

=2E..Johan

--=20
Johan Herland, <johan@herland.net>
www.herland.net
