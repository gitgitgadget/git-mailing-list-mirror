From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Intricacies of submodules
Date: Thu, 17 Apr 2008 18:25:01 -0300
Message-ID: <46a038f90804171425q1cc4cff4m6b783252040a3b26@mail.gmail.com>
References: <47F15094.5050808@et.gatech.edu>
	 <7vlk3jlkrr.fsf@gitster.siamese.dyndns.org>
	 <1208202740.25663.69.camel@work.sfbay.sun.com>
	 <7vd4or7wdt.fsf@gitster.siamese.dyndns.org>
	 <1208317795.26863.91.camel@goose.sun.com>
	 <87lk3c4ali.fsf@jeremyms.com>
	 <1208461808.26863.129.camel@goose.sun.com>
	 <46a038f90804171306t22491685p87d7445d44f00879@mail.gmail.com>
	 <7vabjsnrda.fsf@gitster.siamese.dyndns.org>
	 <bd6139dc0804171400x515b3c8br3cb1501cca8a6d0a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Roman V. Shaposhnik" <rvs@sun.com>,
	"Jeremy Maitin-Shepard" <jbms@cmu.edu>,
	"Ping Yin" <pkufranky@gmail.com>,
	"Avery Pennarun" <apenwarr@gmail.com>,
	stuart.freeman@et.gatech.edu, git@vger.kernel.org
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Thu Apr 17 23:38:33 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jmbc6-0000un-UB
	for gcvg-git-2@gmane.org; Thu, 17 Apr 2008 23:25:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752071AbYDQVZF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2008 17:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752153AbYDQVZE
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Apr 2008 17:25:04 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:17959 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751663AbYDQVZD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2008 17:25:03 -0400
Received: by ug-out-1314.google.com with SMTP id z38so1248248ugc.16
        for <git@vger.kernel.org>; Thu, 17 Apr 2008 14:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Zn+rYi9UlwgjENYK2lJlh2pIWJFleu7A77SDkcMyPtw=;
        b=Viyw+7+/zbiwP3iFAIzoQNgtLGo18CRNvTWQ9EcDzUCEaTh1/LVRJPdQcSEgNPPCDOpOkNL/A31VQ2KB+pMV2nD/74ACmmnsq2ZuixVemiBDd+fpfSvs49WDobT2AN7vHuihRDZWchCQK9AfPFTqpT8UlikM4rIcxLN0GgiZZlI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=M6L1JrEG+REO202ppD0ZZTKqPJsA+VLNj2P3tyhaZ7KAo69YSYcfGtUXqKpmU9j5EYBHiQYceBGtVdT+u4yKR/CMe5g8Ypt3JTbPXIHGNhTK1SyKKDc+fBEmUHdruM5phq9UPdPSF1eb08WI9ftQaivn9aHI7jDJ07eBtoGObfY=
Received: by 10.66.243.2 with SMTP id q2mr9004725ugh.14.1208467501533;
        Thu, 17 Apr 2008 14:25:01 -0700 (PDT)
Received: by 10.66.252.2 with HTTP; Thu, 17 Apr 2008 14:25:01 -0700 (PDT)
In-Reply-To: <bd6139dc0804171400x515b3c8br3cb1501cca8a6d0a@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79834>

On Thu, Apr 17, 2008 at 6:00 PM, Sverre Rabbelier <alturin@gmail.com> wrote:
>  provide any hooks to execute things (which of course includes changing
>  the environment) it should be fine, but if it is, it should be ignored
>  till after clone has finished.

It should not be allowed at all. After the clone is the review, and
that has to be safe too.

>  Because of that an in-tree '.gitconfig' would have no security risks
>  as long as it is not 'used' until after the clone.

This is not true. A pre-commit hook or pre-checkout hook could be destructive.

cheers,


m
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
