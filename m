From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jan 2013, #11; Wed, 30)
Date: Wed, 30 Jan 2013 11:17:15 -0800
Message-ID: <7v4nhylbus.fsf@alter.siamese.dyndns.org>
References: <7vd2wmldw9.fsf@alter.siamese.dyndns.org>
 <20130130190759.GJ1342@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Jan 30 20:17:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0dAD-0002xA-5H
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 20:17:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755699Ab3A3TRT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 14:17:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54823 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754010Ab3A3TRS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2013 14:17:18 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8ABD0B754;
	Wed, 30 Jan 2013 14:17:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SOMZwLAbT+6YzlXrXnqMCe4KuNc=; b=SnpF5H
	OSNTDbpjj3TQBLEjhEKq+dSkRxTxEFxqjp2W13IlBBGSfu47AWSVd12tD4gsLphi
	AKzQ3R5OO4+YUeNuI0TfZ0GuUXg9Kq8p1MRj62ZHVjdBzoWtHpcxrUv0u/f3/C5I
	YJqWmvabJB9Ch/DG+qf9Ou0M+zeEOChcAS1/U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=emjihh60sFSE6ZDkvKYVfeNEcsa3cXJp
	5qjEv+A2q21OgdlyM5PqmpP22HMzNMPl/Y6PrOMVrQxROmbN/kRH6+NbfHRWRAdf
	WVgDNrHdDx2joTOjz1a4Y+8Bn41wNBdHQlvllO7kenQOpTR6Ol4resua4kPWzE7F
	nkKL4fuoGTc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 551C2B753;
	Wed, 30 Jan 2013 14:17:17 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BADBCB74E; Wed, 30 Jan 2013
 14:17:16 -0500 (EST)
In-Reply-To: <20130130190759.GJ1342@serenity.lan> (John Keeping's message of
 "Wed, 30 Jan 2013 19:07:59 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A8F441AC-6B11-11E2-952B-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215059>

John Keeping <john@keeping.me.uk> writes:

> On Wed, Jan 30, 2013 at 10:33:10AM -0800, Junio C Hamano wrote:
>> [Discarded]
>> 
>> * jk/update-install-for-p4 (2013-01-20) 1 commit
>>  . INSTALL: git-p4 doesn't support Python 3
>> 
>>  Made obsolete by bc/git-p4-for-python-2.4 topic.
>
> I disagree with this - that branch doesn't change INSTALL to list "not
> Python 3" in the supported versions.
>
> Brandon, would you mind doing s/2.4 or later/2.4 - 2.7/ on your branch?

Thanks for being a careful reader.

Let's do something like this on top of the topic.

 INSTALL | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/INSTALL b/INSTALL
index b96e16d..2dc3b61 100644
--- a/INSTALL
+++ b/INSTALL
@@ -131,8 +131,9 @@ Issues of note:
 	  use English. Under autoconf the configure script will do this
 	  automatically if it can't find libintl on the system.
 
-	- Python version 2.4 or later is needed to use the git-p4
-	  interface to Perforce.
+	- Python version 2.4 or later (but not 3.x, which is not
+	  supported by Perforce) is needed to use the git-p4 interface
+	  to Perforce.
 
  - Some platform specific issues are dealt with Makefile rules,
    but depending on your specific installation, you may not
