From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 0/9] Introduce publish tracking branch
Date: Fri, 11 Apr 2014 14:16:09 -0500
Message-ID: <53483f7984cb8_2c1f6e72ecc0@nysa.notmuch>
References: <1397156686-31349-1-git-send-email-felipe.contreras@gmail.com>
 <vpqtxa0jkfo.fsf@anie.imag.fr>
 <20140411142504.GA25376@nysa.casa.local>
 <vpqd2gng4nl.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>,
	John Szakmeister <john@szakmeister.net>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 11 21:26:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYh5c-0007BI-AA
	for gcvg-git-2@plane.gmane.org; Fri, 11 Apr 2014 21:26:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753905AbaDKT0L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2014 15:26:11 -0400
Received: from mail-oa0-f52.google.com ([209.85.219.52]:62262 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751462AbaDKT0J (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2014 15:26:09 -0400
Received: by mail-oa0-f52.google.com with SMTP id l6so6560696oag.25
        for <git@vger.kernel.org>; Fri, 11 Apr 2014 12:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=tWhSJFY7j9R89bfVHxEZW+iloh0cebJbgBXdKvA5vso=;
        b=eik/XS0ZDpyM8I60mHX+fLsYK8Y5mfkNckoqiVLLnBaaFgHe/w8rpDkp59fMYahzFt
         FuJEL3sNEwWkCLnGhtWvp1UI9V9EBYjbRQZCi9iTzslE3LlS3yFlgxa0HTFmB0E5W/70
         /i29xykQuZYLjzcVdABexnsipL9cMQFyGgykDT78fDtelNLPNUHX5it7EdkJ6DnKQtz3
         WjqBlhD2mNL51wxCBsjT8Z9rZJDxlWtF1sRlDW3FO2iesHyvXaCN3bcuAAn0jDHYcKnK
         W2nnyyLk3JlYrwzPTY99gqdH2h9KhK9AqzihQW/coVEP4k13byfhEF/YsByo6MpeWcqE
         yT/g==
X-Received: by 10.60.162.7 with SMTP id xw7mr20849971oeb.13.1397244369246;
        Fri, 11 Apr 2014 12:26:09 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id dh8sm34952369oeb.10.2014.04.11.12.26.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Apr 2014 12:26:08 -0700 (PDT)
In-Reply-To: <vpqd2gng4nl.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246135>

Matthieu Moy wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > My patch series only affects push.default=simple, perhaps you have a
> > different configuration.
> 
> Good catch. I have push.default=upstream (essentially for compatibility
> with old Git versions, I'd prefer simple actually).
> 
> > Maybe we want the publish branch to override any push.default, so:
> 
> Not sure actually. If a user says "push.default=upstream", it seems
> weird to push to something other than upstream indeed. What's clear to
> me is that your patch in its current form clearly makes "simple" a much
> better default than "upstream" (good news, it it the default!).

As you said in another email; that's just the default. If the user explicitely
told Git to use certain branch (git push -p), Git should use that branch.

> That said, the advice given by "git status" is clearly wrong:
> 
> > >   $ git status
> > >   On branch master
> > >   Your branch is ahead of 'origin/new' by 4 commits.
> > >     (use "git push" to publish your local commits)
> 
> It should say (use "git push origin new" to publish your local commits)
> with push.default=upstream and the current behavior of the patch.
> 
> Perhaps argumentless "git push" could warn when push.default=upstream
> and branch.<name>.publish is configured, I'm not sure.
> 
> Sorry, more questions and "I'm not sure" than actual suggestion :-(.

I believe in v3 of the patch series "git push" will actually do it correctly.

Cheers.

-- 
Felipe Contreras
