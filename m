From: Chris Packham <judge.packham@gmail.com>
Subject: Re: changing files and large files
Date: Fri, 7 May 2010 14:08:27 -0700
Message-ID: <r2ha038bef51005071408z38f7845bwfca893cafe268ec3@mail.gmail.com>
References: <j2v366c6f341005071207x7cba4b50jcb9dd3f2c2872a62@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Peng Yu <pengyu.ut@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 07 23:08:35 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAUmg-0006WD-UY
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 23:08:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756283Ab0EGVI3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 May 2010 17:08:29 -0400
Received: from mail-qy0-f183.google.com ([209.85.221.183]:57756 "EHLO
	mail-qy0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755491Ab0EGVI2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 May 2010 17:08:28 -0400
Received: by qyk13 with SMTP id 13so2262945qyk.1
        for <git@vger.kernel.org>; Fri, 07 May 2010 14:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=7F5xsFDFngWXf2+a6kMk9VKwyn0U1U1+3L7TwODpKp4=;
        b=uOroGBzZg7Bcv0xtur7MSuQMHtcQrjwUOPXNnJrC5tBBrFPY8kyyYjKzWOXFjy6Jy6
         cHrWIkIKaiOF6P+OeCu9Xgu773EebmFPsrrC6DuQ+GwYXrEuMpA9YYT5ZSVqQtuU2ZUd
         Wg+Ob9t8QZIdqE6XYamk9qFkmfooYXjl1XPlE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=ThzSdKEPq624rALmjvAKHWbKO+VmVNZn+MUggzYwzwveAmengcWT6Md9qrjRrfUYoq
         ZlMpagPJh6WPCI/FF8zFbxjEeIO4o3WEA/FujW9ipbFVWfzMBpAuyqOIlPi+u2ibo/sH
         3YbWCFdn24v8sW+WGHZ4wdbpwEFsWX/oPDcM0=
Received: by 10.229.218.211 with SMTP id hr19mr331926qcb.92.1273266507784; 
	Fri, 07 May 2010 14:08:27 -0700 (PDT)
Received: by 10.229.28.3 with HTTP; Fri, 7 May 2010 14:08:27 -0700 (PDT)
In-Reply-To: <j2v366c6f341005071207x7cba4b50jcb9dd3f2c2872a62@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146599>

Hi,

On Fri, May 7, 2010 at 12:07 PM, Peng Yu <pengyu.ut@gmail.com> wrote:
> I'm considering using file control systems. I'm wondering if git could
> handle the following situations. Would you please let me?
>
> 1. Change file names: whether it records the lineage of files that
> undergoes name changes?
>

Technically it detects renames rather than tracking them explicitly.
Other tools (like bazaar or mercurial) track renames explicitly.

> 2. Files are extremely large (of hundred of MB or even GB).
>

Search this list for a more concrete description of where git is at
with handling large files. Generally speaking the git tools need to
read all of the file into memory to operate so the limit is really the
amount of RAM/swap space you have. I think some people on this list do
have modified version which handle files that are > than available
swap space. Git was designed around tracking source code, which it
does really well. If you're wanting to store/track media you may have
better luck with a system designed for that.
