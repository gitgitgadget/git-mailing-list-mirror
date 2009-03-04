From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [Orinoco-users] linux-firmware binary corruption with gitweb
Date: Tue, 03 Mar 2009 16:26:28 -0800 (PST)
Message-ID: <m3iqmqt9ox.fsf@localhost.localdomain>
References: <49A98F6A.50702@gmail.com> <1235886467.3195.15.camel@mj>
	<49AD7E2B.3010101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pavel Roskin <proski@gnu.org>, git@vger.kernel.org,
	linux-kernel@vger.kernel.org, orinoco-users@lists.sourceforge.net,
	dwmw2@infradead.org
To: Dave <kilroyd@googlemail.com>
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755359AbZCDA0u@vger.kernel.org Wed Mar 04 01:28:24 2009
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755359AbZCDA0u@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeeyF-0007nG-W4
	for glk-linux-kernel-3@gmane.org; Wed, 04 Mar 2009 01:28:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755359AbZCDA0u (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 3 Mar 2009 19:26:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752067AbZCDA0e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Mar 2009 19:26:34 -0500
Received: from fg-out-1718.google.com ([72.14.220.154]:16946 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915AbZCDA0c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Mar 2009 19:26:32 -0500
Received: by fg-out-1718.google.com with SMTP id 16so151307fgg.17
        for <multiple recipients>; Tue, 03 Mar 2009 16:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=EZP56W+8Wh+hIYvXL0AXUCozaBdzbWsMQcMkHG3LTFE=;
        b=KgDKdSl1/S2CxwY0enzNFmma0pqD3aoTv2CruEwh3jw2YrtCTcOn4cTEFe8S4znnYx
         ZhmtHJnn66IM9L94YDljRkj1rbZ0CPS5wcR4+92dxBUQiquM2D6wf5OiNzMfaxGelCx8
         pdodAjCOL47bRyEjt0/HGz4WA22F5dvMtPJdE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=txBfnkt+dxdSTLj4ajzQSS5Ca0mauCB7NQ9mnNnrIPPrlf25MqiQSYSAF5O3Xu2oNM
         ZfupWLfWxEyer0ext7+GcXQTYHqGkE31raNBTtIgJyeevrE2XJvNtnETkhJ7uJsJ9OKl
         FnL0cugH2bWHqnr5BpyO2ZKpAV5jDpttZhzm8=
Received: by 10.86.91.3 with SMTP id o3mr2792677fgb.17.1236126389430;
        Tue, 03 Mar 2009 16:26:29 -0800 (PST)
Received: from localhost.localdomain (abwt152.neoplus.adsl.tpnet.pl [83.8.243.152])
        by mx.google.com with ESMTPS id d6sm1348007fga.2.2009.03.03.16.26.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 03 Mar 2009 16:26:28 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n240QQAp024068;
	Wed, 4 Mar 2009 01:26:27 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n240QNwM024064;
	Wed, 4 Mar 2009 01:26:23 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <49AD7E2B.3010101@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112176>

Dave <kilroyd@googlemail.com> writes:

> Adding the git mailing list.
> 
> Pavel Roskin wrote:
> > On Sat, 2009-02-28 at 19:24 +0000, Dave wrote:

>>> I'm aware of at least a couple users of orinoco who have picked up
>>> corrupt firmware# from the linux-firmware tree*.
>>>
>>> I've verified that the firmware in the repository itself is correct.
>>>
>>> It appears that downloading the file using the blob/raw links from
>>> gitweb causes the corruption (0xc3 everywhere). At least it does with
>>> firefox.
>> 
>> I can confirm the problem with Firefox 3.0.6.  But it's not "0xc3
>> everywhere".  The corrupted file is a result of recoding from iso-8859-1
>> to utf-8.  The correct agere_sta_fw.bin is 65046 bytes long.  The
>> corrupted agere_sta_fw.bin is 89729 bytes long.

[...]
>> My strong impression is that the recoding takes place on the server.  I
>> think the bug should be reported to the gitweb maintainers unless it a
>> local breakage on the kernel.org site.
> 
> Thanks Pavel.
> 
> I just did a quick scan of the gitweb README - is this an issue with the
> $mimetypes_file or $fallback_encoding configurations variables?

First, what version of gitweb do you use? It should be in 'Generator'
meta header, or (in older gitweb) in comments in HTML source at the
top of the page.

Second, the file is actually sent to browser 'as is', using binmode :raw
(or at least should be according to my understanding of Perl). And *.bin
binary file gets application/octet-stream mimetype, and doesn't send any
charset info. git.kernel.org should have modern enough gitweb to use this.
Strange...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
