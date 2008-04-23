From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [RFC] Moving "git remote add --mirror blah" functionality to
 "git clone --bare --origin=blah"
Date: Wed, 23 Apr 2008 22:06:00 +0200
Message-ID: <480F96A8.6020304@gnu.org>
References: <480EF334.1090907@gnu.org> <7vhcdstv0f.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 22:07:50 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JolFn-0006xC-JS
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 22:07:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753815AbYDWUG5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 16:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753928AbYDWUG5
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 16:06:57 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:12847 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753110AbYDWUG4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 16:06:56 -0400
Received: by fg-out-1718.google.com with SMTP id l27so2742043fgb.17
        for <git@vger.kernel.org>; Wed, 23 Apr 2008 13:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=StCipyCOS5rPh24jOsem/10PduJwt3S1SQeeL5+zyC4=;
        b=KppUuDHhEGi67RhfsieP2G5KmrAF3XJG828uDPzNi2GjxPI/2ZoD6Zv1xUgh3sp/+t3zQQi3Lc8F69fhLmkjp+QK6UG8y0Pg4xJu/DPD6CQrd+5s6beM+xH7mVBnng5YVp/jU8qVG+d+WWFUpf41UNYPgm3dbGucSF3uI3yEjXw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:sender;
        b=JS4sDtaWMeaual5xjql08vaoiiHjDHXo1+t5Nrcv/Ph5x0EP1RuyohiMwJTbceTfjMzqwhwGLx5NeKFsXbItYN38OAdbMWWqoU+La/WPavOvyf7trxXoax/iU4dIXNCtxS9m3HK2BwWgThhWJIkRjsGM832ZNFr8Z2V3kqb+j+o=
Received: by 10.86.36.11 with SMTP id j11mr3994130fgj.5.1208981161001;
        Wed, 23 Apr 2008 13:06:01 -0700 (PDT)
Received: from scientist-2.lan ( [213.140.22.65])
        by mx.google.com with ESMTPS id d6sm592618fga.9.2008.04.23.13.05.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 23 Apr 2008 13:05:58 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.12 (Macintosh/20080213)
In-Reply-To: <7vhcdstv0f.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80255>


> *1* In that sense, a more sensible order than rewriting "clone" in C in
> its current form would be to make necessary enhancements to the components
> in this sequence that need to implement clone, figure out how they should
> fit together and first make "clone" a four-liner shell script. Then
> rewriting the result in C may become more trivial.

On the other hand, a C version may have the necessary APIs available to 
support this kind of enhancement, but the APIs may not be there for a 
shell script.

It seems useless to have an option in "git remote add" just because it 
might be necessary in a future refactoring of "git clone", but without a 
good use case beside that one -- because right now "git remote add 
--mirror" is close to useless: anyone who needs it 99% of the time knows 
how to hack the config, unlike people who just want a quick way to 
remotely backup of their repository.

Paolo
