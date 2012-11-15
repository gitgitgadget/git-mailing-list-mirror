From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: Local clones aka forks disk size optimization
Date: Thu, 15 Nov 2012 12:34:13 +1100
Message-ID: <CAH5451=Tk=zjkYbK0720VBkAA12VRCAE_Dx8bBkoXba60ho8AA@mail.gmail.com>
References: <CALZVapmG+HL0SQx8zx=Cfz5pWv84hJq90x-7VdjA0m2Z4dC34A@mail.gmail.com>
 <CALZVapmO61d8yXfXXGx6Qc444ka+8n7HabuNRt0rJdE5qy_7aQ@mail.gmail.com>
 <CAH5451nW2esQR8XaAttT3tYJZEw1Nj3OEMgkHsMZrZDxhcRXHw@mail.gmail.com>
 <CALZVap=kOwOpxeu8+_+5uQYZz3GNC8Ep_JeK7WCQHtu+Hn3rUw@mail.gmail.com>
 <CAH5451m4saVa7-NLbVbXp7q8ca5_0N4FLk3wYaqxLT=AE5frbw@mail.gmail.com> <CALZVapmBM78UtjAiNm2VoeWuetCiyxN70mTxbG14SQh5a5RCeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Javier Domingo <javierdo1@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 02:34:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYoLw-00045t-8H
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 02:34:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992573Ab2KOBee (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2012 20:34:34 -0500
Received: from mail-qa0-f46.google.com ([209.85.216.46]:46423 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992549Ab2KOBee (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2012 20:34:34 -0500
Received: by mail-qa0-f46.google.com with SMTP id c11so2322812qad.19
        for <git@vger.kernel.org>; Wed, 14 Nov 2012 17:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=0fKzsksFdISh2rXTY27m0+MhE/DbGtSjS2PArsuxeWw=;
        b=tcDHztfqLB0/lSs1idQhcc6L6vecrQA+kZSpYKtXWHnGfmbQ3KokRqZstg1dKkYl+U
         HVLfpJSLAZY6VzB/HWOcjJBmL0r3uuG0OCjGkVtohtDrFg+kAeXoX3f1FGkTNxKjhk9E
         t0ikJLHtl5Wx/IAmiudVRY3p+O7RfBJiD0Vjy5sNOdWxep24+vZfr/aFiFhN6t7J3+U0
         AoROf6/X84vBpJYwYXd2L6v/jjob10/ff97INIVZNHIAxcewpr+Hux08MGCXaXml4I2X
         F08Dypiej0K5uMPoVT3wy1N+gTv4qYtuVbkWgRer/Zg8FQ8g3CnxeqSKZWI3ypcbnXsI
         WAoA==
Received: by 10.224.173.207 with SMTP id q15mr27334085qaz.69.1352943273396;
 Wed, 14 Nov 2012 17:34:33 -0800 (PST)
Received: by 10.49.119.65 with HTTP; Wed, 14 Nov 2012 17:34:13 -0800 (PST)
In-Reply-To: <CALZVapmBM78UtjAiNm2VoeWuetCiyxN70mTxbG14SQh5a5RCeQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209780>

On 15 November 2012 12:15, Javier Domingo <javierdo1@gmail.com> wrote:
> Hi Andrew,
>
> Doing this would require I got tracked which one comes from which. So
> it would imply some logic (and db) over it. With the hardlinking way,
> it wouldn't require anything. The idea is that you don't have to do
> anything else in the server.
>
> I understand that it would be imposible to do it for windows users
> (but using cygwin), but for *nix ones yes...
> Javier Domingo

Paraphrasing from git-clone(1):

When cloning a repository, if the source repository is specified with
/path/to/repo syntax, the default is to clone the repository by making
a copy of HEAD and everything under objects and refs directories. The
files under .git/objects/ directory are hardlinked to save space when
possible. To force copying instead of hardlinking (which may be
desirable if you are trying to make a back-up of your repository)
--no-hardlinks can be used.

So hardlinks should be used where possible, and if they are not try
upgrading Git.

I think that covers all the use cases you have?

Regards,

Andrew Ardill
