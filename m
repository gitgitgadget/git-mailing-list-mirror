From: David Kastrup <dak@gnu.org>
Subject: Re: Git reset --hard with staged changes
Date: Tue, 10 Jun 2014 17:27:26 +0200
Message-ID: <871tuwss2p.fsf@fencepost.gnu.org>
References: <CANWD=rWmzgAwTp=E_1=th0Myk-dh4m5Y9PE3=fpHeirsVVQKwQ@mail.gmail.com>
	<CANWD=rX-MEiS4cNzDWr2wwkshz2zu8-L31UrKwbZrJSBcJX-nQ@mail.gmail.com>
	<87vbsayy9w.fsf@fencepost.gnu.org>
	<CANWD=rVB249Vu1QMk64V+FxfCfJPzxqZgCfyEuixJJ_iKoTLPQ@mail.gmail.com>
	<xmqq61k9d5nk.fsf@gitster.dls.corp.google.com>
	<CANWD=rUz9Wgoktp7-NkQMvWDmYOPv0kMqUNoe4FPJ9+Ax_UJBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?iso-8859-1?Q?Pierre-Fran=E7ois?= CLEMENT <likeyn@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 17:27:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuNxo-0007Fk-85
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 17:27:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751783AbaFJP1s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Jun 2014 11:27:48 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:43270 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750969AbaFJP1r convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jun 2014 11:27:47 -0400
Received: from localhost ([127.0.0.1]:42310 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WuNxi-00088c-AO; Tue, 10 Jun 2014 11:27:46 -0400
Received: by lola (Postfix, from userid 1000)
	id BED43E09B2; Tue, 10 Jun 2014 17:27:26 +0200 (CEST)
In-Reply-To: <CANWD=rUz9Wgoktp7-NkQMvWDmYOPv0kMqUNoe4FPJ9+Ax_UJBA@mail.gmail.com>
	(=?iso-8859-1?Q?=22Pierre-Fran=E7ois?= CLEMENT"'s message of "Tue, 10 Jun
 2014 16:59:19
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251197>

Pierre-Fran=E7ois CLEMENT <likeyn@gmail.com> writes:

> 2014-06-10 1:28 GMT+02:00 Junio C Hamano <gitster@pobox.com>:
>> Pierre-Fran=E7ois CLEMENT <likeyn@gmail.com> writes:
>>
>>> Hm, I didn't think of "git apply --index"... Makes sense for this
>>> special use, but I'm not sure about the other use cases.
>>
>> Try merging another branch that tracks a file your current branch
>> does not know about and ending up with conflicts during that merge.
>> Resetting the half-done result away must remove that new path from
>> your working tree and the index.
>
> Hm I see. Even though the documentation doesn't make it very clear
> about what happens to such files, it turns out the scenario we
> stumbled upon seems to be the special use case after all. Thanks for
> shedding some light on this :) I wonder why does git-reset's hard mod=
e
> not always remove untracked files then?

Because it never removes them?  Git only removes files once it tracks
them.  This includes the operation of removing _and_ untracking them,
like with git reset --hard.

The only command which explicitly messes with untracked files is
git-clean.

--=20
David Kastrup
