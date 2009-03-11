From: Tim Visher <tim.visher@gmail.com>
Subject: Re: Confusing `stash apply` behavior
Date: Wed, 11 Mar 2009 08:45:34 -0400
Message-ID: <c115fd3c0903110545o67b00fe2u3bb4924b5c84c0ce@mail.gmail.com>
References: <c115fd3c0903101246n1eff50d4rc819e5fe7586a974@mail.gmail.com>
	 <20090311190217.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 13:47:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhNpy-0001A3-R0
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 13:47:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752148AbZCKMpi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 08:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752098AbZCKMpi
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 08:45:38 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:64483 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751719AbZCKMph convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Mar 2009 08:45:37 -0400
Received: by yx-out-2324.google.com with SMTP id 8so1908081yxm.1
        for <git@vger.kernel.org>; Wed, 11 Mar 2009 05:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=SJBV+D0o2iYFI2XdEmPgl2qrlEk2QPwSmMwuoF0Bmxk=;
        b=R9JAXD0qxyRN7Bt26xuJEuAd8aoUOIfaAhy5AlG5m8VtSy2WrPiwq4+K9Gil5I2Yaf
         tYY2AubftFLr6rRzUmyBI7B+D8zjY3W6htUPInGqpOvii3CcMaozgrBhuyHOqkX5vMpY
         LI9Snvcprli8Y5FgATMS5/5qp+rh3qE+DJb9E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=iq+VwnYh5Jh1fcWa8tqcVRm8s7vUxamrJ+ZDZ/x9JmYiYE0r1dq6Qd5a0Y+awqthUw
         PvEpUuMXTqsenF2RazSfNODv213m2R0tOhECzQ3YXMtqVd5gD1Ufzp9m/mZZAvRgzi1l
         voFz8T93/YYPITSU7VjsI7o1gIvzS+0J5nLNk=
Received: by 10.100.106.1 with SMTP id e1mr2565349anc.51.1236775534223; Wed, 
	11 Mar 2009 05:45:34 -0700 (PDT)
In-Reply-To: <20090311190217.6117@nanako3.lavabit.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112921>

On Wed, Mar 11, 2009 at 6:02 AM, Nanako Shiraishi <nanako3@lavabit.com> wrote:
> Quoting Tim Visher <tim.visher@gmail.com>:
>
>> When I do `git stash apply`, it deletes the file I'm working with.
>>
>>     $ ls
>>     featureList.txt*  keycontrol.mdb*
>>
>>     $ git show stash@{0}
>>     commit b3c0f4b9b3c3ef7741a03fb27174f5838abc939d
>>     Merge: 9fb9886 112bba9
>>     Author: Tim Visher <timothy.visher@fms.treas.gov>
>>     Date:   Tue Mar 10 15:25:04 2009 -0400
>>
>>     WIP on dev: 9fb9886 Added DB Lock file to .gitignore. EOM
>>
>>     diff --cc keycontrol.mdb
>>     index 68a9bac,68a9bac..0000000
>>     --- a/keycontrol.mdb
>>     +++ b/keycontrol.mdb
>>
>>     $ git stash apply
>>     Removing keycontrol.mdb
>>     # On branch refactoring
>>     # Changed but not updated:
>>     #   (use "git add/rm <file>..." to update what will be committed)
>>     #   (use "git checkout -- <file>..." to discard changes in working
>> directory)
>>     #
>>     #       deleted:    keycontrol.mdb
>>     #
>>     no changes added to commit (use "git add" and/or "git commit -a")
>>
>> Considering the output of `git show` I would expect that the contents
>> of the stash are, well, what I expect them to be: a new version of
>> keycontrol.mdb.
>
> The 'index' line in your 'diff --cc' output says that back when you created that stash, the HEAD and your index both held a blob object 68a9bac and your working tree didn't have that file, ie, removed. It is very natural that the file is removed when you apply that stash.

Huh.  I don't know how that would have happened, but I guess I should
have been more careful with the stash command.  Oh well.

Thanks for your help!

-- 

In Christ,

Timmy V.

http://burningones.com/
http://five.sentenc.es/ - Spend less time on e-mail
