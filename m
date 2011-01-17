From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git bisect problems/ideas
Date: Mon, 17 Jan 2011 05:51:33 -0600
Message-ID: <20110117115133.GA29207@burratino>
References: <855249CA-A006-475C-8F96-EFD614795064@gmail.com>
 <AANLkTikNzpCwEieV8sXXctMm+DR69fkLfCF+F3xB6b-k@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Aaron S. Meurer" <asmeurer@gmail.com>, git@vger.kernel.org
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 17 12:52:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pend2-000899-Vx
	for gcvg-git-2@lo.gmane.org; Mon, 17 Jan 2011 12:52:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753364Ab1AQLv7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Jan 2011 06:51:59 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:64855 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753348Ab1AQLvz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Jan 2011 06:51:55 -0500
Received: by iyj18 with SMTP id 18so4530795iyj.19
        for <git@vger.kernel.org>; Mon, 17 Jan 2011 03:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=FQLBsdfrR4JzuTqjlMIHPERgBICt7gzXYx4ma+7I3/c=;
        b=PX0AKOBBmb+GZuq2LoPYQcLZqFPfwJ6bSRX81KcNVJt6uEq53HNAhw5b+F9Ckh9OqI
         A8CHMBt+ByQF6I0f9FKGXsFc67rgIRcoTVQ0o2E4hH8LLLWCBJTHmOAH4V9BN1abLeZe
         lLHjKpf2X198k8klhZyYGXaICUVHXMLAEi3Rs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=v0UhGElN4ZeQ5WYPJXGS7NHQAnxorfZlC8fSY2qM4+6vj1S72NSKsdwZhZDxQb/BW0
         yLC+lySi5BMlpColPBOYooGwsoYsNDZiT/v8hZSyRxOHkZ9QaW9TuSgvt231mrHole5x
         HdELanKcG8qDf3JmMMh/pOGFOc92GDUCJi8ZA=
Received: by 10.42.230.133 with SMTP id jm5mr4375845icb.424.1295265113952;
        Mon, 17 Jan 2011 03:51:53 -0800 (PST)
Received: from burratino ([69.209.76.37])
        by mx.google.com with ESMTPS id g4sm2649900ick.23.2011.01.17.03.51.50
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 17 Jan 2011 03:51:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTikNzpCwEieV8sXXctMm+DR69fkLfCF+F3xB6b-k@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165172>

Hi,

> Aaron S. Meurer wrote:

>> 90% of the time I do not
>> want to go back to where I started bisecting. =C2=A0I would much pre=
fer to just
>> have a git bisect stop command
[which does "git bisect reset HEAD"]

=46WIW I like the idea.  I end up using "git bisect reset" by accident
from time to time and it is almost never what I want, especially
after working on something else for a few days[1].

My only worry is that it could be confusing --- what if a person,
intending to run "git bisect reset", runs "git bisect stop" instead?
To mitigate that, the stop subcommand could print the name of the
start commit so such a user knows what to check out to get back to
a familiar state.

Christian Couder wrote:

> Yeah, many people find it difficult to reverse the meaning of "bad"
> and "good" when looking for a fix. There were some suggestions at som=
e
> points to do something about it. Some of the suggestions were to use
> some aliases for "good" and "bad", but there was no agreement. Other
> suggestions had a patch attached but the patch was not good enough or
> something.

Any pointers to such a discussion or patch?  Maybe whatever small
detail caused it to be forgotten could be fixed...

Ciao,
Jonathan

[1] compare am --abort:
http://thread.gmane.org/gmane.comp.version-control.git/164002
