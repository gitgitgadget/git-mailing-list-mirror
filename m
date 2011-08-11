From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: t5800-*.sh: Intermittent test failures
Date: Thu, 11 Aug 2011 23:39:21 +0200
Message-ID: <CAGdFq_jv_T-x7VGqm_j-fDfeW6TsBG95=1TWn91Yk9B3TGZdsQ@mail.gmail.com>
References: <4E417CB4.50007@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Mailing-list <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Thu Aug 11 23:40:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qrcz5-0004pi-8A
	for gcvg-git-2@lo.gmane.org; Thu, 11 Aug 2011 23:40:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754262Ab1HKVkD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Aug 2011 17:40:03 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:57925 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754216Ab1HKVkC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2011 17:40:02 -0400
Received: by yie30 with SMTP id 30so1621360yie.19
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 14:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=i70ltGtC1oQKta7t9XFOF/FsG1Gtt6anSHCb5VPBsSw=;
        b=Z+Su6Neu3ud1SWuDWBnikO9IZVBc7m0EfDptxsl9u0kJGgbNRXFSu+EuwJTow8ZCyz
         3iw5xMUTXeI7mNiKfnkxwamVRS4Fa1b1bQ80+Z8NlLj23XCtufHSGk2QmHMiweR1hZx1
         mmKbNBFrdceMD8kz3aYwosXhlbagWJLtUFJFk=
Received: by 10.142.3.4 with SMTP id 4mr74972wfc.95.1313098801333; Thu, 11 Aug
 2011 14:40:01 -0700 (PDT)
Received: by 10.68.43.230 with HTTP; Thu, 11 Aug 2011 14:39:21 -0700 (PDT)
In-Reply-To: <4E417CB4.50007@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179144>

Heya,

On Tue, Aug 9, 2011 at 20:30, Ramsay Jones <ramsay@ramsay1.demon.co.uk> wrote:
> The git-fast-import is hung in the read() syscall waiting for data which will
> never arrive. This is because the git(fast-export) process, started by the above
> git(push), executes (producing it's data on stdout) and completes successfully
> and exits *before* the above git-fast-import process starts.
>
> I haven't looked to see how the git(fast-export)/git-fast-import processes are
> plumbed together, but there seems to be a synchronization problem somewhere ...

This seems odd, before the fast-export process is even started it's
stdout are wired to the stdin of the helper (and thus the fast-import
process). What indication do you have that fast-import hasn't started
and that fast-export has finished?

Also, you say git remote-test everywhere, but it should be git
remote-testgit, typo?

-- 
Cheers,

Sverre Rabbelier
