From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Libgit2 on the Summer of Code
Date: Thu, 27 May 2010 20:22:29 +0200
Message-ID: <AANLkTilE7UI3zg180U9GCB6DsByu3B9pwlG6xIyR8uiG@mail.gmail.com>
References: <AANLkTil-M3kQGbRZIacItlwr37Lf3lso7FspftLr43_F@mail.gmail.com>
	<20100527174636.GB9909@LK-Perkele-V2.elisa-laajakaista.fi>
	<20100527180554.GM16470@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org,
	srabbelier@gmail.com
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu May 27 20:28:03 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHhoI-0004N8-L8
	for gcvg-git-2@lo.gmane.org; Thu, 27 May 2010 20:28:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759412Ab0E0S14 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 May 2010 14:27:56 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:33730 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755281Ab0E0S1z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 May 2010 14:27:55 -0400
Received: by gyg13 with SMTP id 13so246043gyg.19
        for <git@vger.kernel.org>; Thu, 27 May 2010 11:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=shBeKgZRixaOz5mTh+6S5zu57WJBEP88yHgLbopHog0=;
        b=uJIBt9U96/iRGvCqv0JX4Dh2TioMDOtCJwQ/xrDX+5p3odpuljWKKGQuOjnjq3KfIj
         b3shYRKiVR+ZodAv+DNFjM7F2GyrKCWxz3tzoZapwoPWNSgQ9hpPd3SQH9dcpMLunad1
         Z3/y738T+UvWCO+9e80Y7pVkobteWmIT864KY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=N316WNrO7C4MRXQQDzDPdh72AZTEcsFVwtbI9ndCIjFi3DRRbJuJHVs6UZychf20iL
         EBxgIWhtjjNMIzu42Nk6th9F9ZDSZt/WgCdHggTuJ4C7nX7nl67IxNZzczOz9OGg0CAd
         yPo5nZKPFjWCcZYU0jN/9El7z/qLr98EA7FgM=
Received: by 10.101.177.39 with SMTP id e39mr13072052anp.8.1274984549298; Thu, 
	27 May 2010 11:22:29 -0700 (PDT)
Received: by 10.100.154.8 with HTTP; Thu, 27 May 2010 11:22:29 -0700 (PDT)
In-Reply-To: <20100527180554.GM16470@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147892>

On Thu, May 27, 2010 at 20:05, Shawn O. Pearce <spearce@spearce.org> wrote:
> Ilari Liusvaara <ilari.liusvaara@elisanet.fi> wrote:
>> * Where algorithm in git_revpool_table__hash() is from? Since it appears to
>> hash binary object IDs, wouldn't just simple sum/xor over words be sufficient
>> (all SHA-1 output bits are very nearly independent). Or do you need to be
>> compatible with some other implementation (doesn't appear so, because hash
>> is computed differently depending on endianess)?
>
> If you need a hash value for a SHA-1, why not just cast the unsigned
> char* to unsigned int* and load the first int as the hash code?
> The output of SHA-1 is pretty evenly distributed, using the first
> few bytes as an int should yield a sufficient distribution throughout
> the hashtable.

Just make sure the SHA1 data are properly aligned for your platform
