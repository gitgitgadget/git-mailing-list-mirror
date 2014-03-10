From: Peter C Rigby <peter.rigby@concordia.ca>
Subject: Re: Fwd: git-reviewed: linking commits to review discussion in git
Date: Mon, 10 Mar 2014 19:43:33 -0400
Message-ID: <CAN6Z0OqLqmyjFKfzhBrPxzeGMZ+aE4UcuM9Upqzn9Cr3CyXNSw@mail.gmail.com>
References: <CANx4bCB5tTzKusbfcqQ=eoeOGJ-WxWvF3QNpfa5rTq7oOSG-5w@mail.gmail.com>
	<CANx4bCAWVoCQdYQQ5cGXF-Z6Evck=Oeb2Shghkcuf7PMvSZBOA@mail.gmail.com>
	<20140218052827.GA25291@sigill.intra.peff.net>
	<8635c4b807ab40db93da43875645dfc8@UMS-SGWHTS1.concordia.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>,
	Murtuza Mukadam <murtuza.i.mukadam@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Tue Mar 11 00:43:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WN9rB-0008Fc-UW
	for gcvg-git-2@plane.gmane.org; Tue, 11 Mar 2014 00:43:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752602AbaCJXng (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 19:43:36 -0400
Received: from mail-la0-f49.google.com ([209.85.215.49]:62467 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752261AbaCJXnf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2014 19:43:35 -0400
Received: by mail-la0-f49.google.com with SMTP id mc6so5114542lab.36
        for <git@vger.kernel.org>; Mon, 10 Mar 2014 16:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=wRM6yIQ4kBTGxwColSefM0rMtse9xH2gc07VGHeoY9Y=;
        b=mncGJ8u7AkcjmYUHsCHrGsVcyFI5yUcdFosl10fLrvpQV2MfRGXtuemwkljs94owEg
         NNwJx8Hsh98zdzApB0dmOoXbSwe2s07mMUeVbwvpBY+ughpv+xh8xsZIGBcpKFbYFg01
         l3leUS2pQ5mlYqeUWlCHukz/qNlvPmo4al9DRLrBuvFConVrXQE8pmf0+C/495X18xRz
         y22l4JTNNi/Hnb+xsqLSC1cOrPIe42HupYUk5aIrwYXedxTuhyF69U/EMHoz8PiWaOHA
         iELJkIV8eaGLugX7KlZ1Ni21ua1qSKpqLDq4sLkvEH9RPSvsnYmFXdDgIVy8H58f3tD0
         mA5w==
X-Received: by 10.112.97.178 with SMTP id eb18mr14889182lbb.13.1394495013746;
 Mon, 10 Mar 2014 16:43:33 -0700 (PDT)
Received: by 10.115.4.6 with HTTP; Mon, 10 Mar 2014 16:43:33 -0700 (PDT)
In-Reply-To: <8635c4b807ab40db93da43875645dfc8@UMS-SGWHTS1.concordia.ca>
X-Google-Sender-Auth: -mjHjSv2wuyMrObe64GSJ7E2Wtg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243826>

On Tue, Feb 18, 2014 at 12:28 AM, Jeff King <peff@peff.net> wrote:
[snip]
>
>   3. How do we present the emails to the user (including showing
>      threads, letting them dig deeper, etc)?

We created a website, you enter a commit and it shows you the reviews:
http://cesel.encs.concordia.ca/process_request.php?repo=git

The site will either display the message id for the review or redirect
you the mailing list archive.


On Sat, Feb 22, 2014 at 11:47 AM, Thomas Rast <tr@thomasrast.ch> wrote:
> Jeff King <peff@peff.net> writes:
>
>> On Mon, Feb 17, 2014 at 03:12:48PM -0500, Murtuza Mukadam wrote:

Very sorry for the delayed response. We wanted compare our linking
technique with yours, see below.

>>
>>> We have linked peer review discussions on
>>> git@vger.kernel.org to their respective commits within the main
>>> git.git repository. You can view the linked reviews from 2012
>>> until present in the GitHub repo at:
>>> https://github.com/mmukadam/git/tree/review
>>
>> Neat. We've experimented in the past with mapping commits back to
>> mailing list discussions.  Thomas (cc'd) has a script that creates
>> git-notes trees mapping commits to the relevant message-id, which can
>> then be found in the list archive.
>>
>> To me, the interesting bits of such a project are:
>>
>>   1. How do we decide which messages led to which commits? There is
>>      definitely some room for heuristics here, as patches are sometimes
>>      tweaked in transit, or come in multiple stages (e.g., the original
>>      patch, then somebody suggests a fixup on top). You might want to
>>      compare your work with the script from Thomas here:
>>
>>        http://repo.or.cz/w/trackgit.git
>
> Eh, or don't.  My script nowadays uses Junio's suggestion of matching on
> (author, authordate) with a little bit of tweaking in case there is no
> match.  The name/date match works for most cases even in slightly
> tweaked forms.

In our technique, we take each email patch, eliminate white space and
hash each line. We then compare the lines with those in commits to the
same files. The commit that changes the same files and has the largest
number of matching lines is considered to be the reviewed commit.

We compared Junio's (author, authordate) and our technique on a
manually created benchmark of 30 messages from the linux, postgres,
and git mailing lists. We found that Junio's simple technique
performed equally well to our more complicated technique (see results
at end of email).

On Tue, Feb 18, 2014 at 12:28 AM, Jeff King <peff@peff.net> wrote:
>   2. How do we store the mapping? I think git-notes are a natural fit
>      here, but you don't seem to use them. Is there a reason?

We wanted a way to store each review as its own blob, so we put the
reviews on a detached 'review' branch and then wrote some simple
scripts to access and display these reviews on the command line (\eg
git reviewed --show <commit_hash>).

However, given the previous discussion on this list
(http://git.661346.n2.nabble.com/RFC-RFH-Fun-things-with-git-notes-or-patch-tracking-backwards-td2297330.html),
we agree that just putting the msg_id as a note is probably more
useful. One additional problem we ran into when storing all the
reviews, is for something like Linux, the reviews took up a massive
amount of storage.

> It would be interesting to apply some kind of clustering algorithm that
> automatically determines the messages related to a commit, including
> both the patch but also any discussion leading up to it. I realize that
> may be getting far afield of your original goals, but hey, you said you
> wanted feedback. I can reach for the stars. :)

It would be interesting to be able to tie in other discussion, perhaps
related bugs. A future project.

Thanks,
Peter

Evaluation of linking commits with email reviews on 30 messages from
Linux, postgres, and git mailing lists

Linux - Files and lines changed:

Perfect: 87%
No Match: 13%
Incorrect: 0%

Linux - Thomas/Junio  (author, authordate)

Perfect: 87%
No Match: 13%
Incorrect: 0%

Git - Files and lines changed:

Perfect: 74 %
No Match  23  %
Incorrect: 3 %

Git - Thomas/Junio  (author, authordate)

Perfect: 77%
No Match: 23%
Incorrect: 0%

Postgres - Files and lines changed:

Perfect: 57 %
No Match  36  %
Incorrect: 7 %

Postgres - Thomas/Junio  (author, authordate)

Perfect: 50%
No Match: 37%
Incorrect: 13%

-- 
http://users.encs.concordia.ca/~pcr/
