From: Thomas Berg <merlin66b@gmail.com>
Subject: Re: git-p4 clone @all error
Date: Wed, 31 Oct 2012 15:01:13 +0100
Message-ID: <CABYiQp=1HEW=53U2Rck5vckhq0PB3C9iuanoXeVvNG6Xv5+oHg@mail.gmail.com>
References: <1351593879401-7570219.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Arthur <a.foulon@amesys.fr>
X-From: git-owner@vger.kernel.org Wed Oct 31 15:01:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTYrI-0004uB-Cq
	for gcvg-git-2@plane.gmane.org; Wed, 31 Oct 2012 15:01:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932886Ab2JaOBP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2012 10:01:15 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:38067 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752220Ab2JaOBO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2012 10:01:14 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so1421369obb.19
        for <git@vger.kernel.org>; Wed, 31 Oct 2012 07:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=agzNIyBVYknWginSwYXLbpVXkmmTEjuTGHHHc2l00BY=;
        b=ojDTf8Sey4glXq2mfKMTey22hjMczCEOF1Et5vk0/RTdL4S878/3TxYzfd/sdCEZtr
         befp3ebJIkutCtcyOK3/LMxpVyLdS3o5+AdrRzwYLVO/sAARppMPtCdUIo1dyBgn1IVL
         pdwiWgNknxKbLhN/F5pFiJozehFWjJOyYlHA+te+hh4XcgZBdf29ny0EniA8ZllQiu8E
         C6KPYvvAaTdmmatfUKv3/nEZRIdlgA3jLBmUyakvhomsFIYFpo+rjK2fKma0BOXzQPmt
         0KbpqqNueDM2v7U8CxevElDVhTFPe/8UArSsL0kVWdixRgB6EXdrTdUYM2HTReA+o4Qm
         Dzpw==
Received: by 10.60.170.142 with SMTP id am14mr31818118oec.40.1351692073996;
 Wed, 31 Oct 2012 07:01:13 -0700 (PDT)
Received: by 10.60.26.7 with HTTP; Wed, 31 Oct 2012 07:01:13 -0700 (PDT)
In-Reply-To: <1351593879401-7570219.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208819>

Hi,

Sorry, forgot to reply-to-all, here is my response again:

On Tue, Oct 30, 2012 at 11:44 AM, Arthur <a.foulon@amesys.fr> wrote:
> The problem :
>
> Importing revision 7727 (100%)Traceback (most recent call last):
>   File "/usr/bin/git-p4", line 3183, in <module>
>     main()
>   File "/usr/bin/git-p4", line 3177, in main
>     if not cmd.run(args):
>   File "/usr/bin/git-p4", line 3048, in run
>     if not P4Sync.run(self, depotPaths):
>   File "/usr/bin/git-p4", line 2911, in run
>     self.importChanges(changes)
>   File "/usr/bin/git-p4", line 2618, in importChanges
>     self.initialParent)
>   File "/usr/bin/git-p4", line 2198, in commit
>     epoch = details["time"]
> KeyError: 'time'
>

Are you permanently converting a project, or are you planning to
continue submitting to perforce with git-p4?

I have seen similar bugs myself when using the --detect-branches
option. The branch detection in git-p4 is flaky anyway: it is limited
what it can handle, and it used to require correct perforce branch
specs at least, so I would recommend not using it unless you know what
it is doing under the hood.

Instead I would just clone a single branch at a time (drop the
--detect-branches) and work on that.

I do this even in the rare cases when I need more than one perforce
branch in the same git repo - there are other ways to achieve the same
thing.

- Thomas
