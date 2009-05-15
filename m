From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-tag bug? confusing git fast-export with double tag objects
Date: Fri, 15 May 2009 06:22:37 -0700 (PDT)
Message-ID: <m34ovmlcve.fsf@localhost.localdomain>
References: <op.utv93sdo1e62zd@merlin.emma.line.org>
	<op.utwdsutn1e62zd@merlin.emma.line.org>
	<7v8wl01iev.fsf@alter.siamese.dyndns.org>
	<op.utwyczlf1e62zd@merlin.emma.line.org>
	<20090514182249.GA11919@sigill.intra.peff.net>
	<op.utxydvnu1e62zd@merlin.emma.line.org>
	<20090515020206.GA12451@coredump.intra.peff.net>
	<op.uty0pjb51e62zd@balu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Jeff King" <peff@peff.net>, "Junio C Hamano" <gitster@pobox.com>,
	git@vger.kernel.org, "Alex Riesen" <raa.lkml@gmail.com>,
	"Brandon Casey" <casey@nrlssc.navy.mil>,
	"Sverre Rabbelier" <srabbelier@gmail.com>
To: "Matthias Andree" <matthias.andree@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 15 15:23:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4xNh-0007Um-NZ
	for gcvg-git-2@gmane.org; Fri, 15 May 2009 15:23:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762937AbZEONWl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2009 09:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762623AbZEONWk
	(ORCPT <rfc822;git-outgoing>); Fri, 15 May 2009 09:22:40 -0400
Received: from mail-px0-f123.google.com ([209.85.216.123]:40813 "EHLO
	mail-px0-f123.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762832AbZEONWj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2009 09:22:39 -0400
Received: by pxi29 with SMTP id 29so1034199pxi.33
        for <git@vger.kernel.org>; Fri, 15 May 2009 06:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=XKBrvL07lnfoazDgHKdFFO2xfSftXHnYUtI9awMH3jI=;
        b=GqR4FTsEh+cWzvejYQtswm/iA22uuvj1TZHq1EV4HcSZ0QWTEqCzGvMcXjoGTcAMYz
         aKrVYGXCR7VLzxvPysgOMJS/aezkQVqxYKt7wZ3YTfeEcphpQV2ldN1e90TkqCx8dRPC
         CBayKP+XJcjBn8q6VaAvr30Exqo/DjkD+LVQ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=oKvrHIZJOibUxrUi2FdWJiTGtKs9OEXkrD3bI5n4iTFC8b0lJkf/hDajHNXh5iFD6T
         5A9wk31jmn/Tb3+LV3+j17Otd/j6JAFqMYGUutdZ/zo4hOAHUJ/j77ZjI9lqMDxI9S16
         pqfw9VKNvqWNtPThePwFRyGMURDdUYLFFlje0=
Received: by 10.114.137.2 with SMTP id k2mr4642018wad.146.1242393760202;
        Fri, 15 May 2009 06:22:40 -0700 (PDT)
Received: from localhost.localdomain (abwb23.neoplus.adsl.tpnet.pl [83.8.225.23])
        by mx.google.com with ESMTPS id a8sm4523031poa.17.2009.05.15.06.22.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 May 2009 06:22:37 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n4FDMWlV021639;
	Fri, 15 May 2009 15:22:33 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n4FDMUTQ021636;
	Fri, 15 May 2009 15:22:30 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <op.uty0pjb51e62zd@balu>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119256>

"Matthias Andree" <matthias.andree@gmx.de> writes:
> Am 15.05.2009, 04:02 Uhr, schrieb Jeff King <peff@peff.net>: 

>>> But what's the new signature or tag good for?
>>
>> Tagging a tag is good for saying something about the original tag, as
>> opposed to saying something about the commit that the original tag
>> points to.
> 
> Yes, I agree to that since Junio's first reply.
> 
> Clear reminder up front: this thread is *not* about tagging tagA with
> another tagB (I'll see if git fast-export has issues with that and
> perhaps  concoct a test script), but this thread *is* about replacing
> tagA with  itself.
> 
> This raises semantic and hence usability concerns.
> 
> So let's shift object relations aside for a while, no need to discuss
> what  we agree about.
> 
> Let's narrow down the discussion to signed tag objects (git tag -s/git
> tag  -u GPG-ID). They are a bit different as there's some extended
> *meaning*  that lies in the signature. I have no trouble with this. A
> <--signed-by--
> B is implemented by "git tag -s B A."
> 
> Your example is:
> 
> 	commit <--signed-by-- tag1 <--signed-by-- tag2.
> 
> Tag2 is useful in an "approved by me, too" meaning or similar. Point taken.
> 
> If I do "git tag -f -s -m three tag1 tag1" (as opposed to... tag2
> tag1),  then I'll have trouble seeing or explaning the meaning or use
> cases of the  result:
> 
> 	commit <-- signed-by-- NIL (removed) <--signed-by-- tag1.

[...]
> For this particular corner case, "git tag -f tag tag" (where I really
> use the same tag name twice) could warn along the lines [...]

[cut]

THIS IS A FEATURE, NOT A BUG.


Please note that the name of tag (heavyweight tag, i.e. tag object)
is stored in two places: in the tag object itself as a contents of
'tag' header (you can see it in output of "git show <tag>" and also
in output of "git cat-file -p <tag>", where <tag> is heavyweight tag,
e.g. v1.6.3 in git.git repository), and also is default name of tag
reference (reference in "refs/tags/*" namespace) pointing to a tag
object.

So when you create signed tag 'A', you have the following situation
(assuming that it points at some commit)

  35805ce   <--- 5b7b4ead  <=== refs/tags/A
  (commit)       tag A
                 (tag)
  
Please also note that "git tag -f A A" (notice the absence of options
forcing it to be an annotated tag) is a noop - it doesn't change the
situation.

If you do "git tag -f -s A A": note that you _force_ owerwriting a tag
(so git assumes that you know what you are doing), and that one of 
-s / -a / -m options is used to force annotated tag (creation of tag
object), you will get the following situation

  35805ce   <--- 5b7b4ea  <--- ada8ddc  <=== refs/tags/A
  (commit)       tag A         tag A
                 (tag)         (tag)

What is unclear about this situation? How would you want to change it:
force user to use 'git tag -f -f' (I really know what I am doing)?

Note also that "git show A" would show the whole chain down to the
non-tag object...

Note also that the tag _reference_ (appropriate reference in the
"refs/tags/*" namespace) is purely _local_ matter; what one repository
has in 'refs/tags/v0.1.3', other can have in 'refs/tags/sub/v0.1.3'
for example.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
