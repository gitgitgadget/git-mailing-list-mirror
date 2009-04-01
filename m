From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: On git 1.6 (novice's opinion)
Date: Wed, 01 Apr 2009 09:41:09 +0200
Message-ID: <vpqhc18rfca.fsf@bauges.imag.fr>
References: <49CC8C90.12268.242CEFCE@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
	<49CCE520.17260.2586E134@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
	<49CCD90F.6090707@gmail.com>
	<49D32ABF.11569.30BC41@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Etienne Vallette d'Osia" <dohzya@gmail.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	"H.Merijn Brand" <h.m.brand@xs4all.nl>, git@vger.kernel.org
To: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
X-From: git-owner@vger.kernel.org Wed Apr 01 09:48:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LovBS-00081t-DG
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 09:48:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759678AbZDAHq4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Apr 2009 03:46:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756505AbZDAHqz
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 03:46:55 -0400
Received: from harmonie.imag.fr ([147.171.130.40]:33206 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753918AbZDAHqy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2009 03:46:54 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id n317fCZN006262;
	Wed, 1 Apr 2009 09:41:12 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Lov4P-0006KO-47; Wed, 01 Apr 2009 09:41:09 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Lov4P-00076L-1i; Wed, 01 Apr 2009 09:41:09 +0200
In-Reply-To: <49D32ABF.11569.30BC41@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de> (Ulrich Windl's message of "Wed\, 01 Apr 2009 08\:50\:07 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Wed, 01 Apr 2009 09:41:13 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115348>

"Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de> writes:

> On 27 Mar 2009 at 14:47, Etienne Vallette d'Osia wrote:
>
>> Ulrich Windl a =E9crit :
>> > AFAIK, "committing" in git is "kind of publishing your work" (othe=
rs may pull it).=20
>> > I don't like publishing my mistakes ;-) Even if no-one pulls the c=
ommit, your=20
>> > "undo" refers to "committing a fix for the last committed mistake"=
, right? Again,=20
>> > I don't really want to document/archive (i.e. commit) my mistake. =
Or did I miss=20
>> > something here?
>> > I know: Other's opinions are quite different on these issues.
>>=20
>> commit is local.
>
> I had made the experience that you can "pull" from a local directory =
(unless=20
> permissions forbid it). As I can't control what others are doing, a "=
commit" is=20
> still more or less making the results public (unless you can convince=
 me that=20
> 	I'm wrong). OK, I grew up with servers that host hundreds of users, =
not with=20
> having my own laptop...

Multi-users server, or NFS-shared $HOME, yes, expose every working
tree and therefore directories to other users. But still, the good
practice would be to distinguish your working area, and a "clean"
area if you want to get all the power of distributed version control.

One of the main points in having version control distributed is
precisely to allow you to distinguish private things and published
ones (i.e. commit !=3D push). Linus explains this better than I do in
his talk:

  http://www.youtube.com/watch?v=3D4XpnKHJAok8

You _can_ expose your working tree directly to others, but if you do
so, you'll have to forget about "git commit --amend",=20
"git reset <anything-else-than-HEAD>", "git rebase",=20
"git filter-branch", ... (any history-editing feature of Git indeed).

OTOH, the common setup for people is to have a workstation (laptop or
desktop) without a public access (for example, my home computer is
switched of when I'm not using it, and my office station is only
reachable from outside with ssh), and to publish things on another
server. So, in the common case, the distinction private/public is
natural.

--=20
Matthieu
