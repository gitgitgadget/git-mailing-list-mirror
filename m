From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: Re: [PATCH 04/15] Set _O_BINARY as default fmode for both MinGW and
 MSVC
Date: Thu, 17 Sep 2009 11:28:32 +0200
Message-ID: <4AB20140.7060901@gmail.com>
References: <cover.1253088099.git.mstormo@gmail.com>	 <6e6345fb3fbc19b1a2467e33e1633fe9025e547b.1253088099.git.mstormo@gmail.com>	 <929c5a34cd2621af24bcda7e47ff2e76b51c2e09.1253088099.git.mstormo@gmail.com>	 <4AB10F01.9010703@viscovery.net>	 <e2480c70909161300o3db4b416k8f33ccce2f987c55@mail.gmail.com>	 <4AB1E118.70504@viscovery.net> <4AB1E4C5.80102@gmail.com>	 <4AB1E6E4.1040100@viscovery.net> <4AB1EB02.2090308@gmail.com>	 <4AB1EF0E.5010600@viscovery.net> <e2480c70909170139x9580bb4pcc1ad8e1b93aef17@mail.gmail.com> <4AB1FB79.5070903@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Alexey Borzenkov <snaury@gmail.com>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de, msysgit@googlegroups.com,
	gitster@pobox.com, j6t@kdbg.org, lznuaa@gmail.com,
	raa.lkml@gmail.com,
	Marius Storm-Olsen <marius.storm-olsen@nokia.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Sep 17 11:29:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MoDIb-0008Ff-65
	for gcvg-git-2@lo.gmane.org; Thu, 17 Sep 2009 11:29:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754286AbZIQJ3A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2009 05:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751930AbZIQJ27
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Sep 2009 05:28:59 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:12242 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751500AbZIQJ27 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2009 05:28:59 -0400
Received: by ey-out-2122.google.com with SMTP id 4so967582eyf.5
        for <git@vger.kernel.org>; Thu, 17 Sep 2009 02:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=+DHC1/JttOW6uGQ8AXXeHwogHeE6QI8EbcNj8dniNEs=;
        b=demrX87BVMV6FNJA//fRnIySdx8CKL3A9pvh/g7dMkKpnyUXiUVu05PL5LOx9g4qRr
         ICWzeHUCWdqVla3DDTBotC/vGcw8h26NnUx1Wi20vLiGsvUJIEYZ/zThTnTCZ0N66Qsg
         AZLPEsHYsazWPldw7IoplbUpg1ItEVLw81KkI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=gplnaVAeI8wXoJMSFYPlqeYn2iiQ+pkyDPpXY82fsY8tV2BfKXM6udT6F0aKSt7dAF
         qj3TrH2NkSaYlSAHfwA2OIOw9LIEmy/Gw0yVFQK0zB1URTwDX0H9L0C0Xc7VygPWVSdy
         U6LjlaRtuKh7oJuYiElNZaLvbsx1JHJfZ9O28=
Received: by 10.216.22.140 with SMTP id t12mr101352wet.148.1253179741816;
        Thu, 17 Sep 2009 02:29:01 -0700 (PDT)
Received: from ?172.24.90.95? ([62.70.27.104])
        by mx.google.com with ESMTPS id 7sm5093956eyg.0.2009.09.17.02.29.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 17 Sep 2009 02:29:01 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.23) Gecko/20090812 Lightning/0.9 Thunderbird/2.0.0.23 ThunderGit/0.1a Mnenhy/0.7.6.666
In-Reply-To: <4AB1FB79.5070903@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128738>

Johannes Sixt said the following on 17.09.2009 11:03:
> Alexey Borzenkov schrieb:
>> Do you want me to cook up a patch?
> 
> I consider an answer to the question "why do we need nsec?" more important.
> 
> BTW: t4130-apply-criss-cross-rename.sh fails quite often as well. This
> time it is because we fill in st_ino = 0 instead of some useful value. The
> test moves files around that happen to have identical sizes. After the
> operation, the dirty working tree could be noticed because st_ino differs
> from the index. But since we always set it to 0, it is not noticed.
> (That's my theory.)
> 
> If you make a patch, can you think about this issue as well?

Cygwin version also sets st_ino = 0, so I'm not sure this is the cause 
of failure; unless this test also fails there? Does anyone know?

--
.marius
