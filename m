From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [RFC/PATCH] Use compatibility regex library for OSX/Darwin
Date: Tue, 16 Sep 2008 19:58:02 -0500
Message-ID: <VPAf9PbSSJcz5E923jIMO7Zjvp4Iw0PwpJfuSJUAeCI5etNDRv9pfQ@cipher.nrlssc.navy.mil>
References: <20080907184537.GA4148@regex.yaph.org> <W_emvcr7ijntBMNCDV17_XHXotGkm1Bn-9Bw-ZixcXmFyBWlDj5vYg@cipher.nrlssc.navy.mil> <alpine.LNX.1.10.0809161722580.18110@suse104.zenez.com> <20080916233220.GA14173@coredump.intra.peff.net> <alpine.LNX.1.10.0809161738010.17105@suse104.zenez.com> <20080916234624.GA14405@coredump.intra.peff.net> <alpine.LNX.1.10.0809161811100.17105@suse104.zenez.com> <a4X38z5PMKaSj4KeLKBBqWb9elMD_Pp1n1eMqdmujRqMrr9xtvQAfA@cipher.nrlssc.navy.mil> <alpine.LNX.1.10.0809161824470.17105@suse104.zenez.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Arjen Laarhoven <arjen@yaph.org>,
	git@vger.kernel.org, Mike Ralphson <mike.ralphson@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>
To: Boyd Lynn Gerber <gerberb@zenez.com>
X-From: git-owner@vger.kernel.org Wed Sep 17 02:59:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KflO8-000848-Ct
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 02:59:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752610AbYIQA6Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2008 20:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752529AbYIQA6Q
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 20:58:16 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:33235 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752522AbYIQA6P (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 20:58:15 -0400
Received: by mail.nrlssc.navy.mil id m8H0w3cK003176; Tue, 16 Sep 2008 19:58:03 -0500
In-Reply-To: <alpine.LNX.1.10.0809161824470.17105@suse104.zenez.com>
X-OriginalArrivalTime: 17 Sep 2008 00:58:03.0028 (UTC) FILETIME=[6FE9A540:01C91860]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96061>

Boyd Lynn Gerber wrote:
> On Tue, 16 Sep 2008, Brandon Casey wrote:
>> Boyd Lynn Gerber wrote:
>>> If I use gdiff or make gnu diff and put it in /usr/local/bin/ and change
>>> the path to have /usr/local/bin first it does not fail/.
>>>
>>> I have a /usr/gnu/bin/... where I have gdiff linked to diff.
>>
>> You must have done something like this in the past when you were
>> testing previous versions since the test_cmp variable has not changed.
>>
>> So, for future reference either have a diff that understands '-u' in
>> your path, or set the test_cmp environment variable.
> 
> I had customized things so that any GNU util used gutil_name.  This is
> the easiest way for me to distinguish between Native utils and GNU utils.
> 
> Is there an easy way to have git use gcommand_name instead of
> command_name?

Not that I know of.

>  I changed the path to run the git test, but not all my
> clients will allow be to have the gnu named command instead of the
> native command.  There programs require the non GNU functionality.  That
> is why I create a /usr/gnu/  with all the GNU stuff available for my
> use, but having to change paths back and forth just to run git is a pain
> when build/trouble shooting customer  aplications.

I usually create a little compile script which sets the environment
variables the way I want, and calls make or gmake appropriately.

For the test suite you can set (if necessary):
  test_cmp
  TAR

'git grep' sometimes calls native grep. You can disallow this by setting
the Makefile variable NO_EXTERNAL_GREP.

And of course SHELL_PATH can be used to set the path to the shell that
all shell code should be executed with.

-brandon
