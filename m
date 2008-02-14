From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: A couple branch questions
Date: Wed, 13 Feb 2008 20:39:56 -0500
Message-ID: <76718490802131739n22c56cadn39c1871ea1762dc3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 14 02:41:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPT63-00079o-Bk
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 02:41:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762494AbYBNBkA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2008 20:40:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934572AbYBNBkA
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 20:40:00 -0500
Received: from wr-out-0506.google.com ([64.233.184.228]:42183 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935388AbYBNBj6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 20:39:58 -0500
Received: by wr-out-0506.google.com with SMTP id c48so358909wra.23
        for <git@vger.kernel.org>; Wed, 13 Feb 2008 17:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=LY15Nsb7I9Jw2smS6Q5fLkbTRPmXNIFjd5b9z9AeKaA=;
        b=JgjDZNfXhjHL/N6t3emVwtPV2JALxyzJnY0+ROxV4Qi/9qIlnlH17Av4q1LvbUip0Eq1mAZ0qMRJVNNQyufj6kg4UT853DoXiNS9NlUBF0AFj/CB0Bn3Te4VPRckKlaIFSOLLls9Y+rji6lzfjkVtZGcy5HekYSBxjUNrHJ3F0Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=uBZfuDJHA87LKlg5YrU3yjqfWZi/vMIVQXVgFBdKLjTFo9Oh903jLUtiNnao4/DckphK3OvdYr9UrXffJmhTg3En9kFXGDdq9zm/O571IrdUD+xSnFynTeWgmPRG+O2qcT1CfndcmIIb+pn4YAGfbmBUZHz1G+4FLiAfFakg7zg=
Received: by 10.114.78.1 with SMTP id a1mr801621wab.14.1202953197006;
        Wed, 13 Feb 2008 17:39:57 -0800 (PST)
Received: by 10.114.255.11 with HTTP; Wed, 13 Feb 2008 17:39:56 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73838>

1) git-branch -d <branchname> complains if <branchname> hasn't been
merged to HEAD. Shouldn't it really only complain if <branchname>
hasn't been merged into any local branch? i.e., as long as
<branchname> has been merged, why care to which branch?

2) Why does --track work only for remote tracking branches? I think it
would be useful for setting up topic branches. I've actually got this
alias setup, but maybe a --topic option for git-checkout and
git-branch would be useful to others (?):

topic = "!sh -c 'branch=$(git symbolic-ref HEAD); test -n \"$branch\"
&& git co -b \"$1\" && git config branch.\"$1\".merge \"$branch\" &&
git config branch.\"$1\".remote . && git config branch.\"$1\".rebase
true' -"

j.
