From: "Erez Zilber" <erezzi.list@gmail.com>
Subject: Re: git-clone works with ssh but not with http/https/git
Date: Tue, 24 Jun 2008 17:16:50 +0300
Message-ID: <ce513bcc0806240716o2556a187wef877fc51ebe9606@mail.gmail.com>
References: <ce513bcc0806240415h669d1725uf7b6e495995ab459@mail.gmail.com>
	 <1214306517.6441.10.camel@localhost>
	 <ce513bcc0806240445x6d00323g303f218504d2df53@mail.gmail.com>
	 <alpine.DEB.1.00.0806241246500.9925@racer>
	 <ce513bcc0806240507q58c2a3y5fe8f0e8033353ad@mail.gmail.com>
	 <m3abhbkoe2.fsf@localhost.localdomain>
	 <ce513bcc0806240642g56ca5450t4edd24fd88ce79c7@mail.gmail.com>
	 <20080624135429.GA6905@atn.sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Matthias Kestenholz" <mk@spinlock.ch>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Anton Gladkov" <agladkov@parallels.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 16:19:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KB9MK-0007Td-NP
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 16:19:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760630AbYFXOQx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 10:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760621AbYFXOQw
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 10:16:52 -0400
Received: from rv-out-0506.google.com ([209.85.198.224]:20989 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760608AbYFXOQv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 10:16:51 -0400
Received: by rv-out-0506.google.com with SMTP id k40so7677495rvb.1
        for <git@vger.kernel.org>; Tue, 24 Jun 2008 07:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Zg9FqaLaKq23Iz+6383KjilVIyJO0oN1NwVJC7kTYIQ=;
        b=Qsb4LVnCFRHCq4nDE6mpQ70m7H06ZX5k6+t02atlwAooCNNY56RB5a5yTPtz/s7n1A
         UTCPleXOlFut7Mt1V61qkVEAYE5LtNJqc8rtLmdZgLEaF7hNuhHiY1YpLt0c3uJSY8R1
         kFLYA0t7BnQqtBoZYG4vmD62KocMKNIr69MpA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=ftG04i6RoQWSqQGkCxxMw2TNwnP8MXV5PU0ZPx9LNT6u6XknjW7zQrfja3Zd6JsebO
         VTVZwx8zW+LKvr8tEVgSIuh7aREzlCzzEAnll8XTmY45Jax+QFDkB3Q4d3kgL3PYCOTB
         StAcx9AxjLLx9Avd0zACVM8dW12Y5TJLiz4bU=
Received: by 10.141.22.1 with SMTP id z1mr14813628rvi.277.1214317010715;
        Tue, 24 Jun 2008 07:16:50 -0700 (PDT)
Received: by 10.141.195.7 with HTTP; Tue, 24 Jun 2008 07:16:50 -0700 (PDT)
In-Reply-To: <20080624135429.GA6905@atn.sw.ru>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86062>

On Tue, Jun 24, 2008 at 4:54 PM, Anton Gladkov <agladkov@parallels.com> wrote:
> On Tue, Jun 24, 2008 at 05:42:14PM +0400, Erez Zilber wrote:
>> I guess that the problem is that no proper mapping exists. That's why
>> I see the following in /var/log/httpd/error_log:
>>
>> [Tue Jun 24 16:31:52 2008] [error] [client 172.16.0.7] File does not
>> exist: /var/www/html/pub
>>
>> What do I need to add in /etc/httpd/conf.d/ in order to set the
>> mapping to /pub/git instead of /var/www/html/pub ? Is there an example
>> that shows how to map?
>
> IMO the simplest way is to create a symlink 'pub' in /var/www/html directory
> pointing to /pub and to add 'Options FollowSymLinks' to <Directory /> in httpd.conf.

Adding the symlink solved the cloning with http problem.

Thanks,
Erez
