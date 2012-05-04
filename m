From: Andreas Ericsson <ae@op5.se>
Subject: Re: git gc == git garbage-create from removed branch
Date: Fri, 04 May 2012 09:37:21 +0200
Message-ID: <4FA38731.8010504@op5.se>
References: <hbf.20120503q14w@bombur.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Hallvard Breien Furuseth <h.b.furuseth@usit.uio.no>
X-From: git-owner@vger.kernel.org Fri May 04 09:37:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQD50-0001X6-KF
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 09:37:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753175Ab2EDHh0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 May 2012 03:37:26 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:37761 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751535Ab2EDHhZ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 May 2012 03:37:25 -0400
Received: by lahj13 with SMTP id j13so1813913lah.19
        for <git@vger.kernel.org>; Fri, 04 May 2012 00:37:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=9XqCROYWjso50wISZlfvbx6hNgioPYJScxz6wbK0ZKk=;
        b=JGHHBp61auCXA6wQXt1dqlKoAG37bv0SliqvaPozaGwFgZ7rgpVqJzeDuKoKitcB2R
         aLTo0d5CDjNraF5dEbw75dK06oZZw2RTDrNVYKMXpXqw1nxUGWCWrhF09MD00MRzzpvQ
         YVQrEhC0JcVlBv9jU7Deq89uugY453jynlcvBjhRPcGqs7NTkOj6p0IHZAvpIRVK9G/8
         H/fojqrolX844bCCaUnij3SlD7wZs2FNMfgFGUJWo3KA3zGK/PPhAlEQB79rJ5m6INV6
         4f69enp6eBFcfHt2/xPaJiITotec0h8oEcw3AxgyysK0z/its9Ny8Vucpl6sOWTWQuEY
         SngQ==
Received: by 10.112.10.202 with SMTP id k10mr2335513lbb.65.1336117043600;
        Fri, 04 May 2012 00:37:23 -0700 (PDT)
Received: from vix.int.op5.se (sth-vpn1.op5.com. [193.201.96.49])
        by mx.google.com with ESMTPS id i6sm9952161lbg.2.2012.05.04.00.37.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 04 May 2012 00:37:22 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120424 Thunderbird/12.0
In-Reply-To: <hbf.20120503q14w@bombur.uio.no>
X-Gm-Message-State: ALoCoQk8Yn+20qR6lh3ZTVC89m+QyRVvPUup80gn8zjp6jbhSFMsO7HF+aK+H5lx1Ta5+fcdb1Ae
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197004>

On 05/03/2012 08:38 PM, Hallvard Breien Furuseth wrote:
> After removing a branch, 'git gc' explodes all objects
> which were only in that branch.  Git filled up my disk that
> way when I had cherry-picked from a big remote repo and then
> did git remote rm.  Tested with Git 1.7.10.1 and 1.7.1.
> 

That's by design. It's added to save people who accidentally
delete a branch or for some other reason really want to keep the
objects they're about to delete.

Use 'git gc --prune=now' with a recent* git and you'll avoid the
problem.

* Recent enough to include the patch that avoids writing out loose
objects when they would be auto-deleted by the following pruning.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
