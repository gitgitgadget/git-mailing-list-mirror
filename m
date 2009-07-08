From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "fatal: index-pack failed" on git-clone
Date: Wed, 08 Jul 2009 15:48:15 -0700
Message-ID: <7vvdm26bbk.fsf@alter.siamese.dyndns.org>
References: <C92DE6F3-4F35-469F-AC28-4DDD1D8105C2@uchicago.edu>
 <4103BA41-39E4-496F-A76F-17D84F30EA21@uchicago.edu>
 <7vd48b6md8.fsf@alter.siamese.dyndns.org> <200907082242.51495.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fritz Anderson <fritza@uchicago.edu>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Jul 09 00:48:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOfwE-0005YR-2d
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 00:48:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756139AbZGHWsY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2009 18:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755770AbZGHWsX
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jul 2009 18:48:23 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63121 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755131AbZGHWsX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2009 18:48:23 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id EB95E261A7;
	Wed,  8 Jul 2009 18:48:21 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 22913261A4; Wed, 
 8 Jul 2009 18:48:16 -0400 (EDT)
In-Reply-To: <200907082242.51495.j6t@kdbg.org> (Johannes Sixt's message of
 "Wed\, 8 Jul 2009 22\:42\:51 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 70231054-6C11-11DE-BB68-DC021A496417-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122924>

Johannes Sixt <j6t@kdbg.org> writes:

> However, if Fritz runs 'sudo /usr/local/bin/git clone ...', then the interim 
> PATH is "/usr/local/bin:/usr/local/libexec/git-core:/bin:/usr/bin" because 
> this time setup_path() finds a non-empty argv0_path, and the command works.

Ahh, that is what I was missing.

As I said elsewhere already, I personally do not think sudo is worth
supporting compared to the cost of this kind of pain resulting from its
misguided "safety" brokenness, but apparently it is widely used.  I think
what Peff suggests in this thread might be a reasonable workaround.
