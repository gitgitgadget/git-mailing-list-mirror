From: Angus Hammond <angusgh@gmail.com>
Subject: Re: Urgent: Issue with GIT ...
Date: Mon, 25 Jun 2012 14:14:32 +0100
Message-ID: <CAOBOgRb9bMHSmMrj2tw56U_eSYjR+93=9ryE9YOcCsX+mVYeRA@mail.gmail.com>
References: <1340624980925-7562097.post@n2.nabble.com> <20120625160734.d8227e5d.kostix@domain007.com>
 <1340628925770-7562100.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: guruprasad <guruprasadkinI@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 25 15:15:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sj986-0006Oc-Ug
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jun 2012 15:14:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755957Ab2FYNOz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jun 2012 09:14:55 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:43420 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753496Ab2FYNOy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2012 09:14:54 -0400
Received: by bkcji2 with SMTP id ji2so3106420bkc.19
        for <git@vger.kernel.org>; Mon, 25 Jun 2012 06:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=8MkMDSyTFAGfh3QuYq3vcKiSwE89ZHiD4SPqcSQwq2I=;
        b=xGFU+LYtYcE+b8OtfNJde/q2SV0r3wW2IF4EzIJgr5NNAN2JUtORBlBRF8q4Tg7ReR
         4XgQJJXvKqMsQ94SMSisuEWQuUDCGYH9ThGYJ6KC/hQJnqRmXVEK2sH5MtTzZScmewZM
         g2zNzLKflv7lO9P5KCpkqz16Rr8svTm73KOWKdgU1H4AHRJfaqHQPRIIjo73yTvtRKj+
         A4u6OocgDC4vOGHc/WIj32kAat+BjXiM7jScceqaIKmjP9+mHsRIagE9neQDL4q/lu30
         zYVXaeLAiXyv+us7X4eJAFXtE/lnsJEeSXgXatzM10PgKZr71KeGn3D2w0rg0rlpfToc
         /DgA==
Received: by 10.152.122.12 with SMTP id lo12mr12185057lab.3.1340630092861;
 Mon, 25 Jun 2012 06:14:52 -0700 (PDT)
Received: by 10.114.12.1 with HTTP; Mon, 25 Jun 2012 06:14:32 -0700 (PDT)
In-Reply-To: <1340628925770-7562100.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200579>

On 25 June 2012 13:55, guruprasad <guruprasadkinI@gmail.com> wrote:
> remote: error: its current branch; however, this is not recommended unless
> you
> remote: error: arranged to update its work tree to match what you pushed in
> some

> 4) But, modified things in files did not get reflected. i tried to push from
> A-->B and B-->A. both dint work.
> 5) Push command i tried after modifying file, staging and committing.
>

I *THINK* the problem you're having is that the push to A updates the
repository itself, but doesn't update the working directory unless you
explicitly tell it to from machine A later on. This is why you got
that horrible long error message when you did the git push, git was
trying to stop you from creating a state where the repository and the
working directory were different.

It seems like the solution would be to checkout master on machine A
after you push, or even better, set up a bare repository somewhere on
one of the systems and arrange for both of the repositories you work
in to push/pull to that one.

Angus
