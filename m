From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: 'git add' corrupts repository if the working directory is 
	modified as it runs
Date: Sun, 14 Feb 2010 01:09:23 +0300
Message-ID: <37fcd2781002131409r4166e496h9d12d961a2330914@mail.gmail.com>
References: <20100211234753.22574.48799.reportbug@gibbs.hungrycats.org>
	 <20100213121238.GA2559@progeny.tock> <20100213133951.GA14352@Knoppix>
	 <201002131539.54142.trast@student.ethz.ch>
	 <20100213162924.GA14623@Knoppix>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Zygo Blaxell <zblaxell@gibbs.hungrycats.org>,
	git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Sat Feb 13 23:10:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgQC4-0000KP-Qw
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 23:10:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089Ab0BMWJZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2010 17:09:25 -0500
Received: from mail-fx0-f227.google.com ([209.85.220.227]:54402 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751005Ab0BMWJZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 17:09:25 -0500
Received: by fxm27 with SMTP id 27so41230fxm.25
        for <git@vger.kernel.org>; Sat, 13 Feb 2010 14:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=INrWtY+qIEuyimItzrL1BXC5UlnzUkkgcuC5i8D+o/E=;
        b=LfD0BRCyQLMEmLUg8iWbzRu+hicEoQSjh4SLExIIcCy1hUMLBsr8BRw1C9GEqiWxjY
         KbLJmzk6VGBJzZbIgcWFY5fle2Qq143WonvL/k7mx0W0qvxmvTzxksN7BZwb2lHUDWAc
         45ghWosUA7qP1V1QeAmEIdaCb7IItk1sRAM1g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Qnj3nM8WGVmnuBQUyKyF/H44ZDzuEdA+igrcmAx7+BVo2p5mch3VVLh9tVy5BeQipa
         5tnJUR0chFEqGPxasjyklyf6yGzH5ORGP7HhGqKBN/OJ9O0PzHcEZZ4l9QHQrQ7hrsDz
         MuEXScRjzBUFqi3UvxOFesRwnhxIeZ99Mh/eI=
Received: by 10.239.135.16 with SMTP id b16mr339887hbb.108.1266098963326; Sat, 
	13 Feb 2010 14:09:23 -0800 (PST)
In-Reply-To: <20100213162924.GA14623@Knoppix>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139865>

On Sat, Feb 13, 2010 at 7:29 PM, Ilari Liusvaara
<ilari.liusvaara@elisanet.fi> wrote:
>
> Hmm... One needs to copy the data block at time into temporary buffer
> and use that for feeding zlib and SHA-1. That ensures that whatever
> SHA-1 hashes and zlib compresses are consistent.

If you want this then just compile Git with NO_MMAP = YesPlease
It should solve the described problem.

Dmitry
