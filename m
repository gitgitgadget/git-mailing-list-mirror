From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH 4/4] grep -O: allow optional argument specifying the pager
 (or editor)
Date: Sat, 12 Jun 2010 19:16:17 +0200
Message-ID: <4C13C0E1.3070707@gnu.org>
References: <20100605005116.GA8774@progeny.tock> <alpine.DEB.1.00.1006051810300.1732@bonsai2> <20100612075542.GB2918@burratino> <alpine.DEB.1.00.1006121139290.2689@bonsai2> <20100612162945.GB1406@burratino> <20100612163946.GD5657@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 12 19:16:31 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONUJo-0005lm-Qo
	for gcvg-git-2@lo.gmane.org; Sat, 12 Jun 2010 19:16:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751882Ab0FLRQX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jun 2010 13:16:23 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:6366 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888Ab0FLRQX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jun 2010 13:16:23 -0400
Received: by fg-out-1718.google.com with SMTP id d23so676156fga.1
        for <git@vger.kernel.org>; Sat, 12 Jun 2010 10:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=8MqFxjrwDYwMdaV6DDbfUhDp2Bbz+n0uGAw6Lc5MWtQ=;
        b=XimBK2ILj49CjrXTqJrlvO85lz30rqPBOoC0tpbrQWHLoPKhVzfcVC96iW/2CJzH+u
         rrJt9C1mMC1hBQS0brC/YL7Nzd0qLRnOSNCSiu3hQAWEc+jEEuSJM1JaJVY2n6u2bdv0
         DVqfKjRLy4CYoeTIkBIJhmvjYKQ5zJ3wls8Ss=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=ZB3m/Kt2cnh56yPQaIgqHIvMxv5KkJfjMEWo8IyJuficlVyYswfuga+SZpjMPTT4Km
         MMt5bh3riFInBsQqq1k7sSj+vwbmlo3NoSKj6Rah3By28QYAxoMNvfkeNN6S9zbU6fEB
         8DpgGsFX8NaP7P5e3UMGGspnycabla/weVpFc=
Received: by 10.87.66.15 with SMTP id t15mr5776511fgk.37.1276362980655;
        Sat, 12 Jun 2010 10:16:20 -0700 (PDT)
Received: from yakj.usersys.redhat.com (s209p8.home.99maxprogres.cz [85.93.118.17])
        by mx.google.com with ESMTPS id 1sm4314464fkt.11.2010.06.12.10.16.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 12 Jun 2010 10:16:19 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100430 Fedora/3.0.4-3.fc13 Lightning/1.0b2pre Thunderbird/3.0.4
In-Reply-To: <20100612163946.GD5657@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149024>

On 06/12/2010 06:39 PM, Jonathan Nieder wrote:
> From: Johannes Schindelin<johannes.schindelin@gmx.de>
>
> Suppose you want to edit all files that contain a specific search term.
> Of course, you can do something totally trivial such as
>
> 	git grep -z -e<term>  | xargs -0r vi +/<term>
>
> but maybe you are happy that the same will be achieved by
>
> 	git grep -Ovi<term>
>
> now.

Ah, I had missed that the argument was optional.  I think that optional 
arguments are slightly frowned upon for POSIX utilities, because they're 
a bit different.  In fact, I think the only one is -i in sed (and BSD 
sed instead makes it mandatory...).  Personally I have no problem with 
making -O in GNU grep optional too, I'll see what the other maintainers say.

Acked-by: Paolo Bonzini <bonzini@gnu.org>

Paolo
