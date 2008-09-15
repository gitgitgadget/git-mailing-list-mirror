From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH FYI] t9700/test.pl: backwards compatibility improvements
Date: Mon, 15 Sep 2008 11:20:08 -0500
Message-ID: <ryvGcG_Sg9kftPIp7uWA1JVCd0inSiqB61VnfUuxRUZJg6W7SWhmOQ@cipher.nrlssc.navy.mil>
References: <IH0MHSTEimhAN93AedvpRKq4qfzm1QA814ZYyhbSBtSdNbq8vuE6aw@cipher.nrlssc.navy.mil> <iZMIxnwnUBIGAGz2GMS0uwCvMMo9aaYd2Arx4fbxk9NusvUC5LUNVg@cipher.nrlssc.navy.mil> <48CE4CFE.1010106@statsbiblioteket.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: "Tom G. Christensen" <tgc@statsbiblioteket.dk>
X-From: git-owner@vger.kernel.org Mon Sep 15 18:21:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfGpJ-0004C6-Eq
	for gcvg-git-2@gmane.org; Mon, 15 Sep 2008 18:21:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754367AbYIOQUQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2008 12:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754371AbYIOQUQ
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Sep 2008 12:20:16 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:33136 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753763AbYIOQUP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2008 12:20:15 -0400
Received: by mail.nrlssc.navy.mil id m8FGK91S007916; Mon, 15 Sep 2008 11:20:09 -0500
In-Reply-To: <48CE4CFE.1010106@statsbiblioteket.dk>
X-OriginalArrivalTime: 15 Sep 2008 16:20:09.0195 (UTC) FILETIME=[EC0D43B0:01C9174E]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95915>

Tom G. Christensen wrote:
> Brandon Casey wrote:
>> Some versions of perl complain when 'STDERR' is used as the third
>> argument
>> in the 3-argument form of open(). Convert to the 2-argument form which is
>> described for duping STDERR in my second edition camel book.
>>
>> The object oriented version of File::Temp is a rather new incarnation it
>> seems. The File::Temp man page for v5.8.0 says "(NOT YET IMPLEMENTED)" in
>> the 'Objects' section. These can be converted to use
>> File::Temp::tempfile().
>>
>> Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
>>
> Tested-by: Tom G. Christensen <tgc@statsbiblioteket.dk>
> 
> Without this patch the testsuite will fail with perl 5.8.0:
> t9700$ ./test.pl
> ok 1 - use Git;
> Bareword "STDERR" not allowed while "strict subs" in use at ./test.pl
> line 41.
> Execution of ./test.pl aborted due to compilation errors.
> 1..1
> # Looks like your test died just after 1.
> 
> 
> Could we please get this patch in?

Junio had asked me to follow up on that patch at a later time, so
thanks for prodding.

Here is an alternative which _removes_ the File::Temp requirement.

-brandon
