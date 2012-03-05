From: dag@cray.com (David A. Greene)
Subject: Re: [PATCH 2/2] Support Out-Of-Tree Valgrind Tests
Date: Mon, 05 Mar 2012 12:11:56 -0600
Message-ID: <nngy5re29zn.fsf@transit.us.cray.com>
References: <1330903437-31386-1-git-send-email-greened@obbligato.org>
	<1330903437-31386-2-git-send-email-greened@obbligato.org>
	<87aa3vzdoc.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <greened@obbligato.org>, <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Mar 05 19:12:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4cOF-00070l-H9
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 19:12:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757337Ab2CESMC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Mar 2012 13:12:02 -0500
Received: from exprod6og113.obsmtp.com ([64.18.1.31]:37306 "EHLO
	exprod6og113.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756199Ab2CESMB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2012 13:12:01 -0500
Received: from stplmr01.us.cray.com ([136.162.34.13]) (using TLSv1) by exprod6ob113.postini.com ([64.18.5.12]) with SMTP
	ID DSNKT1UB7dFT/h4n4LUiSDelK4lUDDZGj4vL@postini.com; Mon, 05 Mar 2012 10:12:01 PST
Received: from transit.us.cray.com (transit.us.cray.com [172.31.17.53])
	by stplmr01.us.cray.com (8.14.3/8.13.8/hubv2-LastChangedRevision: 12441) with ESMTP id q25IBvNC017620;
	Mon, 5 Mar 2012 12:11:57 -0600
Received: from transit.us.cray.com (localhost [127.0.0.1])
	by transit.us.cray.com (8.14.3/8.13.6/client-5260) with ESMTP id q25IBv27030559;
	Mon, 5 Mar 2012 12:11:57 -0600
Received: (from dag@localhost)
	by transit.us.cray.com (8.14.3/8.12.8/Submit) id q25IBuQO030558;
	Mon, 5 Mar 2012 12:11:56 -0600
In-Reply-To: <87aa3vzdoc.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
	"Mon, 5 Mar 2012 08:53:39 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192261>

Thomas Rast <trast@inf.ethz.ch> writes:

> greened@obbligato.org writes:
>
>> +# GIT_VALGRIND_TOOLS is the location of tools like valgrind.sh.
>> +if test -z "$GIT_VALGRIND_TOOLS"
>> +then
>> +	# We allow tests to override this, in case they want to run tests
>> +	# outside of t/.
>> + 
>> +        # For in-tree test scripts, this is in TEST_DIRECTORY/valgrind
>> +        # (t/valgrind), but a test script that lives outside t/ can
>> +        # set this variable to point at the right place so that it can
>> +        # find t/valgrind directory that house test helpers like
>> +        # valgrind.sh.
>> +       GIT_VALGRIND_TOOLS="$TEST_DIRECTORY"/valgrind
>> +fi
>
> I'm a bit curious: why isn't it enough to spell that path
> $GIT_BUILD_DIR/t/valgrind instead of making it fully configurable?

For the same reason that TEST_DIRECTORY is different and unrelated from
GIT_BUILD_DIR.  It's my understanding that GIT_BUILD_DIR could end up
being somewhere compeltely unrelated to where TOP_SRC/t/valgrind is.
At least that's why I introduced a new parameter.

                           -Dave
