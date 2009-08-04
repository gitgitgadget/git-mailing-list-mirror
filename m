From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: Please make git-am handle \r\n-damaged patches
Date: Tue, 04 Aug 2009 08:21:32 +0200
Message-ID: <4A77D36C.9060309@gnu.org>
References: <4A7735B0.2040703@zytor.com> <7vocqw8u0x.fsf@alter.siamese.dyndns.org> 	<4A7760FD.8020705@zytor.com> <fabb9a1e0908031521q579a9bf0ta834b2c9253e58e9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 04 08:21:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYDP8-0000r7-5j
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 08:21:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932449AbZHDGVh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2009 02:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932439AbZHDGVh
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 02:21:37 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:33343 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932438AbZHDGVg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2009 02:21:36 -0400
Received: by bwz19 with SMTP id 19so2883138bwz.37
        for <git@vger.kernel.org>; Mon, 03 Aug 2009 23:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=Gwqxs4tzOegsXQJEmAjtjuJBo/qEbHrw4UN8W+/z+9s=;
        b=MW0fOqEqmHSIn6XYO1/8RzBm1eey7WtUdm/ioNr/qv0fD7vj9mkdnodYr8rptxL1D1
         TxAjy2GAawi2bEEOmsXugh4dbpB1tVxGX0IhNSzvfpXv9XVBib/KSTuuKSwuAR74oXek
         LNrC0XEuei7WuIXHbu4Pppsa0789/oUJgpXo8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=qcMCAAJE1pas7V/xF6+2dDkvbu2KZJD/f6NwvHapO6bBzYlXOYoD26pFPNPBellT7X
         HCibQGy36KxeD+hIebDIiDQyRA/qDDLMTG10/JzdaHPYUt/Vth31SsueHXP9ARgntRra
         X7WqrPKT0x2IMOfub5Aw5Bh4EaZPk5jCGqjAQ=
Received: by 10.103.193.12 with SMTP id v12mr1418094mup.93.1249366896120;
        Mon, 03 Aug 2009 23:21:36 -0700 (PDT)
Received: from yakj.usersys.redhat.com ([88.128.87.174])
        by mx.google.com with ESMTPS id j10sm12444865mue.15.2009.08.03.23.21.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 03 Aug 2009 23:21:35 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b3pre) Gecko/20090513 Fedora/3.0-2.3.beta2.fc11 Lightning/1.0pre Thunderbird/3.0b2
In-Reply-To: <fabb9a1e0908031521q579a9bf0ta834b2c9253e58e9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124754>

On 08/04/2009 12:21 AM, Sverre Rabbelier wrote:
> Heya,
>
> On Mon, Aug 3, 2009 at 15:13, H. Peter Anvin<hpa@zytor.com>  wrote:
>> Yes, that's what they suggested, too.  Like I need an extra step in my
>> patch process.
>
> Write your own git-lazy-am.sh and put it in your path?
>
> cat>  git-lazy-am.sh<<  EOF
> #!/bin/bash
>
> dos2unix "$@" | git am
> EOF

Even better than putting it on the path,

[alias]
	tbam = ~/libexec/git/git-lazy-am.sh

Paolo
