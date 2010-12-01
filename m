From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] add: introduce add.ignoreerrors synonym for
 add.ignore-errors
Date: Wed, 1 Dec 2010 12:57:11 -0600
Message-ID: <20101201185711.GD27024@burratino>
References: <cover.1291207768.git.git@drmicha.warpmail.net>
 <7vd3pmw9n5.fsf@alter.siamese.dyndns.org>
 <b61288036e756c78709438491416d573459a732e.1291207768.git.git@drmicha.warpmail.net>
 <AANLkTi=cb0i28oGi9vrYfEyU_fPHhQGhNNtramtCpCHy@mail.gmail.com>
 <20101201160503.GB26120@burratino>
 <m3aakp4g5o.fsf@localhost.localdomain>
 <20101201163406.GD26120@burratino>
 <20101201175517.GA7774@sigill.intra.peff.net>
 <20101201183615.GA27024@burratino>
 <20101201184659.GA9147@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 01 19:57:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNrrq-0002B1-23
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 19:57:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755259Ab0LAS5V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 13:57:21 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:62671 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754784Ab0LAS5U (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 13:57:20 -0500
Received: by vws16 with SMTP id 16so566077vws.19
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 10:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=qvuA+lUpNPE3/SPmVS17e0Hkoz9V6aXN4/FRr/EH3j0=;
        b=xH8o492Trf4rbuZ1ui6OGZiLBYJkG3iqsBtGWMPjq7wuCQfO5cA++GgLLXiL4hdge7
         JUyfNweYxyNhQtrE1L6R1/XWLMLqY/zp7BDszup7XkdqeS8luyBZcnAHm7Rkqs7+ppE9
         JQFWXE1LvwGFvxW8af+hHSSlhDGLsj6DkgfqQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=eHb27Iu6yz46kIA5eVJYjcRy4J82ah8pVO78dSXE8gNTikXBRsDxoP7fM8wrG+A3yk
         H2Wf3JGwHVIT/fpko7r/+4WSNDFSVTYAPZ39feK98umRS3kqRpRmK9ieLzDPnUkFXIYY
         9Jq4EllSqf+lRmknU6Dk75mrgoj2zDDynvFqg=
Received: by 10.220.195.71 with SMTP id eb7mr1966597vcb.203.1291229839462;
        Wed, 01 Dec 2010 10:57:19 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.ameritech.net [68.255.109.73])
        by mx.google.com with ESMTPS id p22sm80705vcf.20.2010.12.01.10.57.17
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 01 Dec 2010 10:57:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101201184659.GA9147@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162573>

Jeff King wrote:

> Yes, looks good to me. You could potentially drop the old one from the
> config:
>
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -553,6 +553,7 @@ core.sparseCheckout::
>>  	Enable "sparse checkout" feature. See section "Sparse checkout" in
>>  	linkgit:git-read-tree[1] for more information.
>>  
>> +add.ignoreErrors::
>>  add.ignore-errors::
>>  	Tells 'git add' to continue adding files when some files cannot be
>>  	added due to indexing errors. Equivalent to the '--ignore-errors'
>
> which may be less confusing to new users (who might ask "is there a
> difference between the two?").

Right, I prefer to keep it documented for the old and forgetful users
(who might ask "why does this configuration work?").

> But I don't have a strong feeling on it, so either way:
>
> Acked-by: Jeff King <peff@peff.net>

Thanks again for the help.
