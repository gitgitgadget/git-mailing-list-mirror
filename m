From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH 0/3] request-pull: do something if $3 is passed
Date: Tue, 17 Feb 2015 21:34:42 +0100
Message-ID: <54E3A5E2.6060806@gnu.org>
References: <1424110568-29479-1-git-send-email-bonzini@gnu.org>	<xmqqiof163kk.fsf@gitster.dls.corp.google.com>	<54E31405.5040502@gnu.org> <xmqqvbj01fbz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 21:34:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNor9-0004AE-QJ
	for gcvg-git-2@plane.gmane.org; Tue, 17 Feb 2015 21:34:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752606AbbBQUew (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2015 15:34:52 -0500
Received: from mail-we0-f173.google.com ([74.125.82.173]:33595 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752092AbbBQUev (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2015 15:34:51 -0500
Received: by wevk48 with SMTP id k48so740726wev.0
        for <git@vger.kernel.org>; Tue, 17 Feb 2015 12:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=IpanKEJ7USSuZ1FFofvu6+6db3J2Hpb2GWTBZX4EHj4=;
        b=OnfK3rIFTAmVfimwD2Mf+UDjD8ZHehnwg3TBz+rM/XMwyNNOWY2Z60sRhl7s+z9Ou8
         rMtURhJ3gV5QLKRsA9IxOYXkCV1LMYst2D2eRDIROoMzxSs/f/qm7cPa6jMCKw3wFSWZ
         8XacQxVCRJkjb+WX3VZPspnALvGnbQAgOw6Wsi0ePgYliGXJGE5GjSvKdTaUxUTSxCKY
         D4EfuB7WyUYUvJzb5QaT6lajADQsWuM0r1J4U1Pom9Ai41MMey3Y+hYmWnZMElyDDNOF
         z7vDeDwOjemUIC1VY5yhQYJlD/xtnKwD+CJQ1bN0JlhEjDGw41+jfepT1kryojn4URR9
         DPvw==
X-Received: by 10.180.8.65 with SMTP id p1mr38335602wia.42.1424205289942;
        Tue, 17 Feb 2015 12:34:49 -0800 (PST)
Received: from [192.168.10.150] (net-93-66-73-217.cust.vodafonedsl.it. [93.66.73.217])
        by mx.google.com with ESMTPSA id j6sm21178520wiz.17.2015.02.17.12.34.44
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Feb 2015 12:34:48 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <xmqqvbj01fbz.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263980>



On 17/02/2015 20:57, Junio C Hamano wrote:
> Sorry, I was asking what you mean by "complains" (i.e. the exact
> error message).  I was and am guessing it is something like this: 
> 
>     warn: No match for commit 3188ab3... found at <url>
>     warn: Are you sure you pushed 'HEAD' there?

Yes, it is.

> Asking to pull 'HEAD' may be often a wrong thing to do, and I
> wouldn't mind if this sequence:
> 
> 	git checkout kvm-next
>         git request-pull origin/master <url>
> 
> behaved the same way as
> 
>         git request-pull origin/master <url> kvm-next

FWIW, that would always be wrong for my scenario.

> But I do not know if the implicit HEAD should DWIM locally to this:
> 
>         git request-pull origin/master <url> for-linus

I guess only Linus could answer that, since he wrote 024d34cb0 and he
knows the intent better than anyone else.

Paolo
