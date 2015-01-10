From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH v3] doc: core.ignoreStat update, and clarify the --assume-unchanged effect
Date: Sat, 10 Jan 2015 20:22:19 -0000
Organization: OPDS
Message-ID: <5861D798BD564D6EBE0D55C529C8ECF8@PhilipOakley>
References: <1420496573-3260-1-git-send-email-philipoakley@iee.org><xmqqbnmajwd9.fsf@gitster.dls.corp.google.com><1ED88DC1DCC2463782B4F4167DC85D5D@PhilipOakley> <xmqqbnm7da76.fsf@gitster.dls.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	reply-type=original
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "GitList" <git@vger.kernel.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	=?utf-8?Q?Nguy=3Fn_Th=C3=A1i_Ng=3Fc_Duy?= <pclouds@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 10 21:21:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YA2XW-0008AM-CO
	for gcvg-git-2@plane.gmane.org; Sat, 10 Jan 2015 21:21:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751973AbbAJUVh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Jan 2015 15:21:37 -0500
Received: from out1.ip06ir2.opaltelecom.net ([62.24.128.242]:12538 "EHLO
	out1.ip06ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750753AbbAJUVg (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Jan 2015 15:21:36 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AsYJAMuIsVRZ8Y7hPGdsb2JhbABbgwaBKoMFgypsxFoEAoEKRAEBAQEBAQUBAQEBODuEBwUBAQEBAgEIAQEZBAsBBR4BARwFCwIDBQIBAxUFAgUhAgIUAQQaBgcDFAYTCAIBAgMBiBMMtiuGU4w8ASuBIYhuhWqCby6BEwWEO4l/T4ZHgwYNgmSHXIJhgzqCVIE8PjGCQwEBAQ
X-IPAS-Result: AsYJAMuIsVRZ8Y7hPGdsb2JhbABbgwaBKoMFgypsxFoEAoEKRAEBAQEBAQUBAQEBODuEBwUBAQEBAgEIAQEZBAsBBR4BARwFCwIDBQIBAxUFAgUhAgIUAQQaBgcDFAYTCAIBAgMBiBMMtiuGU4w8ASuBIYhuhWqCby6BEwWEO4l/T4ZHgwYNgmSHXIJhgzqCVIE8PjGCQwEBAQ
X-IronPort-AV: E=Sophos;i="5.07,737,1413241200"; 
   d="scan'208";a="665911756"
Received: from host-89-241-142-225.as13285.net (HELO PhilipOakley) ([89.241.142.225])
  by out1.ip06ir2.opaltelecom.net with ESMTP; 10 Jan 2015 20:21:28 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262271>

=46rom: "Junio C Hamano" <gitster@pobox.com>
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>>>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>>>> index 52eeadd..fe179d0 100644
>>>> --- a/Documentation/config.txt
>>>> +++ b/Documentation/config.txt
>>>> @@ -375,15 +375,18 @@ This is useful for excluding servers inside =
a
>>>> firewall from
>>>>  proxy use, while defaulting to a common proxy for external
>>>> domains.
>>>>
>>>>  core.ignoreStat::
>>>> + If true, Git will avoid using lstat() calls to detect if files
>>>> have
>>>> + changed. Git will set the "assume-unchanged" bit for those
>>>> tracked files
>>>> + which it has updated identically in both the index and working
>>>> tree.
>>>
>>> I wonder if this is better stated in two seemingly independent
>>> sentences (like your version), or "... if files have changed by
>>> setting the assume-unchanged bit ...." to clarify where the setting
>>> of the bits to these files come into the big picture, but it is
>>> minor.  Either way, I think it is a lot easier to understand than
>>> what we have in 'master'.
>>
>> I had considered a number of different wordings, and wanted to keep
>> the tricky parts separate to ease cognition.
>
> Hmph, but wouldn't the result get more confusing, by stating two
> "tricky" things in separate sentences without giving any clue to
> guess how these two trickies are related?  That is why I suggested
> to say the same two things in a way that clarifies that "avoid using
> lstat(2)" is the effect and "setting the assume-unchanged bit" is
> the underlying implementation detail to cause that effect, i.e.
>
> If true, Git will avoid using lstat(2) calls to detect if
> files have changed by setting "assume-unchanged" bit for
> these tracked paths that Git has updated identically in both
> the index and in the working tree.

I actually found that awkward to understand that because of both its
length (as a single sentence), and who does what when being mixed
together. Surely it's a 'separation of concerns' process. The splitting
the sentence halves the readability score (among other things).

>
>> On a separte note, this patch was a development from the problem
>> noticed by S=C3=A9rgio of the different actions of 'git commit .'and=
 'git
>> commit -a' when --assume-unchanged was used. Did you have any
>> thoughts
>> regarding Duy's patch (05 December 2014 10:56) to his code given in
>> $gmane/260865.
>>
>> I wasn't sure if it had just been missed, or if there was some other
>> issue?
>
> I thought the reason why we are discussing this documentation
> clean-up (specifically, clarifying that assume-unchanged is a
> promise the user makes not to modify the paths marked as such and is
> not about telling Git to ignore changes to tracked paths), was
> because we agreed that such a change is a wrong thing to do.

While that is true (the documentation gave false suggestions), the
code should be trying to match our hoped for optimization so that the
whole tree doesn't need to be lstat'd

>
> It is wrong for at least two reasons.
>
> - The "I promise not to modify them, so please omit lstat(2)
>   assuming that I keep that promise" is a performance thing---we
>   shouldn't add more code to cater to people who do not keep that
>   promise.

We should add code that keeps our "promise" that [where reasonable] we
will optimise out lstats when there are large numbers of files to be
checked; Surely?

>
> - Adding one more case of "Git will hide changes to tracked paths
>   that you promised not to change" gives more chance to confuse
>   users into an incorrect understanding of what assume-unchanged
>   bit is about.  By not applying $gmane/260865, we keep one more
>   way for the users to notice that the bit is *not* a mechanism
>   to hide changes to tracked paths.

Surely, correcting the documentation is that route.
I don't think we should be retaining the spikes on the steering wheel a=
s
a bad driver reminder. There will be other corner cases for bad drivers
to spin off at.

Ultimately the reason for inclusion would be that on large repos both
commit -a and commit . should be equally fast, which would need to be
said in the commit message.

As a side point, a possible follow on tidy-up patch would be to have a
macro to cover the common (ce->ce_flags & (CE_VALID | CE_SKIP_WORKTREE)
idiom (many places, with different constructs) in the same vein as
ce_skip_worktree()

>
>>>> +When files are modified outside of Git, the user will need to
>>>> stage
>>>> +the modified files explicitly (e.g. see 'Examples' section in
>>>> +linkgit:git-update-index[1]).
>>>> +Git will not normally detect changes to those files.
>>>> ++
>>>> +This is useful on systems where lstat() calls are very slow, such
>>>> as
>>>> +CIFS/Microsoft Windows.
>>>> +False by default.
>>>
>>> I think you are trying to make the result more readable by using
>>> separate paragraphs for separate conceptual points, but then isn't
>>> it wrong to have "False by default" as part of stating which
>>> platforms are intended targets?  I wonder if we want to have that
>>> last line as its own paragraph instead.
>>
>> I was happy with it being a simple separate sentence.
>
> I am also _for_ a separate sentence.  But when a set of three
> paragraphs, i.e.
>
> A, something about A, and things about A.
>
>        B, something about B, and things about B.
>
>        C, something about C, and things about C.
>
> and you want to say something X that is not specific to A or B or C,
> would you add that X at the end of C's paragraph, resulting in:
>
> A, something about A, and things about A.
>
>        B, something about B, and things about B.
>
>        C, something about C, and things about C.  X that applies to
>        all of A, B and C.
>
> or would it be more clear to see:
>
> A, something about A, and things about A.
>
>        B, something about B, and things about B.
>
>        C, something about C, and things about C.
>
>        X that applies to all of A, B and C.
>
> was the question.  I think a simple separate sentence should not be
> part of the same "In what situations this is useful" paragraph.

In this case my split was about making sure that B was a distinct item
within the flow, rather than being a single ABC paragraph, where the
middle item gets lost in the noise [1]. People do remember the first an=
d
last item (sentence), so the default is easy to see.

--
Philip

[1] Losing the middle item(s) in a list is a common human error, and is
commonly cited in human factors studies e.g. "Human Error", Reason.J,
0521314194, cites Three Mile Island maintenance errors from poor
documentation among others.
