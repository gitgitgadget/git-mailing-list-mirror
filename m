From: Chris Packham <judge.packham@gmail.com>
Subject: Re: Egit/Jgit support for relocated .git directories
Date: Thu, 28 Jun 2012 20:16:14 +1200
Message-ID: <4FEC12CE.6030603@gmail.com>
References: <4FE97057.3040609@gmail.com> <CAJo=hJubPwt8y4NhhctMag5Yr6cbYXZ4sORTB1=FkTjQZhEsTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>, jgit-dev@eclipse.org,
	egit-dev@eclipse.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jun 28 10:15:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sk9tH-0007YE-8H
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jun 2012 10:15:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751536Ab2F1IPn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jun 2012 04:15:43 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:36406 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750879Ab2F1IPk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jun 2012 04:15:40 -0400
Received: by dady13 with SMTP id y13so2545501dad.19
        for <git@vger.kernel.org>; Thu, 28 Jun 2012 01:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=ONUnGpzpF4pKCmIug3KQ1JVF+/btEXEQwzmxXxaWNMY=;
        b=W/BKRc1HU2c7f19wcWmFS/jve2hS9exWa3ZU/TGh5nglBT87a5zsRGDzqA/g0P7l8c
         Av7WJncBP8yIgo02BGblkF38b5q3fdUqWDmhF6LFQACArkdIhCmcScQOw+w30/ukyLqa
         Y7V1J/aJqslv/qo0WFcIPbp8G0R6wm2UOpUyH/LzDpJKo5A4a4jdbbdbPo58YvPTyxWt
         34DOQsPaNZDcYQCiB8ypeUGip0nSUimJqsIf/DoV7bxUcpxmdlSuvklHiQqFV5E0pScN
         SSlLJ40Vd1MMF33txAjSTm3hvrGDNEnwNEBK5wL5y6DpD/1yNDjUPph5WoL5Pk5T3Rcb
         oHoQ==
Received: by 10.68.226.226 with SMTP id rv2mr4807372pbc.101.1340871339887;
        Thu, 28 Jun 2012 01:15:39 -0700 (PDT)
Received: from [192.168.1.66] (115-188-15-163.jetstream.xtra.co.nz. [115.188.15.163])
        by mx.google.com with ESMTPS id os3sm1410456pbb.41.2012.06.28.01.15.36
        (version=SSLv3 cipher=OTHER);
        Thu, 28 Jun 2012 01:15:38 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:12.0) Gecko/20120421 Thunderbird/12.0
In-Reply-To: <CAJo=hJubPwt8y4NhhctMag5Yr6cbYXZ4sORTB1=FkTjQZhEsTQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200782>

On 06/27/2012 03:40 AM, Shawn Pearce wrote:
> On Tue, Jun 26, 2012 at 1:18 AM, Chris Packham <judge.packham@gmail.com> wrote:
>> This is a bit of a secondhand bug report/query so sorry if the details
>> are a bit sketchy.
>>
>> Since git 1.7.8:
>>
>> ``When populating a new submodule directory with "git submodule init",
>> the $GIT_DIR metainformation directory for submodules is created inside
>> $GIT_DIR/modules/<name>/ directory of the superproject and referenced
>> via the gitfile mechanism. This is to make it possible to switch
>> between commits in the superproject that has and does not have the
>> submodule in the tree without re-cloning.''
>>
>> I've had several colleagues at work tell me that with the relocated
>> $GIT_DIR the Egit integration with eclipse doesn't work. I can't really
>> qualify "doesn't work" but from what I've been told importing the
>> project works but blaming/annotating doesn't.
>>
>> I believe the gitfile mechanism isn't new but it possibly hasn't been
>> used by many Egit/Jgit users. Can anyone confirm if it is supported by
>> Egit/Jgit (and I'm barking up the wrong tree).
> 
> I am pretty certain we forgot to support gitfile in JGit. Hence this
> doesn't work in EGit.
> 
> Whoops.

This[1] little snippet makes me think it wasn't entirely forgotten but
perhaps not finished or widely tested.

Alternatively as a workaround is there anyway of telling git to use old
the behaviour for git submodule init?

--
[1] -
http://git.eclipse.org/c/jgit/jgit.git/tree/org.eclipse.jgit/src/org/eclipse/jgit/lib/BaseRepositoryBuilder.java#n93
