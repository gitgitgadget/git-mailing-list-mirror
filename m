From: Luka Kac <luka.kac@sis.si>
Subject: Re: Problem with git shell on mac
Date: Wed, 23 Feb 2011 12:25:29 +0100
Message-ID: <2F352739-EDBA-44A7-8B8C-C6B41DB386F5@sis.si>
References: <60BD7CF3-7781-4BEC-9545-8B653F62F32E@sis.si> <AANLkTikuYHY9a+PWp63fP_+Up1YaW5gTH2LiQq7kQV1V@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 23 12:25:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsCqj-0007c4-3o
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 12:25:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752526Ab1BWLZg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Feb 2011 06:25:36 -0500
Received: from sis-gw.amis.net ([212.18.35.94]:61766 "EHLO
	sishost.gostovanje.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752279Ab1BWLZf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Feb 2011 06:25:35 -0500
Received: from localhost ([127.0.0.1] helo=sishost.gostovanje.com)
	by sishost.gostovanje.com with esmtpa (Exim 4.69)
	(envelope-from <luka.kac@sis.si>)
	id 1PsCnG-0000by-PD; Wed, 23 Feb 2011 12:22:06 +0100
Received: from [192.168.1.141] ([127.0.0.2] helo=[192.168.1.141]) with
	IPv4:26 by sishost.gostovanje.com; 23 Feb 2011 12:22:06 +0100
In-Reply-To: <AANLkTikuYHY9a+PWp63fP_+Up1YaW5gTH2LiQq7kQV1V@mail.gmail.com>
X-Mailer: Apple Mail (2.1082)
X-Assp-Whitelisted: Yes
X-Assp-Envelope-From: luka.kac@sis.si
X-Assp-Intended-For: jaysoffian@gmail.com
X-Assp-ID: sishost.gostovanje.com ()
X-Assp-Version: 1.7.1.3(1.0.1)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - sishost.gostovanje.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - sis.si
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167688>


On 22.2.2011, at 23:34, Jay Soffian wrote:

> On Tue, Feb 22, 2011 at 9:39 AM, Luka Kac <luka.kac@sis.si> wrote:
>> Hi guys.
>> 
>> I have a problem with git on a Mac os server.
>> a program is trying to run git shell with this command :
>> 
>> git shell -c git-upload-pack '/path/to/repo.git'
>> 
>> the process dies on an assert in exec_cmd.c :
>> 
>> Assertion failed: (argv0_path), function system_path, file exec_cmd.c, line 27.
>> error: git-shell died of signal 6
>> 
>> 
>> what could be wrong ? is the argv0_path path to the git-upload-pack executable ? I'm pretty sure that it is in path because ssh git@server \echo $PATH contains the path to git.
>> 
>> What else should I do ?
> 
> Your binary appears to have been compiled with RUNTIME_PREFIX set.
> This is (AFAIK) only enabled by default under Cygwin/MinGW. In any
> case, I believe it requires that you invoke git using an absolute
> path.
> 
> Try /path/to/git shell  ...
> 
> j.

Thank you. That worked.