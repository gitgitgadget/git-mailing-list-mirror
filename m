From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH] rebase -m: skip cherry-picked commits more reliably
Date: Wed, 24 Nov 2010 07:53:49 +0100 (CET)
Message-ID: <alpine.DEB.1.10.1011240746030.17721@debian>
References: <1290467372-6487-1-git-send-email-Knut.Franke@gmx.de> <alpine.DEB.1.10.1011232156510.17721@debian>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Knut Franke <Knut.Franke@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 24 13:53:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLEr4-00025S-Ip
	for gcvg-git-2@lo.gmane.org; Wed, 24 Nov 2010 13:53:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754223Ab0KXMxl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Nov 2010 07:53:41 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:52376 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753985Ab0KXMxk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Nov 2010 07:53:40 -0500
Received: by qyk11 with SMTP id 11so4115055qyk.19
        for <git@vger.kernel.org>; Wed, 24 Nov 2010 04:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:x-x-sender:to:cc
         :subject:in-reply-to:message-id:references:user-agent:mime-version
         :content-type;
        bh=F2s9itXZMkZQ4jdjyBqQmfs2VzFHxeXTldFUw+gaF+A=;
        b=f97uMWuOy3NF1YWBRDUA3Yqie1PuNd9yj2hCw6WpcaCLBuA367MeIATdYUbX/gn+Eg
         vHZw6iS26qOLCbNAj99MNH33RM91ZpciPyVWuGu1h3R59VJw9CZUn41jBIoKSWcAnuPZ
         pOqnLV2n8bP2b3J9TeDsEyzx//3boqKc0dzFY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        b=TRAWb9MdBf8l+11IDVp/AjZUv2UGKTFCm9yYIR+CaalkqamNrI907Z8YZ0Ks79SktP
         jlEt2ziGvfQjilPVpOReJc2U7Syn9qir1g+fg1kfcmkQouEQXlqy/E/BCBPUUhT4MvzM
         jTsfddJnRywJ9C9HcUiZk8Xp/eJz4gnvx3X4E=
Received: by 10.224.10.198 with SMTP id q6mr7560338qaq.284.1290603217214;
        Wed, 24 Nov 2010 04:53:37 -0800 (PST)
Received: from [192.168.1.103] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id t35sm4378997qco.6.2010.11.24.04.53.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 24 Nov 2010 04:53:36 -0800 (PST)
X-X-Sender: martin@debian
In-Reply-To: <alpine.DEB.1.10.1011232156510.17721@debian>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162060>



On Tue, 23 Nov 2010, Martin von Zweigbergk wrote:

> What I think we really want to do is to remove any patches in
> upstream..branch that also exist in branch..onto. I don't know how to
> do that efficiently, though. (And am I even right about it?)

To try to answer my own question, would the lines prefixed with a plus
in the output of 'git cherry $onto $branch $(git merge-base $upstream
$branch)' work?

/Martin
