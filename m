From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 0/7] make test output coloring more intuitive
Date: Thu, 20 Dec 2012 11:21:09 -0800
Message-ID: <7vy5gs4jiy.fsf@alter.siamese.dyndns.org>
References: <1355682495-22382-1-git-send-email-git@adamspiers.org>
 <7v8v8xrfnp.fsf@alter.siamese.dyndns.org>
 <CAOkDyE9B_HfUZmqNqO35mtjTvdihBTiW=uOV2oEQgLUw1xyf=A@mail.gmail.com>
 <20121220153411.GA1497@sigill.intra.peff.net>
 <CAOkDyE9y6JvNKTCBoJqu47Hn-3axfjZPUdBhf4bOEfSP-9Q84A@mail.gmail.com>
 <20121220161110.GA10605@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adam Spiers <git@adamspiers.org>, git list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 20 20:21:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TllgS-00067j-JX
	for gcvg-git-2@plane.gmane.org; Thu, 20 Dec 2012 20:21:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751968Ab2LTTVP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2012 14:21:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64850 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751326Ab2LTTVO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2012 14:21:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0EA6AA9D3;
	Thu, 20 Dec 2012 14:21:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6W7yO7SUPjYcIrFt7UNnVJPSgY0=; b=bSZKCS
	peKJ/IfVIZkzVV4vEFzj+lLXEg8hxA80ynvBGNDp/U98CW7hwxW/XvWnbMUCyL23
	NFgb73bTwpy3G9nPe1P+DDK3Wrc4dg0Xd9FzGAy75M4L6B31jeFGFd8JF2r17HpY
	4qxqTIt2OXAQt9ugORh9lwCmAk3a5/qeZ7rEw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Arv1lMdd4JRjO0r4NIp9LgXJOgud3iyn
	8DstDFqKyl72Be1K38xGIXQMDum6I/XkcrwthVkKX96D2Iboxtl5iGBgUrIZ9FJ/
	nxTt4Xm+celpx/P6XF5D10OmZRHToKjHY/9fAxDI1DLgUVtz5RL+QqHBHJ8vua24
	45KgfANAGeM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EEDAFA9D2;
	Thu, 20 Dec 2012 14:21:12 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 36408A9C4; Thu, 20 Dec 2012
 14:21:12 -0500 (EST)
In-Reply-To: <20121220161110.GA10605@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 20 Dec 2012 11:11:10 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6A5CE310-4ADA-11E2-BC7A-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211919>

Jeff King <peff@peff.net> writes:

>> Good point, I forgot to check what it looked like with -v.  Since this
>> series is already on v6, is there a more lightweight way of addressing
>> this tiny tweak than sending v7?
>
> It is ultimately up to Junio, but I suspect he would be OK if you just
> reposted patch 4/7 with the above squashed. Or even just said "I like
> this, please squash it into patch 4 (change info messages from
> yellow/brown to bold cyan).

Surely; as long as the series is not in 'next', the change to be
squashed is not too big and it is not too much work (and in this
case it certainly is not).

I actually wonder if "skipped test in bold blue" and "known breakage
in bold yellow" should also lose the boldness.  Errors and warnings
in bold are good, but I would say the degree of need for attention
are more like this:

	error (failed tests - you should look into it)
        skip (skipped - perhaps you need more packages?)
        warn (expected failure - you may want to look into fixing it someday)
	info
        pass

The "expected_failure" cases painted in "warn" are all long-known
failures; I do not think reminding about them in "bold" over and
over will help encouraging the developers take a look at them.

The "skipped" cases fall into two categories.  Either you already
know you choose to not to care (e.g. I do not expect to use git-p4
and decided not to install p4 anywhere, so I may have t98?? on
GIT_SKIP_TESTS environment) or you haven't reached that point on a
new system and haven't realized that you didn't install a package
needed to run tests you care about (e.g. cvsserver tests would not
run without Perl interface to SQLite).  For the former, the bold
output is merely distracting; for the latter, bold _might_ help in
this case.

At least, I think

	GIT_SKIP_TESTS=t98?? sh t9800-git-p4-basic.sh -v

should paint "skipping test t9800 altogether" (emitted with "-v) and
the last line "1..0 # SKIP skip all tests in t9800" both in the same
"info" color.

How about going further to reduce "bold" a bit more, like this?

diff --git a/t/test-lib.sh b/t/test-lib.sh
index aaf013e..2bbb81d 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -182,13 +182,13 @@ then
 		error)
 			tput bold; tput setaf 1;; # bold red
 		skip)
-			tput bold; tput setaf 4;; # bold blue
+			tput setaf 4;; # bold blue
 		warn)
-			tput bold; tput setaf 3;; # bold brown/yellow
+			tput setaf 3;; # bold brown/yellow
 		pass)
 			tput setaf 2;;            # green
 		info)
-			tput bold; tput setaf 6;; # bold cyan
+			tput setaf 6;; # bold cyan
 		*)
 			test -n "$quiet" && return;;
 		esac
@@ -589,7 +589,7 @@ for skp in $GIT_SKIP_TESTS
 do
 	case "$this_test" in
 	$skp)
-		say_color skip >&3 "skipping test $this_test altogether"
+		say_color info >&3 "skipping test $this_test altogether"
 		skip_all="skip all tests in $this_test"
 		test_done
 	esac
