From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 2/2] t/Makefile: always test all lint targets when running
 tests
Date: Tue, 08 Jul 2014 21:24:25 +0200
Message-ID: <53BC4569.3020907@web.de>
References: <53B5D6FE.2090700@web.de> <53B5D76D.1090509@web.de> <xmqq38eddolk.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 08 21:24:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4b0P-0005p4-Ku
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jul 2014 21:24:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756306AbaGHTYf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2014 15:24:35 -0400
Received: from mout.web.de ([212.227.15.4]:63628 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756301AbaGHTYe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2014 15:24:34 -0400
Received: from [192.168.178.41] ([84.132.191.219]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0LcPhu-1WMDcn2yqk-00joQM; Tue, 08 Jul 2014 21:24:31
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <xmqq38eddolk.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:ktmh2DdDZUi8lwfOdSuJ4pXvLve4Fz7sK6hV7gL3Xb1pbnhsyvt
 nzAa0NwNNbDwztELVqJ+wnM30gW3dm47Q1uxiUr3ITwxinWONr/fDpH63MkZx+oUnrrbJwM
 MqyGiJN5FDDIBV06NvfdcVi+EwpRUxmG1U4llwIgbcCjnXeOAufQt7gjlOpEQvIanAeGQh+
 +fuq/RON3MRNFfNL+ZtrA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253040>

Am 07.07.2014 20:13, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
>> Only the two targets "test-lint-duplicates" and "test-lint-executable" are
>> currently executed when running the test target. This was done on purpose
>> when the TEST_LINT variable was added in 81127d74. But as this does not
>> include the "test-lint-shell-syntax" target added the same day in commit
>> c7ce70ac, it is easy to accidentally add non portable shell constructs
>> without noticing that when running the test suite.
> 
> I not running the lint-shell-syntax that is fundamentally flaky to
> avoid false positives is very much on purpose.  The flakiness is not
> the fault of the implementor of the lint-shell-syntax, but comes
> from the approach taken to pretend that simple pattern matching can
> parse shell scripts.  It may not complain on the current set of
> scripts, but that is not really by design but by accident.
> 
> So I am not very enthusiastic to see this change myself.

Ok, I understand we do not want to lightly risk false positives. I
just noticed that I accidentally forgot to sign off this series, so
I'd resend just the first patch with a proper SOB, ok?
