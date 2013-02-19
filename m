From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Is this a bug?
Date: Tue, 19 Feb 2013 18:02:12 +0700
Message-ID: <CACsJy8DjatRbL=J-MZmQFnd+_7i-WwYHSnkY_ga++fx1R5Whmw@mail.gmail.com>
References: <937BB05095F39E46B969256AA776205322B2CF15C7@ST-EXCL29.statoil.net> <CABPQNSY4ordHh2ee8mk-2kCD40+sMf_SxrjfzGbkyGGTNW1TzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Wade <DAWAD@statoil.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Tue Feb 19 12:03:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7kyZ-0004Et-2K
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 12:03:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932688Ab3BSLCn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 06:02:43 -0500
Received: from mail-ob0-f180.google.com ([209.85.214.180]:42471 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932339Ab3BSLCm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 06:02:42 -0500
Received: by mail-ob0-f180.google.com with SMTP id ef5so6322665obb.25
        for <git@vger.kernel.org>; Tue, 19 Feb 2013 03:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=N3Mr+fjflkteqC3CKq8oqMev0kytaQwrZuW78ra7yT4=;
        b=zUskNDNUcfYk78QIh/sdIvddVQpZldBKoMq/yXfMNiEFSePSs7iOydu7O3NNihm+iO
         cQXtaiPOnXxfmQwUCiU+z5CZ66GFilewADqvC5O0RVJUHEoOpIWGxIz6m8XdZ3TkgqQ0
         pRonkLoLWXW8dRzxWzhNSb7ys4VHztKEcvb6Sl+89U9ZZuVtd3OZzWtd46gADPmP5sC+
         dDrTN5MTKyNOoXuqaBeaByZ/NGTmE7/rT0X2X2tnqwXeXWCZGN4GVW+YPmmmn4Lk0e2U
         QOsolsxUctBUZ5KQ78TehR3YcyGVOXnP0uOva4L1QertZtPPqyZoMB2OvyVFnYVtQpKg
         dd1w==
X-Received: by 10.60.5.231 with SMTP id v7mr7378258oev.62.1361271762133; Tue,
 19 Feb 2013 03:02:42 -0800 (PST)
Received: by 10.76.154.197 with HTTP; Tue, 19 Feb 2013 03:02:12 -0800 (PST)
In-Reply-To: <CABPQNSY4ordHh2ee8mk-2kCD40+sMf_SxrjfzGbkyGGTNW1TzA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216603>

On Tue, Feb 19, 2013 at 4:47 PM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
> On Tue, Feb 19, 2013 at 10:32 AM, David Wade <DAWAD@statoil.com> wrote:
>> Hi,
>>
>> I wrote a commit message beginning with a hash (#) character, like this: 'git commit -m "#ifdef ...." '
>>
>> Everything went okay when committing, but then I tried 'git commit -amend' and without editing the commit message I was told I had an empty commit message.
>>
>> Is this a problem with my text editor (vim 7.2) or git itself? (git version 1.7.2.2 under RedHat 5.8) Or something I'm not supposed to do ;-) ?
>
> The problem is that when doing interactive editing of messages (like
> 'git commit --amend' does), git considers '#' as a comment-character.
> You can disable this by using the --cleanup=verbatim switch (or some
> other suiting cleanup-setting, see 'git help commit').

Nobody is always conscious about the leading # in commit message to do
that. I once edited a commit message and the auto-wrap feature put '#'
at the beginning of the line. I saved and went on without noticing one
line was lost until much later :( Perhaps we should change the comment
signature a bit to reduce accidents, like only recognize '#' lines as
comments after a special line like

# this is not a comment
### START OF COMMENT ###
# this is a comment
-- 
Duy
