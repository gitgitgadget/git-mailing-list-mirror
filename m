From: David Kastrup <dak@gnu.org>
Subject: Re: `git stash pop` UX Problem
Date: Thu, 27 Feb 2014 01:19:14 +0100
Message-ID: <878usx5rwd.fsf@fencepost.gnu.org>
References: <530B0395.5030407@booking.com>
	<CANUGeEbPrPp8Sa-KEKSxNDWJShdkDBTkQyXv7tDJ6ReH6MXrHw@mail.gmail.com>
	<530C953F.9050805@booking.com> <vpqlhwz5o58.fsf@anie.imag.fr>
	<530CA4C9.60601@booking.com> <vpqeh2r43kx.fsf@anie.imag.fr>
	<530D97BA.1080107@booking.com> <vpqzjlez3c4.fsf@anie.imag.fr>
	<xmqqd2i94qfq.fsf@gitster.dls.corp.google.com>
	<vpqy50xd5cr.fsf@anie.imag.fr> <87ha7l62d6.fsf@fencepost.gnu.org>
	<xmqq4n3l34ex.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Omar Othman <omar.othman@booking.com>,
	Brandon McCaig <bamccaig@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 27 01:19:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIohR-00027B-4C
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 01:19:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753871AbaB0ATh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Feb 2014 19:19:37 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:34112 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753288AbaB0ATg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Feb 2014 19:19:36 -0500
Received: from localhost ([127.0.0.1]:33152 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WIohK-0007Nm-2K; Wed, 26 Feb 2014 19:19:34 -0500
Received: by lola (Postfix, from userid 1000)
	id 835B6E9C00; Thu, 27 Feb 2014 01:19:14 +0100 (CET)
In-Reply-To: <xmqq4n3l34ex.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 26 Feb 2014 14:17:10 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242779>

Junio C Hamano <gitster@pobox.com> writes:

> David Kastrup <dak@gnu.org> writes:
>
>> All that verbosity...
>>
>> $ git stash pop
>> Auto-merging foo.txt
>> CONFLICT (content): Merge conflict in foo.txt
>> Cowardly refusing to drop stash
>> $
>
> Actually, modulo "Cowardly", that may be the most harmless phrasing,
> as apply_stash may try to signal an error for reasons not related to
> an inability to apply the change cleanly (e.g. we may have failed to
> refresh the index).

Without "Cowardly", the capriciosity of "refusing" does not make much
sense.  The error message is a tribute to GNU tar:
dak@lola:/tmp$ mkdir x
dak@lola:/tmp$ tar cfz x
tar: Cowardly refusing to create an empty archive
Try `tar --help' or `tar --usage' for more information.
dak@lola:/tmp$ 

The boring variant would be

$ git stash pop
Auto-merging foo.txt
CONFLICT (content): Merge conflict in foo.txt
Not dropping stash
$

-- 
David Kastrup
