From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: Copy branch into master
Date: Tue, 29 Nov 2011 20:49:49 +0800
Message-ID: <CALUzUxrxX7Av6OSb5qHMSCua-Y8dGdf8ux1yLoCwNJeXtd-kow@mail.gmail.com>
References: <CAHxBh_T-f7O4r0zn=NtLTYtdbNqd3qSo2tW84aYRJp7ugDSMpw@mail.gmail.com>
	<20111128183616.GB29503@foghorn.codeweavers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Ron Eggler <ron.eggler@gmail.com>, git@vger.kernel.org
To: Andrew Eikum <aeikum@codeweavers.com>
X-From: git-owner@vger.kernel.org Tue Nov 29 13:49:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVN8G-0003YW-Lj
	for gcvg-git-2@lo.gmane.org; Tue, 29 Nov 2011 13:49:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753437Ab1K2Mtw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Nov 2011 07:49:52 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:63811 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753211Ab1K2Mtv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Nov 2011 07:49:51 -0500
Received: by faaq16 with SMTP id q16so135584faa.19
        for <git@vger.kernel.org>; Tue, 29 Nov 2011 04:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Jm1bPCS/jRlqYMR5Peq6qEGafQh4JCGrt61VkBJwE0I=;
        b=rKv1XR0A2eFHgrjC2gXangOsGv9PtwR2ObboS7I33tIy+E6SCTpaxxm2laKqt6d801
         QX6oheQmOALcehuumRFf8f46XWER+onSS6YVf8uQXezVmdA+Z8Pb+Fxkw2wyj9q8CjAX
         LJIzelUW7WtCNkj0OsgX3edbw6pPQsRKU0WP4=
Received: by 10.204.8.77 with SMTP id g13mr49098250bkg.89.1322570989963; Tue,
 29 Nov 2011 04:49:49 -0800 (PST)
Received: by 10.223.71.206 with HTTP; Tue, 29 Nov 2011 04:49:49 -0800 (PST)
In-Reply-To: <20111128183616.GB29503@foghorn.codeweavers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186056>

On Tue, Nov 29, 2011 at 2:36 AM, Andrew Eikum <aeikum@codeweavers.com> wrote:
> On Mon, Nov 28, 2011 at 10:25:33AM -0800, Ron Eggler wrote:
>> Some time ago I created a DVT branch in my project and I have almost been
>> exclusively working in it. Now the time for some test deployment came and I
>> didn't have time to merge it all back into the master thus I gave out the
>> DVT branch version. Now I would like to copy exactly what I have in that
>> branch back into my master to have an exact copy in my master of what got
>> deployed with out any changes.
>> How can I do this?
>
> Couple options, depending on what you want:
>
> Rename DVT to master (similar to 'mv DVT master', including
> losing the contents of 'master'):
> $ git checkout --detach HEAD
> $ git branch -M DVT master
> $ git checkout master

It might not be wise to take the strict definition of rename = move
(copy + delete). You will lose *all* your reflog associated with
master. The old master is gone forever.

Resetting the branch is "safer". It's like pseudo-copying the branch.
The reflog for both branches are still around. You can do this with

 # on master
 $ git reset --hard DVT

or

 # not on master
 $ git branch -f master dvt

-- 
Cheers,
Ray Chuan
