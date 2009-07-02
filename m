From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: Bug report: .gitattributes: -diff Unset causes files to be reported
 as binaries
Date: Thu, 02 Jul 2009 13:12:28 +0200
Message-ID: <4A4C961C.6090503@gnu.org>
References: <200907011208.35397.fenglich@fastmail.fm> <20090702053534.GA13255@sigio.peff.net> <200907021014.06540.fenglich@fastmail.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Frans Englich <fenglich@fastmail.fm>
X-From: git-owner@vger.kernel.org Thu Jul 02 13:20:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMKKx-0002Ph-1H
	for gcvg-git-2@gmane.org; Thu, 02 Jul 2009 13:20:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752534AbZGBLUH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2009 07:20:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbZGBLUG
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jul 2009 07:20:06 -0400
Received: from mail-ew0-f215.google.com ([209.85.219.215]:49163 "EHLO
	mail-ew0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329AbZGBLUF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2009 07:20:05 -0400
X-Greylist: delayed 456 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 Jul 2009 07:20:04 EDT
Received: by ewy11 with SMTP id 11so24996ewy.37
        for <git@vger.kernel.org>; Thu, 02 Jul 2009 04:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=nFqFOoyhuONq3pEM996JYV5F06WeIVK2h2bbknS85wc=;
        b=IEfkRSEQ5UvJzs6BIEoN8b7zN0uPBdQCoNNt3vE3nnIZa1y5Y4pIQLugyDeV4hVN57
         r2jAFL8WmeZ/PtxH6Bui8BWNKaLw4q6/CXHWpB3nznI3pLI2Xpq9lyVoPuxypg/xCOka
         xRZC7+vmNEbCJI8xPaQtdXKmx491HrbNMNVTA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=WQNcNT9SEbAOYxQdMN020BIZ1i/nTWEGlckt27iXRtb72JXTW1fU/YZsEd9EXyCDee
         tNxkeljCWZRGZjza3JFfuBNSqwX7M2Xf3LRmkFRGNfd73IPFnir/odOoKIxbJhGMcyIo
         JkXyfmV7yhBOMYLLx+nrpHpAlBrPhjPzU+k1o=
Received: by 10.210.62.12 with SMTP id k12mr821756eba.5.1246533151824;
        Thu, 02 Jul 2009 04:12:31 -0700 (PDT)
Received: from yakj.usersys.redhat.com (nat-pool-brq.redhat.com [62.40.79.66])
        by mx.google.com with ESMTPS id 10sm4682457eyz.51.2009.07.02.04.12.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Jul 2009 04:12:30 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b3pre) Gecko/20090513 Fedora/3.0-2.3.beta2.fc11 Lightning/1.0pre Thunderbird/3.0b2
In-Reply-To: <200907021014.06540.fenglich@fastmail.fm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122633>


>> So as far as I can see, git is behaving exactly as it is supposed to.
>> Maybe you can be more specific about what effect you were trying to
>> achieve by setting gitattributes in the first place?
>
> To exclude it in diffs, such as from `git show`. Take the case where you have
> a grammar file for a parser and generate a source file from it(or any similar
> scenario); the diff for the generated source file is not of interest and is
> just noisy when read as part of a patch. This applies to all kinds of
> generated files. However, this doesn't mean that the file should be treated
> as a binary, and what practicalities that implies.

I am not sure it is a good idea, but you can do this with

FILE diff=/bin/true

> If -diff affects whether a file is treated as a binary, as opposed whether
> it's diff'ed, it would imo make sense to call it -binary.

No, diff affects how a file is diffed.  The particular setting "-diff" 
diffs the file as if it was binary.

Paolo
