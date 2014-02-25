From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Re: Can't use difftool to selectively revert changes
Date: Tue, 25 Feb 2014 09:28:04 -0600
Message-ID: <CAHd499CfVNwpoeKhzSqHd-gd9XLsGjUtk7dXd0dWPJgkd+a-Kg@mail.gmail.com>
References: <CAHd499BGt8KhU=QU7dZ+-AR67=3Rf7VhBXfiHg7Ks=vSg6YOQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 25 16:28:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIJvW-0006Kz-Qj
	for gcvg-git-2@plane.gmane.org; Tue, 25 Feb 2014 16:28:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752946AbaBYP2G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Feb 2014 10:28:06 -0500
Received: from mail-ve0-f177.google.com ([209.85.128.177]:64156 "EHLO
	mail-ve0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752657AbaBYP2F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Feb 2014 10:28:05 -0500
Received: by mail-ve0-f177.google.com with SMTP id db12so581611veb.8
        for <git@vger.kernel.org>; Tue, 25 Feb 2014 07:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:content-type;
        bh=S61vW9h+aZy5FD6mllUeYrRH2N4eds+Qvj5qsYtBrrA=;
        b=EIHNpGJrNeePthS1toJJsqpprzGhkOksOmtpkCjlCKbVFxfk4Ebj7gzs7TrYkhIa9w
         KzKAabsZ2syZjHdst9x9qgiiGUdwECX+PbdELPA6X7r8PExACtJDdGSthU2LTHtXgWjh
         zDooT6U8mg2Nkr3AFr9UgErcoz/6BMXcj1rCGz8pkPlRWZw5YUV4b6iVYAzvoORHtFOR
         SaMSSAG8KuotVDZS8akMIRTnmSrDjHutls1Y03kLE117SfN3VGEQObKlGvHyCk7xAgU6
         2GnvdJWYmcYuXtVo094Q7yXYTUl2oZeTf3y9C8EEQc8kAWv+5uYTsWMuM8LR9Fdhz3tG
         7OYw==
X-Received: by 10.58.231.169 with SMTP id th9mr191592vec.49.1393342084216;
 Tue, 25 Feb 2014 07:28:04 -0800 (PST)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.221.49.68 with HTTP; Tue, 25 Feb 2014 07:28:04 -0800 (PST)
In-Reply-To: <CAHd499BGt8KhU=QU7dZ+-AR67=3Rf7VhBXfiHg7Ks=vSg6YOQQ@mail.gmail.com>
X-Google-Sender-Auth: aXHRy1WAzUlriLi9N8072AaWxAE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242672>

Sorry I'm going to go ahead and answer my own question:

$ git difftool $(git merge-base topic1 master) -- Path/SourceFile.cpp

I removed 'HEAD' from the command and now it picks up my changes and
compares to my working copy version (which is actually what I wanted).
I thought HEAD would point to my working copy version but that's
wrong.

Sorry for the superfluous post!

On Tue, Feb 25, 2014 at 9:22 AM, Robert Dailey <rcdailey.lists@gmail.com> wrote:
> I have a branch called topic1 that is based on 'master'. For a
> particular file in my topic branch, I want to revert some changes by
> using my diff tool. I do this by comparing the original revision of
> the file with HEAD like so:
>
> $ git difftool $(git merge-base topic1 master) HEAD -- Path/SourceFile.cpp
>
> When I make changes to the right side (HEAD) through my diff tool, and
> exit, the changes aren't picked up and applied to my working copy.
> Since I'm modifying HEAD, I think it should carry over the changes I
> make. Is this by design or a defect? I don't know how else to
> selectively revert changes to a file through my diff viewer.
