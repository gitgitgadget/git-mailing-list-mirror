From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv2 5/6] gitweb: last-modified time should be commiter, not 
	author
Date: Wed, 11 Feb 2009 10:02:00 +0100
Message-ID: <cb7bb73a0902110102k5b7e5a21vd7d0932c6b6ba20e@mail.gmail.com>
References: <1232970616-21167-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <200902050038.57999.jnareb@gmail.com>
	 <cb7bb73a0902060314u4741528bs196a43d45ff7f283@mail.gmail.com>
	 <200902062212.08857.jnareb@gmail.com>
	 <cb7bb73a0902061500x12105a13la78703918937fe4b@mail.gmail.com>
	 <86d4c5e00902101910k5512efel2c9165f75d61ba53@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Deskin Miller <deskinm@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 10:03:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXB0H-0003Eu-DP
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 10:03:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753454AbZBKJCF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 04:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752903AbZBKJCF
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 04:02:05 -0500
Received: from mail-ew0-f26.google.com ([209.85.219.26]:59929 "EHLO
	mail-ew0-f26.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751822AbZBKJCD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 04:02:03 -0500
Received: by ewy7 with SMTP id 7so26381ewy.13
        for <git@vger.kernel.org>; Wed, 11 Feb 2009 01:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=M6lElWGRFaKUckfP3ym43ecBLqY/zOFxd+S/qXORa6Q=;
        b=iWr+B1zk7HBqmt06LBBo7WDjslEffNsOb6E/VV1GWps4L9eBCL1ypn0EbbksZ+04Gk
         DvBMbkSPkbUlCbtrt97ZGVlABabJWJNrxtk+VDBK6KO62FBVmC70iIptEPzyAlBxe/ZT
         U9q9YP5FggLmT6RzKXhRFUwNTG/bLQE7tAiTU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=kcPUaRV0JUxEdm55nQHwlrgL8p65LFtG/BTF+R3Ab48Ilo/6XyGP2LgCl1fbVsAyVv
         TrIGaRjBqqX1qgld9CW2BlEC2Mca5gyVyC8SNKaUmccQhEbVG9MLGRTyFrASi7GauKOL
         5DIHgLfFeYZVfeoDkf/94IPhVgMZSBj2T+o8U=
Received: by 10.210.16.10 with SMTP id 10mr4321399ebp.80.1234342920346; Wed, 
	11 Feb 2009 01:02:00 -0800 (PST)
In-Reply-To: <86d4c5e00902101910k5512efel2c9165f75d61ba53@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109384>

On Wed, Feb 11, 2009 at 4:10 AM, Deskin Miller <deskinm@gmail.com> wrote:
> On Fri, Feb 6, 2009 at 18:00, Giuseppe Bilotta
> <giuseppe.bilotta@gmail.com> wrote:
>>
>> The real question is: _how_ do you get the (branch) update time?
>>
>
> Sorry the topic's cold, but...
>
> git reflog?
>
> Seems like one could find the oldest time the commit appears in the
> reflog, for the branch one is interested in.  You can use the commit
> time to limit the search through the reflog, but there would be clock
> skew concerns.

Bingo! Thanks a lot

oblomov@rbot ~ $ GIT_DIR=/var/git/rbot.git/ git reflog show
--since="two days ago" master | cat
7324b32... master@{0}: push
e2dc08d... master@{1}: push
oblomov@rbot ~ $ GIT_DIR=/var/git/rbot.git/ git reflog show
--since="yesterday" master | cat
oblomov@rbot ~ $

I'll try to work it in the next review for this patchset.

-- 
Giuseppe "Oblomov" Bilotta
