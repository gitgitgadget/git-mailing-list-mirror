From: Julian Ibarz <julian.ibarz@gmail.com>
Subject: Re: Re: Updating a submodule with a compatible version from another
 submodule version using the parent meta-repository
Date: Sun, 30 Jan 2011 04:44:59 -0500
Message-ID: <AANLkTimBCeSnR270eWMcrgCVj6rmiRkJizOxQPAPOAnn@mail.gmail.com>
References: <AANLkTinN1XVsAZXGLqkuhysrJ8-TCtGm4pOu2RfCEVVp@mail.gmail.com>
	<AANLkTimvNaiieEw8-Y52xxDW6DQ6b16v9azCk+BDPxhe@mail.gmail.com>
	<4D407099.4010805@web.de>
	<AANLkTinMhvBNrBMJ8vQpJdYxP_NgJU2L7JEW0KhXGjhf@mail.gmail.com>
	<4D407875.7080607@web.de>
	<AANLkTik-XdgGM20kFu8KZ5k9ynfNAo8fvL9t7kL_JhQg@mail.gmail.com>
	<7v7hdrl7nw.fsf@alter.siamese.dyndns.org>
	<AANLkTik8VrhbBSLwRq9gd39hofnmifk15zSqXVTsSzAp@mail.gmail.com>
	<7v1v3zjp6w.fsf@alter.siamese.dyndns.org>
	<20110129110807.GA21864@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Sun Jan 30 10:45:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PjTqY-0004hO-0P
	for gcvg-git-2@lo.gmane.org; Sun, 30 Jan 2011 10:45:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752615Ab1A3JpE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Jan 2011 04:45:04 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:54424 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751343Ab1A3JpC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Jan 2011 04:45:02 -0500
Received: by iwn9 with SMTP id 9so4472902iwn.19
        for <git@vger.kernel.org>; Sun, 30 Jan 2011 01:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=UiW1dsolmaXyXa33o2bV8Rit0KXqjL7Fyj8HbOuD1EA=;
        b=L4YQogCumyfyboTqQrTvYB4TxiI433dZ+22H8afDJ83GvPXdLQc6ik//C4nVjRCyck
         Yalr/xIp8EBkZT3Qyjn7ytRy3EaM5EH1cj72TstnpP6qcpl3EpYN0MxDMa7ksOHCCVq9
         +RuliHxyEpp48NLHKEMyTi5Hv3xIMyWZybALE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=HV9lMlUzX+icwllFiGI/gRKzbwXTynpLvoKle/jNEYDF5qLDY0Cmvqp6J13eDHXb63
         v1qd5QxbHRku+yG2ql+tC/uvdxAH1w/H2ZavAA/F2xe+Sklvj/ft5Gf1QshHNbJ1Mgta
         k8YkSWiivVKCI4+VfhgYRqzEq3EKhm+hwctS8=
Received: by 10.42.213.66 with SMTP id gv2mr5735668icb.81.1296380699270; Sun,
 30 Jan 2011 01:44:59 -0800 (PST)
Received: by 10.42.213.71 with HTTP; Sun, 30 Jan 2011 01:44:59 -0800 (PST)
In-Reply-To: <20110129110807.GA21864@book.hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165682>

Today I have started to implement a proof of concept in C (I know a
script would be better but I am really not good in sh so...). I
struggle with the manipulation of the git API. I have pushed my work
here:

http://gitorious.org/julian_ibarz_git/julian_ibarz_git

in branch submodule_checkout

My work is in:

builtin/submodulecheckout.c

And my questions are prepended by the keyword QUESTION (two questions
for now only).

Any help is welcome.

Thanks,

Julian Ibarz

On Sat, Jan 29, 2011 at 6:08 AM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> Hi,
>
> On Wed, Jan 26, 2011 at 02:05:43PM -0800, Junio C Hamano wrote:
>> If that version of submodule B is explicitly bound to a commit in th=
e
>> superproject A, you know which version of A and C were recorded, and=
 the
>> problem is solved.
>>
> [...]
>>
>> If you are confident that you didn't introduce different kind of
>> dependency to other submodules while developing your "old_feature" b=
ranch
>> in submodule B, one strategy may be to find an ancestor, preferrably=
 the
>> fork point, of your "old_feature" branch that is bound to the superp=
roject
>> A. =A0Then at that point at least you know whoever made that commit =
in A
>> tested the combination of what was recorded in that commit, together=
 with
>> the version of B and C, and you can go forward from there, replaying=
 the
>> changes you made to the "old_feature" branch in submodule B.
>
> Lets extend your explanation a little further and maybe demonstrate t=
he problem
> Julian is having a little more. I think what Julian searches for is a=
 tool in
> git that does the lookup for you which is AFAIK not that easy current=
ly. It
> seems to be a quite useful feature. Here what I understand Julian wan=
ts:
>
> 1. Find the most recent superproject commit X'' in A that records a s=
ubmodule
> =A0 commit X' in B which contains the commit X in B you are searching=
 for.
>
> =A0 For this we would need use something similar to git describe --co=
ntains
> =A0 but instead of using the list of existing tags in B it should use=
 the list
> =A0 of commits in B which are recorded in A.
>
> =A0 Here a drawing to explain (linear history for simplicity):
>
> =A0 superproject A:
>
> =A0 =A0 =A0O---O---X''---O
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> =A0 submodule B: \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> =A0 =A0 =A0O---X---O---X'---O---O
>
> 2. Look up the commit of C which is recorded in X'' of A and check it
> =A0 out.
>
> Step 2 is easy but for Step 1 the lookup of X' is missing for the com=
mandline.
> Is there already anything that implements git describe --contains for=
 a defined
> list of commits instead of refs?
>
> Cheers Heiko
>
