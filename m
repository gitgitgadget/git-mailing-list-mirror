From: Junio C Hamano <gitster@pobox.com>
Subject: warning: "git am --whitespace=fix" broken in 1.6.4-rc2
Date: Sat, 25 Jul 2009 01:52:35 -0700
Message-ID: <7vr5w5uoto.fsf_-_@alter.siamese.dyndns.org>
References: <1248308678-23280-1-git-send-email-szeder@ira.uka.de>
 <7vy6qdupio.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 25 10:53:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUd0B-0003rs-3g
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 10:53:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755211AbZGYIwo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 04:52:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752848AbZGYIwo
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 04:52:44 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62543 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752184AbZGYIwn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 04:52:43 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5D1E710F38;
	Sat, 25 Jul 2009 04:52:43 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4165110F36; Sat, 25 Jul 2009
 04:52:36 -0400 (EDT)
In-Reply-To: <7vy6qdupio.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat\, 25 Jul 2009 01\:37\:35 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 843AEE06-78F8-11DE-B533-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123996>

I am very sorry that I did not spot this earlier, but 1.6.4-rc2 has a
quite serious bug in "git apply --whitespace=fix" (hence "git am" with the
same option) in that it can lose all the added empty lines when it detects
any trailing spaces.  I've sent a fix out already, and am planning to
issue 1.6.4-rc3 this weekend, but in the meantime, please do not use it,
nor any version that contains commit 735c674 (Trailing whitespace and no
newline fix, 2009-07-22).

Unfortunately the commit is included in all recent integration branches
down to 'maint'.  I'll push out the fixes for them soonish.

Sorry for the trouble.
