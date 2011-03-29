From: Joshua Juran <jjuran@gmail.com>
Subject: Re: how to squash two commits into only one
Date: Tue, 29 Mar 2011 06:12:15 -0700
Message-ID: <04C85603-1737-42BC-A037-2C45D5315435@gmail.com>
References: <AANLkTi=B37GABBc-YWfJN29Mh0kx4Tn8KenD5dJFo9j1@mail.gmail.com> <AANLkTi=7TNjLVrcJVppiULBnDdKCM_vqwhn1JqoW+DQo@mail.gmail.com> <AANLkTimsN40twLwOWXsQqbv0SVN7T9rEHSUpcVum8aFR@mail.gmail.com> <AANLkTikX5YvMrooVi-7e-YDrCP_7QHqL6wR=1bY1cZ2L@mail.gmail.com> <5A9D499C-26AC-401E-B21A-1F8E03FBAC4B@gmail.com> <AANLkTinjbXzdfkxVRPPSXJj6Z0mMrikzdi2V8N5YAGR-@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Lynn Lin <lynn.xin.lin@gmail.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 15:12:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4Yie-0004gt-6E
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 15:12:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752957Ab1C2NMT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 09:12:19 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:50159 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751876Ab1C2NMS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 09:12:18 -0400
Received: by iwn34 with SMTP id 34so158682iwn.19
        for <git@vger.kernel.org>; Tue, 29 Mar 2011 06:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        bh=wxMlcehJHXh5kefXO9El2VH+Ijnbmt2mphWaWsDIbnY=;
        b=ZGOlxqZ3GRKPzxKeLo6kOTtJNbPYLD66X8lNb4O1hrJbcpNx4PSDFWcjc3D3sljHpM
         WkQ807cIqBO0y0viZbB6tzUMAsahBRylMfhpkeKZ6Bs8KkAj6saxTuretJJsE9blsadq
         W0s6xpm9dSVJzHSHK73wOfk6ya8rHCVpwolZQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=sEYydKy6FgXcset529cGVCEqVDNexUEqIEZczle9FtwS5+9pGEiNPUGZhsGfSI0JKG
         fZced7k6ei3Wq3BBmgO+Ah91SIo6gqVH9rz2M6YT+Vv4PZA22QN918DkzVnoBvFlf4v7
         vyf4jgq/Nvj2BBBEVel9SUclxKh4KaoLi8+5w=
Received: by 10.42.29.5 with SMTP id p5mr249532icc.454.1301404338318;
        Tue, 29 Mar 2011 06:12:18 -0700 (PDT)
Received: from zaphod.jjuran.dyndns.org (c-71-227-175-60.hsd1.wa.comcast.net [71.227.175.60])
        by mx.google.com with ESMTPS id 13sm3658819ibo.25.2011.03.29.06.12.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 29 Mar 2011 06:12:17 -0700 (PDT)
In-Reply-To: <AANLkTinjbXzdfkxVRPPSXJj6Z0mMrikzdi2V8N5YAGR-@mail.gmail.com>
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170265>

On Mar 29, 2011, at 5:49 AM, Nguyen Thai Ngoc Duy wrote:

> On Tue, Mar 29, 2011 at 7:44 PM, Joshua Juran <jjuran@gmail.com>  
> wrote:
>> On Mar 29, 2011, at 3:58 AM, Alex Riesen wrote:
>>
>>> On Tue, Mar 29, 2011 at 12:10, Lynn Lin <lynn.xin.lin@gmail.com>  
>>> wrote:
>>>
>>>> only have two commits
>>>
>>> Than yes, "git reset HEAD^; git commit --amend" seems the best  
>>> solution.
>>
>> Actually, that should be:  `git reset --soft HEAD^; git commit -- 
>> amend`.
>
> "git rebase --root" does not seem a bad idea though. I need to amend
> initial commit a few times and end up using "git reset" without
> --soft.

Or perhaps have `git commit --amend` issue a warning if doesn't  
actually amend anything.  Sometimes you just want to change the commit  
message, so you wouldn't want a warning in that case.  But other times  
you're adding changes and updating the commit message at the same  
time, so you'd want a warning if you forgot to git-add or use --soft.   
A new --fix option to commit could work like --amend, but fail with an  
error if no changes are staged.  Another option is for --amend to list  
the staged changes in the edit buffer, or a warning when nothing has  
changed.

Josh
