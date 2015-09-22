From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: email sender plugin in stash
Date: Tue, 22 Sep 2015 15:53:38 +1000
Message-ID: <CAH5451=6P7bS3LvBgocna9e8xT2uy=8gn2TVfU7VmtOBVvzkcQ@mail.gmail.com>
References: <loom.20150922T073021-705@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Ankit Jain <ankitgr8@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 22 07:54:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeGXA-0004ow-27
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 07:54:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756798AbbIVFyT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2015 01:54:19 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:35960 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756444AbbIVFyS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2015 01:54:18 -0400
Received: by igcrk20 with SMTP id rk20so75204100igc.1
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 22:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=KqVFr2WvG8Dmj/oyhMgEocwXTxolg89MuoDujECSyKI=;
        b=MWCIF0ZaSLXTd1K4tAjIhdP5dFP11pwCk8r7bPY40Fs5IqWrwBCRJU0weGsQpU9lA2
         VWdUY9DvGimGeA08GSMBpLPauuFfVC+9HhMBfDY/2Imkmv+IcB5ba94zP+tCECrXWahP
         tIgJq2g61D1KW/63mGtL2cxxdt602XwENTskJLFAXyKqJocAssGzwftpxph6vNk3RFa3
         AmLH008UCqh8XSSKV/JWuGNVjEPPzzkkE8FndO5nuSz3Fm/roBzcURrU9YPTWS3p8ApP
         Vv0KhabKGyruij3aQ65o32F1oU6fwHgXRYIOwsBXxtGYJKq+zdrrYAfSZrFEKJjzEgCy
         FmEA==
X-Received: by 10.50.45.33 with SMTP id j1mr14198633igm.61.1442901258236; Mon,
 21 Sep 2015 22:54:18 -0700 (PDT)
Received: by 10.36.120.15 with HTTP; Mon, 21 Sep 2015 22:53:38 -0700 (PDT)
In-Reply-To: <loom.20150922T073021-705@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278377>

Hi Ankit,

On 22 September 2015 at 15:35, Ankit Jain <ankitgr8@gmail.com> wrote:
> HI
>
> I need to modify the notifyemail.vm plugin to show only those changes in the
> email which i committed as a part of pull request. I do not want to see all the
> commits which happen  again and again during the review process.

As this is the git developer mailing list, you'll probably get better
assistance over at the Atlassian Answers website
https://answers.atlassian.com/

Essentially what you need to do is adjust the list of changesets to
display. In the given template, the changesets are grabbed using the
function
    smtpNotificationRenderer.getChangesetPage(repository, refChange)

You need to either filter that list, or alternatively write your own
helper to get only the changesets you care about.

Filtering would be relatively straight forward, using either
changeset.author.name or changeset.author.emailAddress if you want to
filter on whose commits are included, or changeset.parents if you only
want to include merge commits.
There are plenty of options for more complex filtering, but that might
be able to help

Regards,

Andrew Ardill
