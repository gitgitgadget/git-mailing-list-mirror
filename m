From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH 2/2] gitweb: Add an option to show size of blobs in the tree view
Date: Thu, 2 Aug 2007 01:58:50 +0200
Message-ID: <200708020158.50343.jnareb@gmail.com>
References: <1185880790812-git-send-email-jnareb@gmail.com> <200708011505.02078.jnareb@gmail.com> <7v3az24zo6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 02 01:59:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGO5f-0004pn-Oy
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 01:58:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753200AbXHAX6w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 19:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752661AbXHAX6w
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 19:58:52 -0400
Received: from mu-out-0910.google.com ([209.85.134.191]:45990 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752494AbXHAX6v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 19:58:51 -0400
Received: by mu-out-0910.google.com with SMTP id i10so445931mue
        for <git@vger.kernel.org>; Wed, 01 Aug 2007 16:58:50 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=F49hnrXgizO5YIpbWUOB8/tFc4A0Ef3cdgwKLVUOe6mLQWqiIxe/nmr30Hqq/MrmiLvqE3WN5q8S4zrD3MQLW0s2p6qnBrNDFgl6AxWa29i7fH+76MTWgMs+/dWv2AeYRrvKKLaKHtP3UjzRXHraWKpdIrZ+RTw9ndqO+E5wJkc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=T7t+wOpY8q0cEDT+eb0EYTke3iuXlEw7SK2TUPvWp6zP4RJF6mQVATx3ki9Eu8/9Mqb0/4GQQsRU3fmmdvMGOqc3zJo5hLWiqeg9XLvEBxXitbNPe0GgpQI7CJge4YCqN/RLDVvxJWwPocyEn0GOhEJdwH8D3lyPMZoCjYbWUUg=
Received: by 10.86.97.7 with SMTP id u7mr938912fgb.1186012729964;
        Wed, 01 Aug 2007 16:58:49 -0700 (PDT)
Received: from host-89-229-8-65.torun.mm.pl ( [89.229.8.65])
        by mx.google.com with ESMTPS id y18sm2642436fkd.2007.08.01.16.58.48
        (version=SSLv3 cipher=OTHER);
        Wed, 01 Aug 2007 16:58:48 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7v3az24zo6.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54502>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> But I agree that this should be protected by the %feature mechanism.
>> Two questions:
>>
>>  1. Should we make '-l' default when turned on? Or make 'showsizes'
>>     %feature tristate: off, on, by default on?
>>
>>  2. If it is turned off, should we silently (or not so silently)
>>     ignore this option, or return "Permission denied" or perhaps
>>     "Invalid extra options parameter"?
>>
>> And how we should name this feature (key in %feature hash)?
> 
> I would say we would not do this by default, only with an
> explicit override with gitweb-config.perl.  I am not sure what
> the good name would be.  "expensive-ls-tree" perhaps?

So you think that ";opt=-l" would be required to have 'tree' view with 
blob (file) sizes, and it would be allowed only if 
gitweb_check_feature('ls-tree-size') is true (or something like that).
Should we return "Permission denied" or simply ignore "-l" extra option 
if it is prohivited by the config?

As to good name: 'showsize'? 'ls-tree-size'? 'ls-tree--long'?

>> P.S. I have received no comments on
>>  [RFC/PATCH] gitweb: Enable transparent compression for HTTP output
>> (trade CPU load for lower bandwidth usage).
> 
> That's probably nobody was interested in it.

Well, it was also posted in the middle of old thread... 

-- 
Jakub Narebski
Poland
