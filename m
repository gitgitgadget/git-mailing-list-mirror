From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: use common parameter parsing and generation for "o", too.
Date: Thu, 17 Aug 2006 21:34:38 +0200
Message-ID: <200608172134.38751.jnareb@gmail.com>
References: <11557673213372-git-send-email-tali@admingilde.org> <ec1d6q$823$2@sea.gmane.org> <20060817191300.GA11477@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 17 21:33:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDncr-0003P8-JV
	for gcvg-git@gmane.org; Thu, 17 Aug 2006 21:33:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030193AbWHQTdy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Aug 2006 15:33:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751269AbWHQTdy
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Aug 2006 15:33:54 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:7702 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751266AbWHQTdx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Aug 2006 15:33:53 -0400
Received: by ug-out-1314.google.com with SMTP id m3so642375ugc
        for <git@vger.kernel.org>; Thu, 17 Aug 2006 12:33:52 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=PaQKoJv1KN0i/uODf2GxA44ZqTpqGV5TmPQkaSU4HJ4vpXU04x268i6liydp9ekBKM4V4qrSqIw8Acoo5eUanGzS0GD96pYW2oQzMkhe/MlNgh70J0NdRAA+Iy+Wg2rMY7XU4blYTucOSwmPM7MARWodObKyA6r5/7RmmPR2iyk=
Received: by 10.67.100.17 with SMTP id c17mr1393412ugm;
        Thu, 17 Aug 2006 12:33:52 -0700 (PDT)
Received: from host-81-190-26-94.torun.mm.pl ( [81.190.26.94])
        by mx.gmail.com with ESMTP id y7sm3090808ugc.2006.08.17.12.33.51;
        Thu, 17 Aug 2006 12:33:51 -0700 (PDT)
To: Martin Waitz <tali@admingilde.org>
User-Agent: KMail/1.9.3
In-Reply-To: <20060817191300.GA11477@admingilde.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25608>

On Thu, Aug 17, 2006 at 21:13, Martin Waitz wrote:
> On Thu, Aug 17, 2006 at 11:35:18AM +0200, Jakub Narebski wrote:
>>> The "o" (list order) parameter was handled special.
>>> Now it is generated with the common href() function and parsed together with
>>> all other parameters.
>>  
>> This was because "o" (sort table by) parameter was used only
>> in one place, and valid values of order parameter depends on
>> the place it is used.
> 
> But I'd really like to have all the parameter parsing and generation
> code in one place.
> 
> Perhaps we can agree that only the validation should be coupled with the
> actual user?  E.g. use normal validate_input() for it and then check
> for actual values inside git_project_list (which is already done now).

The validate_input() function has too generic name and is too widely used:
it should be split into validate_ref() and validate_path(); perhaps "o"
should be validate with $order =~ m/^[a-zA-Z]$/ 

But I was thinking about moving parameter parsing to the "action" functions
which use them, the opposite of what you want to do...

-- 
Jakub Narebski
Poland
