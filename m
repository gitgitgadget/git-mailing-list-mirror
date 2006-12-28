From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH 6/6] gitweb: Make possible to run under mod_perl without ParseHeaders
Date: Thu, 28 Dec 2006 02:12:44 +0100
Message-ID: <200612280212.45120.jnareb@gmail.com>
References: <200612272355.31923.jnareb@gmail.com> <200612280106.24331.jnareb@gmail.com> <20061228010311.GD6558@localhost>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 28 02:10:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzjmS-00008z-0i
	for gcvg-git@gmane.org; Thu, 28 Dec 2006 02:10:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964807AbWL1BJx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Dec 2006 20:09:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964840AbWL1BJw
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Dec 2006 20:09:52 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:54678 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964832AbWL1BJw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Dec 2006 20:09:52 -0500
Received: by ug-out-1314.google.com with SMTP id 44so4030368uga
        for <git@vger.kernel.org>; Wed, 27 Dec 2006 17:09:50 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=kPRK6+YQCQRa8Xa5oDm/dw5NfQKaNl8WMx/lNHbBJa4uaL4FbXlAYppLcr1TDz5GpsLTe4YApie5OgxFpstFHQ2kzTiOIlroelBlRAmflJxIfu9EWxqiQi/8wfIbcdEsdIX7kppSCq+4okoP3b0+ul/xfEL+fX3UoJdI+MfuBXg=
Received: by 10.66.255.7 with SMTP id c7mr20574723ugi.1167268190685;
        Wed, 27 Dec 2006 17:09:50 -0800 (PST)
Received: from host-81-190-19-121.torun.mm.pl ( [81.190.19.121])
        by mx.google.com with ESMTP id u6sm23828432uge.2006.12.27.17.09.50;
        Wed, 27 Dec 2006 17:09:50 -0800 (PST)
To: Robert Fitzsimons <robfitz@273k.net>
User-Agent: KMail/1.9.3
In-Reply-To: <20061228010311.GD6558@localhost>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35497>

Robert Fitzsimons wrote:
>> @@ -1854,7 +1976,8 @@ EOF
>>  		      $cgi->hidden(-name => "a") . "\n" .
>>  		      $cgi->hidden(-name => "h") . "\n" .
>>  		      $cgi->popup_menu(-name => 'st', -default => 'commit',
>> -				       -values => ['commit', 'author', 'committer', 'pickaxe']) .
>> +		                       -values => ['commit', 'author', 'committer',
>> +		                       gitweb_check_feature('pickaxe') ? 'pickaxe' : ()]) .
>>  		      $cgi->sup($cgi->a({-href => href(action=>"search_help")}, "?")) .
>>  		      " search:\n",
>>  		      $cgi->textfield(-name => "s", -value => $searchtext) . "\n" .
> 
> This should be a separate patch.

I'm sorry, somehow I missed this.

Besides, it would be better to assign return value to some
variable, to avoid calling gitweb_check_feature again... 
-- 
Jakub Narebski
Poland
