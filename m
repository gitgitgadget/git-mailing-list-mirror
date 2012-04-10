From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: Re: pre-receive/update hook: how to know forced push?
Date: Tue, 10 Apr 2012 18:49:23 +0400
Message-ID: <20120410184923.7198bf4a@ashu.dyn1.rarus.ru>
References: <20120410175917.0942d8f2@ashu.dyn1.rarus.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alexey Shumkin <Alex.Crezoff@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 10 16:49:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHcNy-0002UD-4c
	for gcvg-git-2@plane.gmane.org; Tue, 10 Apr 2012 16:49:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755492Ab2DJOt3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Apr 2012 10:49:29 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:61606 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753922Ab2DJOt2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2012 10:49:28 -0400
Received: by bkcik5 with SMTP id ik5so4292825bkc.19
        for <git@vger.kernel.org>; Tue, 10 Apr 2012 07:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=/OJYo3ecb+WjB3Ni5BMVct+Mo2/IxM8GPzXVwt+cYvU=;
        b=SwfzHT/ZDHwN2hn3SA8n0KJz1CnyTbdOkcNQGMdwQ9MZC4MiOCsBySEVCDUYAvJL1w
         eEo5TPd32/Xs0Pe/8ZqDhsEkpLYBtbo12QkWyQ95nQbmdl8xKDwJ4QDQjfLqkK+Op2LF
         /Ng7oV1pYJaP4WanJF5r83+CKU88cgVmxpQEMjLwCm5xAoh5bZM4g5xdUaQhJbhQcJc+
         UpMsg6WkfVhOdtfUiNOSjI9EQ02vQyjqggnNPejKmgb9Bhy9Qnahm371Tmde0Mf/fzop
         vXgGTzYbFmhvU3lBVAmNcQocihs05ZQ3hihYVULXSP6pTn+1WkOCNwrRpxSKEQU4KNsZ
         eAeQ==
Received: by 10.204.151.86 with SMTP id b22mr4906721bkw.81.1334069367491;
        Tue, 10 Apr 2012 07:49:27 -0700 (PDT)
Received: from ashu.dyn1.rarus.ru ([85.21.218.130])
        by mx.google.com with ESMTPS id s16sm36788283bkt.3.2012.04.10.07.49.26
        (version=SSLv3 cipher=OTHER);
        Tue, 10 Apr 2012 07:49:27 -0700 (PDT)
In-Reply-To: <20120410175917.0942d8f2@ashu.dyn1.rarus.ru>
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.22.0; i386-redhat-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195091>

After some investigation of sources it seems to me 
decision to push changes to server or not is made by git client,
so server can only reject pushed updates.

Some examples of necessary detections can be found in
'contrib/hooks/post-receive-email' hook.

Sorry for the noise

> Hi, guys!
> 
> How to know in pre-receive hook that commit has been pushed with
> --force option?
> 
> I've written some pre-receive hook that denies pushed commits which
> have author's date earlier then current branch HEAD. It's done to
> prevent not triggering automated builds which are based on authors'
> timestamps.
> 
> But some time later I had to rollback branch to previous state.
> It is not convenient way to "git update-ref ..." on the server, I'd
> like to git push --force, but there is a question in the first
> sentence:
> 
> How to know in pre-receive hook that commit has been pushed with
> --force option?
> 
> Thanx in advance
> 
