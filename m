From: Antony Stubbs <antony.stubbs@gmail.com>
Subject: Re: cvs import and internal plumbing commands
Date: Wed, 22 Jul 2009 11:24:20 +1200
Message-ID: <24155F0E-E467-48EC-9E83-254877B4E786@gmail.com>
References: <B9FEA72A-882C-4CF9-97A3-A353F282ACBB@gmail.com> <20090716100121.GA6742@coredump.intra.peff.net> <7590CBC0-25BA-41D4-9BB5-40550A6CDDF6@gmail.com> <20090717214523.GA29955@coredump.intra.peff.net> <7vprbwvzu7.fsf@alter.siamese.dyndns.org> <20090720153400.GE5347@coredump.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 22 01:30:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTOmo-0007KQ-VO
	for gcvg-git-2@gmane.org; Wed, 22 Jul 2009 01:30:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755898AbZGUXaI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2009 19:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755631AbZGUXaI
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 19:30:08 -0400
Received: from mail-pz0-f204.google.com ([209.85.222.204]:34497 "EHLO
	mail-pz0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753974AbZGUXaG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2009 19:30:06 -0400
Received: by pzk42 with SMTP id 42so725436pzk.33
        for <git@vger.kernel.org>; Tue, 21 Jul 2009 16:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:references:x-mailer;
        bh=T1RmmIlqUMohg30D4BQk4A56HIotrZCEdV83vvLNAEY=;
        b=Bj/q8ufQMSHLm5aG27OCJZYhBuV/OrCwJf4wF/ooZjlNUnoOnTClo9K9uo+PCetM6r
         XvcALvRKT12C0ALr9z8AWcKPaoXFKgYFrq2Fsp8tWOLKZ7CRzjPSPeqjKz7cxQ9Fqj+c
         8ca1Rd1pJYEOtOaupjGuGGFn05oxAWjKb5lVU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=BeE5fWytPxajYgrzT/ZQBfpfZCGsHL5WT+XrKEHGvRvilT/AWWpmv48JRLzFslUgPE
         qGdCNCg6hvmhw+kZX3A/TCVhTqNahRQA9BozTC6tt/t47u5fQmYwpOD/i3d/eLEXIioY
         OzXgFKfUEznxtNNIzVWkCPQg+wz53hlGPplt0=
Received: by 10.114.52.19 with SMTP id z19mr411906waz.13.1248218668252;
        Tue, 21 Jul 2009 16:24:28 -0700 (PDT)
Received: from ?10.10.10.123? ([60.234.161.39])
        by mx.google.com with ESMTPS id k35sm13834286waf.18.2009.07.21.16.24.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 21 Jul 2009 16:24:27 -0700 (PDT)
In-Reply-To: <20090720153400.GE5347@coredump.intra.peff.net>
X-Mailer: Apple Mail (2.935.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123725>

But regardless, surely calling straight into git is simpler/nicer and  
more likely to just work (as on OSX)?

 From the 1.6.0 release notes (http://www.kernel.org/pub/software/scm/git/docs/RelNotes-1.6.0.txt 
):
"""With the default Makefile settings, most of the programs are now
installed outside your $PATH, except for "git", "gitk" and some server  
side programs that need to be accessible for technical reasons.  
Invoking a git subcommand as "git-xyzzy" from the command line has  
been deprecated since early 2006 (and officially announced in 1.5.4  
release notes); use of them from your scripts after adding output from  
"git --exec-path" to the $PATH is still supported in this release, but  
users are again strongly encouraged to adjust their scripts to use  
"git xyzzy" form, as we will stop installing "git-xyzzy" hardlinks for  
built-in commands in later releases. """

note the "but users are again strongly encouraged to adjust their  
scripts to use "git xyzzy" form". Why not just apply the patch and be  
done with it?

-Antony

On 21/07/2009, at 3:34 AM, Jeff King wrote:

> On Sun, Jul 19, 2009 at 07:43:28PM -0700, Junio C Hamano wrote:
>
>> We encourage script writers to just prepend "git --exec-path" at the
>> beginning of their PATH and give guarantee that this simple  
>> procedure will
>> keep their scripts working, so it might be a good idea to have an  
>> example
>> for that as well.
>
> I had it in my head that such a strategy was supposed to be a  
> temporary
> step in the process of getting rid of dashed forms. That is, you can  
> do
> that now to avoid having your scripts break, but in the long run, you
> should be converting to the space form.
>
> But I guess the plan was softened, and we have no deprecation plan for
> dashed forms in exec-path. So maybe my thinking was outdated.
>
>> So the preferred fix might be just the matter of adding one line
>>
>> 	$ENV{'PATH'} = `git --exec-path`. ":$ENV{'PATH'}";
>>
>> at the beginning of the script.
>
> I can see that for a totally third-party script which wanted to use  
> git
> plumbing.  But why do that for a git-* script? The "git" wrapper  
> sets up
> the environment like that already.
>
> -Peff
