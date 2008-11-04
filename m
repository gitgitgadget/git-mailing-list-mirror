From: Liu Yubao <yubao.liu@gmail.com>
Subject: Re: How to send patch series without storing them to disk?
Date: Tue, 04 Nov 2008 14:01:41 +0800
Message-ID: <490FE545.9000106@gmail.com>
References: <490EC57E.4080200@gmail.com> <alpine.LFD.2.00.0811032242080.1791@sys-0.hiltweb.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ian Hilt <ian.hilt@gmx.com>
X-From: git-owner@vger.kernel.org Tue Nov 04 07:04:01 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxF0z-0002HE-LL
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 07:03:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753737AbYKDGBx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 01:01:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751716AbYKDGBx
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 01:01:53 -0500
Received: from ti-out-0910.google.com ([209.85.142.187]:4975 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753738AbYKDGBw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 01:01:52 -0500
Received: by ti-out-0910.google.com with SMTP id b6so1557824tic.23
        for <git@vger.kernel.org>; Mon, 03 Nov 2008 22:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=nYiFBWl8aqIEH6Gmr2KEqEmicqDo/skAqKg5zYPkafM=;
        b=bcTwxNdW4vMkMn9UxsC2D1q7+eadKocbW69B2FosOY6DzBdEZGTYptUv8QthxbeNa2
         qxMRDrhJ3h8AmOTr6GO92umT8zVZP08jxZwVoSJqOj/j4SUybRBK3YmTcTi9ROxZTBAy
         FOoE9nkPHsyFek9483wuwSU51ixp/MlWTJOTg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=PmMPh2YJ0A2MJDrVQHiwRhv1jsBS9PBqsgaCnoktqLpIqgPyW3MFpjMsAuuQ0Pax+i
         oIlOAyiRBchI/1GZIoY2hGEDlGFw9SFN39XEzC01TSfJwYasgIEmAAd2Af8/KPgGZLNJ
         ZhTBpK+MfdsZQWVCg+tdSBluNT7DR12WvnSMc=
Received: by 10.110.10.16 with SMTP id 16mr736149tij.25.1225778510364;
        Mon, 03 Nov 2008 22:01:50 -0800 (PST)
Received: from ?10.64.1.142? ([211.157.41.194])
        by mx.google.com with ESMTPS id i6sm15257654tid.5.2008.11.03.22.01.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 03 Nov 2008 22:01:49 -0800 (PST)
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
In-Reply-To: <alpine.LFD.2.00.0811032242080.1791@sys-0.hiltweb.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100041>

Ian Hilt wrote:
> On Mon, 3 Nov 2008, Liu Yubao wrote:
>> Hi,
>> I tried to send one patch using git-send-email, it reported "Syntax: AUTH mechanism".
>>   git send-email --from <myemail> --to <my-another-email> \
>>                  --smtp-pass <mypass> --smtp-user <myaccount> \
>>                  --smtp-server <the-smtp-server> \
>>                  --smtp-encryption auth          \
>>                  0001-just-a-test.patch
>>
>> The parameters about smtp are right, I tested with msmtp. What's wrong?
>>
>> I have MIME::Base64 and Authen::SASL installed and the smtp server doesn't use
>> ssl and tls.
> 
> Try removing --smtp-encryption and add --envelope-sender <youremail>.
> 

I traced the related Perl modules and found Authen::SASL in Ubuntu Gutsy is buggy,
the problem is resolved after I install the module from CPAN.

> 
> 	Ian
> 
