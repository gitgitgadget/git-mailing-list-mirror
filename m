From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: git push stages original version on server
Date: Fri, 11 Sep 2009 13:09:27 +0200
Message-ID: <4AAA2FE7.5020802@gnu.org>
References: <D7E5118C-AE88-4C4B-8D8A-5AF16ECF731D@roalddevries.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Roald de Vries <rdv@roalddevries.nl>
X-From: git-owner@vger.kernel.org Fri Sep 11 13:09:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mm40W-0003jA-L0
	for gcvg-git-2@lo.gmane.org; Fri, 11 Sep 2009 13:09:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752238AbZIKLJ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2009 07:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752179AbZIKLJ0
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Sep 2009 07:09:26 -0400
Received: from ey-out-2122.google.com ([74.125.78.26]:31933 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751920AbZIKLJ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2009 07:09:26 -0400
Received: by ey-out-2122.google.com with SMTP id 25so198751eya.19
        for <git@vger.kernel.org>; Fri, 11 Sep 2009 04:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=c6MSAy7MTtn1ED2HZfSKYFdJhLoEaPwkfXwixbccA+M=;
        b=a3WyUrTd9UY9L5bXwdOnoRfkVJLMbrRTEULgoz8AV0vH3lVfYe+P3fs3Zfi4dXxR0Y
         6ndq1hESLoZBs9IYJsdEdJgazCvrl/Zia3rQk4FUKza9cKUc/1hlCclR+xPQzEhlm8W5
         jRSBsyQJI3NIS854VSgca9Now698l/3gFY2dw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=b4CXiuOWn0Z8nkqGYEzFr1ETU3imsDYZEKmqEvGFyUO83im9dQ3OhkEJXFZw9YHuno
         x+P5kRfcTI4ChcL7kFVOatMfUlQRcSFfSyxhSSe/wQhB+VfFBOGISWlmfNnhbkyIg84Y
         3e787alWIxnsBWJZD9dMH9dc6RhmNG2no4hW4=
Received: by 10.210.156.7 with SMTP id d7mr419401ebe.16.1252667368428;
        Fri, 11 Sep 2009 04:09:28 -0700 (PDT)
Received: from yakj.usersys.redhat.com (nat-pool-brq.redhat.com [62.40.79.66])
        by mx.google.com with ESMTPS id 23sm1728916eya.33.2009.09.11.04.09.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 11 Sep 2009 04:09:27 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.1) Gecko/20090814 Fedora/3.0-2.6.b3.fc11 Lightning/1.0pre Thunderbird/3.0b3
In-Reply-To: <D7E5118C-AE88-4C4B-8D8A-5AF16ECF731D@roalddevries.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128187>

Pushing to a non-bare repository is discouraged.

> - How can I have git automatically checkout pushed changes on the server?

I think you could in principle add a hook that does the "git checkout" 
or "git reset --hard $(git symbolic-ref HEAD)", but I suggest pushing to 
a bare repository and have the hook trigger a "git pull" elsewhere.

Paolo
