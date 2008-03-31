From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Silence cpio's "N blocks" output when cloning locally
Date: Sun, 30 Mar 2008 17:19:04 -0700
Message-ID: <7v1w5rwxs7.fsf@gitster.siamese.dyndns.org>
References: <1206685186-10352-1-git-send-email-bdonlan@fushizen.net>
 <alpine.LSU.1.00.0803281400330.18259@racer.site>
 <2145F4A8-7C6E-4AE9-A531-026DC65417BE@wincent.com>
 <alpine.LSU.1.00.0803281728530.18259@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Wincent Colaiuta <win@wincent.com>,
	Bryan Donlan <bdonlan@fushizen.net>, git@vger.kernel.org,
	gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 31 02:20:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jg7l2-0004fe-1r
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 02:20:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751713AbYCaATW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Mar 2008 20:19:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752510AbYCaATW
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Mar 2008 20:19:22 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41726 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751661AbYCaATW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Mar 2008 20:19:22 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 70BDF1C5B;
	Sun, 30 Mar 2008 20:19:20 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id B30511C58; Sun, 30 Mar 2008 20:19:13 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78535>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Fri, 28 Mar 2008, Wincent Colaiuta wrote:
>
>> El 28/3/2008, a las 14:01, Johannes Schindelin escribi=C3=B3:
>>=20
>> >On Fri, 28 Mar 2008, Bryan Donlan wrote:
>> >
>> > >Pass --quiet to cpio in git-clone to hide the (confusing) "0 bloc=
ks"=20
>> > >message. For compatibility with operating systems which might not=
=20
>> > >support GNUisms, the presence of --quiet is probed for by greppin=
g=20
>> > >cpio's --help output.
>> >
>> >We have a builtin clone which is almost ready for 'next', and I thi=
nk=20
>> >that this issue would be resolved there anyway.
>>=20
>> In any case, I'd rather see the cpio check at configure-time rather =
than=20
>> run-time.
>
> That would have to be done via ./configure, missing out those people =
who=20
> do not run ./configure, but just make.

Runtime is just fine for this case.  Unlike other commands, clone is no=
t
something you run all the time.  Anything more elaborate is just
overengineered.
