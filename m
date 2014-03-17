From: Gilles Filippini <gilles.filippini@free.fr>
Subject: [BUG] contrib/subtree: t/t7900-subtree.sh: test 21 fails when environment
 variable 'prefix' is set
Date: Mon, 17 Mar 2014 13:58:00 +0100
Message-ID: <5326F158.4050402@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 17 13:58:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPX7P-0003JL-Nr
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 13:58:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932951AbaCQM6L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2014 08:58:11 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:58386 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932631AbaCQM6K (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2014 08:58:10 -0400
Received: from [129.200.100.4] (unknown [88.189.102.17])
	by smtp3-g21.free.fr (Postfix) with ESMTP id BEDF2A624C
	for <git@vger.kernel.org>; Mon, 17 Mar 2014 13:58:02 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20131103 Icedove/17.0.10
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244248>

Hi,

Test 21 from contrib/subtree/t/t7900-subtree.sh fails when an
environment variable 'prefix' is set. For instance here is what happens
when prefix=/usr:

expecting success:
        echo "You must provide the --prefix option." > expected &&
        test_must_fail git subtree split > actual 2>&1 &&
	test_debug "printf 'expected: '" &&
        test_debug "cat expected" &&
	test_debug "printf 'actual: '" &&
        test_debug "cat actual" &&
        test_cmp expected actual &&
        rm -f expected actual

--- expected	2014-03-17 10:39:34.907594853 +0000
+++ actual	2014-03-17 10:39:34.979595322 +0000
@@ -1 +1,9 @@
-You must provide the --prefix option.
fatal: /usr: '/usr' is outside repository
fatal: /usr: '/usr' is outside repository
fatal: /usr: '/usr' is outside repository
fatal: /usr: '/usr' is outside repository
fatal: /usr: '/usr' is outside repository
fatal: /usr: '/usr' is outside repository
fatal: /usr: '/usr' is outside repository
fatal: /usr: '/usr' is outside repository
+No new revisions were found
not ok 21 - Check that prefix argument is required for split


Thanks,

_g.
