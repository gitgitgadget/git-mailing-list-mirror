From: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Thu, 2 Sep 2010 16:42:55 +0100
Message-ID: <AANLkTikBnKQJmgOms2wK1+6fCLtHWiWkhuCVMN7kKLXP@mail.gmail.com>
References: <AANLkTik-w6jWgrt_kwAk2uNGhF_=3tMEpTZs3nyF_zGA@mail.gmail.com>
	<AANLkTinu=RoGfq93d+yjHiQwCt0HXx4YtqfvhXyZdO=F@mail.gmail.com>
	<AANLkTimpE6rf0azHtrz6BFK5d7YojF+G1YuSA1gusSC=@mail.gmail.com>
	<4C7FC3DC.3060907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git <git@vger.kernel.org>
To: gitzilla@gmail.com
X-From: git-owner@vger.kernel.org Thu Sep 02 17:43:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrBwM-0007bq-QL
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 17:43:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752498Ab0IBPm5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Sep 2010 11:42:57 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:46643 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751632Ab0IBPm5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Sep 2010 11:42:57 -0400
Received: by eyb6 with SMTP id 6so354270eyb.19
        for <git@vger.kernel.org>; Thu, 02 Sep 2010 08:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=/hKk1+az7W8SZjRLdbzJhODrC+slwbVUZX9I/QonYC8=;
        b=nFAf0n6B/ZAUkaoNSOFrW96tIOyxhIuAj6wvyijXD+o+G/AYE0V4KuYUCkqtuN9iKM
         lqQRTKSrOOf+qtXThZv/OEWiBiy6DJ/dzv8sMXCgSwS3aO4qSIq8q5A/tR2jJYeE2VXf
         jxl9M+sMPtOjAhGQegvbNXDVCSaXfwpUHX+34=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=LGYVJPlhPaQ7QtU+y5A5Qwrf1aJEUp5AKwFdosUetr1j1ZqYjP647fugUpMtyxFYhi
         bsojp8B3MUwD6I57yGs5bGJ6EJwa+A5zOd4ztyDcBDirDvKU4Fc/RbX7bEVH3Vkqq66t
         ddrWYe5lTEEsIUy3Y1YSTnJHsViq3Y+hhco7o=
Received: by 10.213.7.7 with SMTP id b7mr211220ebb.30.1283442175630; Thu, 02
 Sep 2010 08:42:55 -0700 (PDT)
Received: by 10.220.98.8 with HTTP; Thu, 2 Sep 2010 08:42:55 -0700 (PDT)
In-Reply-To: <4C7FC3DC.3060907@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155136>

On Thu, Sep 2, 2010 at 4:33 PM, A Large Angry SCM <gitzilla@gmail.com> =
wrote:
> On 09/02/2010 09:37 AM, Luke Kenneth Casson Leighton wrote:
>>
>> On Wed, Sep 1, 2010 at 11:04 PM, Nguyen Thai Ngoc Duy<pclouds@gmail.=
com>
>> =C2=A0wrote:
>
> [...]
>>>
>>> There were discussions whether a pack is stable enough to
>>> be shared like this,
>>
>> =C2=A0it seems to be. =C2=A0as long as each version of git produces =
the exact
>> same pack object, off of the command "git pack-objects --all --stdou=
t
>> --thin {ref}< =C2=A0{objref}"
>
> This is not guaranteed.

 ok.  greeeat.

 so, some sensible questions:

 * what _can_ be guaranteed?

 * diffs?

 * git-format-patches? (which i am aware can do binary files and also
rms)?

* individual files in the .git/objects directory?

 and, asking perhaps some silly questions:

* why is it not guaranteed?

* under what circumstances is it not guaranteed?  and, crucially, is
it necessary to care?   i.e. if someone does a shallow git clone, i
couldn't give a stuff.

* is it possible to _make_ the repository guaranteed to produce
identical pack objects?

* does for example "git gc" change the object store in such a way such
that one git repo will produce a different pack-object from the same
ref?  if so, can running "git gc" prior to producing the pack-objects
gurantee that the pack-objects will be the same?

* is it a versioning issue?  is it because there are different
versions (2 and 3)?  if so, that's ok, you just force people to use
the same pack-object versions.

etc. etc.

l.
