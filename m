From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: git subcommand sigint gotcha
Date: Tue, 19 Oct 2010 13:55:29 +0400
Message-ID: <AANLkTi=tvyzyz2xpezufHLFc44HDbtMibkhNEvYxPB2g@mail.gmail.com>
References: <20101019045300.GA18043@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Tue Oct 19 11:55:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P88uv-0007BS-5X
	for gcvg-git-2@lo.gmane.org; Tue, 19 Oct 2010 11:55:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758197Ab0JSJzb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Oct 2010 05:55:31 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:49845 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758190Ab0JSJz3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Oct 2010 05:55:29 -0400
Received: by qyk12 with SMTP id 12so601406qyk.19
        for <git@vger.kernel.org>; Tue, 19 Oct 2010 02:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=i5CV+H5rjrOiG1pAT/eI5BJd69RQcKQrX31MrRglmyo=;
        b=jVTq6f2LtY+qjVa4dkFLQVjO41CWq462vrXkZPAYt2x1tyKTDbpizeBh+vL3uvAIef
         mR4mrHl6Lzu64ToWA7YqXvcdsCBNjyfbgLD9nOxY31p7Wmzq0Fa9MDyYAD2h8Dio9D5x
         701jQW95l7SYyaXTJ5Cg2+j733Ary6ucvbb5M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=xxMLlfYw2WM7c+1ktT31E4E9L17LmrUjxs9gpTsMYuGJgY9z2hmuuJAXWBGsI9iIrp
         hdp5V1Xal4H7uMWQMrB+wrbNgGShdoGFqtVq+dxx5kx6T1iaAPXSui3DFMDdLuAAKTFD
         IoyuVUC70DRL0V5nZ0wq3trhtjDn/toPd9rd8=
Received: by 10.224.197.197 with SMTP id el5mr3143733qab.104.1287482129275;
 Tue, 19 Oct 2010 02:55:29 -0700 (PDT)
Received: by 10.229.222.147 with HTTP; Tue, 19 Oct 2010 02:55:29 -0700 (PDT)
In-Reply-To: <20101019045300.GA18043@gnu.kitenet.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159319>

On Tue, Oct 19, 2010 at 8:53 AM, Joey Hess <joey@kitenet.net> wrote:
> I was trying to write a git subcommand, and I noticed that if I ctrl-c'd
> it, git would return, but leave the subcommand running in the
> background.

It looks like this regression was introduced in v1.6.4, when Jeff tried to fix
one serious issue with a pager. I have bisected the problem to this commit:
http://git.kernel.org/?p=git/git.git;a=commit;h=d8e96fd86d415554a9c2e09ffb929a9e22fdad25

Dmitry
