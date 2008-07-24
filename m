From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: git rebase to move a batch of patches onto the current branch
Date: Thu, 24 Jul 2008 16:16:06 -0400
Message-ID: <32541b130807241316x4f85bcdfw12857be575fb3289@mail.gmail.com>
References: <32541b130807241257j7820a591if8ca01c66bbcd6b2@mail.gmail.com>
	 <20080724201333.GA3760@blimp.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 22:17:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM7FQ-0000gy-GK
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 22:17:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751784AbYGXUQN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 16:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752097AbYGXUQN
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 16:16:13 -0400
Received: from wr-out-0506.google.com ([64.233.184.224]:55766 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751557AbYGXUQM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 16:16:12 -0400
Received: by wr-out-0506.google.com with SMTP id 69so1957010wri.5
        for <git@vger.kernel.org>; Thu, 24 Jul 2008 13:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=FjrUBONG0YvUwYsSFF8jntllRvOlNFGWhdIyTFVcESg=;
        b=hiFtjkDrtbalR7A51x4FRszQVYrXavyi/9EA8EIZRoEMbhobaLOVk3ePrun+6hjW9V
         1BPh6rcPlf+Vr5vhGOh2cxidd+2niQPbHJGuUUarRA9YqNNY86TNjWpriuWr4U78kHeW
         1DkmHLvIHwDzBq6VrObjAjSvb6QGRL7hxHVeo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=VCzQ46efLXb73PXjGtisAP6SsADlEB+O2e8mXkRoXtQVoat974YyQVYq35O5ioi95H
         uQN3bkk3ariQu/0dN2ZcNaHkFwDH5HGODvUHcMES1amE5Yt/tWG0+5wTOpXB2H5IjFPH
         A+RxfzLCyQlt60pQ664mpoyX6YRWrMcQH9KIQ=
Received: by 10.100.207.5 with SMTP id e5mr1240722ang.104.1216930566985;
        Thu, 24 Jul 2008 13:16:06 -0700 (PDT)
Received: by 10.150.96.5 with HTTP; Thu, 24 Jul 2008 13:16:06 -0700 (PDT)
In-Reply-To: <20080724201333.GA3760@blimp.local>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89956>

On 7/24/08, Alex Riesen <raa.lkml@gmail.com> wrote:
> Avery Pennarun, Thu, Jul 24, 2008 21:57:03 +0200:
>
> > I often find myself being on a branch and wanting to do the equivalent
>  > of a series of cherry-picks from another branch into the current one.
>  > Unfortunately, "git cherry-pick" only does one patch at a time (which
>  > is very tedious), and "git rebase", which is much less tedious to use,
>  > seems to specializing in applying your current branch on top of
>  > another branch, not the other way around.
>
> Try this:
>
>     $ type gcp3
>     gcp3 is a function
>     gcp3 ()
>     {
>         git format-patch -k --stdout --full-index "$@" | git am -k -3 --binary
>     }

But that'll give up when there are conflicts, right?  git-rebase lets
me fix them in a nice way.

Avery
