From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: RFC: Making submodules "track" branches
Date: Tue, 8 Jun 2010 20:23:49 +0000
Message-ID: <AANLkTilYHfDrtCAcPPxB1AZnzch2ELTEiIFTW3N5LBEc@mail.gmail.com>
References: <AANLkTilBQPHgkCLJ7ppNo5TwC9Bdmqo-OMRpaDFwbQPd@mail.gmail.com>
	<201006080912.31448.johan@herland.net>
	<4C0E630A.7020803@xiplink.com>
	<AANLkTimtWrp1yimeooJ-ptAaDoxwpUc5KOP9HJUxx0X2@mail.gmail.com>
	<4C0E9AC7.7080802@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Tue Jun 08 22:24:10 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OM5LB-0001P6-LZ
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 22:24:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756305Ab0FHUXy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Jun 2010 16:23:54 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:51505 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756278Ab0FHUXv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Jun 2010 16:23:51 -0400
Received: by iwn37 with SMTP id 37so5025433iwn.19
        for <git@vger.kernel.org>; Tue, 08 Jun 2010 13:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=AOSiwUO5PIG6gNDac6GaG+v2l/qqas2EHRdZNnPcwcY=;
        b=A/aOHB0RGsuM+tiw8lM9ijk2K/Px9HanqNJRfU3JxbLMvg71cQcGpK+cb60Ge+wzNA
         HDtsebeEH9E+u+I5SodbQFdpmGyLEEj0PTm6wXj/mEii5drjGBPVVN6ASELySS19ndxk
         /gr0AxcMtBwC/C2dz/c0IQozRgGlWzWSXDzvE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=QiMVtvcZ1uwRNTfmezCDebkaZDDaX7sAcSulF5elaZHa5y9vJbEV8BRNjhlhWzZaIN
         acwgFC7DyELQEEBFM1ZNxKab3rXSR4aFmiQcc0ZCPSOKTK9wc0lB2jGWkSIc/c4ztyaY
         nr0Z+K+UE8kGteChy/lzAHuD7EHoRsviD/BAI=
Received: by 10.231.120.100 with SMTP id c36mr2182501ibr.77.1276028629958; 
	Tue, 08 Jun 2010 13:23:49 -0700 (PDT)
Received: by 10.231.155.144 with HTTP; Tue, 8 Jun 2010 13:23:49 -0700 (PDT)
In-Reply-To: <4C0E9AC7.7080802@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148708>

On Tue, Jun 8, 2010 at 19:32, Marc Branchaud <marcnarc@xiplink.com> wro=
te:
> On 10-06-08 12:09 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Tue, Jun 8, 2010 at 15:34, Marc Branchaud <marcnarc@xiplink.com> =
wrote:
>>>
>>> So, back to the issue at hand: Sometimes I want static (non-trackin=
g)
>>> submodules, and sometimes I want dynamic (tracking) submodules. =C2=
=A0IMO, this
>>> makes =C3=86var's proposed configuration-based approach impractical=
=2E =C2=A0(Of course,
>>> I'm not looking to replicate svn's externals...)
>>
>> I'm proposing that you be able to configure how you want to handle
>> submodules on a per-submodule basis.
>
> Yes, and that's precisely the problem. =C2=A0For a given submodule, s=
ometimes it
> should track a branch and sometimes it shouldn't. =C2=A0Having to edi=
t a
> configuration to change that is impractical.

See below.

>> The exact semantics that I proposed may be impractical for some
>> reason, but the idea is that it'd be opt in. We'd perhaps have
>> multiple approaches (via config) to submodules, instead of the curre=
nt
>> monolithic scheme.
>
> Opting in or out can't just be a monolithic setting for each submodul=
e. =C2=A0A
> submodule's branch tracking has to be on or off depending on the circ=
umstances.

I don't really get what the objection is exactly. How should "branch
tracking" be achieved do you think?

Anyway, right now what we track is set in a monolithic fashion by a
combination of a commit pointer in a tree and what's being versioned
in .gitmodules. If you want to change anything that's where you have
to do it.

Why should it be any different when the submodule isn't tracking a
specific commit? I.e. when it's "track the latest version of $thingy,
whatever that is", instead of "track version $version of $thingy".

>> So if you didn't want a svn:externals like "always track trunk"
>> repository you'd just not set your superproject up to treat the
>> submodule like that.
>
> Yes, of course.
>
> I guess what I'm saying is that duplicating svn's externals doesn't s=
eem all
> that useful to me and I'd rather see git do better. =C2=A0I've no obj=
ection if
> folks want to have such a feature, but to me it's not what "submodule=
s
> tracking branches" should be about.

Obviously I have no objection to doing better, but how specifically
should that be done? If the semantics you want are "give me the latest
version of $URL, whatever that is" then the SVN semantics are pretty
good.
