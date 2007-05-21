From: "Stian Haklev" <shaklev@gmail.com>
Subject: Fwd: Problem: git doesn't update working dir (always) when checkout'ing other branch
Date: Mon, 21 May 2007 15:59:04 +0700
Message-ID: <566574ef0705210159m69d4e32cjd4bc5db66c1677b1@mail.gmail.com>
References: <566574ef0705210157j14cb7c56h62392c6193472a98@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 21 10:59:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hq3jR-0006G4-TG
	for gcvg-git@gmane.org; Mon, 21 May 2007 10:59:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755716AbXEUI7G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 04:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756904AbXEUI7G
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 04:59:06 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:40817 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755716AbXEUI7F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 04:59:05 -0400
Received: by py-out-1112.google.com with SMTP id a73so261963pye
        for <git@vger.kernel.org>; Mon, 21 May 2007 01:59:04 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iuxWjqLC43IvO5Pzuj7JcT749bGb5e0XcTUhDdNiKGWOhLxW1479YU2zJ1kimOXkq2fibEne5WKsXi7dd0M1+zVTR+Zl0dkEH8PInzPw8IuKnWDwP1g6+byChUUDgFQLHKhfxsZEUTSCe6eDf2Nf7mKSQ1FeXm/9mIap3iUf5Vs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VgsHZM0olw4/RC1t0lPGLFno2zFlj89938/Audk/aa7pOOZ4sxhia2BHsxkfe774oVYkACWcLOYm2KIkNsa6ZfDJcZudB7Mv+KtS4BSn4OLifMYeRmIB9X9eQZJnxewRLM7TEkKPgAPEOSEvztji4MQI/SptgoeTPh1gMe0UZAw=
Received: by 10.35.21.9 with SMTP id y9mr8377463pyi.1179737944544;
        Mon, 21 May 2007 01:59:04 -0700 (PDT)
Received: by 10.35.72.14 with HTTP; Mon, 21 May 2007 01:59:04 -0700 (PDT)
In-Reply-To: <566574ef0705210157j14cb7c56h62392c6193472a98@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47995>

Newbie to git, but I've been reading up on the docs and I really love
both the theory and what it let's you do (still confused by some
issues like rebasing and stuff). For now I mostly use it on my own
small projects (where I frequently make branches, merge, cherry-pick
etc), and also push it to  repo.or.cz.

One confusing thing to me is that if I am in a clean state (no updated
files in working dir), and I checkout another branch (or another
treeish), sometimes git doesn't update the working dir, and sometimes
it does. So for example in my own repo I do

~wiki/> git status
no files updated

~wiki/> git checkout trying-new-feature
checked out

~wiki/> git status
no files updated

(this is how it should be obviously - the working dir reflects the
index which is now pointing at trying-new-feature, but then...)

~wiki/> git checkout master
checked out

~wiki/> git status
it then puts me directly into commit mode, with every file having a
ton of differences - because the files are still from
trying-new-feature and the index is pointing at master.

It also seems to do inconsistent things with files that exist in only
one of the branches - ie if switching back the file remains in the
directory but is now an "untracked" file, etc.

Maybe I am completely misunderstanding and there is something I should
do differently. It works out if I do git reset --hard, but it just
seems so uneccessary. (As I said, in all cases the working dir is
completely clean before doing the checkout).

thank you
Stian
