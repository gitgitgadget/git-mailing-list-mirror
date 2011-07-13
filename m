From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 06/17] revert: Eliminate global "commit" variable
Date: Wed, 13 Jul 2011 11:40:31 -0500
Message-ID: <20110713164031.GB747@elie>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
 <1310396048-24925-7-git-send-email-artagnon@gmail.com>
 <20110712174518.GB14120@elie>
 <CALkWK0k3muAi_h7GRqgJ9vY8SwHK40-AwMdjA=uCDO8Ng4utCA@mail.gmail.com>
 <20110713071029.GA31285@elie>
 <CALkWK0mUbEXCjUYVPi8Kvctkh0+bnnk0VoAHjUjT_8M5druzqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 13 18:40:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qh2US-0007Ed-Fv
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 18:40:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756473Ab1GMQko (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jul 2011 12:40:44 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:43992 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756211Ab1GMQkn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2011 12:40:43 -0400
Received: by gxk21 with SMTP id 21so2463773gxk.19
        for <git@vger.kernel.org>; Wed, 13 Jul 2011 09:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=dtnzws0U8hc7drJHxDnZtUqRAcoXiM9QDadxI7838rI=;
        b=erihU5h8eocWPbZYo+l+JngB/JVk6nWcc0BUQpIfGZgv8XPfnoHAIk4TXv+yoGyOT5
         tsANTA0hP/fUVtYAOkxHbkO83RJ+2LfGRjupaCtqZivK5OqywqbmvKByTwmazO/GRi33
         tLYWYwgCO0cjzDdZvPBl9yLetwYCl5mWyaf94=
Received: by 10.150.115.14 with SMTP id n14mr1530797ybc.293.1310575242796;
        Wed, 13 Jul 2011 09:40:42 -0700 (PDT)
Received: from elie (adsl-69-209-70-6.dsl.chcgil.sbcglobal.net [69.209.70.6])
        by mx.google.com with ESMTPS id v25sm3677612yhk.64.2011.07.13.09.40.38
        (version=SSLv3 cipher=OTHER);
        Wed, 13 Jul 2011 09:40:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0mUbEXCjUYVPi8Kvctkh0+bnnk0VoAHjUjT_8M5druzqQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177059>

Ramkumar Ramachandra wrote:

> Yes.  Thanks.  How about this?
>
> revert: Eliminate global "commit" variable
>
> Prior to v1.7.2-rc1~4^2~7 (revert: allow cherry-picking more than one
> commit, 2010-06-02), the file-scope static "commit" variable used to
> represent one of the arguments passed to the "git cherry-pick" or "git
> revert".  This was not changed after cherry-pick learnt to replay

Meh, I prefer the version starting with "Functions which act on
commits", which was already readable and not too confusing.

The point of the just-so story I wrote is that the "commit" variable
was probably static _because_ of an analogy with command-line options
that needed to be static to be pointed to by the "struct options"
initializer.  But that is not a very important detail; it just helped
my understanding.

Regards,
Jonatahn
