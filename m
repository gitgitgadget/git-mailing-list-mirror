From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [CGIT PATCH] parsing.c: handle unexpected commit/tag content
Date: Sun, 14 Sep 2008 10:52:05 +0200
Message-ID: <8c5c35580809140152t442a46datb49497cd99b0408@mail.gmail.com>
References: <8c5c35580809131302w1f51f4ebsede59eb2ae36a99c@mail.gmail.com>
	 <1221378782-26036-1-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Lars Hjemli" <hjemli@gmail.com>
To: pasky@suse.cz
X-From: git-owner@vger.kernel.org Sun Sep 14 10:53:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KenMM-0001q6-Lc
	for gcvg-git-2@gmane.org; Sun, 14 Sep 2008 10:53:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751837AbYINIwK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Sep 2008 04:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751777AbYINIwJ
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Sep 2008 04:52:09 -0400
Received: from wa-out-1112.google.com ([209.85.146.180]:12024 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751690AbYINIwI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Sep 2008 04:52:08 -0400
Received: by wa-out-1112.google.com with SMTP id j37so1026225waf.23
        for <git@vger.kernel.org>; Sun, 14 Sep 2008 01:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=FNfu9SJqt9ifyxJ0DrqghLNKb10BSAeAKKSSiZLYtPQ=;
        b=buI9vrUI3Kv8cP2GW2zHG1wbZpZ979bmspHs3b134lbltgIp1c3LM6p0luF0L1K1F/
         4aNtKLKa2wuFW9XSlXJk6VB2gJ6Ue/MgxR4IGLna+j0zj7HXD7gVtHNqphLjw42nShGh
         1+ixyP3KE34BE6P+Ci3bEa2JaX97IrUxnK6Fs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=hXTFRoyscEzgj/ZZHUEmDeLgidJzvn2KJdGs4K7J4SaYNff6oblg8bJQzWUKxCSmC3
         HBlAjNk+RuD2/Rr/rMgVmSYCP+yg7rRSu+pqcPVm6/oftcZ2qPHH4Na988p3k1IEu9CE
         VeXPDEOuIERhu5touPEf+K8VioBSVxaD/BTqI=
Received: by 10.114.182.15 with SMTP id e15mr4984189waf.84.1221382325308;
        Sun, 14 Sep 2008 01:52:05 -0700 (PDT)
Received: by 10.114.166.20 with HTTP; Sun, 14 Sep 2008 01:52:05 -0700 (PDT)
In-Reply-To: <1221378782-26036-1-git-send-email-hjemli@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95825>

On Sun, Sep 14, 2008 at 9:53 AM, Lars Hjemli <hjemli@gmail.com> wrote:
> +       // skip extra blank lines between headers and message body
> +       while (p && *p == '\n') {
> +               p = strchr(p, '\n');
> +               if (p)
> +                       p++;
> +       }

Btw, this is just silly so I've changed it:

while (p && *p == '\n')
        p++;

The wip-branch at http://hjemli.net/git/cgit has a fixed-up patch.

--
larsh
