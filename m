From: Laszlo Papp <djszapi@archlinux.us>
Subject: Re: [PATCH 1/1] Use GIT_ASKPASS environment to launch thirdpart UI 
	app to get password
Date: Thu, 25 Feb 2010 18:15:21 +0100
Message-ID: <a362e8011002250915l7e42beel316878b60899c440@mail.gmail.com>
References: <1266923463-2828-1-git-send-email-lznuaa@gmail.com>
	 <20100224051307.GA3232@gmail.com>
	 <1976ea661002240013j164fc875o469c0dcdf74afe0c@mail.gmail.com>
	 <20100225091500.GB2903@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Frank Li <lznuaa@gmail.com>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 18:15:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkhJD-0000wj-Jl
	for gcvg-git-2@lo.gmane.org; Thu, 25 Feb 2010 18:15:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932877Ab0BYRPZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Feb 2010 12:15:25 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:47096 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932681Ab0BYRPY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Feb 2010 12:15:24 -0500
Received: by gwj16 with SMTP id 16so1818401gwj.19
        for <git@vger.kernel.org>; Thu, 25 Feb 2010 09:15:22 -0800 (PST)
Received: by 10.101.184.37 with SMTP id l37mr2152441anp.145.1267118121980; 
	Thu, 25 Feb 2010 09:15:21 -0800 (PST)
In-Reply-To: <20100225091500.GB2903@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141056>

On Thu, Feb 25, 2010 at 10:15 AM, David Aguilar <davvid@gmail.com> wrot=
e:
> On Wed, Feb 24, 2010 at 04:13:01PM +0800, Frank Li wrote:
>>
>> > Many users already have SSH_ASKPASS defined. =A0It would be very
>> > nice if we supported SSH_ASKPASS as a fallback when GIT_ASKPASS
>> > is not provided.
>> >
>>
>> I consider add such fallback at git.c. =A0when user use git svn, =A0=
git
>> main program will be called firstly.
>> git main entry will check if GIT_ASKPASS and SSH_ASKPASS, if
>> SSH_ASKPASS set but GIT_ASKPASS not set,
>> GIT_ASKPASS will be set as SSH_ASKPASS.
>>
>> Do you think we needs add such check at git-svn.perl ?
>>
>> best regards
>> Frank Li
>
> Interesting question. =A0I had never thought of moving the
> fallback to git.
>
> I would have done it in the script as a localized fix but
> I definately see the value in aiding scripts from
> all having to implement this same fallback, though:
>
> =A0 =A0 =A0 =A0$ENV{GIT_ASKPASS} ||=3D $ENV{SSH_ASKPASS};
>
> If Junio, Eric, and the git list think that this should
> live in git instead then by all means.
>
> --
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0David
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>

I don't think localized fix in every scripts, third party application
is the good and the trivial solution for this issue. I'm just a simple
TortoiseGIT user, but I guess other GUIs, frontends suffer from this
problem too.

Best Regards,
Laszlo Papp
