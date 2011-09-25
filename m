From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] mergetool: Use args as pathspec to unmerged files
Date: Sun, 25 Sep 2011 02:45:01 +0200
Message-ID: <20110925004459.GA19780@gmail.com>
References: <7v4o0h7byd.fsf@alter.siamese.dyndns.org>
 <7vipox2wd6.fsf@alter.siamese.dyndns.org>
 <D3CA81F2-647B-4AD0-A4FC-4C22772FD791@JonathonMah.com>
 <7vsjnysuyl.fsf@alter.siamese.dyndns.org>
 <C5AD8BFC-DA48-4CE9-B821-D0076825F33C@JonathonMah.com>
 <7vaaa4fdix.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathon Mah <me@JonathonMah.com>, git@vger.kernel.org,
	Dan McGee <dpmcgee@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 25 02:44:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7cpZ-0003Zr-24
	for gcvg-git-2@lo.gmane.org; Sun, 25 Sep 2011 02:44:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751549Ab1IYAoP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Sep 2011 20:44:15 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:61523 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751506Ab1IYAoO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Sep 2011 20:44:14 -0400
Received: by wwn22 with SMTP id 22so9114097wwn.1
        for <git@vger.kernel.org>; Sat, 24 Sep 2011 17:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=lIiAbqo7BJVmFwYh592lpIDXPTGMqZBiSUz/dTXoa7o=;
        b=lL4zPusroJqIIXsu8rTaiVvCzNs9BItlF8f9o2Xb8SgChNv8JwMcdDW0O20lhRg2GF
         Z+zsGN3NC6GhsgTl/GsqZlJLCvrbOv2vZuWRq1v7piol7ynNhkEmz5cvDOpyfs1QYW7u
         4JQjIE3WDRSy3MSuGZcXAzJfNm38dRxBYaFNE=
Received: by 10.216.135.164 with SMTP id u36mr6896738wei.84.1316911452782;
        Sat, 24 Sep 2011 17:44:12 -0700 (PDT)
Received: from gmail.com (172.Red-83-60-36.dynamicIP.rima-tde.net. [83.60.36.172])
        by mx.google.com with ESMTPS id s34sm23623217wbo.0.2011.09.24.17.44.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 24 Sep 2011 17:44:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vaaa4fdix.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182051>

On Fri, Sep 16, 2011 at 01:17:10PM -0700, Junio C Hamano wrote:
> Jonathon Mah <me@JonathonMah.com> writes:
> 
> > Mergetool now treats its path arguments as a pathspec (like other git
> > subcommands), restricting action to the given files and directories.
> > Files matching the pathspec are filtered so mergetool only acts on
> > unmerged paths; previously it would assume each path argument was in an
> > unresolved state, and get confused when it couldn't check out their
> > other stages.
> >
> > Running "git mergetool subdir" will prompt to resolve all conflicted
> > blobs under subdir.
> >
> > Signed-off-by: Jonathon Mah <me@JonathonMah.com>
> 
> It looks like this simplifies the code quote a bit and make the result
> easier to follow ;-)  Nicely done.
> 
> As nobody reads from a pipe in while loop and runs merge_file or prompt
> inside, there no longer is a reason to redirect the original standard
> input and make it available, hence we could perhaps add this patch on top
> of your change.
> 
> Ack from mergetool/difftool folks?

I've been on vacation and am just catching up with my git mail.

I just tested:
6bed9767daaa "Merge branch 'jm/mergetool-pathspec' into pu"
and it looks good to me.

FWIW,
Acked-by: David Aguilar <davvid@gmail.com>

Being able to do "git mergetool -- subdir" is very nice!
Thanks guys,
-- 
					David
