From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] Improving performance with pthreads in refresh_index().
Date: Tue, 11 Oct 2011 21:59:01 +1100
Message-ID: <CACsJy8D7-vtfNvx8BqAK77Y7A4qYxORTzovMugXRZLuxXtYY+Q@mail.gmail.com>
References: <1318325521-23262-1-git-send-email-klinkert@webgods.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: klinkert@webgods.de
X-From: git-owner@vger.kernel.org Tue Oct 11 12:59:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDa3d-00021b-EH
	for gcvg-git-2@lo.gmane.org; Tue, 11 Oct 2011 12:59:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754569Ab1JKK7d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Oct 2011 06:59:33 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:45245 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754265Ab1JKK7c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Oct 2011 06:59:32 -0400
Received: by bkbzt4 with SMTP id zt4so9626927bkb.19
        for <git@vger.kernel.org>; Tue, 11 Oct 2011 03:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=nYa5aKB99pP+9e2cB7a06ZpoKPpJRNIdq8ABofJ/PmU=;
        b=OS0gjq2Sd2K/dEyW2TFwwk5Hmmr6DMOXw25roTRNacclJyapNJFIBl7Yc7ZT/vh9dv
         EEZ3ABpWsoE8zLW2H4OT0DEa5xZH3kGtHxy1GiXdVURZQmEDs7n0E1ctFJVjIIdYZtkv
         T5o0m5j7aftE8GZ4ILKMu6om77JIt4P/ZFlQQ=
Received: by 10.204.133.77 with SMTP id e13mr9187596bkt.94.1318330771151; Tue,
 11 Oct 2011 03:59:31 -0700 (PDT)
Received: by 10.204.120.75 with HTTP; Tue, 11 Oct 2011 03:59:01 -0700 (PDT)
In-Reply-To: <1318325521-23262-1-git-send-email-klinkert@webgods.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183291>

On Tue, Oct 11, 2011 at 8:32 PM,  <klinkert@webgods.de> wrote:
> Git performs for every file in a repository at least one (with a cold cache)
> lstat(). In larger repositories operations like git status take a
> long time. In case your local repository is located on a remote server
> (e. g. mounted via nfs) it ends up in an *incredible* slow git.

This sounds really similar to what Linus did with preload-index.c..
-- 
Duy
