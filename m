From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFCv2 1/2] gitweb: add patch view
Date: Wed, 3 Dec 2008 18:08:01 +0100
Message-ID: <200812031808.01916.jnareb@gmail.com>
References: <1228298862-28191-1-git-send-email-giuseppe.bilotta@gmail.com> <200812031400.50980.jnareb@gmail.com> <cb7bb73a0812030514u11e10bebue5a1451d54fc3f96@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	"Petr Baudis" <pasky@suse.cz>
To: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 18:09:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7vEL-0000nr-MS
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 18:09:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382AbYLCRIN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 12:08:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbYLCRIN
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 12:08:13 -0500
Received: from an-out-0708.google.com ([209.85.132.241]:17540 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751322AbYLCRIM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2008 12:08:12 -0500
Received: by an-out-0708.google.com with SMTP id d40so1506840and.1
        for <git@vger.kernel.org>; Wed, 03 Dec 2008 09:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=NNb64/h8RfJSmKO2hdxmAMQpFaI2QGicJRwOGaeQv+k=;
        b=Xs2OdwwgGw5d3bstwi7LfHj148CBt2WtiypYIIXkpFjxhQ4NKZTvsZN6LVBS/FAWRw
         oJVOZKaXeJvdVqyrh3qfx0Eab5XzI0Br+1yru99BUybD0RJe3y+t4XgTPC+xW11s0aab
         JYIbYs0XjgVnzZbKLmIh4duYfpP0r8fh+N4as=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=SWGgjH5TYYS6rAsfmleFNhFudEZyIF6T1vnEkGkQOV+7SXZKkcoSQuFLvdXRFLaBe+
         oVsk/yzKoIL+bweL445NREfle5FrRM9zKVU8l/HanXhDj05I9kKsYALvLmdrdJFLeWIh
         1WJ059pwFkrlwVKra4BiyhWLOzUOtx4VbXcxI=
Received: by 10.103.222.1 with SMTP id z1mr6213682muq.121.1228324089832;
        Wed, 03 Dec 2008 09:08:09 -0800 (PST)
Received: from ?192.168.1.11? (abvo179.neoplus.adsl.tpnet.pl [83.8.212.179])
        by mx.google.com with ESMTPS id n7sm9947375mue.13.2008.12.03.09.08.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Dec 2008 09:08:08 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <cb7bb73a0812030514u11e10bebue5a1451d54fc3f96@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102271>

On Wed, Dec 3, 2008 at 14:14, Giuseppe Bilotta wrote:
> On Wed, Dec 3, 2008 at 2:00 PM, Jakub Narebski <jnareb@gmail.com> wrote:
>> On Wed, 3 Dec 2008, Giuseppe Bilotta wrote:
>>> On Wed, Dec 3, 2008 at 12:19 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>>
>>>> Perhaps this configuration should also be a feature defined in %feature,
>>>> overridable by each repository?  If you default it to "disabled" (as any
>>>> new feature typically does), you do not have to yank a random number such
>>>> as 100 out of thin air.
>>>
>>> I thought about it, but then I thought it was way too useful for
>>> single patches to disable the feature a priori. I'd rather make the
>>> default limit much smaller (like the original 16 commits I had in
>>> mind, or even less).
>>
>> Perhaps %feature can be used to configure _maximum_ number of patches
>> in 'patch' / 'format_patch' view (gitweb_get_feature... well, sort of
>> as gitweb_check_feature would work too), rather than checking if it
>> is enabled or disabled?
> 
> The way it's implemented in v2, you just need to set $patch_max in
> your local or system config file (e.g. /etc/gitweb.conf). I'm not sure
> about the benefit we would gain in going through %feature.

Ah, I haven't read patch in detail yet.

The (doubtful or not) benefit of going through %feature would be ability
to set limits (with perhaps -1 / <0 / undef / '' meaning: unlimited) on
per repository basis, with no limit for small repository, some limit for
the rest, and no 'patch' view or heavily limited for repository with
large size commits.

Just my 2 cents.
-- 
Jakub Narebski
Poland
