From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH v2 3/3] git-p4: Add test case for complex branch import
Date: Sat, 21 Jan 2012 10:51:15 +0000
Message-ID: <4F1A98A3.2090607@diamand.org>
References: <1327105292-30092-1-git-send-email-vitor.hda@gmail.com> <1327105292-30092-4-git-send-email-vitor.hda@gmail.com> <7vehutd59p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Vitor Antunes <vitor.hda@gmail.com>, git@vger.kernel.org,
	Pete Wyckoff <pw@padd.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 21 11:51:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RoYXc-0003TP-Kz
	for gcvg-git-2@lo.gmane.org; Sat, 21 Jan 2012 11:51:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753688Ab2AUKvU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jan 2012 05:51:20 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:60142 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750918Ab2AUKvT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jan 2012 05:51:19 -0500
Received: by werb13 with SMTP id b13so1060430wer.19
        for <git@vger.kernel.org>; Sat, 21 Jan 2012 02:51:18 -0800 (PST)
Received: by 10.216.144.160 with SMTP id n32mr818962wej.5.1327143078210;
        Sat, 21 Jan 2012 02:51:18 -0800 (PST)
Received: from [86.26.7.206] (cpc1-cmbg14-2-0-cust973.5-4.cable.virginmedia.com. [86.26.7.206])
        by mx.google.com with ESMTPS id di5sm18628860wib.3.2012.01.21.02.51.16
        (version=SSLv3 cipher=OTHER);
        Sat, 21 Jan 2012 02:51:17 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
In-Reply-To: <7vehutd59p.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188922>

On 21/01/12 04:54, Junio C Hamano wrote:
> Vitor Antunes<vitor.hda@gmail.com>  writes:
>
>> +		grep -q update file2&&
>
> Do you really need to use "-q" here?  Wouldn't it help if you wrote it
> without it while debugging tests with "sh ./t9801-*.sh -v"?
>
> Also how does this series interact with the series Luke posted earlier on
> branches and labels?

Vitor's series applies cleanly to my changes.

However, one thing I noticed in reading through is that it will break if 
you end up importing a P4 branch that has spaces (or other shell chars) 
in its name. A quick test confirms this.

- the code doesn't handle the names properly
- git and p4 have different ideas about valid branch names

But before rejecting Vitor's changes because of that it would be worth 
considering whether we care (much). My own opinion is that if you have 
developers who are daft enough to put spaces or dollars in their branch 
names then their project is already doomed anyway....

Perhaps it would be enough just to issue a warning ("your project is 
doomed; start working on your CV") and skip such branch names rather 
than falling over with inexplicable error messages.


>
> Thanks.
