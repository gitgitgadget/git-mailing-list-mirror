From: "Jike Song" <albcamus@gmail.com>
Subject: Re: how to edit commit message in history
Date: Fri, 16 Jan 2009 12:09:27 +0800
Message-ID: <df9815e70901152009i3bd717d0t6c20c41e9be19552@mail.gmail.com>
References: <20090116035714.GA6984@b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 16 05:10:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNg2n-0001kB-Ou
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 05:10:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755511AbZAPEJa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 23:09:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755378AbZAPEJa
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 23:09:30 -0500
Received: from ti-out-0910.google.com ([209.85.142.189]:40181 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754877AbZAPEJ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 23:09:29 -0500
Received: by ti-out-0910.google.com with SMTP id b6so784225tic.23
        for <git@vger.kernel.org>; Thu, 15 Jan 2009 20:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=nLonZv5ljMnHdi5cK2QmwQfyy6B06cY7+s38RX0/bBw=;
        b=MRSw1zGZ1be7Hq5xDD3vxZsFl6FU7cepBKv7ogpWtRzakZKhg1A21dNF4t7atWLav6
         G2KpLDZN1BkwZ9w1aCNVeAEghj3lhoVVkraJLzCJWUA/s/4kWBBE3oMf0mQ6zwTws7uE
         Sq25uGZ56mv4oToA9OutyJnq82y8XmPM4lQ8I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=HhRNzNxgxkwD9ykAJa6sS2XOk4NdlW9efRog2d2m7LDXJhqwVnE8ifpUQMsKCGtbt/
         MmJldO8AHMbOcfo+lcRPPphvJBUq/MOb6a3zNhXXVkvpwlcjawtky0XBYyg0eZu/wGkf
         G5OfnSeyVr79tQjCGNbMMNlBjvMVN5Ujr4eMI=
Received: by 10.110.43.18 with SMTP id q18mr2652959tiq.14.1232078967483;
        Thu, 15 Jan 2009 20:09:27 -0800 (PST)
Received: by 10.110.43.4 with HTTP; Thu, 15 Jan 2009 20:09:27 -0800 (PST)
In-Reply-To: <20090116035714.GA6984@b2j>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105919>

On Fri, Jan 16, 2009 at 11:57 AM, bill lam <cbill.lam@gmail.com> wrote:
> I made some typos in commit messages, how to edit them without
> affecting everything else?
>
> Thanks in advance.

say, it's commit HEAD~2 to be revised.

    git rebase -i HEAD~3

In your editor, you all see something like this:

pick db79377 2nd
pick fa9ced8 3rd
pick b842e49 4nd

# Rebase 1423d77..b842e49 onto 1423d77
#
# Commands:
#  p, pick = use commit
#  e, edit = use commit, but stop for amending
#  s, squash = use commit, but meld into previous commit
#
# If you remove a line here THAT COMMIT WILL BE LOST.
# However, if you remove everything, the rebase will be aborted.
#



Now change "pick" to "edit" with your typo commit, save it and exit.
You will see something like this:

$ git-rebase -i HEAD~3
Stopped at db79377... 2nd
You can amend the commit now, with

        git commit --amend

Once you are satisfied with your changes, run

        git rebase --continue


Just follow the instructions.

-- 
Thanks,
Jike
