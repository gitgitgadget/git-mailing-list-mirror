From: Junio C Hamano <gitster@pobox.com>
Subject: Re: branch.<branch>.merge and --format='%(upstream)'
Date: Tue, 16 Jun 2009 08:46:32 -0700
Message-ID: <7v7hzcdvvr.fsf@alter.siamese.dyndns.org>
References: <adf1fd3d0906160408s668f7a3fj5725cc4e98b317fc@mail.gmail.com>
	<20090616122312.GB5227@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Santi =?utf-8?Q?B=C3=A9jar?= <santi@agolina.net>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 16 17:46:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGary-0004iH-UT
	for gcvg-git-2@gmane.org; Tue, 16 Jun 2009 17:46:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754843AbZFPPqc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Jun 2009 11:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753773AbZFPPqb
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jun 2009 11:46:31 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:44313 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753381AbZFPPqb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2009 11:46:31 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090616154632.UCKF25927.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Tue, 16 Jun 2009 11:46:32 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id 4fmZ1c0034aMwMQ03fmZ73; Tue, 16 Jun 2009 11:46:33 -0400
X-VR-Score: -200.00
X-Authority-Analysis: v=1.0 c=1 a=dvchac0stc0A:10 a=PKzvZo6CAAAA:8
 a=2aWxOXLf1nzaj67AxpAA:9 a=0_AtEUG2xQHMdjeAXjm7fO5yxQsA:4 a=OdWmie4EkE0A:10
X-CM-Score: 0.00
In-Reply-To: <20090616122312.GB5227@coredump.intra.peff.net> (Jeff King's message of "Tue\, 16 Jun 2009 08\:23\:12 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121685>

Jeff King <peff@peff.net> writes:

> On Tue, Jun 16, 2009 at 01:08:02PM +0200, Santi B=C3=A9jar wrote:
>
>>   I've noticed that having branch.<branch>.merge set with the branch
>> name, and not with the full ref, cause problems with
>> --format=3D'%(upstream)'  and also with the "branch -av" and "git
>> status" upstream branch outputs. But git-fetch and git-pull works ok=
,
>> so it is a valid setting.
>
> Actually, it is broken in a lot of places. for-each-ref relies on the
> same code as "git status", "git checkout", etc, which will all fail t=
o
> display tracking info. I believe the same code is also used for updat=
ing
> tracking branches on push. So I'm not sure if it was ever intended to=
 be
> a valid setting.

It wasn't.  Some places may accept them gracefully by either being extr=
a
nice or by accident.
