From: Howard Miller <howard@e-learndesign.co.uk>
Subject: Re: How does gitosis know who the key belongs to
Date: Fri, 25 Sep 2009 07:15:18 +0100
Message-ID: <26ae428a0909242315x3cf1aafcue004a73f5c471450@mail.gmail.com>
References: <26ae428a0909240751k3a799750h121935a79439b389@mail.gmail.com>
	 <20090924172610.GA31309@book.hvoigt.net>
	 <vpqskeckuto.fsf@bauges.imag.fr>
	 <26ae428a0909242310r259ccf5eya7c95b8f43fc5c23@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Heiko Voigt <hvoigt@hvoigt.net>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Sep 25 08:15:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mr45i-0001ZN-0O
	for gcvg-git-2@lo.gmane.org; Fri, 25 Sep 2009 08:15:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbZIYGPR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2009 02:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbZIYGPR
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Sep 2009 02:15:17 -0400
Received: from mail-ew0-f211.google.com ([209.85.219.211]:44504 "EHLO
	mail-ew0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185AbZIYGPQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2009 02:15:16 -0400
Received: by ewy7 with SMTP id 7so2290446ewy.17
        for <git@vger.kernel.org>; Thu, 24 Sep 2009 23:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type;
        bh=sfdqAeDYmnq1WceEbIiIdjYPiELJhUqxLnTWdATgd/M=;
        b=dBCeckMWFF/ZmoNYM/si/2Iot5Dd9bAtqFHhJU5gdCcoFi6SPNxtjL/96x41OHwbG7
         bjRnDMbOkEO6pOi04JrGoVt9IX6uODqQt+CV2luyRc9vMvnDt74np0jArvqMk6CA5Xpn
         f5tbG7KdBzu+mby6XYoWnV0QaMZ0M9HYxcXLo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        b=nw4KQh0dGgcDkJJLW2iWjNoGU5xDg0OJ5OC2roY+iPbUr/QDQsw+IOBHx4MhMtvofX
         1lfRcYKN4RoLdRXBxct+o/lRg5R9BwbsGRRlmImCtk/OHplExBAxtgbJ5augd6CXJz7Y
         086HXoHsd9cXp2rWIeDhdeQdbt9QfkIAWIo48=
Received: by 10.216.4.9 with SMTP id 9mr936237wei.130.1253859318738; Thu, 24 
	Sep 2009 23:15:18 -0700 (PDT)
In-Reply-To: <26ae428a0909242310r259ccf5eya7c95b8f43fc5c23@mail.gmail.com>
X-Google-Sender-Auth: bbbe26e3c4ac6853
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129062>

2009/9/25 Howard Miller <howard@e-learndesign.co.uk>:
> Hi,
>
> I don't really understand the answers I have been given. Trying
> desperately not to "top post" see bellow...
>
> 2009/9/24 Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>:
>> Heiko Voigt <hvoigt@hvoigt.net> writes:
>>
>>> On Thu, Sep 24, 2009 at 03:51:44PM +0100, Howard Miller wrote:
>>>> Gitosis obviously uses keypairs but the config file addresses the user
>>>> by name/host. How does gitosis connect the two together? Is it any
>>>> more complicated than the user detail at the end of the public key?
>>
>> The user@host at the end of the public key is mostly a comment. No
>> serious software would use it for authentication, since you can freely
>> edit it without changing the rest of the key.
>>
>>> Not much different. It uses the command feature of the authorized_keys
>>> file of ssh to limit access to the 'gitosis-serve' command which is
>>> given the username from the gitosis.conf as argument.
>>
>> ... the username -> key association being done in gitosis's
>> configuration itself (the key held in keydir/foobar is the one of user
>> foobar).
>
>
> Yes, I realise that the association is done im gitosis' config file,
> but that is exactly my question - how does that association work?
>
> To take a step back - I have to put a name (or a name@hostname) in the
> configuration file. How do I know what that should be in the general
> sense? When I create a key it doesn't ask me for the username I want
> so I see a disconnect here. Do I put a name, do I put name@hostname,
> does it matter and (again) how does it know which is 'my' public key?
> Is it the naming convention of the key or something magic? Plus, when
> I actually use gitosis, I am logging as the user 'git' so how does it
> know who I am? I am thoroughly confused by the whole thing. I'm
> probably missing something really obvious but, AFAIK, this is not
> covered at all in the docs.
>
> Thanks!
>
> Howard
>


Ahh... just read Heiko's post properly and actually looked at the
authorized_keys file. This is now starting to make some sense. So the
name in config has to match that sent to gitosis-server presumably. I
still don't quite see the cause and effect. If I don't like being
howard@x.y.z and would rather be just 'howard' what can I change? It
tells me not to edit that file!
