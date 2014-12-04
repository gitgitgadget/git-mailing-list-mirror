From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] compat: convert modes to use portable file type values
Date: Thu, 04 Dec 2014 11:39:19 -0800
Message-ID: <xmqq8uintdaw.fsf@gitster.dls.corp.google.com>
References: <87wq68w3se.fsf@gmail.com>
	<CAEvUa7nxzX=54QJto_R3hfvAO4FKhs8Pancz0TTiC7ev22--Kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: David Michael <fedora.dm0@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 04 20:39:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwcFL-00054h-7y
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 20:39:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932315AbaLDTjX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 14:39:23 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59455 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751822AbaLDTjW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 14:39:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1727D233A9;
	Thu,  4 Dec 2014 14:39:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RhSvxnsLBPUYgKYIjLVn6+wg6qU=; b=riuvYv
	Po0k1t1IGyrYxeQqoExay9zscCw0T4n848lvLpsjOqzPPvxIwLY4Sx02I50QFecd
	Wm3uSkukj9PvAYDa4UdjZ/1S7yFGrlcJoqlzNlpTIjIMdT34coKiUlByVRXYMYOK
	Op7X2ua6XewI6CYiX/kX725FdFEYKMPIxNGQg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h//gjDRGY30sMVw5saxOH5t1GyP3jinB
	aGYKKOx0UdE71EGaII3fsAFzGw9tjZQjJPBPtGA2YkM6EnaBn+E1YjjIZaN08U4J
	Jx0gSEpeWUyck8XNjIb6jEr0CAqrut2TgJMPHGcQNqP7wl2hFinxPHn5PBREcmgB
	ZZxoKFhq1RM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0C1DD233A8;
	Thu,  4 Dec 2014 14:39:21 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 76655233A7;
	Thu,  4 Dec 2014 14:39:20 -0500 (EST)
In-Reply-To: <CAEvUa7nxzX=54QJto_R3hfvAO4FKhs8Pancz0TTiC7ev22--Kw@mail.gmail.com>
	(David Michael's message of "Thu, 4 Dec 2014 14:27:24 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3DF65554-7BED-11E4-A289-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260789>

David Michael <fedora.dm0@gmail.com> writes:

> On Wed, Dec 3, 2014 at 9:24 PM, David Michael <fedora.dm0@gmail.com> wrote:
>> --- /dev/null
>> +++ b/compat/stat.c
>> @@ -0,0 +1,49 @@
>> +#define _POSIX_C_SOURCE 200112L
>> +#include <stddef.h>    /* NULL         */
>> +#include <sys/stat.h>  /* *stat, S_IS* */
>> +#include <sys/types.h> /* mode_t       */
>
> Oops, the <stddef.h> line can be removed now that this is no longer
> testing for NULL.  Let me know if this warrants a v3 if there is no
> other feedback.

Let me queue with this squashed in for now.

 compat/stat.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/compat/stat.c b/compat/stat.c
index c2d4711..a2d3931 100644
--- a/compat/stat.c
+++ b/compat/stat.c
@@ -1,5 +1,4 @@
 #define _POSIX_C_SOURCE 200112L
-#include <stddef.h>    /* NULL         */
 #include <sys/stat.h>  /* *stat, S_IS* */
 #include <sys/types.h> /* mode_t       */
 
