From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] Respect crlf attribute even if core.autocrlf has not been set
Date: Tue, 29 Jul 2008 17:46:19 +0400
Message-ID: <20080729134619.GB7008@dpotapov.dyndns.org>
References: <488772BC.80207@workspacewhiz.com> <32541b130807231133x37083278u1badd82b5c48e57b@mail.gmail.com> <alpine.DEB.1.00.0807231956280.8986@racer> <FB7ABDC5-8505-4FD1-8082-9BB5013E73C6@orakel.ntnu.no> <alpine.DEB.1.00.0807232041570.8986@racer> <3B9933A6-9637-41AE-9133-9B6EA9204E6B@orakel.ntnu.no> <alpine.DEB.1.00.0807250159420.4140@eeepc-johanness> <E0666371-5C5E-4AA9-B67A-16C42477865B@orakel.ntnu.no> <20080725140142.GB2925@dpotapov.dyndns.org> <42C252B2-85B9-4D05-B3A2-2A0250D7F5D6@orakel.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Avery Pennarun <apenwarr@gmail.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>
X-From: git-owner@vger.kernel.org Tue Jul 29 15:47:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNpY5-0002hP-Qp
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 15:47:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754225AbYG2Nqc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 09:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753841AbYG2Nqc
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 09:46:32 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:25288 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753140AbYG2Nqb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 09:46:31 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2319137fgg.17
        for <git@vger.kernel.org>; Tue, 29 Jul 2008 06:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=9z7jvxJGo1bp0Z3RF/CfOrapW8JZPmi+B/Gn7fHnJuY=;
        b=VVC/9GX3NlGi6Ym7EsgoDaJe5ISyIBLFS2l7syJNq3utHQuEE8nWEXd/0nVoOfrN/s
         Vkqruo3EBqbN77hUAmEP3YbSdKUsKiw4SxT/aoHiqc2OpmfeP3DwxXlo/Jm+YlB8OL1L
         maTQGYX3u7ZwA40Cuu0MtHxkWeli5VF+Rh72A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ZDVJ228TClpjQaw3+plnSIVIQ2YDXbUjmnZZ5t6YC547oBXsC34Xkjj0sZHuSY23H6
         eoh5wEtq4x/XahnOtJIUOz09N2J9iBv6/VA3NJmUZYh1QavXsFooH6o44brK+3AUtQlS
         bipLigtz6EYyVdePU2rIO12kCQdc5wB01CQSk=
Received: by 10.86.93.19 with SMTP id q19mr3724920fgb.37.1217339184758;
        Tue, 29 Jul 2008 06:46:24 -0700 (PDT)
Received: from localhost ( [85.140.170.95])
        by mx.google.com with ESMTPS id e20sm12559508fga.1.2008.07.29.06.46.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 29 Jul 2008 06:46:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <42C252B2-85B9-4D05-B3A2-2A0250D7F5D6@orakel.ntnu.no>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90640>

On Fri, Jul 25, 2008 at 11:05:33PM +0200, Eyvind Bernhardsen wrote:
> 
> The reason I want versioning is to fix the problem of enforcing  
> normalised line endings in repositories with checked-in CRLFs; I'm not  
> sure how to solve it any other way, but I'm open to suggestions.

You clearly want *enforcing* and versioning for you is just means to do
that. Regardless, what is the best way to achieve that, the *main*
question is whether we want this enforcing and if yet then in what form
and to what degree...

> 
> >If we had core.autocrlf=input as default then clueless users will not
> >checkin files with the incorrect ending. But there is an objection to
> >that -- you penalize those who always have good endings. And even the
> >fact that is merely default value that you can easily change to false
> >does not convince everyone.
> 
> That is an excellent argument for why setting "autocrlf=true" by  
> default on Windows was a bad idea.  Thanks! :)

I am sorry, but I don't see connection here.

> 
> >The same can be said about your
> >* eol=auto
> >It forces conversion on everyone, even on those who do not need it.
> >Of course, you can say those projects that do not have the problem  
> >with
> >clueless users putting text files with incorrect end-of-lines will not
> >have lines like that in their .gitattribute. Yet, if I participate in
> >that project, why do I have to pay the price for this conversion just
> >because someone stupid can mess up line-endings?
> 
> It's about correctness: if the repository isn't supposed to have CRs  
> in any text files, that needs to be enforced.  You might not be  
> stupid, but that doesn't mean you won't ever take a file that was  
> created on Windows and commit it to the repository on Linux.  If the  
> tool used to create the file was CR-damaged, there goes the  
> repository's LF-only policy.

