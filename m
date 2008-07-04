From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: RFC: grafts generalised
Date: Fri, 4 Jul 2008 02:43:53 +0200
Message-ID: <200807040243.54739.jnareb@gmail.com>
References: <20080702143519.GA8391@cuci.nl> <m3lk0kfdo1.fsf@localhost.localdomain> <20080702173203.GA16235@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Fri Jul 04 02:45:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEZQT-0004Ph-U3
	for gcvg-git-2@gmane.org; Fri, 04 Jul 2008 02:45:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754041AbYGDAo2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 20:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754061AbYGDAo2
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 20:44:28 -0400
Received: from rv-out-0506.google.com ([209.85.198.233]:61112 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754041AbYGDAo1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 20:44:27 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1257216rvb.1
        for <git@vger.kernel.org>; Thu, 03 Jul 2008 17:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=GHvsyRUvosAI/RcOxoDymjnFNUEFpaWa8gkHcRwE2xE=;
        b=xJHbDqOHNq97oeWbwGeCAM/fO2ytDHg70fu/Iic1zjs96+ITM28xPb1jAP+rm22MxY
         m6uUYbA89ChTFLmlANkFQMJwWkWz7hQb551leWU/A2gdbGodCXZmszq+eD7idmPAOJtt
         zCEes0wl7X9E0higUec2VaOl2sE03I7RUvceM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=ti++f0H1Lr9Ssbti0wa9R3gmAq47XMag7/qa3m92NsNaGtrN4gZdFzxIGMSKrKEE99
         ysWM3bXC9x+JUXO5SCjMXhaEvvLUiGeWWFuTkxxQ7RuT2BvdMYlyLOpCitnqWXpBPszw
         WBbYD1QRH9VyIyOHHHVLz/V3ut1gL6q6EUdqQ=
Received: by 10.114.184.11 with SMTP id h11mr1579167waf.175.1215132266947;
        Thu, 03 Jul 2008 17:44:26 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.222.3])
        by mx.google.com with ESMTPS id y34sm1214518iky.10.2008.07.03.17.43.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 03 Jul 2008 17:44:25 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20080702173203.GA16235@cuci.nl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87350>

On Wed, 2 July 2008, Stephen R. van den Berg wrote:
> Jakub Narebski wrote:
>>
>> [...] So I think that it would
>> be better to provide generic git-filter-branch filter which can
>> understand this "generalized grafts" file format, or rather
>> 'description of changes' file.  Put it in contrib/, and here you
>> go...
> 
> The problem is that the process of fixing history is an iterative one,
> which can take many months, and everytime you make a change, the
> correctness needs to be viewed using gitk.
[...]

I wanted to propose that git-filter-branch generic "generalized grafts"
file based filter should be accompanied by extending gitk so it
understand this format to...

...but after reading wonderfull suggestion to create new commits with
corrected contents, and insert them (replace older version by them)
using grafts, thought and brought independently by Dmitry Potapov and
Petr Baudis, I think that you would be best with extending gitk to
support this way instead.

You would have to extend gitk to maintain reverse revision mapping
(from revision to its children), and then you would be able to edit
history interactively from within gitk, with gitk correcting its
internal structures to redisplay changed commits, and creating commits
and doing grafting behind the scenes for later git-filter-branch
run.

-- 
Jakub Narebski
Poland
