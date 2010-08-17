From: Charles Bailey <charles@hashpling.org>
Subject: Re: Conflict markers in mergetool $LOCAL ?
Date: Tue, 17 Aug 2010 22:24:25 +0100
Message-ID: <4C6AFE09.5020302@hashpling.org>
References: <loom.20100817T054731-955@post.gmane.org> <20100817093008.GA26357@gmail.com> <loom.20100817T185804-167@post.gmane.org> <f595ee73-b1a3-4797-bf55-20c0f1b309e0@email.android.com> <loom.20100817T230158-934@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Seth House <seth@eseth.com>
X-From: git-owner@vger.kernel.org Tue Aug 17 23:24:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlTe4-0002O2-3O
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 23:24:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751069Ab0HQVY0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Aug 2010 17:24:26 -0400
Received: from relay.ptn-ipout01.plus.net ([212.159.7.35]:59870 "EHLO
	relay.ptn-ipout01.plus.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750746Ab0HQVYZ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Aug 2010 17:24:25 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av0EAJOaakxUXeb0/2dsb2JhbACDGJ0mca47kiSBIoMicwQ
Received: from outmx03.plus.net ([84.93.230.244])
  by relay.ptn-ipout01.plus.net with ESMTP; 17 Aug 2010 22:24:23 +0100
Received: from hashpling.plus.com ([212.159.69.125])
	 by outmx03.plus.net with esmtp (Exim) id 1OlTdv-0008Ed-3j; Tue, 17 Aug 2010 22:24:23 +0100
Received: from heisenberg2.hashpling.org ([192.168.76.29])
	by hashpling.plus.com with esmtps (TLSv1:CAMELLIA256-SHA:256)
	(Exim 4.72)
	(envelope-from <charles@hashpling.org>)
	id 1OlTdu-0001q7-T1; Tue, 17 Aug 2010 22:24:22 +0100
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-GB; rv:1.9.2.8) Gecko/20100802 Thunderbird/3.1.2
In-Reply-To: <loom.20100817T230158-934@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153781>

On 17/08/2010 22:04, Seth House wrote:
> Jacob Helwig<jacob.helwig<at>  gmail.com>  writes:
>> That actually looks exactly like it should.  The order of the window=
s
>> that vimdiff uses is (IIRC): ours, on-disk file, theirs.
>
> Hm, you=E2=80=99re right. I just found the git-mergetool--lib script =
on my
> system and it opens vimdiff with $LOCAL $MERGED $REMOTE. Thank you, t=
hat
> opened my eyes enough to clarify my question:
>
> The conflict markers don't seem very useful in the context of a merge
> tool. I would prefer to see two windows in vimdiff with each side of =
the
> conflict, respectively. Something like:
>
> vimdiff $MERGED-left-hand-conflicts $MERGED-right-hand-conflicts
>
> Is that possible with Git -- or does anyone know of external tools to
> help with such a workflow?

I think that your problem is mainly with vimdiff, not with mergetool. O=
r=20
perhaps the way they interact. Although I'm a heavy vim user I don't=20
really get on with vimdiff as a merge tool. Most 3-way merge tools use=20
BASE, LOCAL and REMOTE to allow a good semi-automatic conflict=20
resolution to be performed. vimdiff is used by mergetool as a two-way=20
diff tool with an extra edit pane; it's not quite the same thing.

The conflict markers have been but into the target file by merge before=
=20
mergetool even starts and mergetool considers the target file to be an=20
output only.

I personally have used and would recommend kdiff3 and the Perforce=20
visual merge tool with git. Can I suggest you try a different mergetool=
=20
to see if you works better for you?

Charles.
