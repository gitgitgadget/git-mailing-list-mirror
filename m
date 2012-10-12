From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: Re: [PATCH] git-gui: Few issues with using full path name
Date: Fri, 12 Oct 2012 10:08:02 -0400
Message-ID: <50782442.2060407@gmail.com>
References: <1349195115-15494-1-git-send-email-andrew.kw.w@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Andrew Wong <andrew.kw.w@gmail.com>, git list <git@vger.kernel.org>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Fri Oct 12 16:08:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMfuY-0004tX-GF
	for gcvg-git-2@plane.gmane.org; Fri, 12 Oct 2012 16:08:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933447Ab2JLOIL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2012 10:08:11 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:51468 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933050Ab2JLOIK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2012 10:08:10 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so4789737iea.19
        for <git@vger.kernel.org>; Fri, 12 Oct 2012 07:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=HEduuepzvwhu/RiNL7a7t76NtiMiii/kL+Rs/erMsEk=;
        b=apbl2GhCcjnF6xtvapdIxm1MZJm1GH3naLzOLlFdd4sKpV7mI9MnxvyrbAgUFpiDOF
         r9lvK4AoNTiiPugGXfPOwzO7gkLVu88d17UHGrqXluUfyvFqNVOcR6xHMVY2z3u+QeKc
         OU5L/NGVvWXE/5mt9g7BQ0nD/+4hCBsYkmIpnbfL1YYJiwsMdutH+POqeocnfSdyvcn+
         vlOv9weqkiTuf6GAtB1ceicjUFZbR+mWbe3KfCaqIGTK5kBkC5c2r9dzbVEWWftgsKAF
         BFLfU+FoI8Nxllyl6PmdQ68nW6bDAjljJqDLWAK+nM5RFVSDntddOIywkC+1hhGQYdXZ
         stVA==
Received: by 10.50.236.74 with SMTP id us10mr2406792igc.5.1350050889418;
        Fri, 12 Oct 2012 07:08:09 -0700 (PDT)
Received: from [192.168.1.112] ([66.207.196.114])
        by mx.google.com with ESMTPS id 10sm1585361ign.5.2012.10.12.07.08.06
        (version=SSLv3 cipher=OTHER);
        Fri, 12 Oct 2012 07:08:08 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120421 Thunderbird/12.0
In-Reply-To: <1349195115-15494-1-git-send-email-andrew.kw.w@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207545>

Can I get some feedback on these two patches? It'd be great to have them 
merged into git-gui. Thanks.


On 10/02/2012 12:25 PM, Andrew Wong wrote:
> I ran into a file name parsing issue in git-gui. If I'm in a subfolder and try
> to pass a full path to "git-gui blame", then "git-gui" will fail to detect the
> argument as a valid path. The first patch will handle this scenario.
>
> The second patch just another issue that I noticed when "git-gui" fails to
> detect the file name. It'll then try to use the previously detected "head" as
> the file name, while prepending it with "prefix". This is incorrect if "head"
> is actually a full path.
>
> There is also an issue when using a full path along with a rev argument, but I
> don't have time to look it right now. I'll try to get to that issue another
> time.
>
> Andrew Wong (2):
>    git-gui: Detect full path when parsing arguments
>    git-gui: Don't prepend the prefix if value looks like a full path
>
>   git-gui.sh | 20 +++++++++++++++++---
>   1 file changed, 17 insertions(+), 3 deletions(-)
>
