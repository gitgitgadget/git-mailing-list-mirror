X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [RFC] Submodules in GIT
Date: Fri, 1 Dec 2006 10:29:26 +0000
Message-ID: <200612011029.28059.andyparkins@gmail.com>
References: <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net> <200612010919.06030.andyparkins@gmail.com> <20061201095751.GK18810@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 1 Dec 2006 10:29:39 +0000 (UTC)
Cc: Martin Waitz <tali@admingilde.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=keQe2vPjr30mzK/DE6rWNYdvitbRqvBN0eCwr7ynQvds5C0LNQ12iNehNvWoZjAZCe8s/3RZ333DcgXNea45WHmxyZRWaYn2aZz3D/aSh6VSRW5zV4LP+SCXRJCr+SVffLGwTwyAu1GusTtrH/JJma3TIYYY0r8FOAUynMksrzs=
User-Agent: KMail/1.9.5
In-Reply-To: <20061201095751.GK18810@admingilde.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32885>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gq5eD-00032E-JJ for gcvg-git@gmane.org; Fri, 01 Dec
 2006 11:29:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936127AbWLAK3e (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 05:29:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936131AbWLAK3e
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 05:29:34 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:29719 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S936127AbWLAK3e
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 05:29:34 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2380914uga for
 <git@vger.kernel.org>; Fri, 01 Dec 2006 02:29:32 -0800 (PST)
Received: by 10.67.99.1 with SMTP id b1mr7006220ugm.1164968972485; Fri, 01
 Dec 2006 02:29:32 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id 29sm23731749uga.2006.12.01.02.29.30; Fri, 01 Dec 2006 02:29:31 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Friday 2006 December 01 09:57, Martin Waitz wrote:

> So why do you need the url hint committed to the supermodule?
> We don't store remote information in the object database, too.

That's why it was a hint, probably configured when you first create the 
submodule connection.

> Remember: this is still a distributed project, there is no one URL to
> any submodule.

That point applies equally to your "tracking a submodule branch" point, except 
mine is only a URL hint, to help when first cloning that supermodule.  In 
truth, the clone will be perfectly able to get the submodule objects from the 
upstream supermodule, maintaining the distributed nature easily.

> > I say:
> >  submodulecommithash points at a commit /in the submodule/
>
> But unluckily, this does not work.

Eh?  "Not work", we're talking about code that doesn't even exist, of course 
it doesn't "work".   Do you mean "doesn't work if we're using my 
implementation of submodules"?  Well that hardly seems like a fair attack.

> You really have to be able to traverse the entire commit chain
> from the supermodule into all submodules.

You can: when you hit a submodule tree object you set GIT_DIR to that 
submodule and continue.  If you don't do it like that then you have stored 
submodule trees in the supermodule and it's no longer a separate repository.  
Why you'd want to - I have no idea.  What purpose would you have for 
traversing the commit chain into the submodules?  The commit in the submodule 
is just a note of where that submodule was during the supermodule commit in 
question.

I notice though that you avoided my question: what does YOUR submodule object 
contain?  I really do want to know, as there is obviously a fundamental 
difference in what I think a submodule does and what you (and maybe everybody 
else) thinks a submodule does.  I'm perfectly willing to accept I'm wrong, 
but not without understanding how your method is going to work.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
