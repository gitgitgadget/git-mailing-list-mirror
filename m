From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH] compat: Add another rudimentary poll() emulation
Date: Sun, 30 May 2010 09:44:21 +0200
Message-ID: <4C021755.8090307@gnu.org>
References: <1274948384-167-1-git-send-email-abcd@gentoo.org>	<1274948384-167-2-git-send-email-abcd@gentoo.org>	<20100527101043.GA4390@progeny.tock>	<AANLkTikYa2vq4PrKrO2QIkHVxYqbhUZRw42kQq875FNT@mail.gmail.com>	<AANLkTikfaWVEPkHBRF8WHNWmyXIH9f7wRju1wSRC_lwm@mail.gmail.com>	<AANLkTinXwM1fem6E3RgnLW9vqLD1fV7JvaQnxzZVRakA@mail.gmail.com> <AANLkTinX8nK68rZtN5dwJ-fGQm4gR2G84xo9raxb4vLY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: kusmabite@gmail.com, Jonathan Nieder <jrnieder@gmail.com>,
	Jonathan Callen <abcd@gentoo.org>, git@vger.kernel.org,
	mduft@gentoo.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Johannes Sixt <j6t@kdbg.org>,
	msysGit <msysgit@googlegroups.com>
To: Marko Kreen <markokr@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 30 09:45:15 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OIdCs-0005N8-T3
	for gcvg-git-2@lo.gmane.org; Sun, 30 May 2010 09:45:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464Ab0E3Ho1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 May 2010 03:44:27 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:50829 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751399Ab0E3Ho0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 May 2010 03:44:26 -0400
Received: by fg-out-1718.google.com with SMTP id l26so341967fgb.1
        for <git@vger.kernel.org>; Sun, 30 May 2010 00:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=XzFGxrVyk+diUQFA64oVhgo5ysNd5xx4ovHJIvEVNgk=;
        b=baw+6FJX/n2CPLD/+Liiuf0TnQj4+RfH8EwksybnbuEDppyi4/sm2NUxKQk/j2O/bo
         1E7FBWL2K1Qc38QfAe6Rn6LSBM/OaHE2Q7iuh8Kz93Xh6yhh6UjWFLl/26FyOjLoxFTQ
         QotBstvn9yDO/Ji2L1g89TuL9rQTU0OugZtqE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=FtrQF5vGgxX3kvurCl8/am9Owh8b9wlU1XC5TOB38I4YHgyNuaMtaOSTLpRIWlnyGT
         xMCnleCWwMFEI0Fv4nOb8uogGw6ClsZ1ARzs9e5cZseah5KCfxpWu3/vEP12nyckJyz0
         y4gAQVqgwPN/J7YnlrlEn4haln4yAMUIeL19I=
Received: by 10.87.63.21 with SMTP id q21mr6304886fgk.52.1275205464625;
        Sun, 30 May 2010 00:44:24 -0700 (PDT)
Received: from yakj.usersys.redhat.com (s209p8.home.99maxprogres.cz [85.93.118.17])
        by mx.google.com with ESMTPS id g28sm6090373fkg.28.2010.05.30.00.44.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 30 May 2010 00:44:23 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100430 Fedora/3.0.4-3.fc13 Lightning/1.0b2pre Thunderbird/3.0.4
In-Reply-To: <AANLkTinX8nK68rZtN5dwJ-fGQm4gR2G84xo9raxb4vLY@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147987>

On 05/27/2010 02:36 PM, Marko Kreen wrote:
> Hm, good catch.  Seems such compat poll() cannot be done without
> OS-specific hacks.
>
> Do you know perhaps what other OS-es have non-bitmap fd_set?

I don't think any does.  Winsock needed that because its fd_sets host 
handles instead of small integers.

Paolo
