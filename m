From: Joseph Parmelee <jparmele@wildbear.com>
Subject: Re: Lack of detached signatures
Date: Wed, 28 Sep 2011 16:40:33 -0600 (CST)
Message-ID: <alpine.LNX.2.00.1109281536540.25187@bruno>
References: <alpine.LNX.2.00.1109271742460.24832@bruno> <7vty7xttxh.fsf@alter.siamese.dyndns.org> <CAMOZ1Bs2HW6e3V6sayVSm0NhC=0e5129ZR8YSGuZPnJw9H9TEA@mail.gmail.com> <4B2793BF110AAB47AB0EE7B90897038516F63A7C@ORSMSX101.amr.corp.intel.com>
 <1317195719.30267.4.camel@bee.lab.cmartin.tk> <alpine.LNX.2.00.1109280555460.25187@bruno> <7v1uv01uqm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: =?ISO-8859-15?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>,
	"Olsen, Alan R" <alan.r.olsen@intel.com>,
	Michael Witten <mfwitten@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 29 01:25:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R93Vi-0002rN-96
	for gcvg-git-2@lo.gmane.org; Thu, 29 Sep 2011 01:25:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755243Ab1I1XZs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Sep 2011 19:25:48 -0400
Received: from ip205-30-10-190.ct.co.cr ([190.10.30.205]:50472 "EHLO
	bruno.wildbear.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932235Ab1I1Wkg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2011 18:40:36 -0400
Received: by bruno.wildbear.com (Postfix, from userid 503)
	id 482F91BE05B2; Wed, 28 Sep 2011 16:40:33 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
	by bruno.wildbear.com (Postfix) with ESMTP id 30D001BE037E;
	Wed, 28 Sep 2011 16:40:33 -0600 (CST)
X-X-Sender: jparmele@bruno
In-Reply-To: <7v1uv01uqm.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182372>




On Wed, 28 Sep 2011, Junio C Hamano wrote:

> Joseph Parmelee <jparmele@wildbear.com> writes:
>
>> There is confusion here between the repository and the tarball.  Once you
>> have produced the tarball there is NO cryptographic protection against
>> forgeries unless you sign it with GPG.
>
> True.
>
> If I give you a URL http://code.google.com/p/git-core/downloads/list with
> checksums
>
>  $ sha1sum git-1.7.7.rc3.tar.gz
>  c6ba05a833cab49dd66dd1e252306e187effbf2b  git-1.7.7.rc3.tar.gz
>
> You either have to trust that code.google.com/ is not broken, or this
> message is coming from real Junio (provided if you can trust him in the
> first place).
>

How do I know that I am actually connected to code.google.com and not some
other site served up to me by a bogus proxy somewhere?

> BUT.
>
> The world is not so blank-and-white. Trust is ultimately among humans. If
> this message is not from the real Junio, don't you think you will hear
> something like "No, that c6ba05... is forgery, please don't use it!" from
> him, when he finds this message on the Git mailing list?  If he does not
> exercise diligence to even do that much, does he deserve your trust in the
> first place?
>
> GPG does add security (if you have the key) but you can do pretty well
> even without it in practice.
>

Nonsense.  There is a reason why responsible sites everywhere use detached
signatures on their release tarballs.


>> It is only because kernel.org exercised due diligence in the production of
>> tags and signatures on all their tarballs that the kernel code itself
>> withstood their recent intrusion....
>
> I do not think that is true at all. Developers just dropped *.tar.gz on a
> 'master' machine, and left the rest to a cron job that reflates the
> tarball into *.tar.bz2, sign both using a GPG key, and mirror them to the
> public-facing machines 'www'.
>
> Somebody who had access to the 'master' machine could add a new tarball
> and have it go thru the same exact process, getting signed by the cron.
>

The "cron job" provided the passphrase for the signing as well instead of
requiring a human to authorize the transaction by providing the passphrase
or by some other means?  I suspect not.  Have you actually used GPG to sign
something?

And even if that egregious error (no human authorization) had been made,
there is the matter of the secret signing key.  Of course if the bad guys
have that (and the passphrase) then they have everything and can readily
prepare fraudulent packages.  But without a detached signature you are
allowing them to do it even without going to the bother of stealing the
secret key and breaking/stealing the passphrase.  Without a dual key
signature, you are providing ABSOLUTELY NO protection against
man-in-the-middle attacks that you will never know occurred, but which will
nevertheless (rightfully) reflect on your project.  To just assert that "you
can do pretty well even without it in practice" is just plain irresponsible
and convinces me not to update our copies of git until it returns to
kernel.org and to administrators that understand the situation.
