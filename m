From: Leonid Podolny <leonidp.lists@gmail.com>
Subject: Re: Rebasing multiple branches
Date: Wed, 22 Dec 2010 16:54:46 +0200
Message-ID: <4D121136.6050906@gmail.com>
References: <4D10AE5B.2080700@gmail.com> <4D10B44D.5090309@viscovery.net> <20101222143654.GA4829@nibiru.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: weigelt@metux.de
X-From: git-owner@vger.kernel.org Wed Dec 22 15:54:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PVQ5f-0000R7-QB
	for gcvg-git-2@lo.gmane.org; Wed, 22 Dec 2010 15:54:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753365Ab0LVOyv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Dec 2010 09:54:51 -0500
Received: from mail-fx0-f43.google.com ([209.85.161.43]:58255 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752403Ab0LVOyu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Dec 2010 09:54:50 -0500
Received: by fxm18 with SMTP id 18so5704037fxm.2
        for <git@vger.kernel.org>; Wed, 22 Dec 2010 06:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=1EVK1p/b9CoiGY+LDdz8UUmxgqGb75YZF/ZQl3yDevo=;
        b=S0hYJy9OoZgSbJT7wB+Iwm+3bFq8TaIdg0WX5sCAmqVCf0F0JD7iht3EwFEN3vrzfA
         D0XqPQW/oL7KNC+wD/IHYYdzqD3rCQizaZPIba7Z2eMDGRfNO1GIZCoze76PWncOx1lz
         g9Q6wuC3ew3fpsErLFEPYIXe/c9dDHrgyIhB0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=fWqvPywOh6rOX6nfwtHktagx0R4yKe5F/KaxXdLfbQnhicNl8FSOKTtChDdj7MBVLd
         LOE5XruY2bQTYj7aDMR/xAReb9CoQNy18Sj74B3WgpqqPxtDOnT265028ugdWGvGFu+i
         Pxj0N4YsAp1G1d+j42iyZ/ZzoyN5EZ5bmgxp8=
Received: by 10.223.86.16 with SMTP id q16mr7548659fal.58.1293029689239;
        Wed, 22 Dec 2010 06:54:49 -0800 (PST)
Received: from [10.20.20.19] (80.179.223.9.cable.012.net.il [80.179.223.9])
        by mx.google.com with ESMTPS id 5sm1724114fak.23.2010.12.22.06.54.47
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 22 Dec 2010 06:54:48 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Thunderbird/3.1.7
In-Reply-To: <20101222143654.GA4829@nibiru.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164088>

On 12/22/2010 04:36 PM, Enrico Weigelt wrote:
> Why not this way ?
>
> git checkout D
> git rebase -p -i D~3 --onto C'
>
> (C' is the merged branch of A' and B').
>
>
> So:
>
> git checkout branch_A -b rebasing_A
> git rebase master			# rebase old A to master
> git checkout branch_B -b rebasing_B
> git rebase master			# rebase old B to master
> git checkout -b rebased_merge
> git merge rebasing_A			# we're on B', merge in A'
> git checkout branch_C
> git rebase -p -i C --onto rebased_merge # set D~3..D ontop of it
>
>
> cu

Ah, nice. I didn't notice the -p option. However, the man page advises 
against using -p and -i together.
