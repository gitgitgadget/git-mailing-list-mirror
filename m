From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH 1/4] git p4: bring back files in deleted client directory
Date: Mon, 30 Apr 2012 07:55:39 +0100
Message-ID: <4F9E376B.1000107@diamand.org>
References: <1335747437-24034-1-git-send-email-pw@padd.com> <1335747437-24034-2-git-send-email-pw@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Gary Gibbons <ggibbons@perforce.com>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Mon Apr 30 08:55:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOkWR-0006Aa-D3
	for gcvg-git-2@plane.gmane.org; Mon, 30 Apr 2012 08:55:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751875Ab2D3Gzn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Apr 2012 02:55:43 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:64216 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752619Ab2D3Gzm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 02:55:42 -0400
Received: by eekc41 with SMTP id c41so597574eek.19
        for <git@vger.kernel.org>; Sun, 29 Apr 2012 23:55:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=bFFKGg7l56nf+ADl6OYxTzGB8E5Weck2P63rc2zAJkU=;
        b=K4daiu6OC5PLC9aHWDv6yBiMHzmENdTLgVpfQxFo4sMlwPo30ZT/9IlF+nq+2V7HKF
         Nfj0J9tIABz28MatEgRIVAy/DY4h5ILbpei5RRLgUkiJ2RHWNS0iQmL5vbhL5Ugk5ipJ
         MBiNO9XqHW+xT7rhoR05Pri1uhsgPCzuihJijDE/AXOdMc5X0wHE53KhyQUBIwEs07Vz
         ES33q7pzbIL00jG8d8WJkCFiGSUMfl2BQsRCKjnjrjIw51S4xOoDHJXmM4GoZya7EOcq
         PSQVxwiSo/4qU5NGpE7nksm5lyHwH08cTjkcuZTpA6kuYe7rjnYkcJawxt84+zgZsHDh
         0iqQ==
Received: by 10.213.113.203 with SMTP id b11mr1478988ebq.164.1335768940703;
        Sun, 29 Apr 2012 23:55:40 -0700 (PDT)
Received: from [86.6.30.7] (cpc19-cmbg14-2-0-cust6.5-4.cable.virginmedia.com. [86.6.30.7])
        by mx.google.com with ESMTPS id z47sm70173169een.5.2012.04.29.23.55.39
        (version=SSLv3 cipher=OTHER);
        Sun, 29 Apr 2012 23:55:40 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
In-Reply-To: <1335747437-24034-2-git-send-email-pw@padd.com>
X-Gm-Message-State: ALoCoQluzcsRCnUtbb9hNShX3BG2FbXCQTRnrZpS1pOjb6nIqq60zo/KDKS6RZt85PXldh6+i5BB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196543>

On 30/04/12 01:57, Pete Wyckoff wrote:
> The code to auto-create the client directory, added in 0591cfa
> (git-p4: ensure submit clientPath exists before chdir,
> 2011-12-09), works when the client directory never existed.
>
> But if the directory is summarily removed without telling p4,
> the sync operation will not bring back all the files.  Always
> do "sync -f" if the client directory is newly created.

I'm possibly missing something obvious here, but 
./t9807-git-p4-submit.sh fails with this change.

Rebasing the current branch onto remotes/p4/master
First, rewinding head to replay your work on top of it...
File file1 doesn't exist. file1
not ok - 3 submit with no client dir

Luke
