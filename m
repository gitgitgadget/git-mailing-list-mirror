From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [1.8.0] make two-argument fetch update remote branches
Date: Tue, 01 Feb 2011 16:05:54 -0500
Message-ID: <4D4875B2.4070008@gmail.com>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org> <7vwrll57ha.fsf@alter.siamese.dyndns.org> <201101312244.10047.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Feb 01 22:11:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkNVR-00044V-MV
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 22:11:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752729Ab1BAVLP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Feb 2011 16:11:15 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:49734 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752215Ab1BAVLO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Feb 2011 16:11:14 -0500
Received: by vws16 with SMTP id 16so2577042vws.19
        for <git@vger.kernel.org>; Tue, 01 Feb 2011 13:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:disposition-notification-to:date
         :from:user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=c7iCdV5W2KFXIfT/MvHAwV2mO+PDddec3OQTDaWEebE=;
        b=o3LQhOr4NXwy3oxcqKQO27u+W1tZegrQVejm6lVmtc4qhUAqtr9owWA+VzRYRg68YY
         DeBSURxi7cijkq4+e0HYMYtky2irZeQ5tRiJuni9+UV9uYMHyxCOscOfNOChqWnHsIX7
         hC/ytZ6CmI8rvU4W7qMcQynZ7+MFr+KjZYT0A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        b=Seyjp460WqVgOfvpldjFLiIucXVhOFgSP22aC3QOp/dKtLiLh6+1crt+/EbiPjIeqL
         C2vJinBTC0DW5y5ofPcAK9QBLCUTRYBeh0V1vxDpQ+I3xXFBJKcx+j8NSmeYsUGLVesU
         6lWJf5YfunAExhWeQ0ulZX2xb6MqiAcnIxZBo=
Received: by 10.220.192.198 with SMTP id dr6mr2155145vcb.49.1296594358236;
        Tue, 01 Feb 2011 13:05:58 -0800 (PST)
Received: from [10.0.1.130] (cpe-67-248-185-165.nycap.res.rr.com [67.248.185.165])
        by mx.google.com with ESMTPS id u4sm7738177vch.36.2011.02.01.13.05.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Feb 2011 13:05:56 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.16) Gecko/20101226 Icedove/3.0.11
In-Reply-To: <201101312244.10047.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165854>

On 01/31/2011 04:44 PM, Thomas Rast wrote:
> Proposal:
>
> Running "git fetch origin master" only updates FETCH_HEAD, not
> origin/master, which turns out to be quite confusing for newcomers
> especially after running 'git pull origin master'.
>
> Since the remote branches in some sense reflect the "last known state"
> of the remote, it would make sense to also update them to whatever a
> two-argument fetch got.
>

If this is proposing to break:

	get-fetch ${REPO} ${SRC_REF}:${DST_REF}

then I am against this since that form _is_ used and *is* plumbing.
