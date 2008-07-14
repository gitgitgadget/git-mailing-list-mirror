From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (topics)
Date: Sun, 13 Jul 2008 23:45:39 -0700
Message-ID: <7vej5xj758.fsf@gitster.siamese.dyndns.org>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org>
 <7vabjm1a0q.fsf@gitster.siamese.dyndns.org>
 <7vr6crj0jk.fsf@gitster.siamese.dyndns.org>
 <7vmyn4hr8f.fsf@gitster.siamese.dyndns.org>
 <7vmymsjz6x.fsf@gitster.siamese.dyndns.org>
 <7vabijxhk4.fsf@gitster.siamese.dyndns.org>
 <7vwslhg8qe.fsf@gitster.siamese.dyndns.org>
 <7vhccfiksy.fsf@gitster.siamese.dyndns.org>
 <7vod6k6zg4.fsf@gitster.siamese.dyndns.org>
 <7v4p7xwsfp.fsf@gitster.siamese.dyndns.org>
 <7v3anb19n7.fsf@gitster.siamese.dyndns.org>
 <7vwskjazql.fsf@gitster.siamese.dyndns.org>
 <7vk5ggipuw.fsf@gitster.siamese.dyndns.org>
 <7vej6l3lp7.fsf@gitster.siamese.dyndns.org>
 <7vod5kd3im.fsf@gitster.siamese.dyndns.org>
 <7v3amv1e8n.fsf@gitster.siamese.dyndns.org>
 <7vprpwhp7t.fsf@gitster.siamese.dyndns.org>
 <7vlk0ffhw3.fsf@gitster.siamese.dyndns.org>
 <7vtzf1w0rj.fsf@gitster.siamese.dyndns.org>
 <7vabgqsc37.fsf@gitster.siamese.dyndns.org>
 <7vtzetjbif.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 14 08:46:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIHpc-0004g1-Rz
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 08:46:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753055AbYGNGpq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 02:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753324AbYGNGpq
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 02:45:46 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62449 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753040AbYGNGpp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 02:45:45 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 36F212591E;
	Mon, 14 Jul 2008 02:45:44 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 6DE152591C; Mon, 14 Jul 2008 02:45:41 -0400 (EDT)
In-Reply-To: <7vtzetjbif.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 13 Jul 2008 22:11:20 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7B8EB388-5170-11DD-B0F4-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88385>

Junio C Hamano <gitster@pobox.com> writes:

> * lw/gitweb (Fri Jul 11 03:11:48 2008 +0200) 3 commits
>  - gitweb: use new Git::Repo API, and add optional caching
>  - Add new Git::Repo API
>  - gitweb: add test suite with Test::WWW::Mechanize::CGI
>
> This does not pass t9710, at least for me X-<.

This is getting a bit boring and tiresome.  Obviously I haven't checked
what _else_ is missing because I did not install Carp::Always myself to my
system.

 t/t9710-perl-git-repo.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t9710-perl-git-repo.sh b/t/t9710-perl-git-repo.sh
index ca67b87..2da3cd8 100755
--- a/t/t9710-perl-git-repo.sh
+++ b/t/t9710-perl-git-repo.sh
@@ -6,8 +6,8 @@
 test_description='perl interface (Git/*.pm)'
 . ./test-lib.sh
 
-perl -MTest::More -e 0 2>/dev/null || {
-	say_color skip "Perl Test::More unavailable, skipping test"
+perl -MTest::More -MTest::Exception -MCarp::Always -e 0 2>/dev/null || {
+	say_color skip "Perl Test::{More,Exception}, Carp::Always unavailable, skipping test"
 	test_done
 }
 
