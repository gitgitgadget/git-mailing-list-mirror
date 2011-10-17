From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH] Git-p4: git-p4.changeOnSubmit to do 'change' instead
 of 'submit'.
Date: Mon, 17 Oct 2011 19:53:18 +0100
Message-ID: <4E9C799E.70700@diamand.org>
References: <83923897.7841.1318868319131.JavaMail.root@zimbra-prod-mbox-2.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, Pete Wyckoff <pw@padd.com>,
	Andrei Warkentin <andreiw@vmware.com>
To: Andrei Warkentin <awarkentin@vmware.com>
X-From: git-owner@vger.kernel.org Mon Oct 17 20:53:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFsJT-0002fl-15
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 20:53:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751716Ab1JQSxX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Oct 2011 14:53:23 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:57389 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751217Ab1JQSxW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Oct 2011 14:53:22 -0400
Received: by wyg36 with SMTP id 36so2538287wyg.19
        for <git@vger.kernel.org>; Mon, 17 Oct 2011 11:53:21 -0700 (PDT)
Received: by 10.227.32.73 with SMTP id b9mr5990644wbd.49.1318877601203;
        Mon, 17 Oct 2011 11:53:21 -0700 (PDT)
Received: from [86.26.7.206] (cpc1-cmbg14-2-0-cust973.5-4.cable.virginmedia.com. [86.26.7.206])
        by mx.google.com with ESMTPS id fy13sm32686533wbb.18.2011.10.17.11.53.18
        (version=SSLv3 cipher=OTHER);
        Mon, 17 Oct 2011 11:53:19 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
In-Reply-To: <83923897.7841.1318868319131.JavaMail.root@zimbra-prod-mbox-2.vmware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183807>

On 17/10/11 17:18, Andrei Warkentin wrote:
> Hi,
>
> ----- Original Message -----
> Anyway, the other suggestion I had was to create a new command
> instead of overriding behaviour of an existing one. Of course,
> copy-pasting P4Submit into P4Change is silly, so...
>
> How about something like this?
>
> The commands dict maps command name to class and optional dict passed to cmd.run(). That way 'change'
> can really mean P4Submit with an extra parameter not to submit but to do a changelist instead. The
> reason why I initially made the config flag was because I didn't want to copy-paste P4Submit into P4Change.
>
> commands = {
>      "debug" : [ P4Debug, {} ]
>      "submit" : [ P4Submit, { "doChange" : 0 } ]
>      "commit" : [ P4Submit, { "doChange" : 0 } ]
>      "change" : [ P4Submit, { "doChange" : 1 } ]
>      "sync" : [ P4Sync, {} ],
>      "rebase" : [ P4Rebase, {} ],
>      "clone" : [ P4Clone, {} ],
>      "rollback" : [ P4RollBack, {} ],
>      "branches" : [ P4Branches, {} ]
> }
>
> Thanks for the review,
> A
>

Sounds plausible to me. The alternative would be a command line 
parameter, although that could get annoying and error prone, especially 
as you can't easily unsubmit a perforce change.
