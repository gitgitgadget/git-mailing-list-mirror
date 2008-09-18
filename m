From: "Matthias Kestenholz" <mk@spinlock.ch>
Subject: Re: Editing Git Log
Date: Thu, 18 Sep 2008 08:21:25 +0200
Message-ID: <1f6632e50809172321y6343a3aau27e2ecd719185060@mail.gmail.com>
References: <48D1ECB4.9080808@tensilica.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Piet Delaney" <piet.delaney@tensilica.com>
X-From: git-owner@vger.kernel.org Thu Sep 18 08:23:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgCv9-0003Zl-3I
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 08:23:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751917AbYIRGV1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 02:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751854AbYIRGV1
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 02:21:27 -0400
Received: from rv-out-0506.google.com ([209.85.198.239]:11990 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751449AbYIRGV0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 02:21:26 -0400
Received: by rv-out-0506.google.com with SMTP id k40so3555209rvb.1
        for <git@vger.kernel.org>; Wed, 17 Sep 2008 23:21:25 -0700 (PDT)
Received: by 10.141.74.17 with SMTP id b17mr7154144rvl.119.1221718885317;
        Wed, 17 Sep 2008 23:21:25 -0700 (PDT)
Received: by 10.141.115.1 with HTTP; Wed, 17 Sep 2008 23:21:25 -0700 (PDT)
In-Reply-To: <48D1ECB4.9080808@tensilica.com>
Content-Disposition: inline
X-Google-Sender-Auth: 232808a454a07277
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96164>

On Thu, Sep 18, 2008 at 7:52 AM, Piet Delaney
<piet.delaney@tensilica.com> wrote:
> I think I recall reading that a feature of git was the prevention of the git
> commits
> from being changed. I noticed today that a couple of us have checked in
> files
> without our customary [XTENSA] architecture prefixed to the 1st line of our
> Commit Messages.
>
> I couldn't find a way to do this, other than our reverting back to a earlier
> repository
> and recommitting (each?) change with the slightly changed Commit Message;
> not an attractive investment of our time.
>
> Any suggestions?
>

You have to create new commits, but you do not have to do it by hand. See
filter-branch[1]

The example given in the manpage removes the git-svn identifiers:

git filter-branch --msg-filter '
        sed -e "/^git-svn-id:/d"
'

You can probably modify the sed expression and use it nearly as is (of course
you would not want to filter the whole history, only the handful commits that
came from you or your team.

[1]: http://www.kernel.org/pub/software/scm/git/docs/git-filter-branch.html
