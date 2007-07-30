From: Eric Lesh <eclesh@ucla.edu>
Subject: Re: [GUILT PATCH 3/4] guilt-select: Select guards to apply when pushing patches
Date: Mon, 30 Jul 2007 00:02:26 -0700
Message-ID: <87fy36cr25.fsf@hubert.paunchy.net>
References: <118569541814-git-send-email-eclesh@ucla.edu>
	<11856954182318-git-send-email-eclesh@ucla.edu>
	<20070730041231.GE22017@filer.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jsipek@cs.sunysb.edu, git@vger.kernel.org
To: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
X-From: git-owner@vger.kernel.org Mon Jul 30 09:02:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFPHM-0000Zl-L6
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 09:02:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S938005AbXG3HCl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 03:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937845AbXG3HCl
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 03:02:41 -0400
Received: from smtp-7.smtp.ucla.edu ([169.232.46.138]:46903 "EHLO
	smtp-7.smtp.ucla.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763869AbXG3HCk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 03:02:40 -0400
Received: from mail.ucla.edu (mail.ucla.edu [169.232.47.145])
	by smtp-7.smtp.ucla.edu (8.13.8/8.13.8) with ESMTP id l6U72XuE024731;
	Mon, 30 Jul 2007 00:02:33 -0700
Received: from localhost (adsl-75-26-169-114.dsl.scrm01.sbcglobal.net [75.26.169.114])
	(authenticated bits=0)
	by mail.ucla.edu (8.13.8/8.13.8) with ESMTP id l6U72WDC026507
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 30 Jul 2007 00:02:32 -0700
Received: by localhost (Postfix, from userid 1000)
	id 989401E80A8; Mon, 30 Jul 2007 00:02:26 -0700 (PDT)
In-Reply-To: <20070730041231.GE22017@filer.fsl.cs.sunysb.edu> (Josef Sipek's message of "Mon\, 30 Jul 2007 00\:12\:31 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.0 (gnu/linux)
X-Probable-Spam: no
X-Spam-Report: none
X-Scanned-By: smtp.ucla.edu on 169.232.46.138
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54194>

Josef Sipek <jsipek@fsl.cs.sunysb.edu> writes:

[...]

>> +if [ $# == 0 ]; then
>> +	if [ -s "$guards_file" ]; then
>> +		cat "$guards_file"
>
> Later on, for the -s option processing, you sort (presumably to have uniq do
> the right thing), should we sort here too to be consitent?
>

The $guards_file isn't really meant to be handed edited, and
guilt-select itself sorts before it stores them in the guards file.  I could
sort it again on printing, but don't think it's necessary.

>> +
>> +case $1 in
>> +	-n|--none)
>> +		rm -f "$guards_file"
>> +		touch "$guards_file"
>
> Since guilt-init doesn't create the guards file, I'm thinking that this
> should be just a rm -f ...

Should guilt-init create it?  I added $guards_file to guilt(7), so not
seeing it might freak Documentation-conscious readers out?

	Eric
