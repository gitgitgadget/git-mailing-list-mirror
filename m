From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [RFC/PATCH] Use compatibility regex library for OSX/Darwin
Date: Tue, 16 Sep 2008 19:13:50 -0500
Message-ID: <SYLwfNw_i8AJD2SReRObweoVtWG2KY6sT1-akI631fOeWpAzh0OGeQ@cipher.nrlssc.navy.mil>
References: <20080907184537.GA4148@regex.yaph.org> <W_emvcr7ijntBMNCDV17_XHXotGkm1Bn-9Bw-ZixcXmFyBWlDj5vYg@cipher.nrlssc.navy.mil> <alpine.LNX.1.10.0809161722580.18110@suse104.zenez.com> <20080916233220.GA14173@coredump.intra.peff.net> <alpine.LNX.1.10.0809161738010.17105@suse104.zenez.com> <20080916234624.GA14405@coredump.intra.peff.net> <alpine.LNX.1.10.0809161808011.17105@suse104.zenez.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Arjen Laarhoven <arjen@yaph.org>,
	git@vger.kernel.org, Mike Ralphson <mike.ralphson@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>
To: Boyd Lynn Gerber <gerberb@zenez.com>
X-From: git-owner@vger.kernel.org Wed Sep 17 02:15:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kfkhb-0005cj-4c
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 02:15:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752519AbYIQAOT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2008 20:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752402AbYIQAOT
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 20:14:19 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:40597 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751717AbYIQAOR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 20:14:17 -0400
Received: by mail.nrlssc.navy.mil id m8H0DpYM028917; Tue, 16 Sep 2008 19:13:51 -0500
In-Reply-To: <alpine.LNX.1.10.0809161808011.17105@suse104.zenez.com>
X-OriginalArrivalTime: 17 Sep 2008 00:13:51.0348 (UTC) FILETIME=[43636340:01C9185A]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96058>

Boyd Lynn Gerber wrote:

> * expecting success:
> 
>         (
>                 unset GIT_CONFIG GIT_WORK_TREE GIT_CONFIG
> 
>                 mkdir again &&
>                 cd again &&
>                 git init >out1 2>err1 &&
>                 git init >out2 2>err2
>         ) &&
>         grep "Initialized empty" again/out1 &&
>         grep "Reinitialized existing" again/out2 &&
>         >again/empty &&
>         test_cmp again/empty again/err1 &&
>         test_cmp again/empty again/err2
> 
> Initialized empty Git repository in
> /home/zenez/build/osr6/git-1.6.0.2/t/trash directory/again/.git/
> Reinitialized existing Git repository in
> /home/zenez/build/osr6/git-1.6.0.2/t/trash directory/again/.git/
> diff: ERROR: Illegal option -- u
> Usage: diff [ -bcefhrC<n> ] file1 file2

The tests are failing at the test_cmp line. By default, test_cmp is
set to 'diff -u'. Perhaps you usually set test_cmp to something else
like 'cmp -s' or modify your path so that a more modern diff is used?

-brandon
