From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: hook for rebase --continue
Date: Tue, 15 Nov 2011 17:28:12 -0600
Message-ID: <4EC2F58C.9020202@gmail.com>
References: <CALts4TQ545L1d1J0EiUjd7x=WBJpjCCv6UsXZOoGQAC29RqC5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Matt Graham <mdg149@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 16 00:28:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQSQP-0007F8-NB
	for gcvg-git-2@lo.gmane.org; Wed, 16 Nov 2011 00:28:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757091Ab1KOX2R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Nov 2011 18:28:17 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:39442 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755535Ab1KOX2Q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2011 18:28:16 -0500
Received: by yenq3 with SMTP id q3so1235943yen.19
        for <git@vger.kernel.org>; Tue, 15 Nov 2011 15:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=nRsiw1Oot4i66+ysXZKJMKyXiCMyiqAxf2RrexW8TOE=;
        b=QyNyS52nBKCMEu3tJfIr+dbO+gV0ZLR6CFjRk6VKDnTvGBFLjXcX4uPRNYMpnYy+6Q
         hJ4uamQtGPtm0ykN/wuQq5TB6guypnY3WoS4v8ysKUOoXsmL3ce9GpRw09RRoQAHC2K0
         TWj31zCXAlclKezlWHvD6t8XlHYX6fIvY5U/o=
Received: by 10.101.11.40 with SMTP id o40mr8950676ani.42.1321399695693;
        Tue, 15 Nov 2011 15:28:15 -0800 (PST)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id f32sm78737400ani.20.2011.11.15.15.28.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 15 Nov 2011 15:28:14 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.24) Gecko/20111103 Thunderbird/3.1.16
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <CALts4TQ545L1d1J0EiUjd7x=WBJpjCCv6UsXZOoGQAC29RqC5g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185499>

On 11/7/2011 1:42 PM, Matt Graham wrote:
> Hi, I did some testing and it appears that during a rebase, if I
> resolve a conflict and call git rebase --continue, the pre-commit
> hook doesn't run.  This means that if I don't resolve the conflict
> correctly, our check for invalid syntax doesn't get run and creates
> the risk that someone could push code with invalid syntax, not
> realizing that the check didn't run.
>
> Does anyone else share my expectation that the pre-commit hook
> should run during a rebase? Or at least for the first commit
> following a rebase conflict?
>
> If not, is there another hook that is triggered by a rebase that I
> should be using instead?
>
I just noticed there is a post-rewrite hook in the manpage
http://schacon.github.com/git/githooks.html.  Maybe this does what you want.

v/r,
neal
