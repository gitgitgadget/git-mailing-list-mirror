From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Thu, 28 Apr 2011 10:54:46 +1000
Message-ID: <BANLkTikCKDS3NhbpnRqf82c_oB4+JqGX-Q@mail.gmail.com>
References: <4DB80747.8080401@op5.se>
	<BANLkTimUHrHqS-Ssj+mK=0T8QHKg34pkaw@mail.gmail.com>
	<4DB82D90.6060200@op5.se>
	<7vbozr8uo8.fsf@alter.siamese.dyndns.org>
	<7vpqo77dlr.fsf@alter.siamese.dyndns.org>
	<1303930175.25134.38.camel@drew-northup.unet.maine.edu>
	<20110427194233.GA16717@gnu.kitenet.net>
	<7vwrif5q93.fsf@alter.siamese.dyndns.org>
	<20110427220748.GA19578@elie>
	<7vsjt35l84.fsf@alter.siamese.dyndns.org>
	<20110427234224.GA26854@elie>
	<7viptz5j82.fsf@alter.siamese.dyndns.org>
	<BANLkTi=w0aKH6dxu84i4DjkL-vNCWQi8pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, Joey Hess <joey@kitenet.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 02:54:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFFVN-0004Rz-NJ
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 02:54:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755690Ab1D1Ayt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Apr 2011 20:54:49 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:44530 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752037Ab1D1Ays convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2011 20:54:48 -0400
Received: by eyx24 with SMTP id 24so677992eyx.19
        for <git@vger.kernel.org>; Wed, 27 Apr 2011 17:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=QDLpa9sMUcqNgafO0KpeCovqDLFpAFoOLPzs7/3M8xU=;
        b=i3Au82guavEYTloebG4DcSERODRiL0K4gSA/QRR+ilpDCVkgJTbmxH6Ro+SIyrZrf0
         /toZkbwHmbdStHdIkdxxt8HVRtkaaLHJmunGpByuncT7J/63JGJC73VvOMJaQ4PJWY9v
         AaRkl6bNpgeUaH/iHDPVNITvcSHp25T3P/OlM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=rPdjdmAVCKI8VS3r/qJr+CRFvHQpzinXMVlGD9BNeF4adKbtwGnoGO1WMLh09whir4
         tb1PerjNM+CBTCdkSMf7OzdTwuBoD9yGP9az9FCNX1iPqvPMcUbPEd7MYzjZ9V7nUthx
         5eqVLeFzxHLBnL5L1zU/st2uzgHMz07RAfBZY=
Received: by 10.14.50.15 with SMTP id y15mr1271800eeb.149.1303952086886; Wed,
 27 Apr 2011 17:54:46 -0700 (PDT)
Received: by 10.14.22.68 with HTTP; Wed, 27 Apr 2011 17:54:46 -0700 (PDT)
In-Reply-To: <BANLkTi=w0aKH6dxu84i4DjkL-vNCWQi8pw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172299>

On Thu, Apr 28, 2011 at 10:50 AM, Jon Seymour <jon.seymour@gmail.com> w=
rote:
> On Thu, Apr 28, 2011 at 10:10 AM, Junio C Hamano <gitster@pobox.com> =
wrote:
>> Jonathan Nieder <jrnieder@gmail.com> writes:
>>
>>> Right, my worry was based on the usual way programs find their way
>>> onto my $PATH. =C2=A0That is:
>>>
>>> =C2=A0- if they are installed via a package from the distro, they a=
re in
>>> =C2=A0 =C2=A0/usr/bin.
>>>
>>> =C2=A0- if they are installed with "make install" by the local sysa=
dmin for
>>> =C2=A0 =C2=A0all users, they are in /usr/local/bin.
>>>
>>> =C2=A0- if I am trying them out for myself, they are in $HOME/opt/f=
oo/bin
>>> =C2=A0 =C2=A0and when it is time to remove it, "rm -fr $HOME/opt/fo=
o".
>>>
>>> =C2=A0- if I have adopted them, symlinks go in $HOME/bin.
>>>
>>> With a local gcc-4.6 in $HOME/bin, if the sysadmin upgrades gcc so
>>> gcc-4.6 is to appear in /usr/bin or /usr/local/bin, my setup still
>>> works without trouble. =C2=A0So, barring bugs, each installation me=
thod
>>> does not interfere with the other ones.
>>>
>>> Call it overengineering, but I would want a way for installing new =
git
>>> commands to have the same attributes (installable by normal users i=
n
>>> multiuser systems and name conflicts not being a terrible
>>> administrative burden).
>>
>> Ok, I wasn't thinking about folks who use repackaged /usr/bin/git to=
gether
>> with their own choice of third-party enhancements.
>>
>> Probably we would be better off if we define a new set of paths that=
 is
>> independent from GIT_EXEC_PATH and friends. =C2=A0The installed git =
and nothing
>> else will occupy GIT_EXEC_PATH etc., but at the runtime, git would l=
ook at
>> a user-writable location GIT_PLUGIN_PATH/{bin,man,...} to see if the=
 user
>> has her own customization, and add them to its vocabulary.
>>
>> Or something like that. =C2=A0I am not all that interested, but it f=
eels like a
>> good direction.
>>
>
> I agree. Apologies for confusing things by talking too much about a
> git pm install command.
>
> I think there are 3 levels of functionality. FWIW, I am suggesting
> git-core stops at #2.
>
> 0. unmanaged plugins
>
> git doesn't provide any explicit management of plugins, but will use
> them if finds them.
>
> Without some kind of management, however, you will be forced to dump
> the man pages and scripts
> for the plugins in one place.
>
> This would be very distribution manager unfriendly since there could
> be conflicts galore.
>
> I guess an unmanaged solution could use separate directories for each
> plugin, but this would imply scanning all these paths each time you
> invoke git. In my view, symbolic links from a dir already
> GIT_EXEC_PATH to plugin directories would be a more efficient way to
> do this.
>
> 1. managed plugins
>
> git provides minimal plugin management functionality. Each plugin has
> its own directory, but an activate step is required to make the plugi=
n
> available to the GIT_EXEC_PATH and GIT_MAN_PATH.
>
> This has the advantage that conflicts between plugins would be more
> readily avoided and is potentially more performant. As Pau suggests,
> this option is much more package manager friendly
>
> It probably does require a git plugin command of some kind, however,
> in order to perform the activation step.
>
> 2. managed packages
>
> A meta-package manager for plugins, that delegates plugin installatio=
n
> concerns to a platform package manager.
>
> The thing is, you may absolutely hate #2, but if approach #1 is
> adopted by git-core, someone can at least attempt this by, well,
> writing a plugin for it.
>

Sorry, sorry/. git-core stops at #1!!

> jon.
>
