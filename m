From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: Re: [JGIT PATCH] Disambiguate "push not supported" from "repository
 not found"
Date: Fri, 29 Aug 2008 14:18:47 +0200
Message-ID: <48B7E927.2000205@gmail.com>
References: <1219969118-31672-1-git-send-email-spearce@spearce.org> <200808291120.44413.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Aug 29 14:20:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZ2xJ-0005U8-8Z
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 14:19:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbYH2MSx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 08:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750847AbYH2MSx
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 08:18:53 -0400
Received: from mu-out-0910.google.com ([209.85.134.191]:60508 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750725AbYH2MSw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 08:18:52 -0400
Received: by mu-out-0910.google.com with SMTP id g7so685473muf.1
        for <git@vger.kernel.org>; Fri, 29 Aug 2008 05:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=ANi6MPXEZonPw8LZEkn1CrfkJ/CVdy9Y4FTFCIpzOSo=;
        b=JyjKLXPs1kcccIUh29c1vYuGDsvD9Oyxj8s1EJ6nEfKX5VH32OVG4zwsFjlcutkhZw
         49P395/LsH+PYZ/Cr15sXWlHEa7wot9ZH3EUY+9IbXq00JMYIKIKhaZYgMtE943QH7Ca
         8LaOW43YKWpKzUmsCQo63ackxFdeAF1f1adxA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=dt4mgZWTgjgNnUctw6ANln61al5kbLFoAzQVSwnN2qWQ3n3eL6q5zLED8bDslDftIG
         mKaL6VLc6RKz7+VoFcbc4h50ZhZmMxhvCuK+M3TQWbYtVEf+QaZYIQd/EQbCz4BG2uDP
         W8qB/zJMJ0gITi41wSyjagSAn/oqkAxF0BSx4=
Received: by 10.103.18.19 with SMTP id v19mr1829589mui.113.1220012330796;
        Fri, 29 Aug 2008 05:18:50 -0700 (PDT)
Received: from ?62.21.4.140? ( [62.21.4.140])
        by mx.google.com with ESMTPS id t10sm3256724muh.16.2008.08.29.05.18.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 29 Aug 2008 05:18:50 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.16) Gecko/20080702 Iceape/1.1.11 (Debian-1.1.11-1)
In-Reply-To: <200808291120.44413.robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robin Rosenberg wrote:
> fredagen den 29 augusti 2008 02.18.38 skrev Shawn O. Pearce:
>> +				if (avail.isEmpty())
>> +					throw noRepository();
>>  				throw eof;
>>  			}
>>  
>> @@ -185,6 +182,10 @@ else if (this instanceof FetchConnection)
>>  		available(avail);
>>  	}
>>  
>> +	protected TransportException noRepository() {
>> +		return new NoRemoteRepositoryException(uri, "not found.");
>> +	}
>> +
> 
> Why an extra method for instantiating the exception?

Isn't it overrode in subclass - BasePackPushConnection?
-- 
Marek Zawirski [zawir]
marek.zawirski@gmail.com
