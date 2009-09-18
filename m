From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH] Avoid the use of backslash-at-eol in pack-objects usage 
	string.
Date: Fri, 18 Sep 2009 18:40:47 -0300
Message-ID: <a4c8a6d00909181440l5c8b0193k4703af8d06dde9b0@mail.gmail.com>
References: <1253224300-18017-1-git-send-email-tfransosi@gmail.com>
	 <7vvdjhgrjv.fsf@alter.siamese.dyndns.org>
	 <a4c8a6d00909171506l6c4b6a49i22d7b337a0c6cfa2@mail.gmail.com>
	 <7vd45pgjhr.fsf@alter.siamese.dyndns.org>
	 <a4c8a6d00909180802r713d7644mcb4e98ae4352a03a@mail.gmail.com>
	 <7v1vm49ifb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 18 23:40:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MolCI-0002kU-R4
	for gcvg-git-2@lo.gmane.org; Fri, 18 Sep 2009 23:40:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752895AbZIRVkq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Sep 2009 17:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752669AbZIRVkp
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Sep 2009 17:40:45 -0400
Received: from an-out-0708.google.com ([209.85.132.246]:32230 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752064AbZIRVko convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Sep 2009 17:40:44 -0400
Received: by an-out-0708.google.com with SMTP id d40so1832212and.1
        for <git@vger.kernel.org>; Fri, 18 Sep 2009 14:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=TLoEQlZ6PYwepGkfK254dWtYH6uWPZuX/yIJFl3LYFQ=;
        b=grIsE2WUHSsqOBKSnQxo6USP/8ky9VQhoo2Y529hnNO1z5y3j/RCTtOw3SBLy0iVeR
         dx1InaJH7/PMdSss49VKSG/LgUl5u2yvA+lUVFqhdzYX+bGHZA80oWHeexcJ6HEET1WC
         Yf2B451wfk2DgZUTJ/N5ZWsgChPUVAnhWuxrM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=fbwZwOuEfVclkYY0PqZnbwoAIIciVI90VslMbsejy7LLKxqw4QjYtpfGmMsQC1VjrC
         bIGu9cGILLdgeWNs3WOPXX3z4c592XPdhOLZ80Q/4SLZW9HR/JWEG7hojLtEobYH/cE/
         3WElm342HhWdaFR1C2ykXfOb6oI/j0nqDv31s=
Received: by 10.101.193.25 with SMTP id v25mr2028151anp.132.1253310048083; 
	Fri, 18 Sep 2009 14:40:48 -0700 (PDT)
In-Reply-To: <7v1vm49ifb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128813>

On Fri, Sep 18, 2009 at 4:11 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Thiago Farina <tfransosi@gmail.com> writes:
>
>> This release candidate freeze is a period that no one can send patch=
es?
>
> No.
>
> After -rc1, only fixes to regressions and severe bugs and trivially
> correct documentation patches will be applied to my tree, but all oth=
er
> kinds of patches are still sent to the list for discussion, so that t=
he
> proposed changes can be discussed, polished and then become ready for=
 the
> development cycle after the upcoming release.
>=A0I often even pick them up and queue them to 'pu' and possibly 'next=
' as time permits.
If you don't want to pick a patch this means that it was not accepted,
right? I wrote others two trivial patches, one has comments, and I did
the changes suggested, but I guess not will be done about it because
it is just trivial.
>> And what did you mean with code churn?
>
> A change primarily for the sake of change without urgency nor real be=
nefit
> in the longer term.
>
> It bothers nobody if a long literal string is written as a string lit=
eral
> in a dq pair with LFs quoted with backslashes, or as a run of multipl=
e
> string literals, each of which ending with LF, to be concatenated by =
the
> compiler. =A0It however would bother somebody who actually wants to m=
odify
> these lines for a real change, and that is the best time for doing su=
ch a
> clean-up. =A0Reasons for such a real change vary; to fix earlier mist=
akes
> (e.g. one line being excessively longer than others, or an option is
> misspelled), to add a new option, or to make the output of the progra=
m
> easier to read in general, etc.
This means that trivial patches like this one I wrote are generally
not accepted? Why is there this difficult (is it to maintain the high
level of the patches)? I thought if it is trivial it can be merged
after a review, into one of the integration branches. You write the
comments (the people in mailing list), I make the changes, and then
the patch is committed. But what I'm seeing here, this is not how the
things are done here. It is much more complicated than that I guess.

In a codereview tool I can send a patch for review, I can assign it to
someone review, he will make comments, I will make the necessary
changes, and when the patch is ready, it will be committed. What is
the workflow? With an email I can't assign a patch to someone, with
time it will be lost.

I'm just trying to understand what I have to do, to submit better
patches. Another issue that I saw, is about *issues* or bugs, they are
not tracked in a bug traker. It's just an email, so how can I work in
a bug if I don't know about it, have I to find the bugs myself?
