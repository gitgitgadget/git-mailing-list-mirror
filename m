From: =?UTF-8?B?SHJ2b2plIE5pa8WhacSH?= <hniksic@gmail.com>
Subject: 'git add' option to non-interactively stage working tree changes
Date: Fri, 7 Jan 2011 19:56:48 +0100
Message-ID: <AANLkTimLKZnVn8Lr-E-8M8T5mXA55XabCT5rC+broeFJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 07 19:56:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbHUc-0005ZM-Oq
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 19:56:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754017Ab1AGS4t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 13:56:49 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:56614 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751590Ab1AGS4s (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 13:56:48 -0500
Received: by iwn9 with SMTP id 9so17485357iwn.19
        for <git@vger.kernel.org>; Fri, 07 Jan 2011 10:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=aO8qOc64Dz1rPAQPEoUUnMDa+6IflY5EvC8qrBU9Qj0=;
        b=kOXxf8Uru8sBiTsUw9RgTEuFyzKeYmCn3v/3Gg62Dm7jBT9m05ONi90QYGLHOt1pjy
         6pm/orbQFvjDtE5eu3RlZfRR+TjTN52A+U/R2OAHtIjH+fwnAFuE0l4OwuAbybQ5KYdm
         CpOtrzv9gPY1hT2bkdcIxZsefbV8E1BuTLFFs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=j5XarteEwY1Iolt08vMq45isuR8lIaymX7l1CDd8w/m8UbT8zYa3mAjsLgODsBm3+V
         s+Cz2ITFwnFggNqXFem20y7B8GrhfE/f+coUPB3PTgjkxLc+vU823+ymKdEGE7+mQnuR
         vqDMwhmnSHPGZoi8N6lvs1BV+mQ/Nuqn+Tw64=
Received: by 10.42.176.66 with SMTP id bd2mr1217334icb.441.1294426608135; Fri,
 07 Jan 2011 10:56:48 -0800 (PST)
Received: by 10.42.174.67 with HTTP; Fri, 7 Jan 2011 10:56:48 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164742>

Is there a way to non-interactively instruct git to stage all changes
in the working tree, specifically those that would be detected by "git
add -p" or "git commit -a"?

One can use "git add" for this purpose, but it is necessary to specify
the root, and with the unpleasant side effect of adding untracked
files. "git add -u" avoids the file addition, but root still has to be
spelled out. "git add -p" does exactly the right thing, but requires
interaction. I would like an automated --yes-to-all version of "git
add -p".

Specifying the root may seem innocuous, but it is inconsistent with
"git diff" and "git commit [-a]", which don't care where in the tree
you are.
