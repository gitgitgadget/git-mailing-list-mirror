From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] On error, do not list all commands, but point to	--help
 option.
Date: Sun, 21 Oct 2007 16:17:30 +0200
Message-ID: <471B5F7A.6010303@op5.se>
References: <bqaujirk.fsf@blue.sea.net> <Pine.LNX.4.64.0710202126430.25221@racer.site> <odetifoh.fsf@blue.sea.net> <Pine.LNX.4.64.0710210001390.25221@racer.site> <20071021020653.GA14735@spearce.org> <ED3FFB7A-861F-47E4-97EA-D7A05552FC2C@wincent.com> <471B4931.5040102@op5.se> <20071021131351.GE8887@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Wincent Colaiuta <win@wincent.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jari Aalto <jari.aalto@cante.net>, git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Sun Oct 21 16:17:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ijbcl-00077N-7q
	for gcvg-git-2@gmane.org; Sun, 21 Oct 2007 16:17:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074AbXJUORg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Oct 2007 10:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751060AbXJUORg
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Oct 2007 10:17:36 -0400
Received: from mail.op5.se ([193.201.96.20]:32778 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751028AbXJUORf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2007 10:17:35 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id F127C173057E;
	Sun, 21 Oct 2007 16:17:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zX43OAXfTv7g; Sun, 21 Oct 2007 16:17:32 +0200 (CEST)
Received: from nox.op5.se (unknown [172.27.77.30])
	by mail.op5.se (Postfix) with ESMTP id 05728173057C;
	Sun, 21 Oct 2007 16:17:31 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <20071021131351.GE8887@efreet.light.src>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61903>

Jan Hudec wrote:
> On Sun, Oct 21, 2007 at 14:42:25 +0200, Andreas Ericsson wrote:
>> Wincent Colaiuta wrote:
>>> El 21/10/2007, a las 4:06, Shawn O. Pearce escribi=F3:
>>>> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>>>>>>> On Sat, 20 Oct 2007, Jari Aalto wrote:
>>>>>>>
>>>>>>>> - commented out call to list_common_cmds_help()
>>>>> Well, I'm almost sure of the opposite.  One of the big results of=
 the=20
>>>>> Git
>>>>> Survey was that git is still not user-friendly enough.  Your patc=
h would
>>>>> only make this issue worse.
>>>> Actually I think Jari's patch helps for the reason originally
>>>> stated in the message (less output when you make a small typo).
>>>> Though I agree that the commented out code should just be removed.
>>>>
>>>> I actually had to do `git config alias.upsh push` just to keep
>>>> myself from screaming every time I made a small typo and Git gave
>>>> me a screenful of "helpful reminders".
>>> If you want to go really user friendly, how about a check against t=
he list=20
>>> of known commands using a shortest-edit distance algorithm?
>> http://en.wikipedia.org/wiki/Levenshtein_distance
>>
>> Implementing the algorithm doesn't seem terribly difficult.
>=20
> That's not the correct algorithm (you need to consider transpozitions=
, so you
> need at least http://en.wikipedia.org/wiki/Damerau-Levenshtein_distan=
ce, but
> I would not think that's the easier, or faster, way to do it. Though =
this
> would have to be benchmarked -- calculating the edit distance is quad=
ratic,
> while generating the list of possibilities (and seeing whether they e=
xist) is
> linear, but with large constant. So the question is, whether we have =
few
> enough commands that the quadratic calculation might be faster.
>=20

It's intended to be used for strings of length 3-14, run through once w=
hen the
user has given bogus input. We're not gonna index databases here. Simpl=
icity
in the implementation almost certainly outweighs the performance penalt=
y of
doing it the stupid way.

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
