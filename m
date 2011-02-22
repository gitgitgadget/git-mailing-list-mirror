From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: Problem with git shell on mac
Date: Tue, 22 Feb 2011 17:34:00 -0500
Message-ID: <AANLkTikuYHY9a+PWp63fP_+Up1YaW5gTH2LiQq7kQV1V@mail.gmail.com>
References: <60BD7CF3-7781-4BEC-9545-8B653F62F32E@sis.si>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Luka Kac <luka.kac@sis.si>
X-From: git-owner@vger.kernel.org Tue Feb 22 23:34:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps0og-0007jD-Dr
	for gcvg-git-2@lo.gmane.org; Tue, 22 Feb 2011 23:34:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755529Ab1BVWec (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Feb 2011 17:34:32 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:33284 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754121Ab1BVWea (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 17:34:30 -0500
Received: by iyb26 with SMTP id 26so2304460iyb.19
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 14:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=WPM01rlMWOAhevqwG1GvZlJRQkWn9z//i5R+cX+8ED0=;
        b=tbNPsEh5A1fWsxgLF8RmGqvdwwphBaYfdzHpEf0iwlYbQQp3WpWU4D+JlPpgrFN162
         7U5ZiTzEaMkhfgeP8aa7LxCcMVNZRsitXLA71wcvLGdrONIp3u39WQXAjkHE0vCZuCep
         ARXI/gEjZspORw6TX2bRgLGh04hHMlEiPx3LM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=F7g2lC1nPsZ14aQ16H8eHRY6g4rRdjHOAPzWFf0ZUe5iU868rZY2ekXNxawsloS3ca
         uPkudckQBxzjL+0aN6uxhaYh3+WdiBxxALohczV2oftIoemBi7QAJLZ30Vv5C+iJgCEc
         EyIdNHk0QkYxoW7KOypTLrRKsDUdyT9U8/lj0=
Received: by 10.231.37.138 with SMTP id x10mr2447385ibd.192.1298414070062;
 Tue, 22 Feb 2011 14:34:30 -0800 (PST)
Received: by 10.231.40.2 with HTTP; Tue, 22 Feb 2011 14:34:00 -0800 (PST)
In-Reply-To: <60BD7CF3-7781-4BEC-9545-8B653F62F32E@sis.si>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167584>

On Tue, Feb 22, 2011 at 9:39 AM, Luka Kac <luka.kac@sis.si> wrote:
> Hi guys.
>
> I have a problem with git on a Mac os server.
> a program is trying to run git shell with this command :
>
> git shell -c git-upload-pack '/path/to/repo.git'
>
> the process dies on an assert in exec_cmd.c :
>
> Assertion failed: (argv0_path), function system_path, file exec_cmd.c, line 27.
> error: git-shell died of signal 6
>
>
> what could be wrong ? is the argv0_path path to the git-upload-pack executable ? I'm pretty sure that it is in path because ssh git@server \echo $PATH contains the path to git.
>
> What else should I do ?

Your binary appears to have been compiled with RUNTIME_PREFIX set.
This is (AFAIK) only enabled by default under Cygwin/MinGW. In any
case, I believe it requires that you invoke git using an absolute
path.

Try /path/to/git shell  ...

j.
