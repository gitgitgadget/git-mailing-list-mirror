From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH] t4202 (log): add failing test for log with subtree
Date: Mon, 22 Apr 2013 15:19:49 +0200
Message-ID: <87li8aog7e.fsf@linux-k42r.v.cablecom.net>
References: <1366632487-28153-1-git-send-email-artagnon@gmail.com>
	<87ppxmogdv.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>,
	Avery Pennarun <apenwarr@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 22 15:19:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUGey-0006c0-4K
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 15:19:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753455Ab3DVNTw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 09:19:52 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:26347 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753253Ab3DVNTv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 09:19:51 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 22 Apr
 2013 15:19:48 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS22.d.ethz.ch (172.31.51.112) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Mon, 22 Apr 2013 15:19:49 +0200
In-Reply-To: <87ppxmogdv.fsf@linux-k42r.v.cablecom.net> (Thomas Rast's message
	of "Mon, 22 Apr 2013 15:15:56 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222015>

Thomas Rast <trast@inf.ethz.ch> writes:

>> +test_expect_failure 'log pathspec in tree read into prefix' '
>> +	git checkout --orphan subtree &&
>> +	git rm -rf . &&
>> +	echo foodle >ichi &&
>
> 'ichi' also exists in M^1 because you reused a name from another test.
> So rename detection will never pair the eventual 'bar/ichi' with this
> 'ichi', because the 'ichi' path was *modified*, not deleted, w.r.t. M^1.

Argh, that should read 'w.r.t. M^2', i.e. the subtree side.

The subtree side brings its own 'ichi', but it is moved to bar/ichi, so
there is a large difference between M:ichi (which came from M^1) and
M^2:ichi.


PS: As mentioned on IRC, even if you fix all that, a one-line file is
probably too small to pass the rename detection heuristics.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
