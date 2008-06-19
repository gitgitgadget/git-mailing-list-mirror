From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: stg export fails
Date: Thu, 19 Jun 2008 09:18:50 +0100
Message-ID: <b0943d9e0806190118p1a15b174sd661ae7fbe473a02@mail.gmail.com>
References: <cc723f590806182030p65e737f6wcec3bada5a03d0b2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Aneesh Kumar" <aneesh.kumar@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 19 10:20:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9FNR-0002D2-Lw
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 10:20:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756213AbYFSISx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 04:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751545AbYFSISw
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 04:18:52 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:20816 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750730AbYFSISu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 04:18:50 -0400
Received: by wa-out-1112.google.com with SMTP id j37so493025waf.23
        for <git@vger.kernel.org>; Thu, 19 Jun 2008 01:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=vkFzwiFEFyBN4tztppZ8pI3C7Cythrw1+7HTiEuhIAY=;
        b=pzhKra346DB/mPx3fnpGAxYvdk3RDFEleeF7BcH18n1wdStW/jY/z6WuZhSm6DGnhy
         BbCdnD23ObAEvxGOKuIFvoCSBPvCFRyWSHslTKp3yqHU6WnDWUbcOAUlEBPzW3nwNC+C
         fP/+A7KUT5Y9HIvjjI0xi4FvxJuzNo97qSTJ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=m24HSbfnI52/G0Jli+KIRkVLUOZ8Tc9TBpOD6Pzf1fRvqeq+4mQT9r3OqRAcaQU4sv
         S1ohr8Ut8BRc4NOddlyUG+tFKeeh8Ba+A9CHkchI07SI0rV97PAFnWq80UiUFWR6HtqM
         X5+BxiVRL+A/VKSURt8YD6q3f3djmoTU0Gg6I=
Received: by 10.114.46.11 with SMTP id t11mr2033873wat.211.1213863530209;
        Thu, 19 Jun 2008 01:18:50 -0700 (PDT)
Received: by 10.114.193.12 with HTTP; Thu, 19 Jun 2008 01:18:50 -0700 (PDT)
In-Reply-To: <cc723f590806182030p65e737f6wcec3bada5a03d0b2@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85457>

2008/6/19 Aneesh Kumar <aneesh.kumar@gmail.com>:
> [2.6.26-rc6.1-work@linux-review-ext]$ stg export -d /tmp/final/
> 001-ext4-bmap.patch
> Checking for changes in the working directory ... done
> Error: Unhandled exception:
> Traceback (most recent call last):
>  File "/home/kvaneesh/bin-local/stgit//lib/python2.5/site-packages/stgit/main.py",
> line 278, in main
>    ret = command.func(parser, options, args)
>  File "/home/kvaneesh/bin-local/stgit//lib/python2.5/site-packages/stgit/commands/export.py",
> line 94, in func
>    patches = parse_patches(args, applied + unapplied, len(applied))
> NameError: global name 'parse_patches' is not defined
> [2.6.26-rc6.1-work@linux-review-ext]$

Thanks. The latest HEAD broke the export function (there was another
report). I'll push the fix tonight (and add a test case).

-- 
Catalin
