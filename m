From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Documentation/fast-import: put explanation of M 040000
 <dataref> "" in context
Date: Tue, 18 Jan 2011 16:02:26 -0600
Message-ID: <20110118220226.GB22763@burratino>
References: <AANLkTinsnMRyoeGzCn1Rkk7tc+zwVa5j3AGqVZCdDGDv@mail.gmail.com>
 <1286681415-1831-1-git-send-email-david.barr@cordelta.com>
 <20110116022234.GA28452@burratino>
 <7v1v4amex6.fsf@alter.siamese.dyndns.org>
 <20110118211654.GA22763@burratino>
 <7vk4i1khvp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Barr <david.barr@cordelta.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Gabriel Filion <lelutin@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 18 23:02:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfJdV-0007iN-7H
	for gcvg-git-2@lo.gmane.org; Tue, 18 Jan 2011 23:02:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751981Ab1ARWCk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jan 2011 17:02:40 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:50604 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751739Ab1ARWCj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jan 2011 17:02:39 -0500
Received: by fxm20 with SMTP id 20so149037fxm.19
        for <git@vger.kernel.org>; Tue, 18 Jan 2011 14:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=OcBRWE4BpwJmjm5kBVQfsW9F2pN6/l/e/czvzgbxnp4=;
        b=QBoT2JxcNtJlTQr0IVbFgSH99+8oK93AICXdzk0WxttXHkRHOyvQs59oGuhMOPumlk
         gsB4xVd0J08UH3lvoHsERMtHK1OO9X5LM0dpkJFUOHYnCTBx5tCpIMI96uii4zZWxmP5
         Juzs+GyNmumBwPwIO6nCl5K6xau38ZHAvfeRI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=c6aQt6iC9z+PhrdpJtsNsyL/YRvuucthxJ2mYZHEqBoMvC32fsryp7YNlB+UKC0A30
         TLojiv/Vl87qAvSflUb+/pWmJ5Dp9thHByqiSXP1Grwv+ZufupXJwt3QlX2BXkIyKsDv
         /hfP2mtVKCrGTsP1QzezqVl0AfxbOfMy1mOig=
Received: by 10.223.86.193 with SMTP id t1mr6709684fal.147.1295388158288;
        Tue, 18 Jan 2011 14:02:38 -0800 (PST)
Received: from burratino (adsl-69-209-76-37.dsl.chcgil.ameritech.net [69.209.76.37])
        by mx.google.com with ESMTPS id a2sm2335446faw.46.2011.01.18.14.02.34
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 18 Jan 2011 14:02:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vk4i1khvp.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165227>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> +++ b/Documentation/git-fast-import.txt
>> @@ -542,7 +542,7 @@ The value of `<path>` must be in canonical form. That is it must not:
>>  * contain the special component `.` or `..` (e.g. `foo/./bar` and
>>    `foo/../bar` are invalid).
>>  
>> -In `040000` mode, `<path>` can be the empty string (`""`)
>> +If `<mode>` is `040000`, `<path>` can be the empty string (`""`)
>>  to specify the root of the tree.
>
> For whom is this paragraph written?  People who produce g-f-i streams, or
> people who interpret somebody else's g-f-i streams?
> 
> I am wondering if it is easier to read if we consistently target the
> former, something like this:
> 
>         The root of the tree can be represented by `<mode> 040000` with an
>         empty string as `<path>`.

Sounds good to me.  I suppose the clause "by <mode> 040000" should just
be left out --- we already explained that directories must have mode
S_IFDIR a few lines earlier.
