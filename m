From: Paolo Bonzini <paolo.bonzini@gmail.com>
Subject: Re: [PATCH, 4th version] git-branch: register where to merge from,
 when branching off a remote branch
Date: Fri, 02 Mar 2007 12:14:50 +0100
Message-ID: <45E8072A.2020303@lu.unisi.ch>
References: <es450f$d58$1@sea.gmane.org>	<Pine.LNX.4.63.0703010221000.22628@wbgn013.biozentrum.uni-wuerzburg.de>	<81b0412b0702282355i176ad7e5t7b9e417b27e524fb@mail.gmail.com>	<45E68897.8000607@lu.unisi.ch>	<81b0412b0703010010o24513f60x937b5af52362e0c8@mail.gmail.com>	<45E68EDE.2090405@lu.unisi.ch>	<81b0412b0703010033w2e1079a3l6ac6e38c59bdefd5@mail.gmail.com>	<45E69297.8070001@lu.unisi.ch>	<81b0412b0703010059w52a33b54n4d3c25ada6b96369@mail.gmail.com>	<45E69EEE.8070905@lu.unisi.ch>	<81b0412b0703010212w5367c8cek51f22e9098f8e22f@mail.gmail.com>	<7vvehls1h9.fsf@assigned-by-dhcp.cox.net>	<45E70041.1030705@lu.unisi.ch>	<Pine.LNX.4.63.0703012240210.22628@wbgn013.biozentrum.uni-wuerzburg.de>	<45E7DC04.5010701@lu.unisi.ch> <45E7E53E.5020704@gnu.org> <7vtzx4ezvm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Paolo Bonzini <paolo.bonzini@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Mar 02 12:15:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HN5j3-0003gY-Sj
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 12:15:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423026AbXCBLO6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 06:14:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423028AbXCBLO6
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 06:14:58 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:1355 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423026AbXCBLO4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 06:14:56 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1245612nfa
        for <git@vger.kernel.org>; Fri, 02 Mar 2007 03:14:54 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=ChcBlCDoJBNQNMm4u+SoVbRF3qrJAVT5bBYa9yT4hd03T/tB9fufEzo9tyY9WbmIHoUcGl7QlEdfpwn2c53WgYzKsj/Yq4FMVfECxYfxRKbUHMr/KpVI0+YR5NMLNn5KO5XZxd0wsvwNpHmNyqnTauOVP5xa6Um8Nftmt+KZY0U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=iP3vL0Cc0p2OtgWt8vOXxtfdQLfeYvSY+BAbwKzrYfF0vZ8bKxWWePiyncKdWYNjFCMLDJjtrBF0Keob15cA+D0iAaPwYufOp5UPIr1Fj9jB/wj+m8cp4E7yIzRPcjnsYNox2lWzL1Nb/SWF403poOkRlAPXpHwkGYmUKNrsMgM=
Received: by 10.49.43.2 with SMTP id v2mr7507134nfj.1172834094740;
        Fri, 02 Mar 2007 03:14:54 -0800 (PST)
Received: from ?192.168.68.211? ( [195.176.178.209])
        by mx.google.com with ESMTP id g1sm4914961muf.2007.03.02.03.14.53;
        Fri, 02 Mar 2007 03:14:53 -0800 (PST)
User-Agent: Thunderbird 1.5.0.9 (Macintosh/20061207)
In-Reply-To: <7vtzx4ezvm.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41190>

> I have a feeling that "git checkout -b" and "git checkout -B"
> should be taught to explicitly use "git branch --no-track" and
> "git branch --track" to create a new branch (currently it does
> not even use "git branch" as far as I can tell).  With your
> patch, I suspect that you have to say "git branch topic
> origin/topic" and then "git checkout topic", which means you
> made the three-step process into two steps, but you could have
> made it into one step.

Well, yes, the next part would have been to patch git-checkout.  But this one is already proving to be complicated enough.  :-)

> I'll send out an untested patch to
> git-checkout so that you can try it out in a separate message.

I saw it.  I tested your patch and it seems to work.
 
>  - (micronit) Is it true that both strlen() tests are about long
>    *branch* names?

If you consider something like "origin/next" to be a branch name, yes.

>  - (moderately serious) The code blindly trusts that
>    "refs/remotes/foo/bar" tracks "refs/heads/bar" from remote
>    named "foo", which is a bit disturbing.  With the default
>    configuration git-clone and git-remote creates, it always is
>    the case, but I suspect you might want to at least verify
>    that assumption (the user can have different settings in the
>    config), if not figuring them out by reading the existing
>    configuration yourself.

Ouch.  Absolutely right, but this means I will prepare the patch later then.

>> +	else if (dwim_ref(start_name, strlen(start_name), sha1, &real_ref))
>> +		remote = !prefixcmp(real_ref, "refs/remotes/");
> 
>  - (pure question) What happens if dwim_ref() returns more than one?

Then, real_ref is the one matching sha1.

Considering your other objection about the naming of the variable, what about enabling/disabling the tracking using remote.REMOTENAME.tracklocalsubbranches?

Paolo
