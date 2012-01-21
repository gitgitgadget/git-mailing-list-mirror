From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: post-update to stash after push to non-bare current branch
Date: Fri, 20 Jan 2012 18:35:21 -0600
Message-ID: <4F1A0849.8050205@gmail.com>
References: <jf70vc$kol$1@dough.gmane.org> <4F171088.4080006@gmail.com> <4F1714AD.4090706@gmail.com> <7vwr8oljq7.fsf@alter.siamese.dyndns.org> <4F1764B9.90907@gmail.com> <7vboq0ld5e.fsf@alter.siamese.dyndns.org> <4F188FA2.1000209@gmail.com> <4F1A0311.30502@gmail.com> <7vr4ytdi54.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: unlisted-recipients:;
	"(no To-header on input) Neal Kreitzinger" <neal@rsss.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 21 01:36:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RoOwA-00036p-PA
	for gcvg-git-2@lo.gmane.org; Sat, 21 Jan 2012 01:36:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753820Ab2AUAf0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jan 2012 19:35:26 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:42799 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752509Ab2AUAfZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jan 2012 19:35:25 -0500
Received: by yhoo21 with SMTP id o21so581398yho.19
        for <git@vger.kernel.org>; Fri, 20 Jan 2012 16:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=ktvqDuzHcIzlcsLueECFLbhlZ8DjMHnQ4sGvSpVEtYs=;
        b=o4HFKUg4+RTlcJOThKLNcUSMMaYZqG2iu3b9SrG0suhYtfxKaaDIIWk+46xzfdPZT9
         1//lgT6+Ba7TBKIBeIq3uMuPuieNhCfvhXRh/VOM58DBFijUMdVV6pxtJv19qrY9lmQd
         xnmMuB1n0n70VmN8rOosndQrztpthydYteKd8=
Received: by 10.236.129.138 with SMTP id h10mr11853409yhi.65.1327106124244;
        Fri, 20 Jan 2012 16:35:24 -0800 (PST)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id 17sm12783127ang.11.2012.01.20.16.35.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 20 Jan 2012 16:35:23 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.25) Gecko/20111213 Thunderbird/3.1.17
Newsgroups: gmane.comp.version-control.git
Illegal-Object: Syntax error in CC: address found on vger.kernel.org:
	CC:	unlisted-recipients:;"(no To-header on input) Neal Kreitzinger" <neal@rsss.com>
					     ^-missing end of address
In-Reply-To: <7vr4ytdi54.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188916>

On 1/20/2012 6:16 PM, Junio C Hamano wrote:
> Neal Kreitzinger<nkreitzinger@gmail.com>  writes:
>
>> To get this to work I had to learn more about shell scripting and export
>> the GIT_WORK_TREE git environment variable.
>>
>> (post-update hook):
>> export GIT_WORK_TREE=/home/neal/FSNMSTHTML
>> git checkout -f HEAD
>
>
> Hmm, I thought "cd ..&&  git checkout -f HEAD" (or "git reset --hard")
> would have worked.

Ok, I just tried that for the first time and it complained "not a git 
repository: '.'" because it looks like that caused GIT_DIR to no longer 
point to WORKTREE/.git but instead to WORKTREE/ because GIT_DIR is set 
to '.' in the post-update script's environment as indicated in this 
thread: 
http://stackoverflow.com/questions/6635018/reuse-git-work-tree-in-post-receive-hook-to-rm-a-few-files

v/r,
neal
