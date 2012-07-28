From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [RFC/PATCH] t3300-*.sh: Fix a TAP parse error
Date: Sat, 28 Jul 2012 19:03:17 +0100
Message-ID: <50142965.4020801@ramsay1.demon.co.uk>
References: <500AEB11.4050006@ramsay1.demon.co.uk> <20120721182049.GL19860@burratino> <500EEAAA.8030604@ramsay1.demon.co.uk> <7veho1exu6.fsf@alter.siamese.dyndns.org> <501043D9.70604@ramsay1.demon.co.uk> <20120725205120.GD4732@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 28 20:53:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvC9B-0004Iq-Kn
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jul 2012 20:53:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752547Ab2G1Sxr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jul 2012 14:53:47 -0400
Received: from mdfmta004.mxout.tbr.inty.net ([91.221.168.45]:48621 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751533Ab2G1Sxq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2012 14:53:46 -0400
Received: from mdfmta004.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta004.tbr.inty.net (Postfix) with ESMTP id AA7F6A0C080;
	Sat, 28 Jul 2012 19:53:44 +0100 (BST)
Received: from mdfmta004.tbr.inty.net (unknown [127.0.0.1])	by mdfmta004.tbr.inty.net (Postfix) with ESMTP id CFB49A0C07F;	Sat, 28 Jul 2012 19:53:43 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta004.tbr.inty.net (Postfix) with ESMTP;	Sat, 28 Jul 2012 19:53:42 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:14.0) Gecko/20120713 Thunderbird/14.0
In-Reply-To: <20120725205120.GD4732@burratino>
X-MDF-HostID: 9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202451>

Jonathan Nieder wrote:
> [...]
>> [1] For example, what should/will happen if someone uses test_must_fail,
>> test_might_fail, etc., within the test_fixture script? Should they simply
>> be banned within a text_fixture?
> 
> Why wouldn't they act just like they do in test_expect_success blocks?

Heh, well they do indeed act just like they do in text_expect_success blocks!

I spent only about 20 minutes writing test_fixture, playing with it, and then
deciding to shelve it for now. Again, I wanted a *quick* fix for the TAP
parse error, so that it would make it into v1.7.12. :(

Having now spent a further 30 minutes, I can see that I did a better job than
I thought! :-P

Actually, scratch that; rather I should say that Junio and the other authors
of the test infrastructure did such a good job (particularly with separation
of concerns), that I lucked into a good implementation.

I still haven't done any serious testing, so if I subsequently find any
problems, then the lousy implementation is my fault! ;-)

> FWIW I find Junio's test_setup name more self-explanatory.  What
> mnemonic should I be using to remember the _fixture name?

I don't have a problem with 'test_setup' either; test-fixture comes from the
various xUnit unit-test libraries. (I think Kent Beck et.al. wrote JUnit first
and then it was ported to various other languages. eg cppUnit for C++).

Briefly, a test-fixture provides a context or common environment, via code for
test setup and teardown, in which to run one or more tests.

HTH

ATB,
Ramsay Jones
