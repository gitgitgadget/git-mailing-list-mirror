From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: sharing git work while downstream from svn?
Date: Tue, 11 Aug 2009 23:17:24 +0000
Message-ID: <32541b130908111617m12fa4b97vddfa9793dff31f29@mail.gmail.com>
References: <auto-000020209577@sci.utah.edu> <32541b130908111603v1e3f6c42peac792caf7097e0d@mail.gmail.com> 
	<auto-000020209671@sci.utah.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: tom fogal <tfogal@alumni.unh.edu>
X-From: git-owner@vger.kernel.org Wed Aug 12 01:18:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mb0bV-0007yP-FR
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 01:18:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755591AbZHKXRo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Aug 2009 19:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755547AbZHKXRo
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 19:17:44 -0400
Received: from mail-yx0-f175.google.com ([209.85.210.175]:44871 "EHLO
	mail-yx0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755557AbZHKXRn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Aug 2009 19:17:43 -0400
Received: by yxe5 with SMTP id 5so5182378yxe.33
        for <git@vger.kernel.org>; Tue, 11 Aug 2009 16:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=HEnNmwbhDWZM4q2ZKhyMSHFcKn/qGJVrPdVMQaR0USM=;
        b=P93QJiJ1VoK2fr90wTOfFp/x1N7GqiU6nQmVC0J4CHYhjBhN0SHB2CYm6r3Qmn0L+R
         ftBWD0b85Vq1k7BGBJdjYKDn+7dSI4SX/lBPQa3V5Ksl6HVVtOkh6UisjsCzqxzBAHZK
         D/e48sWQ40DoWJDx6C16VgBtFu2W034sYRlx0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=vbgJbVyLXzhDmludQVivY3Y6zjpOScKh4ntyh32hsAXKcorqcUWuAVvO5j/LBXJ51+
         DkBYsdQHgVXoxGcnzKmcsO02PxoGE9nprWHDzT0pb8EqdWSDFMV9WudEu/xP0+mdzllp
         wrJMyGkFsuOICGPW9I63/D3o67mDRrcZSjtz0=
Received: by 10.151.78.19 with SMTP id f19mr6333559ybl.182.1250032664090; Tue, 
	11 Aug 2009 16:17:44 -0700 (PDT)
In-Reply-To: <auto-000020209671@sci.utah.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125620>

On Tue, Aug 11, 2009 at 11:14 PM, tom fogal<tfogal@alumni.unh.edu> wrot=
e:
> Avery Pennarun <apenwarr@gmail.com> writes:
>> On Tue, Aug 11, 2009 at 10:55 PM, tom fogal<tfogal@alumni.unh.edu> w=
rote:
>> > This gets to be a mess when trunk changes: I'll rebase + potential=
ly
>> > fix some conflicts. =A0Other developers with some of the experimen=
tal
>> > patches will svn update, and get similar conflicts. =A0These might=
 differ
>> > in subtle ways, and now exchanging patches gets more difficult.
>>
>> Instead, do all your work in a branch *other* than the git-svn main
>> branch. =A0When you're ready to merge your stuff into svn, do:
> [snip]
>> This basically results in a *single* commit getting sent to svn,
>> rather than the batch of all the git commits you've been working
>> on. =A0Most svn users don't care about this, because they lose all t=
hat
>> granularity whenever they merge a branch anyhow.
>
> ... but I, as a git user forced to live in an svn world, *do* value a=
ll
> of that history. =A0When I find a bug a month later, I want git-bisec=
t
> to be useful. =A0Further, when I'm reviewing sets of changes in a sea=
rch
> for some particular change, I want to be able to skip over large sets
> of patches simply by looking at the first line of a commit log. =A0If=
 I
> squash all that history down, I have to wade into the patch itself.

That's the great thing!  Your git history never gets lost with this
technique, since you *never* rewind any branches.  The detailed
history just never makes it into svn, which has no way of representing
it anyhow.

As a bonus, the fact that your git history becomes more and more
detailed vs. the svn history slowly makes your case for switching
everybody else to git that much stronger :)

Have fun,

Avery

P.S. Shameless plug: I wrote the chapter about git-svn in O'Reilly's
"Version Control With Git," in which I described this technique in
more detail.  (I *don't* make any money on commissions on that book,
as I'm not the primary author.)
