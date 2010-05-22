From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: Re: What's cooking extra
Date: Sat, 22 May 2010 21:42:14 +0200
Message-ID: <50199F1F-3513-43A6-8990-957F3D0AF58C@gmail.com>
References: <7vsk5o9d1f.fsf@alter.siamese.dyndns.org> <20100519170656.GA30161@pvv.org> <20100522130916.GA28452@localhost>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Finn Arne Gangstad <finnag@pvv.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sat May 22 21:42:27 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFuaY-0006Js-5r
	for gcvg-git-2@lo.gmane.org; Sat, 22 May 2010 21:42:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758030Ab0EVTmU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 May 2010 15:42:20 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:63752 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755756Ab0EVTmT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 May 2010 15:42:19 -0400
Received: by wwb13 with SMTP id 13so166445wwb.19
        for <git@vger.kernel.org>; Sat, 22 May 2010 12:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:mime-version
         :content-type:from:in-reply-to:date:cc:content-transfer-encoding
         :message-id:references:to:x-mailer;
        bh=UPQ1OfsQFQeqgzxLE6ftSqMdlzjOyNOox9Ier6odnfg=;
        b=OWYB6MZjXGfv6doX8kHdIWNwznEifmc2X81l9E96SjwCDcr7nwHqBPAT+17UgjfKSw
         rKYmPRWCkuS4by0okEoF6bPWjEOW22iTCKtVZdh2mtXRAekKnh8rY8rq5wkHl36SwL6v
         eN56SKDevFMG461rBP9x+PZgvjWmk5L7ah0Oo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=TiEqmAkvAOzn6uD+iYxZHRVZ+Gcx+Y8GfmkpgxMG+YQAeMgZnHZ/hcDsncSEXoN4Rd
         p1oe0XSJ0xmcieJKhwy4Zb8w/qt4N+sp7ppNLUL6QdSo2PStkP9AWVqBfZQgQadzheYB
         5fYj8a3wPOwhHE2fMgGPYn5yJ9p4Mp51Kbbfo=
Received: by 10.216.169.72 with SMTP id m50mr1924919wel.169.1274557336321;
        Sat, 22 May 2010 12:42:16 -0700 (PDT)
Received: from [172.16.3.223] (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id 16sm1115465ewy.7.2010.05.22.12.42.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 22 May 2010 12:42:15 -0700 (PDT)
In-Reply-To: <20100522130916.GA28452@localhost>
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147539>

On 22. mai 2010, at 15.09, Clemens Buchacher wrote:

> On Wed, May 19, 2010 at 07:06:56PM +0200, Finn Arne Gangstad wrote:
>> On Wed, May 19, 2010 at 07:33:32AM -0700, Junio C Hamano wrote:
>> 
>>> * (Eyvind Bernhardsen and Linus) Fixing the behaviour of crlf attribute;
>>>   ignoring them when core.autocrlf is not in effect was a wrong design
>>>   decision.
>>> 
>>>   I agree with what Linus said in the thread; I haven't yet looked at the
>>>   discussion in the past few days.  Also I don't know where '[PATCH v2]
>>>   Add "core.eol" config variable' fits in the picture.
>> 
>> I think this one is pretty much discussed by now, with the latest
>> changes this should do pretty much what Linus wanted.
> 
> That is not the impression I got. Linus was objecting to the idea of new
> attribute and configuration variables, which essentially do the same thing
> but with slightly different semantics.
> 
> As soon as the existing crlf attribute is given priority over core.autocrlf,
> all the problems discussed originally go away. So what exactly are the new
> attributes supposed to do?

There is one new attribute, "eol", that is used for files which need a specific line ending.  Being able to "force" LF or CRLF line endings has been requested several times on the list, and is already sort of provided for by "crlf=input".

Linus had lots of strong objections, but I also made lots of changes during the course of the discussion.

> Also, could you post a truth table for all the parameters involved (eol,
> crlf, core.autocrlf, core.eol). The documentation in the patches is too
> confusing for me to understand even that.

I'll do my best.  Basically there are two things to keep track of: "should this file be normalized as text?" and "which line endings should this file have in the working directory?".  There is an attribute for each, and two configuration variables that set the default values of the attributes.

Unfortunately my mail client mangles ascii art, so I can't do a table.  This will have to suffice:

Any file with the "text" attribute set will have its line endings normalized to LF in the repository.  If "text" is set to the special value "auto", git will only convert the file if it looks like a text file.

The "eol" attribute is used for files that need a specific line ending.  Setting it also sets "text".

core.eol controls which line endings to use for normalized files that don't have the "eol" attribute set, and defaults to the platform native line ending.

When core.autocrlf is set, the default value of the "text" attribute is set to "auto" but with an extra safety feature: if a file contains CRs in the index, it won't be normalized.  The extra feature comes from Finn Arne's "safe autocrlf" patch.

There is a backwards compatibility wrinkle in that core.autocrlf will override core.eol if the latter isn't explicitly set, so that "core.autocrlf=true" still results in CRLFs in the working directory on Linux.

> And, renaming the crlf attribute to text? Where did Linus suggest that? If
> we do that, we don't even have to talk about backwards compatibility any
> more.

In <alpine.LFD.2.00.1005121824260.3711@i5.linux-foundation.org>:
> So if you rename these things, keep them separate.  Make the "am I a
> text-file" boolean be a boolean (plus "auto"), and just call it "text". 
> And make the "what end of line to use" be just "eol" then.


So he didn't suggest renaming it, but he did suggest a better name and UI than the one I came up with.  I expected objections to renaming the attribute, which is why that is a separate commit, but people seemed supportive overall.

The "crlf" attribute will be used if it is present so backwards compatibility is preserved to a degree.  Scripts that test for the "crlf" attribute explicitly (such as git-cvsserver, which I fixed) will break.  I don't know how big a problem that is going to be in practice, but nobody raised it as an issue during the discussion.

Compatibility with older clients is a valid concern, but older clients will ignore "crlf" as well as "text" unless core.autocrlf is set, so they will cause problems no matter what.
-- 
Eyvind
