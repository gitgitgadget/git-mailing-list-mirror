From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: can I use multiple worktree in same git repo ?
Date: Thu, 21 Jul 2011 20:50:19 +0200
Message-ID: <201107212050.20108.jnareb@gmail.com>
References: <20110720182438.3c40cf1d@shiva.selfip.org> <m3sjpzsdll.fsf@localhost.localdomain> <20110721182215.GA9505@kolya>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	"J. Bakshi" <joydeep@infoservices.in>, git@vger.kernel.org
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Thu Jul 21 20:50:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjyKQ-0007i2-Iv
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jul 2011 20:50:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753593Ab1GUSu3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jul 2011 14:50:29 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:50311 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753544Ab1GUSu1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2011 14:50:27 -0400
Received: by fxd18 with SMTP id 18so3931330fxd.11
        for <git@vger.kernel.org>; Thu, 21 Jul 2011 11:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=1VhcOmhfTGCwQKXMEV16FP+0LhLznWWboOsla6hXFuA=;
        b=d4RKHyDWZOSqsB105yQWpCaWBuCXeRaPjP/QsFscDxAEHdGIVCLeZdp05spsfKKijX
         UN3WfXjDfQx0mrhwTJIVUa//O7pNHcfHJxnyVr6QtPyrkjvGWnAC7uv8DuljbQ2V0l/y
         dXfEpFj/7jXxCFVOgCE28C7hGjAviAnS+YzP0=
Received: by 10.223.1.68 with SMTP id 4mr38742fae.74.1311274226563;
        Thu, 21 Jul 2011 11:50:26 -0700 (PDT)
Received: from [192.168.1.13] (abwr62.neoplus.adsl.tpnet.pl [83.8.241.62])
        by mx.google.com with ESMTPS id e10sm1568776fak.18.2011.07.21.11.50.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 21 Jul 2011 11:50:25 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20110721182215.GA9505@kolya>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177613>

On Thu, 21 Jul 2011, Fredrik Gustafsson wrote:
> On Thu, Jul 21, 2011 at 11:17:57AM -0700, Jakub Narebski wrote:

> > Actually with git-new-workdir you can have multiple working
> > directories associated with single repository, by the way of symlinks.
> > 
> > Note however that if you intend to *work* in those workdirs, they
> > better correspond to different branches... or you can mess something
> > heavy.
> 
> It would be possible to use the .git-file feature here. Then symlinks are
> avoided and the solution is portable.

Actually it wouldn't.  Each new workdir has a separate HEAD and a
separate index; it is contents of .git that is symlinked, not .git
itself.

-- 
Jakub Narebski
Poland
