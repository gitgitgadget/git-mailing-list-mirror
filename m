From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: how to squash two commits into only one
Date: Tue, 29 Mar 2011 19:49:16 +0700
Message-ID: <AANLkTinjbXzdfkxVRPPSXJj6Z0mMrikzdi2V8N5YAGR-@mail.gmail.com>
References: <AANLkTi=B37GABBc-YWfJN29Mh0kx4Tn8KenD5dJFo9j1@mail.gmail.com>
 <AANLkTi=7TNjLVrcJVppiULBnDdKCM_vqwhn1JqoW+DQo@mail.gmail.com>
 <AANLkTimsN40twLwOWXsQqbv0SVN7T9rEHSUpcVum8aFR@mail.gmail.com>
 <AANLkTikX5YvMrooVi-7e-YDrCP_7QHqL6wR=1bY1cZ2L@mail.gmail.com> <5A9D499C-26AC-401E-B21A-1F8E03FBAC4B@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Lynn Lin <lynn.xin.lin@gmail.com>, git@vger.kernel.org
To: Joshua Juran <jjuran@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 14:49:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4YMr-0001qS-TF
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 14:49:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752928Ab1C2Mts convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Mar 2011 08:49:48 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:46439 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752504Ab1C2Mtr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Mar 2011 08:49:47 -0400
Received: by wya21 with SMTP id 21so107828wya.19
        for <git@vger.kernel.org>; Tue, 29 Mar 2011 05:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=5gNWogMiwkHCV8cDLl6Eln1Siknc1suJcFsUfGruSRM=;
        b=YXTAAJn+3nmO2ziSBgfNce40MyuafbDZ0MoJVyyYIFTScIaippjLJJzTe404HaVGj4
         s+EjnNsxqhabLWUE+2iEk/sKPz5wzf1oCGcfZ1cZ5FqIW8X2xi7Okp5lim2qkHPuYkgy
         CqZjG05yeSS6lKLwugUAWOSTfV10wkRi81ZZk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=XWyPJ6G3qqv63qoFNG3HYButuMQv2pWW7r2jiVtK0MNFfJfsZEqeSf7gS9BuPd/rEi
         nqHkqReJO4tKzLk0bVCZaTEjnU9WR6sDqbqvsW/VhEucEb1Q/6/ylHzEkTHx86rkRjTB
         l75HRtGm9Ml29uJZi5bVh2AQPxC5ejNMiIeHY=
Received: by 10.216.120.129 with SMTP id p1mr5289228weh.81.1301402986152; Tue,
 29 Mar 2011 05:49:46 -0700 (PDT)
Received: by 10.216.163.202 with HTTP; Tue, 29 Mar 2011 05:49:16 -0700 (PDT)
In-Reply-To: <5A9D499C-26AC-401E-B21A-1F8E03FBAC4B@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170264>

On Tue, Mar 29, 2011 at 7:44 PM, Joshua Juran <jjuran@gmail.com> wrote:
> On Mar 29, 2011, at 3:58 AM, Alex Riesen wrote:
>> On Tue, Mar 29, 2011 at 12:10, Lynn Lin <lynn.xin.lin@gmail.com> wro=
te:
>>> On Tue, Mar 29, 2011 at 5:38 PM, Alex Riesen <raa.lkml@gmail.com> w=
rote:
>>>> On Tue, Mar 29, 2011 at 07:42, Lynn Lin <lynn.xin.lin@gmail.com> w=
rote:
>>>>> =C2=A0I have only have two commits in repo,then I want to squash =
these
>>>>> two commit into one through git rebase -i .However it fails
>>>>>
>>>>> $ git rebase -i HEAD^1
>>>>> it only show up one commit so can't squash (can't squash without =
a
>>>>> previous commit)
>>>>
>>>> $ git rebase -i HEAD~2
>>>>
>>> only have two commits
>>
>> Uh. That's unusual.
>>
>> Than yes, "git reset HEAD^; git commit --amend" seems the best solut=
ion.
>
> Actually, that should be: =C2=A0`git reset --soft HEAD^; git commit -=
-amend`.

"git rebase --root" does not seem a bad idea though. I need to amend
initial commit a few times and end up using "git reset" without
--soft.
--=20
Duy
