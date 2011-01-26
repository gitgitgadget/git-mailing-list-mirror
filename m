From: Julian Ibarz <julian.ibarz@gmail.com>
Subject: Re: Updating a submodule with a compatible version from another
 submodule version using the parent meta-repository
Date: Wed, 26 Jan 2011 15:45:38 -0500
Message-ID: <AANLkTik8VrhbBSLwRq9gd39hofnmifk15zSqXVTsSzAp@mail.gmail.com>
References: <AANLkTinN1XVsAZXGLqkuhysrJ8-TCtGm4pOu2RfCEVVp@mail.gmail.com>
	<AANLkTimvNaiieEw8-Y52xxDW6DQ6b16v9azCk+BDPxhe@mail.gmail.com>
	<4D407099.4010805@web.de>
	<AANLkTinMhvBNrBMJ8vQpJdYxP_NgJU2L7JEW0KhXGjhf@mail.gmail.com>
	<4D407875.7080607@web.de>
	<AANLkTik-XdgGM20kFu8KZ5k9ynfNAo8fvL9t7kL_JhQg@mail.gmail.com>
	<7v7hdrl7nw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 26 21:45:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PiCFN-0007MO-7U
	for gcvg-git-2@lo.gmane.org; Wed, 26 Jan 2011 21:45:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754119Ab1AZUpl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Jan 2011 15:45:41 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:37617 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753703Ab1AZUpk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Jan 2011 15:45:40 -0500
Received: by wwa36 with SMTP id 36so1419800wwa.1
        for <git@vger.kernel.org>; Wed, 26 Jan 2011 12:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=GqYGd9nY4QGcL9gGyuYq0EAN/46AVKrJqXHuv9bpIFI=;
        b=afNGbSuYXr+KDCv9teqbNcck/2v7DOdT6VTfrJplOpLJFhSjSWaZr9loYkgdJnp2bN
         kLYHM/OTcE4DQ6LWTX7tAplGmJ9IzOvOd7s7JjX2MBTkxGrnGqk9CRpZ608q6OecgYT7
         HSyE/abRwMBblUnoUaVQFK9c6Qrmh1+THyK3k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=fm1CLOSxb+2dDK1wDfHXPDeOVAjkWwVAEcPEd26iKUyGTzGwmK5vHYUngOTK4HW6oL
         hiPyb7MYoNMUxlcrl8Ub9kU2rbUgkHTKeIIQopx/WyjF/li0y8iunPIGU8Uu6cqQCKAd
         zyaZJN1oSR8TsCkh8eOHTc2PmE4U8Cf5T983E=
Received: by 10.227.166.194 with SMTP id n2mr39732wby.172.1296074739016; Wed,
 26 Jan 2011 12:45:39 -0800 (PST)
Received: by 10.227.146.83 with HTTP; Wed, 26 Jan 2011 12:45:38 -0800 (PST)
In-Reply-To: <7v7hdrl7nw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165542>

On Wed, Jan 26, 2011 at 3:41 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Julian Ibarz <julian.ibarz@gmail.com> writes:
>
>>> Hmm, looks like I lost you here ... you want to bisect in B althoug=
h
>>> you know what commit you want there? Care to explain a bit more?
>>
>> In B I have a feature to integrate in master branch. This feature is
>> in branch old_feature. But this branch is really old. To try this
>> feature I need to rebuild it at this version. To make the build
>> success I need also to revert back the submodule C because B is
>> dependent on it. But finding the good version of C that match
>> old_feature version is a pain... Is it clear?
>
> That sounds like bisecting in C with a frozen checkout of B to see wh=
ich
> version in C works well with that target commit in B you know you wan=
t to
> use. =A0Why do you need to bisect in B???
>

=46orget about bisect. This is a different use case where I need the
feature I am talking about: checkout an old version in B and
automatically having A and C switch to a compatible version (the cause
can be because of a bisect or just because I want to try an old
feature not yet integrated into master or whatever the reason I want
to be on this old version).