Again, why should people who do not use Windows and other CR-damaged
tools be penalized? No one can prevent me from putting in *my* own 
repository whatever I want anyway. Thus, if we agreed having this
conversion/check is useful, remaining questions are:
1. whether this check should be possible to turn off
2. whether this check should be turned off by default for people
   who use Git on other system than Windows?
The current status is:
1. Yes, it is possible to turn of this conversion
2. It is turned off by default for anyone but MSYS/GIT users.

And the main argument for having that in this way is that people with LF
text files should be unnecessary penalized for Windows being different.

> 
> As you say, the reason I want the setting to be per-repository is that  
> I don't think the cost is worthwhile for every repository.

Side note: Personally, I am not very concerned about this cost, but some
people are...

> The case  
> where it _is_ worthwhile is when the repository will be shared between  
> Windows users and Linux users, and the Windows users want CRLFs in  
> their working directories.  I think it's worthwhile to actually make  
> Git work right in that case.

Windows users who want CRLF should set autocrlf=true
Windows users who prefer LF should set autocrlf=input
Non-Windows users who copy file directly from Windows should also
set autocrlf=input
All other users who do not touch Windows may have autocrlf=false.

Files that do not need conversion (such as *.bat) should be marked as
"-crlf" in .gitattributes.

Of course, those who are very careful and have good editors can set
autocrlf=false even on Windows...

> 
> As a side note, there's a lot of complaining about the cost of  
> enforcing LF-only input, but I can't remember seeing any actual  
> numbers.  Is it really that bad?

No, it is not bad. In most practical cases, you will not notice any
difference. I've posted some numbers in this thread. You can find
them here:
http://article.gmane.org/gmane.comp.version-control.git/89908

> 
> >>There's also no way of saying "this file should
> >>have LF line endings, even with autocrlf=true".
> >
> >Actually, there is
> >
> >*.sh crlf=input
> >
> >i.e. I want my shell files to have LF even I normally use CRLF for
> >all other files (on Windows).
> 
> Won't they still be converted to CRLF on checkout when autocrlf=true  
> on Windows?

autocrlf=true works in the same way on Linux and Windows, and I have
tested it right now, and it works as I said above.

> >but there are people who do not want to pay any price for conversion.
> >Currently, "core.autocrlf=false" means to do nothing about end-of- 
> >lines,
> >and even to ignore setting in .gitattributes. Should it be possible to
> >disable *any* conversion on checkin and checkout? Should this be that
> >value be the default, which most users use?
> 
> Well, there's no reason why Git repositories used only on Windows  
> machines shouldn't store CRLFs, so why should all msysgit users pay  
> the cost on every checkin _and_ checkout?

1. You may want to use on other platforms later. In any case, it makes
   much sense to have the default that compatible with other systems.
2. Conversion cost is not significant (I suppose much less than gzip
   compression used for all objects) and it also saves some space.
3. Internally, Git considers only LF as true end of line. CR is just
   like an extra space before end-of-line. Is any good reason to have
   it inside of your repo anyway?
4. This is what other VCSes do on Windows. CVS converts all text files
   on checkin. SVN does the same for files having svn:eol-style=native.

In fact, if you read the discussion we had here some time ago, you may
find some other arguments too.

> 
> This is the reason the setting needs to be a per-repository policy and  
> not a user configuration;

What exactly?

> users should not be able to configure away  
> correctness,

Why not? *Every* user has him/her own repository, so he/she can do
*anything* with it, in principle.

> but they shouldn't be penalised unnecessarily for it,  
> either.

The problem is how to determine when it is necessary and when it is
not. If I never commit with wrong EOLs, I don't think it is necessary
for me to have this conversion... On the other hand, I don't mind having
this check as default.  It does not really bother me much, and if I can
turn it off, it is fine with me. But I suppose other people may feel
differently about this issue.


Dmitry
