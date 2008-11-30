From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH 3/3] gitweb: make gitweb_check_feature a boolean wrapper
Date: Sun, 30 Nov 2008 02:31:12 +0100
Message-ID: <cb7bb73a0811291731g7f8770f7p89e924c00d2ab004@mail.gmail.com>
References: <1227904793-1821-3-git-send-email-giuseppe.bilotta@gmail.com>
	 <1227959616-8056-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <7vej0u1d2c.fsf@gitster.siamese.dyndns.org>
	 <7vzljiz1qn.fsf@gitster.siamese.dyndns.org>
	 <7vmyfiz0zf.fsf_-_@gitster.siamese.dyndns.org>
	 <cb7bb73a0811291427n7922ab1fq50caedafe7163f9e@mail.gmail.com>
	 <7vej0uysbs.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Jakub Narebski" <jnareb@gmail.com>,
	"Petr Baudis" <pasky@suse.cz>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 30 02:32:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6bAn-0002QL-A5
	for gcvg-git-2@gmane.org; Sun, 30 Nov 2008 02:32:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753835AbYK3BbQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Nov 2008 20:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753634AbYK3BbQ
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Nov 2008 20:31:16 -0500
Received: from ik-out-1112.google.com ([66.249.90.181]:18553 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753412AbYK3BbP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Nov 2008 20:31:15 -0500
Received: by ik-out-1112.google.com with SMTP id c29so1594002ika.5
        for <git@vger.kernel.org>; Sat, 29 Nov 2008 17:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=yLvs/72CDojqVSFZcBohsA0Ah0ApFhFHJDngIrmXk0Q=;
        b=RMCWAz5L8sRwgMCMkWmc24FunRKM0rs4RLBn11xw56cMelfIXwDMvYIeFgj1brgB3H
         gUlKuyMI1m1e6SmddhyG5hXh4ueKCH30aJIeS9MLeQ+YajzbZlsOSyJ6hM8qOrudkBL7
         uiB1BvWfgzsyLekDXwOb3u4D/OCs5Zzrlul4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=WKp4zdzj2wopMT+8OY2fNjqqdFb7vj34ptHr+C2A77mCoY4VBqfMhM3//PXKIdq/Qq
         ZMfNajvG9x9zRw/y3B6uYm1J38YAUJEj6wOwCr5/0cpalWiGtOvkTi+S0ciqTwZ15VqL
         RHljyUlt+Hrsyr18L0/Yz4Wc+0QVv88how0kE=
Received: by 10.210.120.7 with SMTP id s7mr10813361ebc.78.1228008672330;
        Sat, 29 Nov 2008 17:31:12 -0800 (PST)
Received: by 10.210.79.12 with HTTP; Sat, 29 Nov 2008 17:31:12 -0800 (PST)
In-Reply-To: <7vej0uysbs.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101944>

On Sun, Nov 30, 2008 at 1:23 AM, Junio C Hamano <gitster@pobox.com> wrote:
> "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com> writes:
>
>> On Sat, Nov 29, 2008 at 10:16 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>  * Again, this is to demonstrate how I would have liked to see your
>>>   patches as a reviewable series.  Notice how this naturally justifies
>>>   the dropping of parentheses in many lines that begin with "my", and
>>>   makes it easier to review?  You can review the patch easily by knowing
>>>   that callers that have s/get/check/ are now safe to use scalar context.
>>
>> Yes, I get the point: do less things under the hood. I also still
>> think that three patches with code going ping-pong are way too much,
>> though 8-P
>>
>> For what it's worth, you get my Ack: to your patchset 8-)
>
> Well, I am not interested in taking credits for this series.  I am very
> much interested in reducing my future workload by showing people how an
> easily reviewable series should look like.
>
> So if you still think it is "way too much", I did not succeed what I tried
> to do X-<.

At least as far as this patch goes, from my point of view, the
'clueless/careless' usages of gitweb_check_feature are the
conceptually (although not code-wise) correct ones, so they shouldn't
be the ones touched by the patch, considering that in addition to the
futureproofing, (implicit) fixing those usages is one of the main
points of the patch itself.

OTOH, I _do_ get the point about ease of review. But for example (and
for future reference for myself): would you say that it would have
been enough to have a cleaner commit message explicitly mentioning the
fact that formerly incorrect usages of the gitweb_check_feature() were
left intact because they were now correct?

Something like this http://git.oblomov.eu/git/patch/gitweb/check-feature-v3

-- 
Giuseppe "Oblomov" Bilotta
