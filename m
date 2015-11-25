From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Sparse checkout in worktree
Date: Wed, 25 Nov 2015 21:17:56 +0100
Message-ID: <CACsJy8BGPk7C3d9JWjRwYrgh4OTUiiAjGzcKcRJy8+-5=x8=Pg@mail.gmail.com>
References: <5655AC29.20801@drmicha.warpmail.net> <CACsJy8Acb0Z3sw7_r6QfTTz=GqedsU76QxjexWf4yZFg9O7W-w@mail.gmail.com>
 <56560FAE.3000605@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Nov 25 21:18:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1gWL-0007je-Fg
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 21:18:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751606AbbKYUS3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2015 15:18:29 -0500
Received: from mail-lf0-f46.google.com ([209.85.215.46]:35459 "EHLO
	mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751467AbbKYUS1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2015 15:18:27 -0500
Received: by lfdl133 with SMTP id l133so73842161lfd.2
        for <git@vger.kernel.org>; Wed, 25 Nov 2015 12:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=iYfHFLLGQze2XgRTpQG5dLTeqGKOfREUHGqCvAfdCFw=;
        b=iKNp32g3Jm32Fpwl4huBJ6vmss2NAwnxpDLYW9HlMk8BGLt+nzsJ3ghUKelX5GIqGO
         bL6m72RsjwVTuNYCGd98p5x2yuGdzhjJM35gL0ninA98Apo5bavQ73PVYNEsfvHNLquL
         kd5f4BGQzSTx1Ref1NP8TZ1o4qiSfFmfHhXG2yJD2RBYCBqNVNYfuVXQifRxVSAeWLvY
         evYZ0AfIej1flvn3bvK7bC3BqYOipT9IijUQhvv1ItRz4QA2+u7pgM8dMvxnjlJCB2G3
         uyQ/AaFQK0zSOXrge60rmS14TH4FqiD/nQSci93bjONc2zFLl8gWKWr5GSR1IxlxGdfi
         RQxQ==
X-Received: by 10.112.171.74 with SMTP id as10mr15650433lbc.137.1448482705818;
 Wed, 25 Nov 2015 12:18:25 -0800 (PST)
Received: by 10.112.199.5 with HTTP; Wed, 25 Nov 2015 12:17:56 -0800 (PST)
In-Reply-To: <56560FAE.3000605@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281738>

On Wed, Nov 25, 2015 at 8:44 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Duy Nguyen venit, vidit, dixit 25.11.2015 20:38:
>> On Wed, Nov 25, 2015 at 1:40 PM, Michael J Gruber
>> <git@drmicha.warpmail.net> wrote:
>>> Hi there,
>>>
>>> I'm wondering how much it would take to enable worktree specific sparse
>>> checkouts. From a superfluous look:
>>>
>>> - $GIT_DIR/info/sparse_checkout needs to be worktree specific
>>
>> It already is.
>
> But where should I put the worktree specific sparse_checkout file? Is
> Documentation/technical really the only place to find information about
> this? And to make the existing tree sparse, do I need to rm -r and
> checkout sparsely?

Ahh.. worktree-specific files of the checkout "foo" stay in
$GIT_DIR/repos/foo. So sparse-checkout path should be
$GIT_DIR/repos/foo/info/sparse-checkout. This is another good reason
to add 'git checkout --edit-sparse' that opens the sparse-checkout
file for you to update. Or you could use 'git rev-parse --git-path
info/sparse-checkout" to get full path.
-- 
Duy
