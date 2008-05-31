From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb forgets to send utf8 header for raw blob views
Date: Sun, 1 Jun 2008 00:39:12 +0200
Message-ID: <200806010039.14663.jnareb@gmail.com>
References: <alpine.LNX.1.10.0805282002510.19264@fbirervta.pbzchgretzou.qr> <m3tzgg1a06.fsf@localhost.localdomain> <alpine.LNX.1.10.0805311703420.4055@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jan Engelhardt <jengelh@medozas.de>
X-From: git-owner@vger.kernel.org Sun Jun 01 00:40:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2ZkG-00037y-3M
	for gcvg-git-2@gmane.org; Sun, 01 Jun 2008 00:40:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754885AbYEaWjW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 May 2008 18:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754849AbYEaWjW
	(ORCPT <rfc822;git-outgoing>); Sat, 31 May 2008 18:39:22 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:2742 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754790AbYEaWjV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 May 2008 18:39:21 -0400
Received: by ug-out-1314.google.com with SMTP id h2so129396ugf.16
        for <git@vger.kernel.org>; Sat, 31 May 2008 15:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=DbtUuMlAzvndRKy/QnYW6S2ytRjPcKJ3K21g00hwF9w=;
        b=mhl7sn4WOYU+dKeLtlV5tj1PjtFaU4jLje/tjJzCvHNyiPzX2Ksdn5dSI0YjMDTyhh
         Q07mn1u5MrLY51qV8OyT4EmLxT8KHhtWOPm84soenbMYlu8O6k6wIMSPAPfg9SJZ0DRY
         JBNsWHKGUQwfDurUaNYQwy82YAMLkp0LBE80M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=DCtW75V5oba9OzHtsD1T56aOXE9zY4gAunq97kF35WH+esqzhbGdPN4kb8QU1rkQ2B
         xD5IgYFTDGbccpR1p9s2EgszqsjBz821SXfhcZIS4Cvi6ZqHQ/mR2M8llY/gxTpzsvrh
         vTsGbnq+ktL9WCt3xoTFPL8PWKv3+fiSr650Y=
Received: by 10.67.119.15 with SMTP id w15mr860523ugm.73.1212273559489;
        Sat, 31 May 2008 15:39:19 -0700 (PDT)
Received: from ?192.168.1.15? ( [83.8.204.14])
        by mx.google.com with ESMTPS id e23sm2996790ugd.24.2008.05.31.15.39.17
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 31 May 2008 15:39:18 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.LNX.1.10.0805311703420.4055@fbirervta.pbzchgretzou.qr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83411>

On Sat, 31 May 2008, Jan Engelhardt wrote:
> On Friday 2008-05-30 10:18, Jakub Narebski wrote:
>>Jan Engelhardt <jengelh@medozas.de> writes:
>>
>>> I have configured gitweb to use utf8, and that works for text blob views 
>>> like on
>>> http://dev.medozas.de/gitweb.cgi?p=hxtools;a=blob;f=bin/git-forest;hb=HEAD
>>> but it does not for raw blob views like
>>> http://dev.medozas.de/gitweb.cgi?p=hxtools;a=blob_plain;f=bin/git-forest;hb=HEAD
>>
>> This can depend on configuration, both on gitweb configuration (you
>> can for example define $default_blob_plain_mimetype to 'text/plain;
>> charset=utf-8', and define $default_text_plain_charset to 'utf-8'),
>> and on your /etc/mime.types; gitweb does not add charset info if
>> mimetype is acquired from mime.types, which I guess is a mistake.
> 
> Thanks for the hint. Setting 
> 	our $default_text_plain_charset  = "utf-8";
> was all that was needed.

By the way, do you think that this should be the default for gitweb?

-- 
Jakub Narebski
Poland
