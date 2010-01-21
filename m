From: SungHyun Nam <goweol@gmail.com>
Subject: Re: git locate
Date: Thu, 21 Jan 2010 09:11:20 +0900
Message-ID: <4B579BA8.8050000@gmail.com>
References: <43d8ce651001191717l58d10919j691f4e5b056fe9b5@mail.gmail.com> <alpine.DEB.1.00.1001200224270.4985@pacific.mpi-cbg.de> <m3zl49bk0o.fsf@localhost.localdomain> <alpine.DEB.1.00.1001201021060.31129@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 21 01:11:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXkdq-00010N-HE
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 01:11:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754320Ab0AUALN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 19:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752681Ab0AUALN
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 19:11:13 -0500
Received: from mail-fx0-f220.google.com ([209.85.220.220]:55530 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754019Ab0AUALM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2010 19:11:12 -0500
Received: by fxm20 with SMTP id 20so774951fxm.1
        for <git@vger.kernel.org>; Wed, 20 Jan 2010 16:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:newsgroups:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=kC+DOIoDIDlnPTduXcZtfqZyuUFtY101wHcPF+PnTCc=;
        b=LQAVdvpeAEqGiDJDsPh4QRs1J++gQ9RbYqh0NkiZgGpTHvfcPDZtkW3GovyJOHFGtr
         viMHCJjdLZP7sOM4ddek6nSooxWvxkXKAfd3Qty/Pxmok0APrETT9msUUZYR8mSqlIOw
         Dv4OumluV28VqO5U7BE/wAS8MTFZeC+1XVqT0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=e8nBrjwTIbIf34LfbAyMm+T3El/J0ej9d9jwRgAK9CfjaV6dZ5AZPur+zdoi2hc8X0
         MrgRp8zLBusx20FCMVrOGYhg/wiW8jOkr0k2Po3lPIVt5oIICCT6uH4CBgontwXbgKcB
         LbbbWnCv+6wvyoX+gai/RujU113QlaiGiY4/M=
Received: by 10.223.6.9 with SMTP id 9mr707290fax.84.1264032670915;
        Wed, 20 Jan 2010 16:11:10 -0800 (PST)
Received: from ?210.181.13.12? ([210.181.13.12])
        by mx.google.com with ESMTPS id 13sm298444fxm.9.2010.01.20.16.11.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 Jan 2010 16:11:10 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; ko; rv:1.9.1.7) Gecko/20100111 Thunderbird/3.0.1
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <alpine.DEB.1.00.1001201021060.31129@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137602>

Hello,

Johannes Schindelin wrote:
>
> On Tue, 19 Jan 2010, Jakub Narebski wrote:
>
>> Johannes Schindelin<Johannes.Schindelin@gmx.de>  writes:
>>
>>> On Wed, 20 Jan 2010, John Tapsell wrote:
>>>
>>>>    Could we add a:  git locate<filename>        or git find<filename>
>>>
>>> How about "git ls-files \*<filename>"?
>>
>> Or "git ls-files '*filename'...
>>
>> ... but how to make an (git) alias for this?
>
> Add something like this to your $HOME/.gitconfig:
>
> [alias]
>          locate = !sh -c 'git ls-files "\\*$1"' -

The alias 'git locate' and the command 'git ls-files' runs
differently if I run them in a subdirectory.
Is it expected?

[master] ~/srcs/git[299]$ git locate urls.txt
Documentation/urls.txt
[master] ~/srcs/git[300]$ git ls-files '*urls.txt'
Documentation/urls.txt
[master] ~/srcs/git[301]$ cd t
[master] ~/srcs/git/t[302]$ git locate urls.txt
Documentation/urls.txt
[master] ~/srcs/git/t[303]$ git ls-files '*urls.txt'
[master] ~/srcs/git/t[304]$

Thanks,
namsh
