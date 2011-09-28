From: Joseph Parmelee <jparmele@wildbear.com>
Subject: RE: Lack of detached signatures
Date: Wed, 28 Sep 2011 06:36:10 -0600 (CST)
Message-ID: <alpine.LNX.2.00.1109280555460.25187@bruno>
References: <alpine.LNX.2.00.1109271742460.24832@bruno>  <7vty7xttxh.fsf@alter.siamese.dyndns.org>  <CAMOZ1Bs2HW6e3V6sayVSm0NhC=0e5129ZR8YSGuZPnJw9H9TEA@mail.gmail.com>  <4B2793BF110AAB47AB0EE7B90897038516F63A7C@ORSMSX101.amr.corp.intel.com>
 <1317195719.30267.4.camel@bee.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811328-1754446401-1317213370=:25187"
Cc: "Olsen, Alan R" <alan.r.olsen@intel.com>,
	Michael Witten <mfwitten@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: =?ISO-8859-15?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>
X-From: git-owner@vger.kernel.org Wed Sep 28 14:36:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8tN4-0008T0-KL
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 14:36:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754097Ab1I1MgO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Sep 2011 08:36:14 -0400
Received: from ip205-30-10-190.ct.co.cr ([190.10.30.205]:49955 "EHLO
	bruno.wildbear.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752921Ab1I1MgM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2011 08:36:12 -0400
Received: by bruno.wildbear.com (Postfix, from userid 503)
	id 7D8871BE05BF; Wed, 28 Sep 2011 06:36:10 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
	by bruno.wildbear.com (Postfix) with ESMTP id 61A401BE029D;
	Wed, 28 Sep 2011 06:36:10 -0600 (CST)
X-X-Sender: jparmele@bruno
In-Reply-To: <1317195719.30267.4.camel@bee.lab.cmartin.tk>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182308>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811328-1754446401-1317213370=:25187
Content-Type: TEXT/PLAIN; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT


On Wed, 28 Sep 2011, Carlos Martín Nieto wrote:

> On Wed, 2011-09-28 at 04:17 +0000, Olsen, Alan R wrote:
>> [Sorry for the top posting. Outlook is evil.]
>>
>> Detached signatures are created with gpg, not git.
>
> Git delegates all the signing business to gpg.
>
>>
>> What I would like to see in git would be signed commits. I have looked
>
> Every single commit? That sounds very heavy. You might want to look at
> signed pushes (signed push certificates), which were discussed in the
> list some time the kernel.org intrusion.
>
> Due to the way git calculates the hash for each object, signing a tag
> means that you also sign every single commit up to that point (with all
> their tree and blob objects).
>
>>  at what it would take to make it work, but I don't have all the
>> details worked out. (Certain merges and cherry-picks would not work
>> very well.)
>
> This is precisely because of the cryptographic hash that is used to make
> sure that history doesn't get changed.
>
>   cmn
>
>>
>> -----Original Message-----
>> From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On Behalf Of Michael Witten
>> Sent: Tuesday, September 27, 2011 5:08 PM
>> To: Junio C Hamano
>> Cc: Joseph Parmelee; git@vger.kernel.org
>> Subject: Re: Lack of detached signatures
>>
>> On Wed, Sep 28, 2011 at 00:03, Junio C Hamano <gitster@pobox.com> wrote:
>>> Joseph Parmelee <jparmele@wildbear.com> writes:
>>>
>>>> Under the present circumstances, and particularly considering the
>>>> sensitivity of the git code itself, I would suggest that you implement
>>>> signed detached digital signatures on all release tarballs.
>>>
>>> Well, signed tags are essentially detached signatures. People can verify
>>> tarballs against them if they wanted to, although it is a bit cumbersome.
>>
>> Aren't tarballs used to get git on machines that don't yet have git?
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> NrybX?v^)?{.n+??}?z&j:+vzZ++zfh~izw?&)?f
>
>
>

There is confusion here between the repository and the tarball.  Once you
have produced the tarball there is NO cryptographic protection against
forgeries unless you sign it with GPG.  That is my point: either produce
signatures with the tarballs, or don't provide them at all and force users
to clone the repository.  Git itself provides internal crytopgraphic
protection with its commit tags.

The stability of the head depends on the policies followed by the developers
and cannot be known by users not intimately involved in the development.  In
any event if there is a tarball most users assume that it represents a more
stable state of the repository than the head and they will tend to use it,
even if they already have a version of the code, instead of cloning the
repository directly.

Git, and its signing key, are high-value targets for the bad guys, even
higher than the kernel itself.  I hope you will give just a moment's thought
to the damage that will be done if bad guys succeed in a DNS poisoning
attack and succeed in passing off a phony git tarball with a back door in
the git code itself to a major code project.  Any code produced in a
repository using that phony version of git can then itself be corrupted.

It is only because kernel.org exercised due diligence in the production of
tags and signatures on all their tarballs that the kernel code itself
withstood their recent intrusion.  I suspect that their signing key was not
so lucky and needs to be changed.  The situation now is really dangerous
with various important projects scattered about, including git, which are
being operated without proper consideration of security.
---1463811328-1754446401-1317213370=:25187--
