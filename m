Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB3CAC2B9F2
	for <git@archiver.kernel.org>; Sat, 22 May 2021 15:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8B8A6121E
	for <git@archiver.kernel.org>; Sat, 22 May 2021 15:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbhEVP4w (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 May 2021 11:56:52 -0400
Received: from lvs-smtpgate3.nz.FH-Koeln.DE ([139.6.1.49]:10070 "EHLO
        lvs-smtpgate3.nz.fh-koeln.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231216AbhEVP4v (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 22 May 2021 11:56:51 -0400
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Sat, 22 May 2021 11:56:51 EDT
IronPort-SDR: U2SCGGQey0FvJHezVrOuMVZ1fH/g4fK2rboOv+uCyUtFaB8POlysN28rzvk1m0y8tZyYFiwobA
 i5JK8qKiEfkanMgiPghejqtMV4jOEhDfezu0dvZVdZhZt/d4eYrZojzWnFzeDK53VDgG6uTb3M
 wpRaU+L5A5Ye45zkzr17VTZabMgCHerxuW9kdzPxxXyWnIshMjQ3ee9XoSjFvLfeJ2HFLnwP5U
 11gvP3jje4UOMQE+wgDfGX7IK106Qkfzbfxkt24FQcISvK22Kly8BzlDZC9uOLVxNw4OKVeJaf
 L56ID3kpmYWRfBQIvGKeL0lJ
Received: from lvs-wm2.nz.fh-koeln.de (HELO lvs-wm0.nz.fh-koeln.de) ([139.6.1.39])
  by smtp.intranet.fh-koeln.de with ESMTP/TLS/ECDHE-RSA-AES128-SHA; 22 May 2021 17:48:16 +0200
Received: from p5de2bc2b.dip0.t-ipconnect.de (p5de2bc2b.dip0.t-ipconnect.de
 [93.226.188.43]) by webmail.th-koeln.de (Horde Framework) with HTTPS; Sat,
 22 May 2021 15:48:15 +0000
Date:   Sat, 22 May 2021 15:48:15 +0000
Message-ID: <20210522154815.Horde.rqiNSyIc3CGJECACotWLO1T@webmail.th-koeln.de>
From:   Andre Ulrich <andre.ulrich@smail.fh-koeln.de>
To:     git@vger.kernel.org
Subject: fast forward merge overwriting my code
User-Agent: Horde Application Framework 5
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hello community,

I am new to git, and at the moment I am learning the basics. There are  
loads of good videos on the internet, but I have one specific  
question, I haven't found the answer yet:

Let's say I have a .txt file on my master branch. I used

git add .

and

git commit -m "blabla"

so everything is staged and in the history. Now I check out a new branch

git checkout -b testing

and edit the .txt file. I add some new lines at the end, but I also  
change some of the already existing lines. Then again I add and commit  
everything. Then I use

git checkout master

and

git merge testing

I would expect git to tell me "hey, wait, you have changed some of the  
first lines in the .txt file. When you merge, your code on master will  
be altered". But git just merges everything in.
Just imagine this was working code, and changing some of the first  
lines breaks everything in the following lines.
I think I have found out what is the problem: git considers this a  
fast forward merge (since there were no commits on master between the  
creation and the merging of the test branch).
But this is annoying. I want to be able to choose, what changes I want  
to keep, when I do the merge (just as in case of a 3way merge, when  
you can call a graphical merge tool to decide what lines to keep).
I know, I could git diff the latest commits hashes of both branches  
and then fix the file on testing branch accordingly. But those are two  
separate steps, and I want everything to happen in one convenient step.

Is there any possibility to do so?

Many thanks for any help in advance!
Many greetings
André Ulrich
-- 
**********************************************************************
**  Fachhochschule Koeln / Cologne University of Applied Sciences
**
**  Andre Ulrich
**  E-Mail: andre.ulrich@smail.fh-koeln.de
**********************************************************************

