From: "Tom Clarke" <tom@u2i.com>
Subject: How to re-use setups in multiple tests?
Date: Mon, 1 Oct 2007 12:27:49 +0200
Message-ID: <550f9510710010327l3e729ff1tbbb9b6c674c1cb11@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 01 12:28:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcIVL-000408-BS
	for gcvg-git-2@gmane.org; Mon, 01 Oct 2007 12:27:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501AbXJAK1w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2007 06:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbXJAK1w
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Oct 2007 06:27:52 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:28137 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751328AbXJAK1v (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2007 06:27:51 -0400
Received: by py-out-1112.google.com with SMTP id u77so6941641pyb
        for <git@vger.kernel.org>; Mon, 01 Oct 2007 03:27:49 -0700 (PDT)
Received: by 10.35.10.13 with SMTP id n13mr7597400pyi.1191234469366;
        Mon, 01 Oct 2007 03:27:49 -0700 (PDT)
Received: by 10.35.86.2 with HTTP; Mon, 1 Oct 2007 03:27:49 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59596>

I'm wondering if there's a pattern for re-using setups across several
tests, similar to how a setUp function is used in xUnit. The problem
is I need the setup to actually be re-run, for each test to start from
a clean slate, so using the following doesn't work as the setup is
just run before the first test.

test_expect_success setup '
     # setup repostory to a particular state
'
test_expect_success test1 '
    # some test that expects the state to be as defined in setup, and
changes state of repository
'

test_expect_success test2 '
    # another test that expects the state to be as defined in setup
'

Is there a convention for doing this that's already used? Perhaps
pulling the setup code into a function or duplicating the code? Or is
it better to create a separate test file for tests that need to be
isolated?

Thanks,

-Tom
