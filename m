From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH 2/4] Teach git-add--interactive to accept a file path to patch
Date: Thu, 22 Nov 2007 11:44:54 +0100
Message-ID: <887C3CB1-D21B-4143-8D4E-BF37709FA102@wincent.com>
References: <1195648601-21736-1-git-send-email-win@wincent.com> <1195648601-21736-2-git-send-email-win@wincent.com> <1195648601-21736-3-git-send-email-win@wincent.com> <20071121152118.GG24108@sigill.intra.peff.net> <7vejejfi28.fsf@gitster.siamese.dyndns.org> <C6E820C8-91E9-48B2-9219-377CA83163A7@wincent.com> <7vk5obb09a.fsf@gitster.siamese.dyndns.org> <20071122091356.GD7153@sigill.intra.peff.net> <7v8x4q7gns.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 22 11:45:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iv9Yg-0004ZE-PQ
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 11:45:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751993AbXKVKpF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Nov 2007 05:45:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751960AbXKVKpE
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 05:45:04 -0500
Received: from wincent.com ([72.3.236.74]:57220 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751528AbXKVKpD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Nov 2007 05:45:03 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lAMAitDL010843;
	Thu, 22 Nov 2007 04:44:56 -0600
In-Reply-To: <7v8x4q7gns.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65779>

El 22/11/2007, a las 10:50, Junio C Hamano escribi=F3:

> Jeff King <peff@peff.net> writes:
>
>> On Wed, Nov 21, 2007 at 04:18:57PM -0800, Junio C Hamano wrote:
>>
>>> What I meant was that if "git add -i" (unrestricted) shows paths
>>> from a set A, "git add -i paths..." should show paths from a
>>> subset of the set A and that subset should be defined with the
>>> existing ls-files pathspec semantics.
>>
>> Ah, I think that is definitely the right behavior. But it does =20
>> raise one
>> more question: is going right into the 'add hunk' interface the =20
>> correct
>> behavior, or is that an orthogonal issue?
>
> I am moderately negative about "paths imply jump to patch
> subcommand".  An option to git-add--interactive that tells which
> subcommand to initially choose is probably acceptable, though.

Let me explain a little why I started this series. Basically, given =20
file "foo" which had multiple changes in it I wanted to stage only =20
selected hunks; so I typed:

	git add -i foo

Which of course didn't work. What I wanted to do was jump straight =20
into the patch subcommand (hence this series).

If I wanted to add entire files I would have just typed:

	git add foo

So I don't think the proposal to add "-p" (jump to "patch" subcommand) =
=20
and "-a" (jump to "add untracked" subcommand) are a very good idea, =20
seeing as we already have builtin-add for adding entire files.

Cheers,
Wincent
