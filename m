From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git rev-parse --git-dir does report yield relative path to git
 directory, per documentation
Date: Thu, 17 May 2012 13:23:04 -0500
Message-ID: <20120517182304.GA14367@burratino>
References: <CAH3Anrrb243zdRJJEqDcWrHBVBDdYkGB=sTG7BbjTzsUHvWY-w@mail.gmail.com>
 <xmqqfwayrcen.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Seymour <jon.seymour@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 17 20:23:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SV5MB-0004WT-EE
	for gcvg-git-2@plane.gmane.org; Thu, 17 May 2012 20:23:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762366Ab2EQSXS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 May 2012 14:23:18 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:36644 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762303Ab2EQSXR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 May 2012 14:23:17 -0400
Received: by yhmm54 with SMTP id m54so2139617yhm.19
        for <git@vger.kernel.org>; Thu, 17 May 2012 11:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=EpNnZkuTt3I2UwHiXGmCAcMf2AwP/tzVHR+/25j3FTQ=;
        b=Kr/XuRrY/vVcFAWlp1QisAWbYiozTSp3No2koRmicXt0+bFvVl68sR4zWjl5py0dOf
         209gQ08DqP+BIoSR5JOwKeI70rDgK6LdcZ1JhFF/t+fpXfeqH/yGxc25s91QI0Mwof+i
         X/t8UyDgD8j9AbgaIutgGgF2qPhXsT/xAWeYBtzKgq5uibW4+ZSBog8cpww/IYZU8b8A
         R/m8V6MgtmaE4M5KBWVt0fXCxoSxYNu1FxembUiOZrt5MNpn7h/ppLyS9QXS+sJeTLEP
         Ba3WcZlTCk5sLSqYThxuO7lZy7/Eu6uZo4a4dLv0zItFxrxnic3UbiDOgqCv3+KhcHaK
         Ol0w==
Received: by 10.50.157.194 with SMTP id wo2mr6581260igb.72.1337278996363;
        Thu, 17 May 2012 11:23:16 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id eo5sm11290774igc.7.2012.05.17.11.23.14
        (version=SSLv3 cipher=OTHER);
        Thu, 17 May 2012 11:23:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqfwayrcen.fsf@junio.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197923>

Hi,

Junio C Hamano wrote:
> Jon Seymour <jon.seymour@gmail.com> writes:

>> Per this advice in git-rev-parse(1):
>>
>>      Show $GIT_DIR if defined. Otherwise show the path to the .git
>> directory, relative to the current directory.
>> ...
[...]
> I am not sure what we were smoking.

Yeah, that text is pretty confusing.  Thanks for finding it.

The intent was:

	Show the path to the git repository database (usually $GIT_DIR or
	".git").  When relative, this path is relative to the current
	directory.

The point of that last part is that this is relative to the cwd when
rev-parse is called and not relative to the top level of the worktree.
