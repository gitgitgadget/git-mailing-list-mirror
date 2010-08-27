From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Aug 2010, #05; Sat, 21)
Date: Thu, 26 Aug 2010 21:52:02 -0700
Message-ID: <7vvd6wk68d.fsf@alter.siamese.dyndns.org>
References: <7v4oen5clj.fsf@alter.siamese.dyndns.org>
 <20100822123412.GA22353@LK-Perkele-V2.elisa-laajakaista.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Fri Aug 27 06:52:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoqvV-0000xZ-3i
	for gcvg-git-2@lo.gmane.org; Fri, 27 Aug 2010 06:52:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753069Ab0H0EwN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Aug 2010 00:52:13 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37217 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752085Ab0H0EwL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Aug 2010 00:52:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B5404D1658;
	Fri, 27 Aug 2010 00:52:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BblPYGRoYZhLWrZl/5Of2yJ5OVw=; b=fsDnIy
	5b7qaS6LTZN2lR+sIJ0bimIN5pQAXu6w3mvD+VmORo1cRT+gCbpdlyHEXD73NPvt
	K4UIwRJg6pAXFuxQYgN0Dw+WyMIEdEoDiDzWmmWUe5u/kcVWMfb4ikJN9HdnByin
	GodoUYSu5Wyculkbz+No33/aMCjRn6K6ZsDpU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gk+P4sOZ7frOkWeHi3cJkMbhtaikh9k5
	OhEQqE4KZSdvlmQJAe22mf0mSPy0CamabMmJuINuhDR8tNItdQe4OZBLrVHrKsM/
	wGvElO8EfjHpCtJBbDrsjMrts5trkesJh/DojNHkHZbMYDzsuc0OsDuUBtWLfpmu
	T3Db8t1r75E=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 91A3CD1657;
	Fri, 27 Aug 2010 00:52:06 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ADCC9D1656; Fri, 27 Aug
 2010 00:52:03 -0400 (EDT)
In-Reply-To: <20100822123412.GA22353@LK-Perkele-V2.elisa-laajakaista.fi>
 (Ilari Liusvaara's message of "Sun\, 22 Aug 2010 15\:34\:12 +0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D7A76C68-B196-11DF-A4E0-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154581>

Ilari Liusvaara <ilari.liusvaara@elisanet.fi> writes:

> On Sun, Aug 22, 2010 at 12:30:00AM -0700, Junio C Hamano wrote:
>> 
>> * il/rfc-remote-fd-ext (2010-08-14) 6 commits
>>  - Fix build on Windows
>>  - Simplify send_git_request()
>>  - Rewrite bidirectional traffic loop
>>  - gitignore: Ignore the new /git-remote-{ext,fd} helpers
>>  - New remote helper: git-remote-ext
>>  - New remote helper git-remote-fd
>> 
>> I haven't heard anything about this series.  Is it desirable?  Or is it
>> not used by anybody and just another baggage we'd rather not carry?
>
> Well, as said in series introduction, some possible uses:
> - ssh with odd options without editing ssh_config (this ocassionally pops up
> on #git, especially with keypair setting, dunno how much of that is
> XY-problem and how much is not).
> - TLS-tunneling git://.
> - etc...
>
> And yes, I use it a lot internally.

I was looking at the diff while merging the series to 'next', and noticed
extra includes to two newly created files.  Perhaps this should go on top
or squashed to the series.

 builtin/remote-ext.c |    5 -----
 builtin/remote-fd.c  |    5 -----
 2 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/builtin/remote-ext.c b/builtin/remote-ext.c
index d861f0a..3f8f8d5 100644
--- a/builtin/remote-ext.c
+++ b/builtin/remote-ext.c
@@ -1,11 +1,6 @@
 #include "git-compat-util.h"
 #include "transport.h"
 #include "run-command.h"
-#include <errno.h>
-#include <stdlib.h>
-#include <string.h>
-#include <stdio.h>
-#include <unistd.h>
 
 /*
  * URL syntax:
diff --git a/builtin/remote-fd.c b/builtin/remote-fd.c
index d27a7a2..22bf048 100644
--- a/builtin/remote-fd.c
+++ b/builtin/remote-fd.c
@@ -1,10 +1,5 @@
 #include "git-compat-util.h"
 #include "transport.h"
-#include <errno.h>
-#include <stdlib.h>
-#include <string.h>
-#include <stdio.h>
-#include <unistd.h>
 
 
 /*
