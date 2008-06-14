From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH 2/2] git-gc: skip stashes when expiring reflogs
Date: Sat, 14 Jun 2008 10:58:58 +0200
Message-ID: <612BAE20-8DF3-4323-8AEF-527B92122A7A@wincent.com>
References: <OLvkESB0JjBNs9kF8Q2M5UFNBJqq4FjbgGeQVyWstGwcXqCOq16_oomM0y-utOBbV7BnndyrICE@cipher.nrlssc.navy.mil>  <20080611213648.GA13362@glandium.org>  <alpine.DEB.1.00.0806112242370.1783@racer>  <20080611230344.GD19474@sigill.intra.peff.net>  <alpine.LFD.1.10.0806111918300.23110@xanadu.home>  <loom.20080612T042942-698@post.gmane.org>  <6413041E-A64A-4BF4-9ECF-F7BFA5C1EAEF@wincent.com>  <7vzlpqza0t.fsf@gitster.siamese.dyndns.org>  <279b37b20806121335p90a6d40qb39b73f71dae990b@mail.gmail.com>  <7vlk1az8aa.fsf@gitster.siamese.dyndns.org> <279b37b20806121436w4f09c8f7n1009ef2f77b66f87@mail.gmail.com> <alpine.DEB.1.00.0806130551200.6439@racer> <0F87000C-B51E-45B8-A21D-1DA184BD603F@wincent.com> <alpine.DEB.1.00.0806132239490.6439@racer>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Raible <raible@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@cam.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jun 14 11:01:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7Rcw-00017E-5o
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 11:00:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754175AbYFNI70 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Jun 2008 04:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754157AbYFNI70
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 04:59:26 -0400
Received: from wincent1.inetu.net ([209.235.192.161]:40426 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754155AbYFNI7Y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Jun 2008 04:59:24 -0400
Received: from cuzco.lan (185.pool85-53-11.dynamic.orange.es [85.53.11.185])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id m5E8wwIE031177
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sat, 14 Jun 2008 04:59:01 -0400
In-Reply-To: <alpine.DEB.1.00.0806132239490.6439@racer>
X-Mailer: Apple Mail (2.924)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84991>

El 13/6/2008, a las 23:41, Johannes Schindelin escribi=F3:

> Hi,
>
> On Fri, 13 Jun 2008, Wincent Colaiuta wrote:
>
>> El 13/6/2008, a las 6:52, Johannes Schindelin escribi=F3:
>>
>>> If you need something from the stash a day after stashing it, you =20
>>> have
>>> a serious problem with understanding what branches are for.
>>
>> While this may be true for codebases which move forward quickly, wha=
t
>> about one which is basically finished and tends not to get touched =20
>> in a
>> long time. A situation arises, you stash something, the phone =20
>> rings, and
>> for whatever reason the stash gets forgotten and you don't revisit =20
>> the
>> project at all for days, weeks, months. It wouldn't be nice to
>> eventually come back and discover that your in-progress work had bee=
n
>> "garbage" collected for you.
>
> You cannot be serious about not wanting to lose the changes when you =
=20
> keep
> them in _one_ _single_ repository anyway.
>
> And you cannot be serious about not wanting to lose the changes when =
=20
> you
> forget about them, for months, even.
>
> So you are making my point for me.

Your arguments are _totally_ spurious.

With respect to your first point, I didn't even mention repository =20
duplication and backups so I don't know why you tried to inject it =20
into the discussion. I am _completely_ serious about preserving my =20
data in the repos I work on, and that's why I do automated backups of =20
the home directory which contains all of my local working repos every =20
two hours (ie 12 times per day), plus an automated whole-disk backup =20
once every 24 hours. However, my point about "git stash" is completely =
=20
independent of my backup regimen; the backup regimen exists to protect =
=20
me against disk and system failures, not to protect me from my SCM.

And on your second point, you are arguing that anything you can't =20
remember isn't worth keeping, which just isn't a sustainable argument. =
=20
Can you remember the thousands of commits in Git's complete history? =20
Would it be okay to just throw away the changes you've forgotten about?

So I don't think I've made your point for you at all; it remains for =20
you to make it for yourself. But it seems to me that you are arguing =20
against the sizeable majority of participants on this thread which has =
=20
already dragged on too long.

So, let's recap:

(1) It is reasonable to expect, and in fact it is clear that most =20
users _do_ expect, that Git should indefinitely remember changes that =20
they told it to remember with "git stash save"

(2) The people largely responsible for the implementation of "git =20
stash" never envisaged its use for long term storage (either =20
intentional abuse of "stash", or inadvertent misuse) and architected =20
it in such a way that it can "forget" stashes after a period of time

So far you've only attacked the first point, and your defense of the =20
second point has consisted of nothing more than an affirmation that =20
the status quo should remain in place because that's the way it's =20
always been. I haven't yet heard any explanation of _why_ it's such a =20
big deal to adjust the behaviour of the tool to match user =20
expectations, expectations created partly by poor documentation but =20
mostly by an unfortunate choice of name for the "stash" command.

We have a choice: re-educate users or modify the tool, and re-=20
education seems of questionable value (for what?) and much more =20
difficult than the latter, which has next to no cost at all. Modify =20
the tool and we won't have to re-educate users: those who abuse "git =20
stash" for long term storage will soon figure out that they're not =20
using it in the best possible way when their stash list gets out of =20
hand, and as an added bonus nobody will ever get burnt by Git throwing =
=20
away something that they thought it should have kept.

An auto-expiration config variable should be enough to keep people =20
like you happy, as you'll get to keep your auto-garbage-collected =20
stash list, but the auto-expiration should be _off_ by default because =
=20
it's best to err on the conservative side about throwing out data. =20
Especially in a case like this one where it is clearly demonstrated =20
that most people are surprised to learn that Git garbage collects old =20
stashes.

Anyway, I've now stated and restated these arguments enough times and =20
I don't think I have anything to add.

Wincent
