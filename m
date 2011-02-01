From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [1.8.0] Tag namespaces
Date: Tue, 1 Feb 2011 22:21:32 +0700
Message-ID: <AANLkTi=kwU+-UxfnCnDj0dD2NLPovTTsCPbSf-RQ3L5P@mail.gmail.com>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org> <7vwrll57ha.fsf@alter.siamese.dyndns.org>
 <AANLkTikeqsg+qJ0z4iQ6ZmKL=_HB8YX_z20L=dFFApmA@mail.gmail.com> <4D481EA0.9090802@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Tue Feb 01 16:22:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkI3c-0000kO-KT
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 16:22:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752143Ab1BAPWG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Feb 2011 10:22:06 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:64797 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751579Ab1BAPWE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Feb 2011 10:22:04 -0500
Received: by ewy5 with SMTP id 5so3142234ewy.19
        for <git@vger.kernel.org>; Tue, 01 Feb 2011 07:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=sUbdEam39cdIMM6nDh8/BkHuvQzojYNtKlz62S7hJVY=;
        b=T/djCALzVOnT4Siu72atC4t2StVbEWrZIplQychRd+G9D7q4llUoQQF2Afi/ZTFWmb
         J96n2n5kreq3zLuI3w2P0jpVHXvl9RR4LOf9Fwhfh7TooRt4VnskYwlWVmkx0Sk0NpnH
         BCUNvKHDELfgc4s1NIBK9MAYo/tKDfOjpxffQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=NNByJ/vHzGkqTycXsgiDv1L9XHXSE4Fdwk7nwEnpSWyEop/zhtf04wz34Qq0j9/wkK
         Ifvko+Pd0PrWlni2dHnEs6O27Lwe3pwaACxwTM3S44zDjJKgejSLoaEFCeTT6wSyhnCW
         GTEuZCXNnsUVT9UCqCNWXMYn9H5sPXvMSoWng=
Received: by 10.216.176.201 with SMTP id b51mr777252wem.34.1296573722337; Tue,
 01 Feb 2011 07:22:02 -0800 (PST)
Received: by 10.216.63.14 with HTTP; Tue, 1 Feb 2011 07:21:32 -0800 (PST)
In-Reply-To: <4D481EA0.9090802@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165817>

On Tue, Feb 1, 2011 at 9:54 PM, Marc Branchaud <marcnarc@xiplink.com> w=
rote:
> On 11-01-31 10:20 PM, Nguyen Thai Ngoc Duy wrote:
>> On Tue, Feb 1, 2011 at 12:05 AM, Junio C Hamano <gitster@pobox.com> =
wrote:
>>> Now the 1.7.4 release is out, I'd like people to help thinking abou=
t the
>>> next cycle(s).
>>>
>>> As a discussion-starter, here are my random wishes. =C2=A0Even thou=
gh this does
>>> not attempt to be exhaustive, keeping the number of goals manageabl=
y small
>>> may help us focus.
>>
>> Another random wish, which does not come with a proposal. How about
>> tag namespace (ie. tags from a remote stay in remote namespace)?
>
> I had just started writing up such a proposal yesterday. =C2=A0What I=
 have so far
> is pretty preliminary:

Thanks. I wrote another proposal (should we have more or less standard
"Git Enhancement Proposal" process like Python's PEP or Scheme's SRFI
to keep track of these over time?) but it's good to see others look at
it too.

> Proposal:
>
> Change tag refspecs to distinguish between remote and local tags. =C2=
=A0An
> unadorned tag "foo" could point to different commits in different
> repositories. =C2=A0A remote could move/edit it's "foo" tag and have =
that update
> smoothly propagated to clones.
>
> I believe this was last brought up in November while discussing the r=
efs base
> for notes:
>
> http://thread.gmane.org/gmane.comp.version-control.git/160503/focus=3D=
160655

One problem with the proposed ref layout is that it breaks current
layout (remotes/<remote>/head -> remotes/<remote>/heads/head). Some
sort of migration support is needed. On the other hand, new layout is
cleaner than my proposal (remote-tags/<remote>/tag).

> Risks:
>
> I think the main risk lies in breaking plain <tagname> refs, as they =
would
> become "origin/<tagname>" refs instead. =C2=A0But I think that can be=
 mitagated
> against (see below).
> ...
> To help mitigate the risk of breaking plain "<tagname>" refs, "git re=
v-parse"
> can look for plain names (i.e. ones without a /) in the remote tags l=
ocation.

Hmm I thought "a-ref" would check "refs/tags/a-ref" and
"refs/remotes/*/a-ref". But you are right. Maybe "tags.relative" can
take three values instead of boolean (names TBD):

 - deprecated (current behavior)
 - migrating (fetch tags to refs/remotes, but tag lookup will look in
refs/tags as well as refs/remotes/*/tags)
 - migrated (fetch tags to refs/remotes, look up in order)

We may slowly turn default value step by step until it becomes "migrate=
d".
--=20
Duy
