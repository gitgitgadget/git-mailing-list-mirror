From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: Git automatic stashing?
Date: Tue, 9 Nov 2010 07:58:07 -0500
Message-ID: <AANLkTin-qFrTnu+ZUx45Gbk_3m3843T1+n+aj3agwfzD@mail.gmail.com>
References: <AANLkTim3MacQK6EtTPNJsYbqb=5bOM3W3BXC6p=hT+PU@mail.gmail.com>
	<AANLkTinwftXiZxbs_=PeM-MxQmMF4VaBCPEufH=OG6iU@mail.gmail.com>
	<AANLkTi=G=Xo90QayvuRDp=GTWtkES2fU0kkmn87Q09_2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Casey McGinty <casey.mcginty@gmail.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 09 13:58:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFnmB-0008UQ-Bt
	for gcvg-git-2@lo.gmane.org; Tue, 09 Nov 2010 13:58:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224Ab0KIM6L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Nov 2010 07:58:11 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:55956 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1749667Ab0KIM6J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Nov 2010 07:58:09 -0500
Received: by vws13 with SMTP id 13so3171633vws.19
        for <git@vger.kernel.org>; Tue, 09 Nov 2010 04:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=5F19wW8VQh9Zo9MljmJJrVPmHFXqMdTUwstXsroVIas=;
        b=N0IORIFWoYGAGi48Sn1WAhqTqiDu8AGHBY4JU937txs4CY6Aqp58ABFS174OFXw7wP
         W5uy/Oj8PifoSk4brkLFmGifzf5Jcg8l7m64uaQ7CJsO9yEJ4Ray14aWYNub17hUKqft
         sXDDJwGsu6jQ2k3f4CccdrB8JX+wgPBcBeP1U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=IeDWvYy70qrcQrb/AoU65IMXz9yjFcXER3GrjeqQK1QYeh+l10fcl4xYAy3/J5ZL6C
         DW1gOhXfy+csOG0exnib35HfNXICYjRX5pYdEAIcB+VnYVLFd+fIMEtNDZ4pikWK1/MC
         HzyJOMtLU/CeZ2EJ3n2FyCo3/PzCzN4SJm2BY=
Received: by 10.224.203.132 with SMTP id fi4mr5198221qab.240.1289307487932;
 Tue, 09 Nov 2010 04:58:07 -0800 (PST)
Received: by 10.224.20.82 with HTTP; Tue, 9 Nov 2010 04:58:07 -0800 (PST)
In-Reply-To: <AANLkTi=G=Xo90QayvuRDp=GTWtkES2fU0kkmn87Q09_2@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161044>

On Tue, Nov 9, 2010 at 7:36 AM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> On Tue, Nov 9, 2010 at 12:37 PM, Casey McGinty <casey.mcginty@gmail.com> wrote:
>> Is there any feature in git to perform and auto stash apply/pop when
>> trying to do a merge/rebase in a dirty working dir? This would save
>> some keystrokes from time-to-time, and make it easier for new users
>> unfamiliar with git.
>
> And when switching branches too.

When switching branches (or checking out a different commit in general),
I think git allows you to check out as long as the files that need to be
replaced have not been updated, much like when merging. As far as I can
see, that makes the benefit of temporarily stashing changes much smaller
(but not non-existent) in these two cases (checkout and merge) than it
is when rebasing.

Thinking a bit more about it, I think you are right, though, that it
would still be a nice-to-have, as an option. Currently, 'git rebase' is
more restrictive than 'git merge', but adding the option to 'git rebase'
would not just make it on par with 'git merge', but would actually make
it less restrictive than 'git merge', as even non-conflicting changes
within files would be automatically handled.
