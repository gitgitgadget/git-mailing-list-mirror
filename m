From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: git log --pretty=format joins lines in the subject of commit message
Date: Wed, 15 Sep 2010 13:01:28 +0000
Message-ID: <AANLkTikXwKBUKvrNs3ezKWjBh35Y87q6gZKSyZ=1cZyG@mail.gmail.com>
References: <DDB24DEE-934B-4C8D-8DAA-595905035AC4@jetbrains.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Kirill Likhodedov <Kirill.Likhodedov@jetbrains.com>
X-From: git-owner@vger.kernel.org Wed Sep 15 15:01:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvrcG-0006sV-KZ
	for gcvg-git-2@lo.gmane.org; Wed, 15 Sep 2010 15:01:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752821Ab0IONBa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Sep 2010 09:01:30 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:36911 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752475Ab0IONBa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Sep 2010 09:01:30 -0400
Received: by bwz11 with SMTP id 11so470031bwz.19
        for <git@vger.kernel.org>; Wed, 15 Sep 2010 06:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=QJqqFmUkSkPh/a85jppoEz/ksqsWSc6/MPqb1uyS69c=;
        b=GOghd8PoT+q+KJT1hZaq3WEK9E/s6TCQH9GIiX+ozJFG8qcFxYHjPz2XVLi0csEUzo
         2ghz9qDQwfQIgobaznUOvscB0sixqLxSoTbIO3LgzdcbqmwgHQ6Up4/nd01fcEpIJRPj
         kjC2NywMnFGD+g5Ca2hxiTXPnVcI+YRcFgDMA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=VK5hSoZ8sLeXB5/NWzI5KuPnDWoYCZj8Y9D/0eKMwjXRwVrCEuOpYeHgesHzLJ4Ra9
         ZuRcEdoot3ku9IdK6QLhyYmp8439PtX61cgOHuYtOI6yLNZoNvdoECGT13hFNREkzy8P
         7N/Z2oHLiH2B8FuWb8F0ozAi08NoTafva4EJc=
Received: by 10.223.110.73 with SMTP id m9mr503324fap.60.1284555688836; Wed,
 15 Sep 2010 06:01:28 -0700 (PDT)
Received: by 10.223.117.14 with HTTP; Wed, 15 Sep 2010 06:01:28 -0700 (PDT)
In-Reply-To: <DDB24DEE-934B-4C8D-8DAA-595905035AC4@jetbrains.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156236>

On Wed, Sep 15, 2010 at 12:55, Kirill Likhodedov
<Kirill.Likhodedov@jetbrains.com> wrote:
> Commit something to a git repository with a commit message with several newlines like this:
>
> ==== commit message starts below ===
> first line
> second line
> third line
>
> fifth line
> === commit message ends above ===
>
> Git treats the first 3 lines as commit message subject and the last line as its body.
>
> 'git log' shows the commit message correctly - exactly like I've entered. So does 'git log --pretty=raw'
>
> But 'git log --pretty=format:%s#%b' joins the first three lines:
> first line second line third line#fifth line
>
> Is it a bug or a feature?

It's probably a feature. We delimit the subject by "\n\n", not
"\n". And IIRC subjects in E-Mail can contain \n.

> If it is a feature how can I acquire the original subject of the commit message by using custom format?

Use a log format that gives you the complete message, then pipe it
through perl or something to parse it?
