From: Bo Yang <struggleyb.nku@gmail.com>
Subject: Re: [PATCH 0/6 rebase-version] Make git log --graph looks better with 
	-p and other diff options
Date: Tue, 25 May 2010 17:39:18 +0800
Message-ID: <AANLkTin1Ouo9DsEIp6s6vLVbsXvBps7NooJyMjx5e8e8@mail.gmail.com>
References: <1274778154-29976-1-git-send-email-struggleyb.nku@gmail.com>
	 <20100525092336.GB30863@coredump.intra.peff.net>
	 <AANLkTim9pDdz-VU8mGsoEaiv81RepaZT29h_5iAOo4bx@mail.gmail.com>
	 <20100525093337.GB32460@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, gitster@pobox.com, trast@student.ethz.ch
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 25 11:39:28 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGqbg-0006OH-07
	for gcvg-git-2@lo.gmane.org; Tue, 25 May 2010 11:39:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754707Ab0EYJjW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 May 2010 05:39:22 -0400
Received: from mail-qy0-f183.google.com ([209.85.221.183]:40749 "EHLO
	mail-qy0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753885Ab0EYJjU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 May 2010 05:39:20 -0400
Received: by qyk13 with SMTP id 13so6958783qyk.1
        for <git@vger.kernel.org>; Tue, 25 May 2010 02:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=5cIWxD/WfcYVNdJFGzFin0MDJPvTjrkdG0/lq1HuixI=;
        b=uR7IZMUYgTjQYVaBbASUXn1a2ePv3AELUWIIRH1cd4kbXkSZ3t2YcdZuSWZi0pc/RT
         95O/ktFfx9uWCE1Ls2Tpahmgn1UG6dfdvBqOHrF9wXQsgIcLJisSWfgUWc0HXGFK5loK
         K5Okl9cTv3UOlqQXA3gCnjdmQNW96IFJ3hXIs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Ik8XKPHsAQLGQ1+2+cwsqbr+S1fZ/4125Xqa2F5tnah6Of0y8k0sh6PZ1/mpoLZRtO
         Cd8ASfk9+BfHSY2xnEL5VQxieChM/DNcpJ3BNOfxYugwTSc1c4wzYGzJS+Qr4LLyXFoI
         utbmX7RF9DkoAHmzSTpKFm9TNMAyaebJfuAm8=
Received: by 10.229.235.202 with SMTP id kh10mr1386125qcb.78.1274780359443; 
	Tue, 25 May 2010 02:39:19 -0700 (PDT)
Received: by 10.229.110.18 with HTTP; Tue, 25 May 2010 02:39:18 -0700 (PDT)
In-Reply-To: <20100525093337.GB32460@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147703>

On Tue, May 25, 2010 at 5:33 PM, Jeff King <peff@peff.net> wrote:
> On Tue, May 25, 2010 at 05:31:23PM +0800, Bo Yang wrote:
>
>> > I have to admit I don't quite understand from the commit message what
>> > the problem is that this is fixing.
>>
>> Ah, the previous code just call a emit_line for parts of the line, and
>> this commit change this behavior. It firstly compose the different
>> parts into one line and only call a emit_line. This is necessary
>> because each time we call emit_line, there will be a graph prefix
>> output. :)
>
> OK. I understood what it _does_ from the commit message and seeing the
> code, but the missing bit was that calling emit_line would get multiple
> graph prefixes.
>

Hmm, as I design, emit_line will be used for emit a complete line out,
so I can add the prefix output code in the emit_line function. And
thus, I should make sure, no one call emit_line to just output some
strings instead of a complete line...

-- 
Regards!
Bo
----------------------------
My blog: http://blog.morebits.org
