From: konglu@minatec.inpg.fr
Subject: Re: [PATCHv6 4/4] status: better advices when splitting a commit
 (during rebase -i)
Date: Tue, 05 Jun 2012 11:13:07 +0200
Message-ID: <20120605111307.Horde.-xsEEHwdC4BPzc2jJ-GgdjA@webmail.minatec.grenoble-inp.fr>
References: <1338477344-15940-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1338748217-16440-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1338748217-16440-4-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <CABURp0pD-QuAsDAJXnQXn3sTLb__maw0Mc30PHhduTZ9YOB1FQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kong Lucien <Lucien.Kong@ensimag.imag.fr>, git@vger.kernel.org,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>,
	Nguyen Huynh Khoi Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Moy Matthieu <Matthieu.Moy@grenoble-inp.fr>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 05 11:13:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbppC-00035n-Ua
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 11:13:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752721Ab2FEJNL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Jun 2012 05:13:11 -0400
Received: from v-smtp.minatec.grenoble-inp.fr ([147.173.216.28]:57500 "EHLO
	v-smtp.minatec.grenoble-inp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752494Ab2FEJNK (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Jun 2012 05:13:10 -0400
Received: from localhost (www02.minatec.grenoble-inp.fr [147.173.216.15])
	by v-smtp.minatec.grenoble-inp.fr (Postfix) with ESMTP id 734F81A02DB;
	Tue,  5 Jun 2012 11:13:07 +0200 (CEST)
Received: from wifi-030006.grenet.fr (wifi-030006.grenet.fr [130.190.30.6])
 by webmail.minatec.grenoble-inp.fr (Horde Framework) with HTTP; Tue, 05 Jun
 2012 11:13:07 +0200
In-Reply-To: <CABURp0pD-QuAsDAJXnQXn3sTLb__maw0Mc30PHhduTZ9YOB1FQ@mail.gmail.com>
User-Agent: Internet Messaging Program (IMP) H4 (5.0.17)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199224>


Phil Hord <phil.hord@gmail.com> a =E9crit=A0:

> On Sun, Jun 3, 2012 at 2:30 PM, Kong Lucien =20
> <Lucien.Kong@ensimag.imag.fr> wrote:
>> Add new informative help messages at the output of 'git status' when
>> the user is splitting a commit. The code figures this state by
>> comparing the contents of the following files in the .git/ directory=
:
>> =A0 =A0 =A0 =A0 =A0- HEAD
>> =A0 =A0 =A0 =A0 =A0- ORIG_HEAD
>> =A0 =A0 =A0 =A0 =A0- rebase-merge/amend
>> =A0 =A0 =A0 =A0 =A0- rebase-merge/orig-head
>>
>> Signed-off-by: Kong Lucien <Lucien.Kong@ensimag.imag.fr>
>> Signed-off-by: Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>
>> Signed-off-by: Jonas Franck <Franck.Jonas@ensimag.imag.fr>
>> Signed-off-by: Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>
>> Signed-off-by: Nguyen Huynh Khoi Nguyen =20
>> <Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
>> Signed-off-by: Moy Matthieu <Matthieu.Moy@grenoble-inp.fr>
>> ---
>> The second test added by this patch fails because the case in which
>> the user amend the last commit through rebase -i is not taken care o=
f.
>> We infer that the user would directly run "git commit --amend" inste=
ad
>> of amending it with a rebase -i.
>
>
> Maybe this is safe and logical for most workflows, or maybe this is a
> convenience that makes this patch possible (I did not read the patch
> yet).  But I know that I sometimes use rebase-i instead of
> commit--amend because I did not realize the patch I am fixing is the
> most recent one until after continuing, or because the patch I am
> amending was moved into the most-recent position during the rebase-i
> itself.

Right, This case has to be taken care of. It will need some work as
it's quite difficult to distinguish the current state after doing
a reset HEAD^ or doing a commit --amend when the rebase-merge/amend
is set on the last commit.
