From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Help! My ISP blocks repo.or.cz. How to push changes?
Date: Tue, 13 Jan 2009 00:43:04 +0100
Message-ID: <200901130043.04772.jnareb@gmail.com>
References: <200901120246.28364.jnareb@gmail.com> <200901121213.45858.jnareb@gmail.com> <20090112122337.GA7262@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Tue Jan 13 00:44:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMWSQ-0006KM-19
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 00:44:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753639AbZALXnL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 18:43:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753560AbZALXnJ
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 18:43:09 -0500
Received: from mail-ew0-f17.google.com ([209.85.219.17]:55150 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752559AbZALXnG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 18:43:06 -0500
Received: by ewy10 with SMTP id 10so11792088ewy.13
        for <git@vger.kernel.org>; Mon, 12 Jan 2009 15:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=A2Kkgvofa2xr0XMji10mNz1s8DdpvkbzLC/0rllb2VA=;
        b=OW0TAo89IuQAR8DLggK1k7UAjGQx0BdZEzJoC+2HisGGFM+nH8++I/x5RMvHQd3fZw
         Z/EqkyDjMaS0ivIZonlvIkLamYb/wta0qOxwI5EtfukBrenzo7EQ0alDNAuzO3Pp/wfY
         AUcZ/FTPFH6kTeFl3EuLBC6A4alf4lbqqSez4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=KEq/3bstGXdn9yDXFA340drZXdH8EicHcL01LGu+uvbkLALeOfbyBuwSDyna4Dg3ST
         ffo+RQ+vfbu73qkMuBAdylFYhQRWgWweh+2hroJxeV+BUSycmmBfZjoMbeKZby0+2UzN
         fAl/N3Qfxk6Z5//QHUZhoVm5TId6T6O+9QAFU=
Received: by 10.210.89.13 with SMTP id m13mr4677102ebb.43.1231803784372;
        Mon, 12 Jan 2009 15:43:04 -0800 (PST)
Received: from ?192.168.1.11? (abvj184.neoplus.adsl.tpnet.pl [83.8.207.184])
        by mx.google.com with ESMTPS id 5sm15588639nfv.18.2009.01.12.15.43.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 12 Jan 2009 15:43:03 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20090112122337.GA7262@glandium.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105416>

On Mon, 12 January 2009, Mike Hommey wrote:
> On Mon, Jan 12, 2009 at 12:13:44PM +0100, Jakub Narebski <jnareb@gmail.com> wrote:

>> Currently I have the folowing in my ~/.ssh/config:
>> 
>>   # TP S.A. blocks repo.or.cz
>>   Host repo.or.cz
>> 	NoHostAuthenticationForLocalhost yes
>> 	HostName localhost
>> 	Port 2222
>> 
>> and I can simply use "git push repo" without any changes.
>> But I have to run 
>> 
>>  $ ssh -f -N -L 2222:repo.or.cz:22 jnareb@host.example.com
>> 
>> first. Is there any way to automate this?
> 
> Something like the following should do the trick:
> Host repo.or.cz
> 	ProxyCommand ssh jnareb@host.example.com nc %h %p
> 
> You will need nc (netcat) installed on the host.example.com server, though.

I assume that is both in place of above ~/.ssh/config configuration,
and making unnecessary port forwarding (ssh -L) invocation, isn't it?

P.S. What should I put in core.gitProxy to make it possible to fetch
via git:// protocol from repo.or.cz?

-- 
Jakub Narebski
Poland
