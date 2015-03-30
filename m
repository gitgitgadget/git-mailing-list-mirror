From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: git ls-files wildcard behavior considered harmful
Date: Tue, 31 Mar 2015 06:16:52 +0700
Message-ID: <CACsJy8BDoXHS6nj7pEe0i8T=bMD8aG5FwuXABKgPOQBeMOr+Vw@mail.gmail.com>
References: <20150330230459.GA13927@kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Joey Hess <id@joeyh.name>
X-From: git-owner@vger.kernel.org Tue Mar 31 01:17:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yciw0-0002bn-4c
	for gcvg-git-2@plane.gmane.org; Tue, 31 Mar 2015 01:17:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753865AbbC3XRZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2015 19:17:25 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:36342 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753859AbbC3XRX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2015 19:17:23 -0400
Received: by iedm5 with SMTP id m5so2734721ied.3
        for <git@vger.kernel.org>; Mon, 30 Mar 2015 16:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=sD+lOOSk7xiZmP9AbrwkkPz/GRDDjTCRVeESbTo9C9c=;
        b=zNZUWXzlIydW1QagB30rdlMlfwIzKJ9HRH2jIuRe4/kClegZX47CfL/RBeICeqZFVV
         dySyFfc0b8EyKpvG4GTwGznWhJg75vJhe/fLMCG0tHt7NriQ7KRER3zaC/iAFs+8cil5
         H+XUbEVmq1CwhftstlE8bwH97URZN1stZeCLdfi8g9YUAfJNC3rDBc0DSNle6tIKzLef
         HJeeS+dgvACAIeD2j/b0DMzbJ/MMxi+C0hxDUnPUhy742R5hfKFLceIfrfEmYZNGu914
         Fpj4fwkoXelwR8dJW1+Ys90IMQOO/Y1Ky2n2YHtWTinKES/TXIKqmltvDagTzyJCFdFR
         Bhig==
X-Received: by 10.107.170.220 with SMTP id g89mr52333104ioj.85.1427757442771;
 Mon, 30 Mar 2015 16:17:22 -0700 (PDT)
Received: by 10.107.131.33 with HTTP; Mon, 30 Mar 2015 16:16:52 -0700 (PDT)
In-Reply-To: <20150330230459.GA13927@kitenet.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266487>

On Tue, Mar 31, 2015 at 6:04 AM, Joey Hess <id@joeyh.name> wrote:
> I was very surprised to learn the other day that git ls-files 'foo*'
> will expand wildcards (including character classes), in the absence of
> expansion by the shell. (git version 2.1.4)
>
> joey@darkstar:~/tmp/aaa>git ls-files 'foo*bar'
> foo*bar
> foobazbar
> joey@darkstar:~/tmp/aaa>git ls-files '[abc]'
> [abc]
> a
> b
>
> As far as I can see this behavior is not documented on the man page,
> except for a tiny mention in the --with-tree documentation, where
> it says "<file> (i.e. path pattern)".
>
> Since I wanted to avoid this wildcard expension, I tried slash-escaping
> the wildcard characters.

You can do "git --literal-pathspecs ls-files ..." or set GIT_LITERAL_PATHSPECS.
-- 
Duy
