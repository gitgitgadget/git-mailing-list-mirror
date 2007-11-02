From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] Add testcase for ammending and fixing author in git commit.
Date: Fri, 02 Nov 2007 15:33:26 -0700
Message-ID: <7vk5p0z39l.fsf@gitster.siamese.dyndns.org>
References: <1194017589-4669-1-git-send-email-krh@redhat.com>
	<7vy7dg1kdg.fsf@gitster.siamese.dyndns.org>
	<1194038030.25288.20.camel@hinata.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 23:33:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Io55J-0000DZ-Sl
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 23:33:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752870AbXKBWde convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Nov 2007 18:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752219AbXKBWdd
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 18:33:33 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:46718 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752204AbXKBWdd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Nov 2007 18:33:33 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 8DCC32F0;
	Fri,  2 Nov 2007 18:33:54 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 179EB91650;
	Fri,  2 Nov 2007 18:33:51 -0400 (EDT)
In-Reply-To: <1194038030.25288.20.camel@hinata.boston.redhat.com> (Kristian
	=?utf-8?Q?H=C3=B8gsberg's?= message of "Fri, 02 Nov 2007 17:13:50 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63186>

Kristian H=C3=B8gsberg <krh@redhat.com> writes:

>> This can't be right.  How are you ignoring the differences in
>> committer dates?
>
> t/test-lib.sh fixes GIT_COMMITTER_DATE so all commits have the date
>
> committer C O Mitter <committer@example.com> 1112911993 -0700
>
> unless you use test_tick.

Heh, that was actually what I was getting at.  By not doing
test_tick, you are not making sure that the commit gets the
timestamp of the time --amend is run.

>> By the way, I _think_ git-commit.sh allows fixing author name/email
>> without molesting the author timestamp (i.e. takes it from the
>> amended commit).  That should probably be checked with the test
>> as well.
>
> You're right, I need to pick GIT_AUTHOR_DATE from the ammended commit=
=2E
> Ok, I'll need to rewrite determine_author_info() a little bit.  I mig=
ht
> get an update patch out this weekend.
