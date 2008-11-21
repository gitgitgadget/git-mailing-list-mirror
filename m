From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: git-svn confused by "empty" (svn prop change) commit
Date: Fri, 21 Nov 2008 07:32:01 +0100
Message-ID: <bd6139dc0811202232l592ea240s89088f78014b6906@mail.gmail.com>
References: <m28wrfhz17.fsf@gmail.com> <m23ahlj26u.fsf@gmail.com>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: paulfred <paul.fredrickson@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 21 07:33:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3Pa4-00041m-GM
	for gcvg-git-2@gmane.org; Fri, 21 Nov 2008 07:33:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751571AbYKUGcG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2008 01:32:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751549AbYKUGcF
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Nov 2008 01:32:05 -0500
Received: from yx-out-2324.google.com ([74.125.44.28]:33869 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751445AbYKUGcC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Nov 2008 01:32:02 -0500
Received: by yx-out-2324.google.com with SMTP id 8so368331yxm.1
        for <git@vger.kernel.org>; Thu, 20 Nov 2008 22:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=4mWFXsSRnUJDxQ5w1NmxqtO7zDawsN87J7imH2+TuUk=;
        b=uRsk/DsLsXHEs4VosND8Ve/uCRKe16+ACh8aejqja80UmC/F8H4Jt8Il6JzXLwpGai
         tA3ByXf4H1pwX7UL9uD4w/2ma66cKDNkc0ZeR5kj6WojFTi0aP/Xx1Q0Pp9Qehqvtu+T
         cxrtYNeSRa3L72E835D/7WtjdwjrVJTfmeF6k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=tEnQXMBhU/gUbik+6MyKF9oQJ0ph55cNvMi7Ld1MPzeQPLwyZ9fPtvNQMCIm3tH1aJ
         zfEWuwluV66HI6YnHPTJ/W8oqKon2HCwqjhAqquouKeZO4m+Zuky63DU4gouFqn2c2Zg
         hY0iFqT2OvghMqtDMwTHH4wj9rELWdUjxi8b4=
Received: by 10.151.14.5 with SMTP id r5mr347035ybi.163.1227249121467;
        Thu, 20 Nov 2008 22:32:01 -0800 (PST)
Received: by 10.150.149.14 with HTTP; Thu, 20 Nov 2008 22:32:01 -0800 (PST)
In-Reply-To: <m23ahlj26u.fsf@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101496>

On Fri, Nov 21, 2008 at 02:30, paulfred <paul.fredrickson@gmail.com> wrote:
> $ git svn dcommit
> Unable to determine upstream SVN information from HEAD history.
> Perhaps the repository is empty. at /usr/local/libexec/git-core/git-svn line 435.
>
> So apparently my problem is NOT the empty commit at all, but trying to use
> noMetadata.  I am surprised that it fails on a fresh download though. Is there
> something I might have done while hacking that would cause git-svn to lose
> track of trunk again?  Is my only option to convince everyone to ignore
> the "noise" in my comments?

Uhm, as I understand it, git svn needs that metadata to dcommit,
unless the .git/svn/git-svn/.rev_db is intact. The --no-metadata
switch should be used only when you're doing a one-time import of a
svn repo. During my usage of git svn, it removed the git-svn-id tags
from the commit message when you 'git svn dcommit', so I don't
understand why you need to use --no-metadata in the frist place.

-- 
Cheers,

Sverre Rabbelier
