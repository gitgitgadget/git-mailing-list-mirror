From: Andreas Ericsson <ae@op5.se>
Subject: Re: [Q] merging from one (kernel) stable to another?
Date: Mon, 30 Mar 2009 14:19:11 +0200
Message-ID: <49D0B8BF.2000502@op5.se>
References: <200903301024.08848.brian.foster@innova-card.com> <49D09207.9080407@op5.se> <49D0A133.80503@viscovery.net> <200903301358.48864.brian.foster@innova-card.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	git mailing list <git@vger.kernel.org>
To: Brian Foster <brian.foster@innova-card.com>
X-From: git-owner@vger.kernel.org Mon Mar 30 14:21:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoGU5-00083f-P9
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 14:20:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755479AbZC3MTL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Mar 2009 08:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752896AbZC3MTI
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 08:19:08 -0400
Received: from mail.op5.se ([193.201.96.20]:35780 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754089AbZC3MTH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 08:19:07 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 763331B80074;
	Mon, 30 Mar 2009 13:56:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QDoFrzDztfk8; Mon, 30 Mar 2009 13:56:26 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id D7AE31B80049;
	Mon, 30 Mar 2009 13:56:25 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <200903301358.48864.brian.foster@innova-card.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115142>

Brian Foster wrote:
> On Monday 30 March 2009 12:38:43 Johannes Sixt wrote:
>> Andreas Ericsson schrieb:
>>> A possibly better approach for you is to "git format-patch"
>>> your own changes and apply them to a clean 2.6.26.8 tree
>>> instead of trying to merge 2.6.26.8 into 2.6.21.
> [ I'm going from .21 to .26.8, so I think you've got that reversed? ]
>> After you have successfully done *that*, you know how the resulting
>> tree must look like, and you give it a tag, say "like-this".
>> If you really want to have a merge, then you can just repeat the
>> merge with your original branch, at which time you will get tons
>> of conflicts.  Now you just 'git checkout like-this -- .' and you
>> have all your conflicts resolved in the way you need them.
>=20
> Andreas & Hannes,
>=20
>   Thanks for the suggestion.  I'll have to experiment,
>  but off-the-top-of-my-head, I think I do want a merge,
>  so that it's easier to track the history of individual
>  local changes.  Having said that, I'm not entirely sure
>  I follow your suggestions.  What I think you mean is:
>=20
>   (1)  Create a patch which is all (local) changes
>          (n=E9e diffs) from linux-mips.21 to our.21;

This is wrong. Create several git-patches, each containing
the equivalence of one commit (complete with diff, author
info and commit message).

>   (2)  Checkout linux-mips.26.8 (e.g.);
>   (3)  Apply the patch created in (1), above;

Except it'll be "apply the patches, re-creating history
as if it had been done with a different base from the
start".

>   (4)  Tag the result `like-this';
>   (5)  Checkout our.21;  and
>   (6)  Merge with `like-this'.
>=20

Merge is not necessary.

>  I admit that now that I write the steps out, it seems
>  to make sense ....?   Am I understanding correctly?
>=20

Almost. "git help format-patch" and "git help am" will get
you the rest of the way, I think.

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
