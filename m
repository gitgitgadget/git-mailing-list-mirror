From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFC] Add a new email notification script to "contrib"
Date: Thu, 8 Nov 2012 16:38:21 +0100
Message-ID: <CACBZZX4gzgTZCk78PYpYHnKdwQ0vScoLz02tuAuUQRXVVXSLVg@mail.gmail.com>
References: <1342249182-5937-1-git-send-email-mhagger@alum.mit.edu>
 <50092C8C.3000305@alum.mit.edu> <CACBZZX6=e6_qO=wMcxLdUAc6XxYpdiP-9RPRsCXrVC_iuJ11Jg@mail.gmail.com>
 <509B7E6B.1030407@alum.mit.edu> <CACBZZX5FihEMSyrws-D7GyWvxtpMCPwvaiM18ZqOBaoBcvEjDA@mail.gmail.com>
 <509BA2E7.4080102@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Andy Parkins <andyparkins@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	=?UTF-8?B?U3RlZmFuIE7DpHdl?= <stefan.naewe@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Marc Branchaud <mbranchaud@xiplink.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Nov 08 16:38:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWUC0-0003qF-94
	for gcvg-git-2@plane.gmane.org; Thu, 08 Nov 2012 16:38:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755188Ab2KHPim convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Nov 2012 10:38:42 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:39694 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752415Ab2KHPim convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Nov 2012 10:38:42 -0500
Received: by mail-ob0-f174.google.com with SMTP id uo13so2927798obb.19
        for <git@vger.kernel.org>; Thu, 08 Nov 2012 07:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Hc9CcBAmwTbFRv6jvh2M7feCAvF7mSnntfNhoDwV+J0=;
        b=QlPpPSE9JzK2SS6R0HrDzII/fLPe4noa0/MrQlFilfGxyb/FzpEOA8K1tf/xCk00BL
         40/TLot2n5Ytjgn73z1YzYDQxSq70HH1O3bpHqOD7Tkv+54DPImlKEQGccZHn6GcBa2A
         dbjMibGnkIIXIf37Ijs4rt4iUjoFysL9eBaRRAXRR1UAkGpDsf5gu3GQLUdt5O47F1Om
         snr0K50bVa5WinYGdqisZpu2KgEd5PNu0nsN1Uo9YqOxrNNFcAlB333NMQExEhu+FRx7
         H1+XR4nMdFF4tTeHMnqe1iuSMDeEYZmmpganSrmGak9GBali7DJVBSpKxI192Z+o1dpW
         b9Vg==
Received: by 10.60.169.38 with SMTP id ab6mr5366446oec.139.1352389121523; Thu,
 08 Nov 2012 07:38:41 -0800 (PST)
Received: by 10.60.93.225 with HTTP; Thu, 8 Nov 2012 07:38:21 -0800 (PST)
In-Reply-To: <509BA2E7.4080102@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209166>

On Thu, Nov 8, 2012 at 1:17 PM, Michael Haggerty <mhagger@alum.mit.edu>=
 wrote:
> On 11/08/2012 12:39 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> [...]
>
> I'm glad it's getting some use.  Thanks for the feedback.
>
>> I'll test it out some more, the issues I've had with it so far in
>> migrating from the existing script + some custom hacks we have to it
>> have been:
>>
>>  * Overly verbose default templates, easy to overwrite now. Might se=
nd
>>    patches for some of them.
>
> The templating is currently not super flexible nor very well document=
ed,
> but simple changes should be easy enough.  I mostly carried over the
> text explanations from the old post-receive-email script; it is true
> that they are quite verbose.
>
>>  * No ability to link to a custom gitweb, probably easy now.
>
> What do you mean by "a custom gitweb"?  What are the commitmail issue=
s
> involved?

Just for the E-Mail to include a link to
http://gitweb.example.com/git/....?h=3D$our_hash etc.

>>  * If someone only pushes one commit I'd like to only have one e-mai=
l
>>    with the diff, but if they push multiple commits I'd like to have=
 a
>>    summary e-mail and replies to that which have the patches.
>>
>>    It only seemed to support the latter mode, so you send out two
>>    e-mails for pushing one commit.
>
> That's correct, and I've also thought about the feature that you
> described.  I think it would be pretty easy to implement; it is only =
not
> quite obvious to which mailing list(s?) such emails should be sent.
>
>>  * Ability to limit the number of lines, but not line length, that's
>>    handy for some template repositories. Should be easy to add
>
> Should too-long lines be folded or truncated?  Either way, it should =
be
> pretty straightforward (Python even has a textwrap module that could =
be
> used).
>
>> But in addition to that we have our own custom E-Mail notification
>> scripts for:
>>
>>  * People can subscribe to changes to certain files. I.e. if you
>>    modify very_important.c we'll send an E-Mail to a more widely see=
n
>>    review list.
>>
>>  * Invididuals can also edit a config file to watch individual files=
 /
>>    glob patterns of files, e.g. src/main.c or src/crypto*
>
> I implemented something like this back when we were using Subversion,
> but it didn't get much use and seemed like more configuration hassle
> than it was worth.
>
> If this were implemented and I asked for notifications about a
> particular file, and a particular reference change affects the file,
> what should I see?
>
> * The summary email for the reference change (yes/no)?
>
> * Detail emails for all commits within the reference change, or only =
for
> the individual commits that modify the file?
>
> * Should the detail emails include the full patch for the correspondi=
ng
> commit, or only the diffs affecting the file(s) of interest?  (The
> latter would start to get expensive, because the script would have to
> generate individual emails per subscriber instead of letting sendmail
> fan the emails out across all subscribers.)

I think just sending the individual patch e-mails to all people who
subscribe to paths that got changed in that patch that match their
watchlist makes sense.

That's how an internal E-mailing script that I'm hopign to replace
with this works.

That script *also* supports sending the whole batch of patches pushed
in that push to someone watching any file that got modified in one of
the patches, in case you also want to get other stuff pushed in pushes
for files you're interested in.

But it doesn't generate individual E-Mails per recipient. I think that
way lies madness because as you rightly point out you have to start
worrying about the combinatorial nightmare of generating the E-mails
per subscriber.

>> I think a good way to support that would be to have either a path to=
 a
>> config file with those watch specs, or a command so you could run "g=
it
>> show ..." on some repo users can push to.
>
> *How* this feature would be configured depends strongly on how the re=
po
> is hosted.  For example, gitolite has a well-developed scheme for how
> the server should be configured, and it would make sense to work
> together with that.  Other people might configure user access via LDA=
P
> or Apache.
>
>> But overall it's very nice. I'll make some time to test it in my
>> organization (with lots of commits and people reading commit e-mails=
).
