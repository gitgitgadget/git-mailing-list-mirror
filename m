From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Using Format/export-subst Howto.
Date: Mon, 17 Sep 2012 15:45:21 +0200
Message-ID: <50572971.9020204@drmicha.warpmail.net>
References: <84EA18831601B6429E578236AE239B01A54807F242@EAGNMNSXMB07.usa.dce.usps.gov> <50532B35.9050607@drmicha.warpmail.net> <5053480E.2010002@viscovery.net> <84EA18831601B6429E578236AE239B01A54807F376@EAGNMNSXMB07.usa.dce.usps.gov> <50534FC6.2040207@viscovery.net> <1347656962.3998.140661128069097.6D9BE3C4@webmail.messagingengine.com> <7vfw6k2t8w.fsf@alter.siamese.dyndns.org> <84EA18831601B6429E578236AE239B01A5498B52A3@EAGNMNSXMB07.usa.dce.usps.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Mestnik, Michael J - Eagan, MN - Contractor" 
	<Michael.J.Mestnik@usps.gov>
X-From: git-owner@vger.kernel.org Mon Sep 17 15:45:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDbdn-0000Gt-PU
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 15:45:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753600Ab2IQNpY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 09:45:24 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:60333 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752452Ab2IQNpX (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Sep 2012 09:45:23 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 1EBBD209C3;
	Mon, 17 Sep 2012 09:45:23 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 17 Sep 2012 09:45:23 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=hdiXrxEpayObdcAbvX2JCs
	v95/g=; b=XSfwlI+4GydneaY4MbjzziSaaGyuD6D0Nhy38/gedQTHWOJvyJR3l9
	2/9KyEEq1688pG8rufTx9+uDck5QI4VIRiML1Np4n4xOWUyLrfa+WEX8XgInh9mo
	p5xYnzzsRIr7EBWIsjhRRue40bPsdnNmKWTkrs6yeyoDoa3GhikK0=
X-Sasl-enc: AaJNHgugDfDY0PqR8xaHUDigJTfi2M9fo2F2oVe89XaD 1347889522
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 5F9454836E7;
	Mon, 17 Sep 2012 09:45:22 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <84EA18831601B6429E578236AE239B01A5498B52A3@EAGNMNSXMB07.usa.dce.usps.gov>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205689>

Mestnik, Michael J - Eagan, MN - Contractor venit, vidit, dixit
17.09.2012 14:12:
> 
>> -----Original Message-----
>> From: Junio C Hamano [mailto:gitster@pobox.com] 
>> Sent: Friday, September 14, 2012 4:24 PM
>> To: Michael J Gruber
>> Cc: Johannes Sixt; Mestnik, Michael J - Eagan, MN - 
>> Contractor; git@vger.kernel.org
>> Subject: Re: Using Format/export-subst Howto.
>>
>> Michael J Gruber <git@drmicha.warpmail.net> writes:
>>
>>> you need to "rm file && git checkout file"). If the user 
>> has to update
>>> $Id$ to match the current sha1
>>> (by remembering to do a more forceful checkout than 
>> checkout -f) then
>>> one half of that feature is useless. 
>>
>> As if there is any value in "$Id$" _feature_.  It's a checkbox item,
>> nothing more ;-).
>>
> 
> I agree here, $Id$ is much more useful in rcs/cvs.  That's why I chose to dive into export-subst, because I wanted my output to not only contain the uniq Id of the script but also the time and user of the last edit.
> 
> I'm going to read up on export today.  Just for context I'm using git to manage daily cron scripts, run on about 1,000 hosts, located on NFS.  I've moved the editing of the scripts into user's home directories as I'm a fan of not using editors on live data.  The key point is that when sudoing to the shared user who manages the files the commands run should be minimal and "pushd; ln -s ... .git; git pull; rm .git; popd;" works well.  If I can replace this with something that would populate these fields that would be awesome.

I'm not completely sure about the setup, but something like

GIT_DIR=fromthisrepo git archive usethisbranchortag |
git tar -xf- -C thereyougo

may do the job (and expand export-subst formats).

Cheers
Michael
