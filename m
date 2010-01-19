From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: Re: Feature idea: Ignore content
Date: Tue, 19 Jan 2010 08:57:00 -0800
Message-ID: <8c9a061001190857i12a8deeex74809ffd302bc54d@mail.gmail.com>
References: <f3271551001190529h389ce321k52dcca6b03e4e8f0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 19 17:57:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXHOR-0004PE-KJ
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jan 2010 17:57:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754627Ab0ASQ5X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2010 11:57:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754274Ab0ASQ5W
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 11:57:22 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:45870 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932067Ab0ASQ5U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2010 11:57:20 -0500
Received: by pwj9 with SMTP id 9so2511789pwj.21
        for <git@vger.kernel.org>; Tue, 19 Jan 2010 08:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=DJAv4Pc4i9pRTUf0AA+daFlztG7mHekILynroXOcwS4=;
        b=MMoe6Qxs01d+uz0+BZmNtsC6TnLYZgUuFQY6w4B+MyuhHS99PErnXVoNDTkvs/kg9V
         ZLxVVkrs8SRlcO62nzbbLMkkKpgfxWXkhOagq8pxOOSI+wjquOsNSna4K8TRjCxmYG3w
         1wn3pR+dDETPJUhhapoqj8WgR6JtEMA8P31XY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=Z49uxiZcdF6VkhNVYzL1wrmHkuuscrZqHEW7BeQ7GPj/WBTpXpPZkUApr3vfL7TjUB
         Ue6U3zeehAClHBhNpmZGv8i7oyy+kTCm2O+zxwMyZ+oxksTv0GmGElNmVbjD2WFQPdMN
         G65b3rtkwb47WIqNOxn3KpeInwt4pRl67I7HM=
Received: by 10.141.12.20 with SMTP id p20mr580399rvi.215.1263920240119; Tue, 
	19 Jan 2010 08:57:20 -0800 (PST)
In-Reply-To: <f3271551001190529h389ce321k52dcca6b03e4e8f0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137473>

On Tue, Jan 19, 2010 at 05:29, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> Hi,
>
> Often, I find that I need to track a file which contains a small
> portion I don't want to track (read: line with a password). Instead of
> moving that out to a separate file and ignoring that file, is it a
> good idea to add a feature to Git to allow ignoring content instead of
> whole files? Since Git by nature tracks content, this shouldn't be too
> hard to implement, right?
>

Generally, the way I've seen this handled is by tracking an example
file, and ignoring the "real" file with the password.

Something like:
  config/database.example.yml <-- Tracked file, with a dummy password
& connection info.
  config/database.yml    <-- Ignored file, actually used by application.
