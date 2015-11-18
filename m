From: Stefan Beller <sbeller@google.com>
Subject: Re: push failure on domain-connected machine
Date: Wed, 18 Nov 2015 12:40:33 -0800
Message-ID: <CAGZ79kaoX8-N1ccT_HqXjqZJ1B3dsB3NYGVY13X2CN7NDPZjtQ@mail.gmail.com>
References: <564CAB93.9040007@icefield.yk.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Erik Blake <erik@icefield.yk.ca>,
	Johannes Schindelin <johannes.schindelin@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 18 21:40:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zz9Wy-0000Bg-Nz
	for gcvg-git-2@plane.gmane.org; Wed, 18 Nov 2015 21:40:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757034AbbKRUkg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Nov 2015 15:40:36 -0500
Received: from mail-yk0-f174.google.com ([209.85.160.174]:35593 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757030AbbKRUke (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Nov 2015 15:40:34 -0500
Received: by ykba77 with SMTP id a77so83523773ykb.2
        for <git@vger.kernel.org>; Wed, 18 Nov 2015 12:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ZNIX7FrFqS4cOLnssh4NxHjA1EvHFEsQStpQHU5Npx0=;
        b=PPCLl4vGtAKgpucsIfC17NG9f8uZewurffc2PTJEsrHopvRbYb/8k+ghPNZ2m1TxnE
         q9sPa8Po+xapDZkntua6Y3FRn/0ErNzHB/IjOcDswi16N+BYdc3x/mq0/9WzMJADXXN9
         rWN+h+ACkuvg/uzQ6aJhCJbxxSYAkfXVSG6VfUVoP3MlDvpEmpX8fCPno575YPyghuun
         QaUCQdcKM9dGWDx7a141Qk6+SCeSxTb3Vq1hSRSvtXi2EEwMy80XszyWO1xYw2wmsLzA
         R1ntTd5r564U/sf4M2/GLfa44LZdZwuUQ+WxPf0qP9q0GpQEYrPlhNR8u5Wo301VYnG3
         xf2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=ZNIX7FrFqS4cOLnssh4NxHjA1EvHFEsQStpQHU5Npx0=;
        b=StMGOC6OUVwjCLdTZV7du3T6VWQfDOMiQg3YOZ+vWKLueA30DNCeSuHAmO9+bds3Ng
         YDi3aSFmIIa1GcxUc9/TcXMyYdZxQwwSatkku7xSvIUJoP0bEx45VTu2hqrrpo7DpxEU
         aIW/AJP++94gGOO6vzN3E4MS1888fF6ZPeBlgfs2ivGdYxYzOElpOESpvv9M0kXSc8Hf
         iD0MTFtrUk5OuvYUHCde6gD6bih7NhkVqouU98IuqKfJHuEhNf7UpLhEajzlzFqS7AR8
         1wLfh/2kS30WKfT+rLiItMZshYh2Bm0CpwfTwJEH27OTs2oRifnZ5AFOvtqK/SjGsT6/
         9shA==
X-Gm-Message-State: ALoCoQlhPZp3Ut/wa6oI7vDzyo3oaSBqD4HFhkDyLP2HECPbzXXw8hF5FtT5gnQKkkEDhnqlicBE
X-Received: by 10.13.251.2 with SMTP id l2mr4043020ywf.44.1447879233740; Wed,
 18 Nov 2015 12:40:33 -0800 (PST)
Received: by 10.37.196.70 with HTTP; Wed, 18 Nov 2015 12:40:33 -0800 (PST)
In-Reply-To: <564CAB93.9040007@icefield.yk.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281457>

+ Johannes

Though git for windows tracks its bugs at
https://github.com/git-for-windows/git/issues I think.

On Wed, Nov 18, 2015 at 8:47 AM, Erik Blake <erik@icefield.yk.ca> wrote:
> When pushing an existing local repo to a new remote repo, git 2.6.3
> misidentifies the user's home directory on a domain-connected Windows
> machine. My machine is running Win7-64 and I have tried both the 32-bit
> and 64-bit version of git.
>
> For example, the following sequence fails on the last command:
>
>>git remote add remote <remote repo URL>
>>git config remote.uf.push refs/heads/master:refs/heads/master
>>git push remote master
>
> The error returned by the last command is "Could not create directory
> '/home/foo/.ssh'."
>
> git should be targeting the directory '/home/foo.domain/.ssh' instead.
>
> The path to the user profile should be taken from %HOMEDRIVE%%HOMEPATH%
> or, preferably, %USERPROFILE% and not %USERNAME%, unless %USERDOMAIN% is
> appended when a domain-connected computer is detected.
>
> git 1.9.5 does not exhibit this problem.
>
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
