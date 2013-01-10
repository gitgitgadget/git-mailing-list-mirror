From: Manlio Perillo <manlio.perillo@gmail.com>
Subject: Re: about vim contrib support
Date: Thu, 10 Jan 2013 12:51:18 +0100
Message-ID: <50EEAB36.6060508@gmail.com>
References: <50EEA34B.7070102@gmail.com> <20130110113958.GA17137@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 10 12:51:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtGfl-000126-0G
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jan 2013 12:51:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753243Ab3AJLv2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2013 06:51:28 -0500
Received: from mail-bk0-f48.google.com ([209.85.214.48]:58265 "EHLO
	mail-bk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751432Ab3AJLv1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2013 06:51:27 -0500
Received: by mail-bk0-f48.google.com with SMTP id jc3so232139bkc.7
        for <git@vger.kernel.org>; Thu, 10 Jan 2013 03:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=c0UOCaN6WC1Wi3NaDD/eEkF4jy5VPMIeiyWHyzbnnwY=;
        b=wgRc/kzM9RN/p2PDlD5xtrEZzKrCm/cIJKpHKw0ylY5OoAPpg8RNFsKaT96zUkrdi9
         KOp8EqM+9GK7Ny2DS7YwY0Df06T4ZEm1CJ6xT3gdWI7TQvrtQLfrHaYKIJu2mkxhWNhE
         7YlFJoC+v1ydTADfuU0DqIyhDkIKtRkZpy48h9TNehiIne7at0tdxta9VTd3xiq8SKiS
         G8k83tRMhp+OgYyRUPZ5hwsxoxlTbYIDRIa7TykSckMzVykJBaRDFsy312eZL3GtUHtc
         e1XJo4npHR9x7kca1YV1i2i7xlmjj7dGn1Xb0/duaD95LsXBqXlFpBNWB+GAbSQxrSNc
         92ww==
X-Received: by 10.204.148.145 with SMTP id p17mr35447492bkv.136.1357818686438;
        Thu, 10 Jan 2013 03:51:26 -0800 (PST)
Received: from [192.168.0.3] ([151.70.196.34])
        by mx.google.com with ESMTPS id u3sm1001163bkw.9.2013.01.10.03.51.23
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 10 Jan 2013 03:51:25 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.16) Gecko/20121216 Icedove/3.0.11
In-Reply-To: <20130110113958.GA17137@sigill.intra.peff.net>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213137>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Il 10/01/2013 12:39, Jeff King ha scritto:
> On Thu, Jan 10, 2013 at 12:17:31PM +0100, Manlio Perillo wrote:
> 
>> In the contrib/vim/README file there are instructions about how to setup
>> git support with Vim builtin git syntax files.
>>
>> However these instructions seems to be redundant, since the system
>> filetype.vim file already have the autocmd rules.
> 
> What version of vim do you have? As the README says, version 7.2 and on
> come with the files already, and you do not need to do anything.

Ah, right.
I missed the first lines of the README file, sorry.


> [...]
>> The only issue I found is with:
>>
>> autocmd BufNewFile,BufRead .msg.[0-9]*
>> 	\ if getline(1) =~ '^From.*# This line is ignored.$' |
>> 	\   setf gitsendemail |
>> 	\ endif
>>
>> It should be:
>>
>> autocmd BufNewFile,BufRead [0-9]*.patch
> 
> It looks like .msg.[0-9] was originally used for send-email cover
> letters,

Ok, thanks.
I was assuming it was used for the generated patched.

> and was changed to .gitsendemail.msg.* by commit eed6ca7. I
> think your [0-9]*.patch would match something else entirely (though it
> is still broken, of course, as .msg.* does not exist anymore).
> 
> [...]
>> By the way: I don't understand the purpose of gitsendemail syntax.
>> On my system it does not highlight the diff.
> 
> As far as I can tell, it is for cover letters, not for patches. Patches
> should already be handled by existing RFC822-message highlighting.
> 

.patch files are handled by diff highlight.
What I would like to do is to use gitcommit syntax highlight, in order
to also enable commit subject message hightlight.



Thanks   Manlio
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlDuqzYACgkQscQJ24LbaUQ5TgCfQPeX53KOsQDF6WJF1AaSpiRd
NpMAn0GcffJwTA/etrnOnXAQctCKAY4W
=IDVf
-----END PGP SIGNATURE-----
