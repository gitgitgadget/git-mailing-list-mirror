From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] test-suite: adding a test for fast-export with tag 
 variants
Date: Sun, 22 Mar 2009 20:41:26 -0700
Message-ID: <7vy6uw9a8p.fsf@gitster.siamese.dyndns.org>
References: <1237758620-6116-1-git-send-email-kusmabite@gmail.com>
 <7vfxh59in9.fsf@gitster.siamese.dyndns.org>
 <40aa078e0903221755n23457ba6m689aad34c0ec8214@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Erik Faye-Lund <kusmabite@gmail.com>, git@vger.kernel.org
To: Erik Faye-Lund <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Mar 23 04:45:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Llb6h-0000XT-In
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 04:45:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754792AbZCWDlf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Mar 2009 23:41:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753646AbZCWDlf
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 23:41:35 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:37542 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752682AbZCWDle convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Mar 2009 23:41:34 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id ADE558BD5;
	Sun, 22 Mar 2009 23:41:31 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 0388A8BD4; Sun,
 22 Mar 2009 23:41:27 -0400 (EDT)
In-Reply-To: <40aa078e0903221755n23457ba6m689aad34c0ec8214@mail.gmail.com>
 (Erik Faye-Lund's message of "Mon, 23 Mar 2009 01:55:15 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7FD89E92-175C-11DE-8F88-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114240>

Erik Faye-Lund <kusmabite@googlemail.com> writes:

> On Mon, Mar 23, 2009 at 1:39 AM, Junio C Hamano <gitster@pobox.com> w=
rote:
> ...
>> These tests seem to only care about fast-export not dying, but don't=
 we
>> also want to check if they produce correct results?
>
> Well, yeah. But I was working mainly on fixing a crash-bug here, and =
I
> don't think I know enough about the correct output of fast-export to
> pull this off. Perhaps tighting up the test is something someone else
> would care to do?

Surely; for a starter, saying something like this:

+# NEEDSWORK: not just check return status, but validate the output
+test_expect_failure 'tree_tag' =C2=A0 =C2=A0 =C2=A0 =C2=A0'git fast-ex=
port tree_tag'
+test_expect_failure 'tree_tag-obj' =C2=A0 =C2=A0'git fast-export tree_=
tag-obj'
+test_expect_failure 'tag-obj_tag' =C2=A0 =C2=A0 'git fast-export tag-o=
bj_tag'
+test_expect_failure 'tag-obj_tag-obj' 'git fast-export tag-obj_tag-obj=
'

would do, and will invite others to fill the gap when they have time.

Thanks.
