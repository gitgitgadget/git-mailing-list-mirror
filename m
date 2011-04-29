From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: git sparse checkout exclusions not working?
Date: Fri, 29 Apr 2011 19:10:26 +0700
Message-ID: <BANLkTi=m4hcs7pVgn0rkQktmZaqK_ORxaA@mail.gmail.com>
References: <BANLkTinPg_jaxiF8yFtnf4BrT4fx-BQ=+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: skillzero@gmail.com
X-From: git-owner@vger.kernel.org Fri Apr 29 14:11:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFmXH-0006yF-F0
	for gcvg-git-2@lo.gmane.org; Fri, 29 Apr 2011 14:11:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757472Ab1D2MK6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2011 08:10:58 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:43111 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752418Ab1D2MK5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2011 08:10:57 -0400
Received: by bwz15 with SMTP id 15so3048049bwz.19
        for <git@vger.kernel.org>; Fri, 29 Apr 2011 05:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=zMgFj/SXB6SQMi6oN3yCM+vWKoNKzwR2bW9QPsd9DU4=;
        b=bymD91+pVIX8pGk1eTdpOLTVCI5RbG/5FYXiHBOKCvlUqTXxg9idNbJQHLw8iBxAuR
         YAoB/AA0Dle8bp8UheAyHwxodNDGIQN1tRw5v0jAP9ipo5kHjwAKfqGO1G8JXvM0Xw7n
         aD0gFSFAF5NCFR5PoD9kcH9j/n3OD0ceR+kAo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=T5i2NPxVsWBUH5N3H/Mo9y5wFdOUqTN/V2kWsbtZWn8QEdVe+iCDW5Jeh6U5Uio+vL
         LjFerGDIHLl3eEq+2yDHe6lOMt4bFh5nVHLJrHvtXPvHA2s+4bCL5LlN1VH2L+KGAv/d
         cMSAvQORzVSM59FkZUgA2b48ltqkZd5iR9Cu4=
Received: by 10.204.114.144 with SMTP id e16mr1913023bkq.119.1304079056170;
 Fri, 29 Apr 2011 05:10:56 -0700 (PDT)
Received: by 10.204.17.14 with HTTP; Fri, 29 Apr 2011 05:10:26 -0700 (PDT)
In-Reply-To: <BANLkTinPg_jaxiF8yFtnf4BrT4fx-BQ=+A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172449>

On Wed, Apr 27, 2011 at 11:35 PM,  <skillzero@gmail.com> wrote:
> It seems like ! patterns in the sparse-checkout file don't exclude
> individual files in a directory. Here's what I did:
>
> ...
>
> The "test1" directory was included, but "test1/file2.txt" wasn't
> excluded even though I added a ! pattern for it. The test2 directory
> was correctly excluded so that makes me think sparse was working in
> general, but just not respecting the ! pattern in this case.
>
> Is this a bug or am I doing something wrong?

I can reproduce it too. It looks like a regression from
whole-directory matching. If a directory is matched, all files inside
are considered "in". Let's see if I can come up with something this
weekend.
-- 
Duy
