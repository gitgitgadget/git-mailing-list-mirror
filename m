From: Phil Hord <phil.hord@gmail.com>
Subject: Re: 'git branch' when origin branch with same name exists
Date: Tue, 19 Jun 2012 19:21:31 -0400
Message-ID: <CABURp0p6Hv8=Yg1MNb_DMRM3D2JWZtGNwn_GiOfP_x3MctrJ9A@mail.gmail.com>
References: <4FE091FB.7020202@desrt.ca> <87a9zztdxt.fsf@thomas.inf.ethz.ch>
 <7v8vfj17de.fsf@alter.siamese.dyndns.org> <4FE0E493.1010308@desrt.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Ryan Lortie <desrt@desrt.ca>
X-From: git-owner@vger.kernel.org Wed Jun 20 01:22:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sh7kE-0002WY-4t
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 01:21:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755131Ab2FSXVx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Jun 2012 19:21:53 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:46937 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750814Ab2FSXVv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Jun 2012 19:21:51 -0400
Received: by obbtb18 with SMTP id tb18so10698390obb.19
        for <git@vger.kernel.org>; Tue, 19 Jun 2012 16:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=N6QWEDB2KP+SGoJV8znXEO1VyfFkscPBxXC3JDZRAsQ=;
        b=gbc+Q1hi9zYzIbEW70dzFURyHyJEs4oOf6PBPj2ZcTDsd4cvo3aKlq6d5SgUashkuD
         NwA/ePRzzfTxAatJju5jwbnA03XWMZRAV6nPSfFSLYUjFmY/0UFN2WVjCy0XSnVnCHsc
         TBdr82C11WR0lUjAcFqMh09bE11m/MaDoWDEaAGvBwKkwHMrkwapQT8SrcCiAxNef5uu
         uPmFnbAEsrwaUySDIOzviXbU+w+WXrBhC+qfUluXWdLDQFJL98LH26nZDrTEWKNSCso8
         U9uIQuAprPhPPyihgv0TpGmkEKPu3YSK15JHB33HiJiEiTH15qIXf2fbFBR2jwmKQO+M
         md9A==
Received: by 10.182.43.33 with SMTP id t1mr21914600obl.24.1340148111265; Tue,
 19 Jun 2012 16:21:51 -0700 (PDT)
Received: by 10.182.111.99 with HTTP; Tue, 19 Jun 2012 16:21:31 -0700 (PDT)
In-Reply-To: <4FE0E493.1010308@desrt.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200264>

On Tue, Jun 19, 2012 at 4:44 PM, Ryan Lortie <desrt@desrt.ca> wrote:
> hi,
>
>
> On 12-06-19 02:31 PM, Junio C Hamano wrote:
>>
>> But I do not think "git branch" can sensibly and
>> correctly make that decision for the user---at least I do not sense
>> any of the people who is in this thread has clear idea on what to
>> base that decision on, and "the same name appears in an existing
>> remote" is not it. =A0"The same name appears, and the new branch is
>> not set to integrate with it" may be closer, but that may forbid
>> valid use cases too much.
>
>
> My originally intended point was that it should be prevented in the c=
ase
> where 'git branch' is given no additional arguments (ie: implicitly c=
reating
> the branch from HEAD). =A0Obviously it should be possible to create a
> 'gtk-3-4' branch that is based on the origin one. =A0In any case, I s=
hould
> have made that more clear.
>
> So to restate the feature request more clearly: "git branch X" with n=
o
> explicitly specified start-point should prevent the branch "X" from b=
eing
> created when a branch with the same name already exists on a remote (=
perhaps
> only considering 'origin').

I'll second the suggestion to offer advice to a user who does this,
possibly even including "undo" commands in case it was a mistake.  But
Junio is right, of course, that the request that this "should prevent"
the action it previously explicitly did -- as documented, even --  is
a non-starter.  Aside from the user interaction problem, it will also
break scripts in ways that may go undetected until they wreak nasty
havoc on some unsuspecting git robot.

Maybe you can suggest the advice verbiage which you think would have
helped this user.

Phil
