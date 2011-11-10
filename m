From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: hook for rebase --continue
Date: Wed, 09 Nov 2011 18:50:38 -0600
Message-ID: <4EBB1FDE.7020006@gmail.com>
References: <CALts4TQ545L1d1J0EiUjd7x=WBJpjCCv6UsXZOoGQAC29RqC5g@mail.gmail.com> <4EBB1F17.4060907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Matt Graham <mdg149@gmail.com>, git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Thu Nov 10 01:50:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROIqr-000579-MX
	for gcvg-git-2@lo.gmane.org; Thu, 10 Nov 2011 01:50:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756651Ab1KJAul (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Nov 2011 19:50:41 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:54405 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756624Ab1KJAuk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Nov 2011 19:50:40 -0500
Received: by yenr9 with SMTP id r9so1289207yen.19
        for <git@vger.kernel.org>; Wed, 09 Nov 2011 16:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=ZGylpyEASr25zQTBixuqYX0RcAN7LQ0o10yfc2MC3Pg=;
        b=FwVxd0pocvNuSSjMmjYIx8Fx2QI8EY1w7ZGzoo9hGjElpRYlvZyJ/XNqhLPERFTXnj
         Fps2AHj1nZ+j3MGbXMB+1MQVU9b4NbI9GX0N8X2LXcQr1bF9njbosrsD5TTLbLdtG//o
         8XVSQGaRH5C1+BsyAJbb7CaGaw7eOzOUR1XZI=
Received: by 10.101.148.29 with SMTP id a29mr2261969ano.21.1320886240113;
        Wed, 09 Nov 2011 16:50:40 -0800 (PST)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id l27sm18629442ani.21.2011.11.09.16.50.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 09 Nov 2011 16:50:39 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.23) Gecko/20110920 Thunderbird/3.1.15
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <4EBB1F17.4060907@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185179>

On 11/9/2011 6:47 PM, Neal Kreitzinger wrote:
> On 11/7/2011 1:42 PM, Matt Graham wrote:
>> I did some testing and it appears that during a rebase, if I resolve
>> a conflict and call git rebase --continue, the pre-commit hook
>> doesn't run. This means that if I don't resolve the conflict
>> correctly, our check for invalid syntax doesn't get run and creates
>> the risk that someone could push code with invalid syntax, not
>> realizing that the check didn't run.
>>
>> Does anyone else share my expectation that the pre-commit hook
>> should run during a rebase? Or at least for the first commit
>> following a rebase conflict?
>>
>> If not, is there another hook that is triggered by a rebase that I
>> should be using instead?
>>
> You could try creating an alias (e.g. "git rebase-continue") in your
> gitconfig that runs the desired validation logic and then executes git
> rebase --continue. Then you would run "git rebase-continue" instead of "git rebase
> --continue".
>
correction: added the --continue option in the alias example above.

--neal
