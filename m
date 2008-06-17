From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: Guided merge with override
Date: Tue, 17 Jun 2008 10:53:53 +0200
Message-ID: <bd6139dc0806170153h4fba934ei62cb06e98e0280fd@mail.gmail.com>
References: <93c3eada0806152116v2cef4035u272dc1a26005661a@mail.gmail.com>
	 <20080616092554.GB29404@genesis.frugalware.org>
	 <48563D6C.8060704@viscovery.net>
	 <bd6139dc0806161521p3667a44ble8573be1569986a0@mail.gmail.com>
	 <485756AE.9050904@viscovery.net>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Miklos Vajna" <vmiklos@frugalware.org>,
	"Geoff Russell" <geoffrey.russell@gmail.com>, git@vger.kernel.org
To: "Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Jun 17 10:55:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8Wxo-0007TX-5u
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 10:54:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754589AbYFQIx4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 04:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755282AbYFQIx4
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 04:53:56 -0400
Received: from wf-out-1314.google.com ([209.85.200.174]:54136 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753523AbYFQIxz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 04:53:55 -0400
Received: by wf-out-1314.google.com with SMTP id 27so5636191wfd.4
        for <git@vger.kernel.org>; Tue, 17 Jun 2008 01:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=bZGwmfU/Crm3e5f670PvPHD+fto5PNqQSVzxnh4aSKk=;
        b=VcLxi6Bdg64sZm7Gz3STii2qHT4RyUI+IznJQ3HsmDfHaQ/eGKErnbctaks+4aVcO3
         oczZ5ya3jO9oELdIWc3SEyurAIZ+w2wZIXwoFsnFpGvxhrw/dLkO01CDgVVZwYNk67fB
         Ll542BOii67VeZf9eLJqaoYPTRsZyqJcfNAgE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=nc3rfFJ3/rsNbLUOtp2XeQJ7YvMr9fbGnpFYD+yIZf2TH89R1P0eH5N4vlip7+oeDZ
         gyS+VW6MDCTkmqrE/tqx3INwRmEXzmk6s2r7iKbyhKTIQBVc19/Zxd7Auzf3mokvAT0X
         ulnOLYkVAOR1TIOjKCVsMqlFVlICrGOCkp3uY=
Received: by 10.142.158.17 with SMTP id g17mr2812590wfe.17.1213692833159;
        Tue, 17 Jun 2008 01:53:53 -0700 (PDT)
Received: by 10.143.38.17 with HTTP; Tue, 17 Jun 2008 01:53:53 -0700 (PDT)
In-Reply-To: <485756AE.9050904@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85275>

On Tue, Jun 17, 2008 at 8:16 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Sverre Rabbelier schrieb:
>> On Mon, Jun 16, 2008 at 12:16 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>>> The solution depends on whether *all* files in B should be taken, or only
>>> those files in B where there's a merge conflict. I don't know an easy way
>>> to do the former, but the latter I'd do like this:
>>>
>>>        $ git diff --name-only | xargs git checkout B --
>>
>> Wouldn't something similar work but do a 'git ls-files' and filter it
>> on files that have a merge conflict?
>
> Well, you could 'git ls-files --unmerged', but that prints the whole index
> entry, not just the name, and then you need a more complicated pipeline.

How about 'git ls-files -t | grep "^M " | xargs git checkout B --',
that would list all files that are unmerged and check them out?

-- 
Cheers,

Sverre Rabbelier
