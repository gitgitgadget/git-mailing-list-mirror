From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] Have a flag to stop the option parsing at the first argument.
Date: Mon, 17 Dec 2007 13:40:18 +0100
Message-ID: <26962818-F702-44D2-BD26-95D74CE21F0D@wincent.com>
References: <20071217095014.GF7453@artemis.madism.org> <30351C09-8BED-4D81-ABDD-2E079B4D54D2@wincent.com> <20071217114703.GH7453@artemis.madism.org> <Pine.LNX.4.64.0712171149540.9446@racer.site> <3CF3CEA5-72F1-47D1-ADB9-37F5C2E292A8@wincent.com> <Pine.LNX.4.64.0712171223210.9446@racer.site>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Dec 17 13:46:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4FMH-0001Fp-8T
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 13:46:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752510AbXLQMpr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Dec 2007 07:45:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752763AbXLQMpq
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 07:45:46 -0500
Received: from wincent.com ([72.3.236.74]:58156 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751528AbXLQMpq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Dec 2007 07:45:46 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lBHCeJI1021548;
	Mon, 17 Dec 2007 06:40:20 -0600
In-Reply-To: <Pine.LNX.4.64.0712171223210.9446@racer.site>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68559>

El 17/12/2007, a las 13:26, Johannes Schindelin escribi=F3:

> Hi,
>
> On Mon, 17 Dec 2007, Wincent Colaiuta wrote:
>
>> Yes, we know what it does because we know that "git ... log ..." is
>> actually two commands and each one handles one of the -p switches, =20
>> but
>> it is much easier to present git as a single tool to the newcomer =20
>> (and I
>> guess I don't need to argue that case here seeing as the decision ha=
s
>> already been taken long ago to talk using dashless forms), and it is
>> much easier to explain to a newcomer something like:
>>
>> git log --paginate -p
>>
>> Than:
>>
>> git -p log -p
>
> How about
>
> 	git log -p
>
> Hmm?
>
> Fact is: you make the tool easier by having sane defaults.  Not by =20
> moving
> around command line options.  The option "-p" for git is an option =20
> that
> holds for _all_ subcommands.  That's why it belongs _before_ the
> subcommand.
>
>> But it doesn't really matter. The proposed changes allow old-timers =
=20
>> to
>> continue putting their special options between the "git" and the
>> "command". If you don't want to deprecate the -p special because of =
=20
>> the
>> confusion it might cause, I think we should at least not give it a =20
>> very
>> prominent place in the documentation, nor use it any examples.
>
> I think it is wrong to go out of our way to support "git status -p" =20
> as a
> synonym to "git -p status".  I simply do not believe that newcomers =20
> are
> not intelligent enough to understand that "git -p <subcommand>" =20
> means that
> the output goes into their pager.

But the point is, of all the special options, -p is the *only* that =20
can't unambiguously go after the subcommand.

I'm arguing that the world would be a simpler place, friendlier to =20
newcomers if *all* git commands looked like "git subcommand opts...", =20
and at the moment -p is the only obstacle to making this so. And just =20
in case it's necessary to restate this, I am not proposing removing =20
support for the git specials subcommand opts..." form; I'm just trying =
=20
to make it so that we don't have to advertise it so prominently. This =20
seems to be the natural complement to the move to dashless forms.

Cheers,
Wincent
