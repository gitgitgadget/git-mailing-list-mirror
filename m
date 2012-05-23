From: Andrew Sayers <andrew-git@pileofstuff.org>
Subject: Re: [PATCH][GIT.PM 2/3] Getting rid of throwing Error::Simple objects
 in favour of simple Perl scalars which can be caught in eval{} blocks
Date: Wed, 23 May 2012 20:36:13 +0100
Message-ID: <4FBD3C2D.3010107@pileofstuff.org>
References: <7vobpulhbk.fsf@alter.siamese.dyndns.org> <1337411317-14931-1-git-send-email-subs.zero@gmail.com> <1337411317-14931-2-git-send-email-subs.zero@gmail.com> <4FB76A21.7000801@pileofstuff.org> <CAB3zAY3nVDiBH6kJKK9YTXKsaFZZnUz7AAFh5z+J0VhXHjYiMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Subho Banerjee <subs.zero@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 23 21:36:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXHMM-0002YZ-OX
	for gcvg-git-2@plane.gmane.org; Wed, 23 May 2012 21:36:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934020Ab2EWTgf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 May 2012 15:36:35 -0400
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:28352 "EHLO
	mtaout01-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933930Ab2EWTgU (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 May 2012 15:36:20 -0400
Received: from aamtaout03-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout01-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20120523193618.NJEI10903.mtaout01-winn.ispmail.ntl.com@aamtaout03-winn.ispmail.ntl.com>;
          Wed, 23 May 2012 20:36:18 +0100
Received: from [192.168.0.2] (really [94.170.150.126])
          by aamtaout03-winn.ispmail.ntl.com
          (InterMail vG.3.00.04.00 201-2196-133-20080908) with ESMTP
          id <20120523193618.DOZT13318.aamtaout03-winn.ispmail.ntl.com@[192.168.0.2]>;
          Wed, 23 May 2012 20:36:18 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.28) Gecko/20120313 Thunderbird/3.1.20
In-Reply-To: <CAB3zAY3nVDiBH6kJKK9YTXKsaFZZnUz7AAFh5z+J0VhXHjYiMQ@mail.gmail.com>
X-Cloudmark-Analysis: v=1.1 cv=JvdXmxIgLJv2/GthKqHpGJEEHukvLcvELVXUanXFreg= c=1 sm=0 a=yXtjXN6ItgYA:10 a=dNJI9zxkJdgA:10 a=u4BGzq-dJbcA:10 a=8nJEP1OIZ-IA:10 a=3tnZ8uVCtx8Dmri_DA0A:9 a=wPNLvfGTeEIA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198318>

On 23/05/12 12:02, Subho Banerjee wrote:
> Hi,
> The semantic
>>        <fail> unless <noun>
> works well when the <fail> part of the code is a singular statement.
> But it is of ungainly when there are a couple of statements to be
> executed as a block. In this case, I believe that a the conjunctive
> ,,or''/,,and'' statement makes more sense. In the sense -
>                  <verb1> or <die_gracefully1> and <die_gracefully2>
> I believe this is easier to read compared to -
>                  <die_gracefully1> and <die_gracefully2> unless <noun>
> especially if you have a larger block of commands to execute in case
> of the failure. I believe the easiest to read would be a classical C
> styled if() block, but that would make the code more "verbose" :-)

To be honest, I drop straight back to C-style if() statements as soon as
I have to start thinking consciously about precedence rules (where by
"thinking" I mean "creating bugs then failing to see them under my
nose").  I also don't think anyone would object if you wanted to stick
with classic if() statements everywhere - colloquialisms are supported,
not required :)

So long as you're aware this is an exception to the rule about matching
the style of surrounding code, I'm personally quite relaxed about fixing
these specific instances.  If nobody else has any opinions, maybe hold
off and see how much change you're planning to make elsewhere?  No sense
getting too attached to code you might have to throw away.

	- Andrew
