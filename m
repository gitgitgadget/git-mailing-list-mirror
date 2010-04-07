From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH/RFC] gitk: refresh index before checking for local changes
Date: Wed, 07 Apr 2010 07:21:53 -0400
Message-ID: <4BBC6AD1.80202@gmail.com>
References: <l2hc6c947f61004061557x8085600fif5e973077d9eb4f3@mail.gmail.com> <20100406233601.GA27533@progeny.tock> <n2kc6c947f61004061647ybb6c2f55zc70197362764ef8@mail.gmail.com> <20100407004353.GA11346@progeny.tock> <4BBBEC43.5000100@gmail.com> <7vfx37g6f6.fsf@alter.siamese.dyndns.org>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Alexander Gladysh <agladysh@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 07 13:22:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzTKf-00021F-2F
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 13:22:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757577Ab0DGLV5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Apr 2010 07:21:57 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:15415 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756065Ab0DGLV4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Apr 2010 07:21:56 -0400
Received: by qw-out-2122.google.com with SMTP id 8so329014qwh.37
        for <git@vger.kernel.org>; Wed, 07 Apr 2010 04:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=yysYhvcH+1LgoEfalmtE9z8plJOPOq3A4O0d4Vhl9Lw=;
        b=n7CUnPPvN1M+5npvJwtDArImkx9xzg6cUjQoU+wAccpno41tHYrj/0TfRdUpDPvtlL
         WfWVggv9eHhX8RG77OSTsuiVM+pCT1J77CawIHLFPMb28a13co0swsBabjOHmQ6siJ6r
         DNHXPdcOmdm34JzFUEvBR9SuJgJoszo0PDQMo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=N8QpJTs35wU2LRGl/oIVqDpfGaf6zVas+XQRHKMj2lYiPtwj7/3eyqcNqm+l0UaMNV
         3PujfxHqd6Ur1GTo8T8EaPgXSIqjlnyllS3s1GGyu3VLBOgkd9jidMFRhiiMJE4LMdoE
         sitBjrQ66Qvnyb0zspF690Sy/8gIR/kw30nr4=
Received: by 10.229.190.21 with SMTP id dg21mr3434881qcb.69.1270639315672;
        Wed, 07 Apr 2010 04:21:55 -0700 (PDT)
Received: from [10.0.0.6] (c-71-199-240-201.hsd1.fl.comcast.net [71.199.240.201])
        by mx.google.com with ESMTPS id v26sm7805728qce.7.2010.04.07.04.21.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 07 Apr 2010 04:21:54 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <7vfx37g6f6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144213>

Junio C Hamano wrote:
> A Large Angry SCM <gitzilla@gmail.com> writes:
> 
>> NAK - gitk should not modify a repository and/or working dir unless
>> _explicitly_ prompted to by the user.
> 
> I used to think that way, until I realized that gitk has operations like
> "Tag this commit" that does write into the repository.
> 

Does that happen every time you run gitk or only when the gitk user 
instructs gitk to?
