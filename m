From: "Dmitry Potapov" <dpotapov@gmail.com>
Subject: Re: error: unlink(.git/refs/remotes/origin/testbranch) failed: was remote does not support deleting refs
Date: Sun, 6 Jul 2008 22:34:31 +0400
Message-ID: <37fcd2780807061134l341ac676ueb674a976ce15e6f@mail.gmail.com>
References: <486FE602.3060301@gmx.de> <48700FC2.8080307@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Martin <html-kurs@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 06 20:35:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFZ5J-0001Xh-5U
	for gcvg-git-2@gmane.org; Sun, 06 Jul 2008 20:35:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756971AbYGFSed (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2008 14:34:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756975AbYGFSec
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jul 2008 14:34:32 -0400
Received: from wf-out-1314.google.com ([209.85.200.173]:24497 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755698AbYGFSec (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2008 14:34:32 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1826878wfd.4
        for <git@vger.kernel.org>; Sun, 06 Jul 2008 11:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=wMO/xc8+D3DQoAb2uMclNabwGtgNnh8/NJexH0nzJgQ=;
        b=RI8G/PdjAX1QlCTDoZB78urDUnAFj1WcroUXKvIosf4DfD2M6kJX5L9eErQq2UVzt8
         AsFv5GRY0cU2XHvcweqzjcMUewkdkqtaRsSIIichvGLRY1yHwWXjuX13iQ22bl2568OC
         UgsxXpv62p+gvhBilpr+096gx9no1YIti2Y9A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=cg2PNQmAWbSgZV267H10pyQ1pKFGTGoAClGP+LJpNuULAj2mOV5zxzx24MfUYjk40r
         gX8xQ5cAUIXTuQHmNULMudbjE8FSqgOTyxotUO1UuoCzB1w8P3uieg0RVhxZc6Nid5RC
         zx+LgNzRXq+XIqfYNR5T+u+nYk9WVIgprDYcU=
Received: by 10.142.166.20 with SMTP id o20mr992678wfe.245.1215369271221;
        Sun, 06 Jul 2008 11:34:31 -0700 (PDT)
Received: by 10.143.32.3 with HTTP; Sun, 6 Jul 2008 11:34:31 -0700 (PDT)
In-Reply-To: <48700FC2.8080307@gmx.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87543>

Hi,

[please do not top post]

On Sun, Jul 06, 2008 at 02:20:18AM +0200, Martin wrote:
>_
> But I get another error:
> $ git push origin :testbranch
> To ssh://myserver.com/my/path/to/repository
>  - [deleted]         testbranch
> error: unlink(.git/refs/remotes/origin/testbranch) failed: No such file_
> or directory
> error: Failed to delete
>_
> Any idea?

It is harmless. It is just that "git push origin :refs/heads/testbranch"
cannot remove your local reference to that branch because you already have
removed it by running "git branch -d -r origin/testbranch"

Normally you just run "git push origin :refs/heads/testbranch" without
"git branch -d -r origin/testbranch" and then you will not have this error.

Dmitry
