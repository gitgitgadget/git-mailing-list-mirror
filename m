From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: possible 'git cp'/how does git detect copies
Date: Fri, 27 Jun 2008 14:57:13 +0200
Message-ID: <8aa486160806270557w20ce622co1099bceec7bc90f9@mail.gmail.com>
References: <4864DFB6.3050204@mircea.bardac.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Mircea Bardac" <dev@mircea.bardac.net>
X-From: git-owner@vger.kernel.org Fri Jun 27 14:58:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCDXT-0003sG-HH
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 14:58:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755289AbYF0M5R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 08:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757327AbYF0M5R
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 08:57:17 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:59328 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753600AbYF0M5P (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 08:57:15 -0400
Received: by fg-out-1718.google.com with SMTP id 19so235904fgg.17
        for <git@vger.kernel.org>; Fri, 27 Jun 2008 05:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=AoXtFtBpES3IJv4Q3zLaEtybhcFfmt3GCiYuIdjCEcw=;
        b=FXh4xh32RCUEAhhE8ml+noUfJxRZhf8QvKV0J3FI84/WH02dp3C9Neo5kxxrAoOIXY
         Qywz2RUNc17hoZu5KWSTRa/XGryN0vhtsEjRFbxHbz2Se6jFg5/ZYI2zl3As+ZhHOMJx
         ANErNsEm6GskwIwFrLFndnfqDgSlYTRab2Ez8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=V0MrdYIu71wahTjlqfx5/8B0RcLhsiI4sXyvyZ2UI7P8WdalOURGn+GD7ROJCRodX0
         mT31jjSygD0UFun8I+FFCUh4ULGYJXbGBGN2sqa2Pfm6aFw7j8m44qZsGW80lvA2nlrP
         zBMtTV+PJ0hk49GqTpO1FMt0IoNQ7ylSaKr58=
Received: by 10.86.25.17 with SMTP id 17mr1780816fgy.63.1214571433712;
        Fri, 27 Jun 2008 05:57:13 -0700 (PDT)
Received: by 10.86.27.11 with HTTP; Fri, 27 Jun 2008 05:57:13 -0700 (PDT)
In-Reply-To: <4864DFB6.3050204@mircea.bardac.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86547>

On Fri, Jun 27, 2008 at 14:40, Mircea Bardac <dev@mircea.bardac.net> wrote:
> I was looking today at duplicating a file but, I soon realized that there is
> no 'git cp' command (this was the "deductive approach to git commands",
> starting from git mv/rm/...). How does "git diff -C" detect copies (-C is
> used for this, according to the documentation)?

Did you followed the "See also −−find−copies−harder."?

>From the man page

--find-copies-harder::
        For performance reasons, by default, `-C` option finds copies only
        if the original file of the copy was modified in the same
        changeset.  This flag makes the command
        inspect unmodified files as candidates for the source of
        copy.  This is a very expensive operation for large
        projects, so use it with caution.  Giving more than one
        `-C` option has the same effect.


>
> On a very simple test, I couldn't see this working. I just copied one file,
> added it, committed the change, ran "git diff -C HEAD^!". There is no place
> saying that it's contents is copied from some other file (both files are in
> the repository now).
>
> "git blame -C new_copied_file" also doesn't show the commits for the
> original file.

git blame -C -C new_copied_file
