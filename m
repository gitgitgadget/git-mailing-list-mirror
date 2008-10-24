From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Zit: the git-based single file content tracker
Date: Fri, 24 Oct 2008 13:32:23 +0200
Message-ID: <200810241332.32487.jnareb@gmail.com>
References: <gdok16$vh2$1@ger.gmane.org> <m38wsei8ne.fsf@localhost.localdomain> <cb7bb73a0810240352u28bab2b5p907065680985270a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Jean-Luc Herren" <jlh@gmx.ch>, git@vger.kernel.org
To: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 24 13:30:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtKsI-000820-5c
	for gcvg-git-2@gmane.org; Fri, 24 Oct 2008 13:30:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752301AbYJXL3Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2008 07:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752323AbYJXL3Z
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 07:29:25 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:35486 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751724AbYJXL3Y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2008 07:29:24 -0400
Received: by ug-out-1314.google.com with SMTP id k3so139504ugf.37
        for <git@vger.kernel.org>; Fri, 24 Oct 2008 04:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=c+22WIAruB5PsgtzLVRDOt35fsRJcxnyyrlVRSnu1hM=;
        b=RzXCrquAWane/Pc8O2tBIgaS7ONy44ApMIGCHTLMrr1XTe/6myyWDbmwGXlnMO+SLH
         jOfWYaycPMTB1c+JyXCaTVhO4XTKB7nXY9lJr+Nnq8H0sujDmAxky/z5xVJUp3zfhrL+
         KXQSALKzyAy3oNdRHbbu8KkrcOrnM4RvQGakg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=K2XsLpxlPM3I0dmMt+RboI6gRmcppxT92pljlme6JO7Sm7QD8WA/k3bog5KOKzi7V6
         fz3E7JxqW1rMEXYknjTtOfVeqDbGk7h1k/VzcotcYKAtiU7RydlVzEUuogYfqSNXuHlz
         CVFuhIHyao0YtEFX/voh4cOCCkQk0QzHNhIo0=
Received: by 10.210.22.8 with SMTP id 8mr2201660ebv.46.1224847762266;
        Fri, 24 Oct 2008 04:29:22 -0700 (PDT)
Received: from ?192.168.1.11? (abwm208.neoplus.adsl.tpnet.pl [83.8.236.208])
        by mx.google.com with ESMTPS id 7sm17940430eyb.1.2008.10.24.04.29.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 24 Oct 2008 04:29:21 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <cb7bb73a0810240352u28bab2b5p907065680985270a@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99028>

On Fri, 24 Oct 2008, Giuseppe Bilotta wrote:
> On Fri, Oct 24, 2008 at 12:31 PM, Jakub Narebski <jnareb@gmail.com> wrote:
>> "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com> writes:
>>> On Fri, Oct 24, 2008 at 1:23 AM, Jean-Luc Herren <jlh@gmx.ch> wrote:

>>>> If you decide against a shared repository, maybe you want to
>>>> consider to not use ".zit.file/", but ".zit/file/" as the
>>>> repository?  This would reduce the clutter to a single directory,
>>>> just like with ".git".  And moving files around wouldn't be that
>>>> much complicated.
>>>
>>> Right. I'll give that a shot.
>>
>> By the way RCS which I use for version control of single files use
>> both approaches: it can store 'file,v' alongside 'file' (just like
>> your '.zit.file/' or '.file.git/'), but it can also store files on
>> per-directory basis in 'RCS/' subdirectory (proposed '.zit/file/' or
>> '.zit/file.git/' solution)
> 
> Indeed, there's not particular reason why both solutions shouldn't be
> available. [...]

> The only problem then is priority. When looking for a file's repo, do
> we look at .file.git first, or .zit/file.git? How does RCS behave in
> this case?

rcsintro(1) states:

  If you don't want to clutter your working directory with RCS files, create
  a  subdirectory called RCS in your working directory, and move all your RCS
  files there.  RCS commands will look *first* into that directory to find
  needed files.

>> By the way, it would be nice to have VC interface for Emacs for Zit...
> 
> I'm afraid someone else will have to take care of that, since Emacs is
> not really something I use.

I'll try to hack it using contrib/emacs/vc-git.el as a base...

-- 
Jakub Narebski
Poland
