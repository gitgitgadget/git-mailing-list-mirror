From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: How to archive repo from sub-directory
Date: Tue, 11 Mar 2008 10:22:54 +0700
Message-ID: <fcaeb9bf0803102022s3cefd1d0jcea74fcf5ac69f6c@mail.gmail.com>
References: <18389.54080.211086.922039@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Bill Lear" <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Tue Mar 11 04:23:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYv5W-0002Rw-J6
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 04:23:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753309AbYCKDXA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2008 23:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752702AbYCKDXA
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 23:23:00 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:27474 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753302AbYCKDW6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2008 23:22:58 -0400
Received: by fg-out-1718.google.com with SMTP id e21so2216837fga.17
        for <git@vger.kernel.org>; Mon, 10 Mar 2008 20:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=e+y5RufuBTg1nqQ4br7zTqDRf1G34xr4/xZEp3OHLyc=;
        b=k13dRYQTbdGXe+MQ99nzY0OOQ1ITx0I2h9WWew2NNfOdwi73VxKqLsyzaZP6elyhyozE6PL689R993V3XzhDOWG8f1VUqVfTnXK+dUgg7Hcwm1+2i3O9pSPe+mYqwCMhdT8J8mV8pyfnFBmwZTjp28LuvnbXEZDlFhvHR6/VrI0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uDlQVknqHwNsjqKfVk+a4GRFBUe/vpSXM9/IfEWqCEF7jTCBYTChPQmJXGqXYwSiraO/Oa8rNCNVFbywhJKYy+3Mrv/Het2jswnJ/NyK1IkcUIPgbfMW9ULgyKXLZDXItgRyhx6qRT/34tkXJDGvQXO5QBnLVgvSmKvrxdk+YzE=
Received: by 10.86.66.19 with SMTP id o19mr7511040fga.10.1205205774334;
        Mon, 10 Mar 2008 20:22:54 -0700 (PDT)
Received: by 10.86.81.4 with HTTP; Mon, 10 Mar 2008 20:22:54 -0700 (PDT)
In-Reply-To: <18389.54080.211086.922039@lisa.zopyra.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76791>

On Tue, Mar 11, 2008 at 7:33 AM, Bill Lear <rael@zopyra.com> wrote:
> If I have a git repo with several levels of sub-directories, how
>  do I get git-archive to archive the entire tree, and not just
>  the tree from where I am?  Example:
>
>  % cd foo
>  % cat .git/description
>  foo project
>  % cd bar/baz
>  % git archive --format=tar --prefix=foo/ HEAD | bzip2 > foo.tar.bz2
>
>  produces a tar file starting only at baz.
>
>  If I can't conjur this on the command line with a clever argument to
>  git archive (I've tried several), then how would I ask git "What is
>  your top-level directory" so at least I could write a script to
>  do this?

You can move back to top-level dir with "cd $(git rev-parse
--show-cdup)". Another way is take "git rev-parse --show-prefix"
result (which would be "bar/baz/") and process it yourself.
-- 
Duy
