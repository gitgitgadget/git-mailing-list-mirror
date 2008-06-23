From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git blame for a commit
Date: Mon, 23 Jun 2008 03:01:12 -0700 (PDT)
Message-ID: <m3ve00lbby.fsf@localhost.localdomain>
References: <485ED2E5.3070906@mircea.bardac.net>
	<alpine.LFD.1.10.0806222300410.23258@sys-0.hiltweb.site>
	<485F6710.1080300@mircea.bardac.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ian Hilt <Ian.Hilt@gmx.com>, git@vger.kernel.org
To: Mircea Bardac <dev@bardac.net>
X-From: git-owner@vger.kernel.org Mon Jun 23 12:02:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAisL-0001mp-Th
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 12:02:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753723AbYFWKBP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 06:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752998AbYFWKBP
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 06:01:15 -0400
Received: from an-out-0708.google.com ([209.85.132.246]:36098 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752729AbYFWKBO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 06:01:14 -0400
Received: by an-out-0708.google.com with SMTP id d40so571268and.103
        for <git@vger.kernel.org>; Mon, 23 Jun 2008 03:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=bZB4fnfC/9aTlgRlWf9+ogO3j1jvYEzBUQpOSt7yOTI=;
        b=mkelwQ/806bhSDDAI1FzexHk722xwI2eAnHGOXvYXEEcLEHODwsShu0/3eMs8O3jo1
         k+SxmOiqLEo6yJipWGAs//1ygB8yLEHcpQZ/AO/7LFFRFJrB0VkY62WmdTRxgKPe8r3+
         zwZbeZHqlqbh0qqGkA+wtynd1QSyG0fET61dI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=wOLMUmBnrfpUIO5b+AwxlcADEcg3vcB51fwX+d0BWdb/iLogK5v4Ggqb36LbsI5+gg
         4NdML69J5ak0GygBBEwoBjbwnLkznJiEat9YL3cut4rnDSF00o05ypigKQha1YdUD2OK
         9k5PUsmnvXePNnnSsdcdeMc8rmQx9jt6/sah4=
Received: by 10.100.141.5 with SMTP id o5mr12943275and.33.1214215273219;
        Mon, 23 Jun 2008 03:01:13 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.247.21])
        by mx.google.com with ESMTPS id d22sm10689965and.2.2008.06.23.03.01.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 23 Jun 2008 03:01:12 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m5NA17BJ029838;
	Mon, 23 Jun 2008 12:01:07 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m5NA15t1029835;
	Mon, 23 Jun 2008 12:01:05 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <485F6710.1080300@mircea.bardac.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85850>

Mircea Bardac <dev@mircea.bardac.net> writes:
> Ian Hilt wrote:
>> On Sun, 22 Jun 2008 at 11:32pm +0100, Mircea Bardac wrote:
>>>
>>> Is there any straightforward way of doing git blame for all the
>>> files that got changed in a commit. Problems are renames, deletes
>>> and copies.
>>
>> Sounds like you want to track files rather than content.  Git tracks
>> the
>> latter.
> 
> Hmm... I'm not really sure that my initial intention was to track
> files. I've given this some more thought and I realized that what I
> actually want is a "git diff" with blame info included. I want this
> information in order to facilitate code reviewing.
> 
> It is true that this would be a front-end functionality, but I am not
> sure at the moment what the best approach would be for something like
> this. I would see this something like
> $ git diff --blame[="parameters_for_blame"] commit1..commit2
> but this is just a thought.
> 
> Has anyone tried blaming a "git diff"?

I think you could script it using "git diff", and "git blame -L m,n",
where line ranges would be calculated from git diff header for
post-image, or both pre-image and post-image (in the case of deletions).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
