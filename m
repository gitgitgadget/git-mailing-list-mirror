From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [Survey] Signed push
Date: Thu, 15 Sep 2011 08:42:40 +1000
Message-ID: <CACsJy8BEES2j8K1v23RQQS=R1vRm1SVizBGFzq0wsDcMvC6Fjw@mail.gmail.com>
References: <7vaaa8xufi.fsf@alter.siamese.dyndns.org> <CACsJy8Dwu2U-7eEZU-VYmcrA7JwtvUkJS5SywXjZWoE1twchhQ@mail.gmail.com>
 <20110914210512.GA20294@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 15 00:43:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3yAr-0005Tm-B3
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 00:43:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818Ab1INWnM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Sep 2011 18:43:12 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:64940 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750784Ab1INWnL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Sep 2011 18:43:11 -0400
Received: by bkbzt4 with SMTP id zt4so1959038bkb.19
        for <git@vger.kernel.org>; Wed, 14 Sep 2011 15:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=jIncYzlVMrYj9ib7xk/H91vLl0CZ+CCdsrkgyrDrJL0=;
        b=wBP2IZu3ILs5Qj2V5QzTfrRJm8XNcu/uCzu/MecJ2UaeCMhYZg5I3MUkciLukzAtQu
         sTiPcJ9KMV3bRb2zlp2sPq7v7QwfnTY8B4o7iv4JLr6FO6Ex3f1O2aZL5ltmZgoU+MmG
         laQOKg9D1Bbz8265d+iRtQNDeyIYZnG7/qhSk=
Received: by 10.204.133.156 with SMTP id f28mr214149bkt.79.1316040190157; Wed,
 14 Sep 2011 15:43:10 -0700 (PDT)
Received: by 10.204.7.4 with HTTP; Wed, 14 Sep 2011 15:42:40 -0700 (PDT)
In-Reply-To: <20110914210512.GA20294@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181405>

On Thu, Sep 15, 2011 at 7:05 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Nguyen Thai Ngoc Duy wrote:
>> On Wed, Sep 14, 2011 at 2:45 AM, Junio C Hamano <gitster@pobox.com> =
wrote:
>
>>> An alternative that I am considering is to let the requester say th=
is
>>> instead:
>>>
>>> =C2=A0 =C2=A0are available in the git repository at:
>>> =C2=A0 =C2=A0 =C2=A0git://git.kernel.org/pub/flobar.git/ 5738c9c21e=
53356ab5020912116e7f82fd2d428f
> [...]
>> Stupid question, if we agree to go with signed push, can we also sig=
n
>> pull requests and verify them when we pull? I suppose most of the
>> time, pulling can be done automatically by extracting pull url from
>> the request. This would make pull/push both signed.
>>
>> BTW, there's a third way (rsync is obsolete) to carry changes away i=
n
>> human-unreadable way: bundles. Should we also sign the bundles too (=
I
>> guess we could just do the same as in signed push).
>
> If I understand you correctly, then ordinary PGP email signing[1]
> should work for that already. =C2=A0In your first example, the receiv=
er can
> make sure whatever process grabs a pull request verifies it, and in
> the second example, the receiver checks the signature on her email
> before saving a bundle and passing it to "git fetch".

Yes, I think we can do that already. It's just more convenient to
teach "git fetch/pull" to take pull requests and automatically verify
them. Some repositories may also want to enforce signing and we can do
that by setting config file and fetch/pull refuses if pull requests
are not signed. We can also store the sign as git notes, just like in
git-push (extra work if it has to be done manually).

> [1] http://www.phildev.net/pgp/gpgmua.html
--=20
Duy
