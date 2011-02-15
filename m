From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Regarding GIT API
Date: Tue, 15 Feb 2011 14:49:39 +0300
Message-ID: <AANLkTim4ucYtoyNEM2+=-dJTmpBtqy1zJOEX3k3Wk+XU@mail.gmail.com>
References: <loom.20110215T120434-373@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Abhinav Goyal <honeykool23@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 15 12:49:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpJPf-0004vV-NJ
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 12:49:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754624Ab1BOLtn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 06:49:43 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:38233 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754524Ab1BOLtl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Feb 2011 06:49:41 -0500
Received: by qyj19 with SMTP id 19so2256353qyj.19
        for <git@vger.kernel.org>; Tue, 15 Feb 2011 03:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=IhiQ2w/3ejQ7xawvx9xri7KAU77CUn6NJJPK7PGcBhg=;
        b=JzRts/agMUc25A5xp6Tgv2USzVnbckwOC9lf8QwIA21oWMRKWrGq6ihH09dlvjVQHy
         dxw63K5Qrakb8evVCi72GWJodSrSrex6CKybNSGCyk3/J4s0L6m0BOhTOvtbTwWZ4ycb
         gYOfLAliqlUTOcwAus3Y4gYiYvZU7FEFzMNIU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Fn7Le02/6xOXXceURlaT7Ov4wkNG+CVrfOhLTYKBjmme6Ea0AsaBPkILkNt5SrRbRw
         hl7N5zsutEkPFaVloDPVn1DaMHjgUjKhLeA4RCkgGBEqG3PmMq+A3ajpDZFtEnay26T/
         y9IjPVtFtWJFM/q6PovrKaZpBsn0o8RpCSGZ0=
Received: by 10.229.220.133 with SMTP id hy5mr3754552qcb.269.1297770579478;
 Tue, 15 Feb 2011 03:49:39 -0800 (PST)
Received: by 10.229.213.4 with HTTP; Tue, 15 Feb 2011 03:49:39 -0800 (PST)
In-Reply-To: <loom.20110215T120434-373@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166840>

On Tue, Feb 15, 2011 at 11:08:14AM +0000, Abhinav Goyal wrote:
> I just need the git command
> support for my C++ application. I have my own reason for not using command
> prompt system call.

If you need full git functionality, currently the only proper way is to
use git porcelain command, i.e. run commands using system() and parse
their output. Git porcelain commands are designed to be used in this way,
so their output is easy to parse. Also, their output should not change
between different versions, in contrast to front-end git commands, which
provide more human oriented output.

NOTE: There are libraries for some other languages such as Java and Ruby
(jGit and Grit correspondingly), but they contain re-implementation of
most git functionality. No one has bothered to write anything like that
in C. So, libgit2 provides only low-level and very limited functionality.

More information about git interfaces to different languages, you can
find here:

https://git.wiki.kernel.org/index.php/Interfaces,_frontends,_and_tools#Interfaces_to_other_programming_languages


Dmitry
