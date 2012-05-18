From: Stepan Koltsov <stepan.koltsov@jetbrains.com>
Subject: Re: bugreport: stgit cannot export empty patch
Date: Sat, 19 May 2012 02:26:08 +0400
Message-ID: <CAPk5vtyc1gHB=31CPDpk=s4QE+Wtp-8wMJDuV1F=R11MfERdTw@mail.gmail.com>
References: <CAPk5vtzpUHgL_dfJLJHgKsaNPZodx1jbTRQpRdoj01RRPRoBfg@mail.gmail.com>
	<xmqqboll2nl0.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 19 00:26:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVVd2-0003F2-G3
	for gcvg-git-2@plane.gmane.org; Sat, 19 May 2012 00:26:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030289Ab2ERW0Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 May 2012 18:26:25 -0400
Received: from mail1.intellij.net ([46.137.178.215]:53144 "EHLO
	mail1.intellij.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030334Ab2ERW0L convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 May 2012 18:26:11 -0400
Received: (qmail 4283 invoked by uid 89); 18 May 2012 22:26:09 -0000
Received: by simscan 1.1.0 ppid: 4225, pid: 4273, t: 0.1235s
         scanners: regex: 1.1.0 clamav: 0.97/m:53/d:13443
Received: from unknown (HELO mail-gg0-f174.google.com) (Stepan.Koltsov@jetbrains.com@209.85.161.174)
  by ip-10-48-137-145.eu-west-1.compute.internal with ESMTPA; 18 May 2012 22:26:09 -0000
Received: by gglu4 with SMTP id u4so3341671ggl.19
        for <git@vger.kernel.org>; Fri, 18 May 2012 15:26:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding:x-gm-message-state;
        bh=YrE43zzvTDTsNCBpVRtK7VkSKmWcLCW4Ax0HOxK/tJ4=;
        b=LnnRvvNi1oh80GXN6QimHgXG+mVeUQBj2DcQu2ycsLpkNADw4Drn3cVlalwTStr9FM
         lVLXM8aXproPsnpRhJI8bCulrSBGRsYMfYA3BI3yhP0VozXo98PntRbLJQgehA1DOS5P
         HiVegQa/5cbglYVonZ2sw0DfDjwGkz/TimhkCQjCihcHVd09vJoRCF7OydiPSfK6SJ7i
         hLK6Il58XVGw8NJQLSmJh90nHU2ahtcmkQASCqMUogrlRnssHFr3xaYWnYn2wx/l3no4
         srwaZyEGyyDvKyn3C6a80we3LgnfqKELAQssbNEqZYmyz5+N63dOzBMFJtztweYpKUcB
         blEg==
Received: by 10.236.115.163 with SMTP id e23mr11684355yhh.95.1337379968101;
 Fri, 18 May 2012 15:26:08 -0700 (PDT)
Received: by 10.147.115.3 with HTTP; Fri, 18 May 2012 15:26:08 -0700 (PDT)
In-Reply-To: <xmqqboll2nl0.fsf@junio.mtv.corp.google.com>
X-Gm-Message-State: ALoCoQnNEEITEriIs7Q/lFPdrsyWVcuxRfhurHU3eSN39kUs8lk3aM5iFCmE+qMwo0M0ACJdNmiA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197979>

On Sat, May 19, 2012 at 1:20 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Stepan Koltsov <stepan.koltsov@jetbrains.com> writes:
>
>> stgit fails to export empty patches:
>>
>> % stg new empty-patch -m 'asasas'
>> Now at patch "empty-patch"
>> % stg export empty-patch
>> Checking for changes in the working directory ... done
>> fatal: unrecognized input
>> stg export: git failed with code 128
>> zsh: exit 2 =C2=A0 =C2=A0 stg export empty-patch
>>
>> % stg --version
>> Stacked GIT 0.16-3-g67cf
>> git version 1.7.9.1
>> Python version 2.7.1 (r271:86832, Jul 31 2011, 19:30:53)
>> [GCC 4.2.1 (Based on Apple Inc. build 5658) (LLVM build 2335.15.00)]
>
> I don't use (or read the sources to) StGIT, but isn't the whole point=
 of
> "stg export" to "convert your StGIT patches into patch files"? =C2=A0=
=46or an
> empty commit, what is an appropriate output? =C2=A0IOW, is it reasona=
ble to
> have an empty commit in your history if you are planning to "stg expo=
rt"
> it?

I'm executing stg export to back up. If series contains empty patches,
backup fails.

Scenario: I started some work, created new empty patch, but did
nothing, decided to go home, and do backup of the whole series before
leaving. Backup fails.

AFAIU there's no simpler way to backup stg series than executing

% stg export `stg series --noprefix`

--=20
Stepa
