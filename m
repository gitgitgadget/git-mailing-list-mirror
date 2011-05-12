From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/8] Sequencer Foundations
Date: Thu, 12 May 2011 06:44:15 -0500
Message-ID: <20110512114415.GA14724@elie>
References: <1305100822-20470-1-git-send-email-artagnon@gmail.com>
 <20110511131356.GI2676@elie>
 <BANLkTi=zXWojMOfe9sECUu-X9euCjr4i3w@mail.gmail.com>
 <20110512084136.GD28872@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 12 13:44:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKUJh-0008OB-BW
	for gcvg-git-2@lo.gmane.org; Thu, 12 May 2011 13:44:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755981Ab1ELLoY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2011 07:44:24 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:55387 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754987Ab1ELLoY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2011 07:44:24 -0400
Received: by iwn34 with SMTP id 34so1331528iwn.19
        for <git@vger.kernel.org>; Thu, 12 May 2011 04:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=S8y7rDJu7yjcxSBS5d83uGIJLbmkopvb+y+281gDT6k=;
        b=F7YOnXB3Y6haQaf2LB6JeygLb5U5uzYxefnxiAVgvUpLwfqmMzHsIPQcEQQSR3Nqdt
         +H9J/f9h2ztGWEetVrKJbIfY+v8OI5rjGdGyNHBBUlbz5FbLNnoBWkPH6M71jmbvJWtK
         hGLfWARthItMxRp+gRKlwKIII8XAYez1xO5JQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=IBpuRD7r4oabVyE8R1IXynwrQQc2H44NA1DjtWqXkTJmtmk6mEndecs+q8Khn2GhXE
         3pISyeUMOtJVm7n6jNT8kZwOZDUksmdt/S4x3zUDQdPnRlqB3hg6sMDbpmOl1jR5xxR6
         tdt+YfAAYrK+3X5L8pg0qgAyUhi0+j2hxyKKE=
Received: by 10.42.131.194 with SMTP id a2mr111539ict.229.1305200663600;
        Thu, 12 May 2011 04:44:23 -0700 (PDT)
Received: from elie (adsl-69-209-56-134.dsl.chcgil.sbcglobal.net [69.209.56.134])
        by mx.google.com with ESMTPS id e12sm447615ics.7.2011.05.12.04.44.21
        (version=SSLv3 cipher=OTHER);
        Thu, 12 May 2011 04:44:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110512084136.GD28872@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173462>

Jonathan Nieder wrote:
> Christian Couder wrote:

>> I think that the risk at this point might be to overengineer things
>> and to lose time, and then we will perhaps find out that we need to do
>> some refactoring of the merge_recursive API anyway.
>
> I agree with the general principle... let's see if I understand the
> details of what you are saying.

It occurs to me now that you were probably talking about the
suggestion of using the lockfile API (i.e., the write temporary/rename
trick).  In that case, I agree --- no need to overengineer it and
concurrency problems can be fixed later.  Sorry for an overcomplicated
explanation.

And thanks for looking out for these things.
