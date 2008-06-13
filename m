From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH 2/2] git-gc: skip stashes when expiring reflogs
Date: Fri, 13 Jun 2008 10:43:59 +0200
Message-ID: <0F87000C-B51E-45B8-A21D-1DA184BD603F@wincent.com>
References: <OLvkESB0JjBNs9kF8Q2M5UFNBJqq4FjbgGeQVyWstGwcXqCOq16_oomM0y-utOBbV7BnndyrICE@cipher.nrlssc.navy.mil>  <20080611213648.GA13362@glandium.org>  <alpine.DEB.1.00.0806112242370.1783@racer>  <20080611230344.GD19474@sigill.intra.peff.net>  <alpine.LFD.1.10.0806111918300.23110@xanadu.home>  <loom.20080612T042942-698@post.gmane.org>  <6413041E-A64A-4BF4-9ECF-F7BFA5C1EAEF@wincent.com>  <7vzlpqza0t.fsf@gitster.siamese.dyndns.org>  <279b37b20806121335p90a6d40qb39b73f71dae990b@mail.gmail.com>  <7vlk1az8aa.fsf@gitster.siamese.dyndns.org> <279b37b20806121436w4f09c8f7n1009ef2f77b66f87@mail.gmail.com> <alpine.DEB.1.00.0806130551200.6439@racer>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Raible <raible@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@cam.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 13 10:51:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K750V-0008IJ-K6
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 10:51:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754724AbYFMIuo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Jun 2008 04:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754700AbYFMIuo
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 04:50:44 -0400
Received: from wincent1.inetu.net ([209.235.192.161]:48906 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754673AbYFMIun convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Jun 2008 04:50:43 -0400
Received: from cuzco.lan (185.pool85-53-11.dynamic.orange.es [85.53.11.185])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id m5D8i0bl030983
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Fri, 13 Jun 2008 04:44:02 -0400
In-Reply-To: <alpine.DEB.1.00.0806130551200.6439@racer>
X-Mailer: Apple Mail (2.924)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84849>

El 13/6/2008, a las 6:52, Johannes Schindelin escribi=F3:

> Hi,
>
> On Thu, 12 Jun 2008, Eric Raible wrote:
>
>> On Thu, Jun 12, 2008 at 1:51 PM, Junio C Hamano <gitster@pobox.com> =
=20
>> wrote:
>>> Perhaps
>>>
>>> http://thread.gmane.org/gmane.comp.version-control.git/84665/focus=3D=
84670
>>>
>>> The user explicitly asks to stash it for a while, where the =20
>>> definition of
>>> the "while" comes from reflog's retention period.
>>
>> But that doesn't answer the basic question as to why it's ok
>> to trash data that the user explicitly asked git to save?
>
> If the user really asked git to save the changes, she would have
> _committed_ them.
>
> "git stash" really is only about shelving quickly and dirtily =20
> something
> you'll need (or maybe need) in a moment.
>
> If you need something from the stash a day after stashing it, you =20
> have a
> serious problem with understanding what branches are for.

While this may be true for codebases which move forward quickly, what =20
about one which is basically finished and tends not to get touched in =20
a long time. A situation arises, you stash something, the phone rings, =
=20
and for whatever reason the stash gets forgotten and you don't revisit =
=20
the project at all for days, weeks, months. It wouldn't be nice to =20
eventually come back and discover that your in-progress work had been =20
"garbage" collected for you.

Wincent
