From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Basic Git usage
Date: Sat, 14 Aug 2010 23:41:38 +0400
Message-ID: <AANLkTikQwwyos_xxD2Qvy-z7yjaoEYN-+twHPUKwKfNL@mail.gmail.com>
References: <1281760358285-5422412.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: hogsolo <greg@localdirt.com>
X-From: git-owner@vger.kernel.org Sat Aug 14 21:41:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OkMbw-0004ea-UB
	for gcvg-git-2@lo.gmane.org; Sat, 14 Aug 2010 21:41:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752871Ab0HNTlj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Aug 2010 15:41:39 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:44498 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752850Ab0HNTlj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Aug 2010 15:41:39 -0400
Received: by qyk29 with SMTP id 29so757174qyk.19
        for <git@vger.kernel.org>; Sat, 14 Aug 2010 12:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=8IJG9bPfqa1nZalCUjuFrL2b8N+ezItkMQ98IcJFCYg=;
        b=H2Z4hZ+qSUfV4GQseXGTMTqnGZw6KcFVnDjA796JoAGlAzXaTIHHRNNdZW4EKmLUwb
         Ku+NdraCxbRXXC/rD0qkxY45NJtS1faQtPRqMuzyg1w+JMz8BMh0/gGaOo5zrfwuzRkM
         4JrJI7jTnAeuSdc9hSYPIYUuX6btSlSrzS/Dw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=qVJPk3K0QvbdAYnUjyKD8v4FU8G+jYIJ5w+c6BGA0BsN7ZZsn/QlUYBO8nuxgq3+Tv
         pmPno13gULj11GZSD3O8gkHcM5TDUs/9Ozl7naaVS91CBnFEh+ujzlBitT3hnCztc/Se
         vwl3mOi9lmoI7SFLY9x0DnP7Z7iierCSZtork=
Received: by 10.229.175.167 with SMTP id ba39mr11311qcb.181.1281814898472;
 Sat, 14 Aug 2010 12:41:38 -0700 (PDT)
Received: by 10.229.251.3 with HTTP; Sat, 14 Aug 2010 12:41:38 -0700 (PDT)
In-Reply-To: <1281760358285-5422412.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153576>

On Sat, Aug 14, 2010 at 8:32 AM, hogsolo <greg@localdirt.com> wrote:
>
> I have a master repo and have created a branch. I want to work in both at
> the same time. I want to change some files in the master, then switch to the
> branch ( git checkout branchname) , work on some files, then switch back to
> the master.
> However git wont let me switch back to the master until I have added,
> committed and pushed my files in the branch.

If you have modified files that are different between two branches then
Git won't allow to switch between them. You have two options:
- to commit your changes
- use "git stash"

In contrast to SVN and some other VCS, Git allows you to amend any commit
later. To amend the last commit on the current branch, 'git commit --amend'
can be used. If you want to modify arbitrary commits, (or squash, or delete
some commits) take a look at: "git rebase --interactive"

Warning: modifying commits that you published (i.e. made available to
other users) is in general a bad idea, because it makes difficult for
other users to work with you.


Dmitry
