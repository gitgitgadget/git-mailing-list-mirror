From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Proposal: sharing .git/config
Date: Tue, 19 Feb 2013 15:54:32 +0530
Message-ID: <CALkWK0m--MbtNzGH9hNPCCLJWhv6rjF9Y=WQ4qnHUFnE61p6kw@mail.gmail.com>
References: <CALkWK0npW6TLdMNd5_zw-RAB0bjF9DDoyAVSx4Zx=7AmvdEo3w@mail.gmail.com>
 <87ip5otybp.fsf@pctrast.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Feb 19 11:25:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7kNx-0008Ne-P5
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 11:25:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932390Ab3BSKYx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 05:24:53 -0500
Received: from mail-ia0-f171.google.com ([209.85.210.171]:35360 "EHLO
	mail-ia0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932246Ab3BSKYw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 05:24:52 -0500
Received: by mail-ia0-f171.google.com with SMTP id z13so5985321iaz.30
        for <git@vger.kernel.org>; Tue, 19 Feb 2013 02:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=ANAglqI1HYVqG2286SaQYdqGuOR9o+sORjI8ANhZA2A=;
        b=hVhsouSjBgj1jxZDao/fau3k+TUDQDMldYHUi+ekZHLD7Dk880ccS+OF5Rgiy6csIK
         L2uZ63c5ujQuBoYmwZ7TEWCyQGiwUxJEUlyxe4aY2IO1kKlUvuvuUfM5GFYYfb+rHzfg
         bhx4oiO7USFKYjsw+4q9zaglAPGf+iFGO2RKINVbgfh/sg7ppi47zmu1/j4qK8lvHV/W
         K0m69GzW/hBUR19IoTxHmp3Y1/aiCDPbG2QUxKewK6qS5NNrBFW2Fm/gfeQCPlXQhe4G
         l/ydBbUQ9WkzOD6MNWk3TN8u/vLVutJxyu6wY71CxyOPN7BMnxVfv/JLwetuMvJWwxrc
         ZnVg==
X-Received: by 10.42.18.138 with SMTP id x10mr7331681ica.22.1361269492253;
 Tue, 19 Feb 2013 02:24:52 -0800 (PST)
Received: by 10.64.166.33 with HTTP; Tue, 19 Feb 2013 02:24:32 -0800 (PST)
In-Reply-To: <87ip5otybp.fsf@pctrast.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216596>

Thomas Rast wrote:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>> I have this itch where I want to share my remotes config between
>> machines.  In my fork, I should be able to specify where my upstream
>> sources are, so remotes get set up automatically when I clone.
>
> Note that you need to carefully pick only certain bits of the config, as
> otherwise there are big security headaches.

Right.  So, we can just start with remotes for the moment?  Ideally,
there should be a way to specify which configuration options to
publish.

>> There are also other things in .git/config that would be nice to
>> share, like whether to do a --word-diff (why isn't it a configuration
>> variable yet?)
>
> Because that would break pretty much every script that uses git-diff?

diff.c already makes a differentiation between git_diff_ui_config()
and git_diff_basic_config(); there are  configuration options that
should only be applied when the command is called interactively.
