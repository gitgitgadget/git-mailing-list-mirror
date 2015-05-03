From: =?UTF-8?B?U8OpYmFzdGllbiBHdWltbWFyYQ==?= 
	<sebastien.guimmara@gmail.com>
Subject: Re: [PATCH v2 1/3] git help: group common commands by theme
Date: Sun, 03 May 2015 15:54:29 +0200
Message-ID: <55462895.8080108@gmail.com>
References: <554405D5.9080702@gmail.com> <xmqqk2wqwg9f.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?U8OpYmFzdGllbiBHdWltbWFy?= =?UTF-8?B?YQ==?= 
	<sebastien.guimmara@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 03 15:54:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YouLv-0001Ej-Rd
	for gcvg-git-2@plane.gmane.org; Sun, 03 May 2015 15:54:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751062AbbECNyf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 May 2015 09:54:35 -0400
Received: from mail-wg0-f45.google.com ([74.125.82.45]:35664 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917AbbECNyd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 May 2015 09:54:33 -0400
Received: by wgyo15 with SMTP id o15so128047456wgy.2
        for <git@vger.kernel.org>; Sun, 03 May 2015 06:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=4WlL/5B/yko1kFQQ5iuovFh0iKn9NPbBhdLwVgvwFj0=;
        b=w5TB0rDIUlyyoJLm/XtZOo9OaLxy/lDM4U91P1EUpGEZY8sY9f9VW5HlIt1m5cXUAf
         VgKljSmxXWH9dAnQm/MsLCcOHZ9kD8zWIGoQ7afPx5OMWl3q7qMW0sNSQuzqsoQZkfNb
         8L+BqGugXrJDITqsidNBaNn8j5HK9R16AoaJw9u8xoSNIlclo4RkKgwc4cCHkF0SRlMb
         7VHDCP+/Bo/L1eEn+N3FYMQmUU+YSIL8QE+vndUgayVywtc83xPJTVLojtfT4AlnDguo
         4xPE0p7pLbg0qWPeJ/1Hz1Cza7Xaj9NSNB6vXH8vjcnfeGSGjDr+kt2dpMro7fl+SerC
         vjfg==
X-Received: by 10.194.171.199 with SMTP id aw7mr32915210wjc.64.1430661272168;
        Sun, 03 May 2015 06:54:32 -0700 (PDT)
Received: from [192.168.0.10] (bd231-1-88-176-208-17.fbx.proxad.net. [88.176.208.17])
        by mx.google.com with ESMTPSA id yr1sm16147550wjc.37.2015.05.03.06.54.30
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 May 2015 06:54:31 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <xmqqk2wqwg9f.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268260>

On 05/03/2015 05:30 AM, Junio C Hamano wrote:
> What is the target audience?  Are they expected to be familiar
> enough with Git that they can guess what the above grouping is based
> on without a group header?

Since this help is not only displayed on '$ git help' but also on
'$ git', we can assume it's directed at people not familiar with
git and/or the command line usage.

We could then display headers this way:

The most commonly used git commands are:
    * starting a working area:
       clone      Clone a repository into a new directory
       init       Create an empty Git repository or reinitialize an existing one
    
    * examining the history and state:
       diff       Show changes between commits, commit and working tree, etc
       log        Show commit logs
       show       Show various types of objects
       status     Show the working tree status
       bisect     Find by binary search the change that introduced a bug
       grep       Print lines matching a pattern

    * working on the current change:
       add        Add file contents to the index
       checkout   Checkout a branch or paths to the working tree
       reset      Reset current HEAD to the specified state
       rm         Remove files from the working tree and from the index
       mv         Move or rename a file, a directory, or a symlink
    
    * growing, marking and tweaking your history:
       commit     Record changes to the repository
       rebase     Forward-port local commits to the updated upstream head
       tag        Create, list, delete or verify a tag object signed with GPG
    
    * working with others:
       fetch      Download objects and refs from another repository
       pull       Fetch from and integrate with another repository or a local branch
       push       Update remote refs along with associated objects
    
    * branching and merging histories:
       branch     List, create, or delete branches
       merge      Join two or more development histories together

This raises a few questions:

1. Is 'bisect' really a common command (from the target audience standpoint)
2. Does 'Forward-port local commits to the updated upstream head' really help
    to grok the idea of 'rebase' ? There are 3 words in this sentence that
    an unfamiliar git user may not be comfortable with : 'forward-port',
    'upstream' and 'head'. I'm not familiar enough with 'rebase' to think of
    a clearer explanation, but what about:
	
	'Rewrite the history of a branch with commits from another branch'
