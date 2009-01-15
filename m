From: "Jeremy Ramer" <jdramer@gmail.com>
Subject: Re: cygwin git diff crash
Date: Thu, 15 Jan 2009 14:08:20 -0700
Message-ID: <b9fd99020901151308u3e901602ya66f170da2b37045@mail.gmail.com>
References: <b9fd99020901141409w1e0c926fkc762f8709bd1c13f@mail.gmail.com>
	 <alpine.DEB.1.00.0901142333200.3586@pacific.mpi-cbg.de>
	 <b9fd99020901150642i2e61bb78yf2dab2b8713592df@mail.gmail.com>
	 <alpine.DEB.1.00.0901151631280.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 15 22:09:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNZTM-0004wT-1W
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 22:09:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934443AbZAOVIX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 16:08:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934148AbZAOVIW
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 16:08:22 -0500
Received: from wa-out-1112.google.com ([209.85.146.183]:56567 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934608AbZAOVIU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 16:08:20 -0500
Received: by wa-out-1112.google.com with SMTP id v27so687070wah.21
        for <git@vger.kernel.org>; Thu, 15 Jan 2009 13:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=4yfB6H7jwHg0FxcX2e25frLqfd4yRCppmHyXtlE78xA=;
        b=UKW/EVMJ3K7mRlLTH6c3evfvdjLqCIyd8en0cgKZSMLLnhRm4mJ8EC/aEr4PS25I1Y
         z17bsnOnFcICdSEKVLKXuQw8/qAI91+c8tdrl84U3G7xhid09H3GkiQFtXGRMNdvuvj/
         afyW9tAVGvW168yuQwUnEHrdDXUqdqecXhC4o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=bJjr2Tm48QMgBavA8iYM2aiUMLhRcZJLdVg76VJ1/kb5bIAVE2UOoQUrdzfXEkda6M
         hJrQH0XbtpTRaP2TV4bvtQHfbtcnxVTDCjkz6UQlHB/eF0aDNctBhhbeDlulh02l1SRh
         gFrPPu1RINTYW4RjGCgE9dMIdy1ttYnEqsynY=
Received: by 10.115.94.1 with SMTP id w1mr1193726wal.177.1232053700162;
        Thu, 15 Jan 2009 13:08:20 -0800 (PST)
Received: by 10.114.57.20 with HTTP; Thu, 15 Jan 2009 13:08:20 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0901151631280.3586@pacific.mpi-cbg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105880>

On Thu, Jan 15, 2009 at 8:34 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Thu, 15 Jan 2009, Jeremy Ramer wrote:
>
>> On Wed, Jan 14, 2009 at 3:33 PM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>> > Hi,
>> >
>> > On Wed, 14 Jan 2009, Jeremy Ramer wrote:
>> >
>> >> Ok this is a weird issue and it's probably cygwin's fault, but I
>> >> haven't found any way to fix it so I' thought I would throw it out
>> >> here for comment.
>> >>
>> >> I am using git 1.6.0.4 on cygwin. I have a repo where if any file has
>> >> changes and git detects as mode 100644 I get this error:
>> >> $git diff
>> >>       3 [main] git 2744 C:\cygwin\bin\git.exe: *** fatal error - could
>> >> not load user32, Win32 error
>> >>
>> >> If I change the mode to 100755 git diff will work fine.
>> >> $chmod a+x test.cpp
>> >> $git diff
>> >> diff --git a/test.cpp b/test.cpp
>> >> old mode 100644
>> >> new mode 100755
>> >> index 7c0dfcd..20987a7
>> >> --- a/test.cpp
>> >> +++ b/test.cpp
>> >> @@ -6,9 +6,11 @@ int main()
>> >>
>> >>  void func()
>> >>  {
>> >> +       int a;^M
>> >>  }
>> >>
>> >>  void func2()
>> >>  {
>> >> +       int b;^M
>> >>  }
>> >>
>> >> Anybody have a clue as to why this might occur?  I have seen this in
>> >> many of the repo's I use, but it is not repeatable.  I tried making a
>> >> test repo but could not reproduce.
>> >
>> > Wow, that _is_ weird.  Does your test suite pass?
>> >
>> > Ciao,
>> > Dscho
>> >
>>
>> Forgive my ignorance, but I am not sure how to run the test suite.  I
>> did a quick google search but didn't find anything.  I am using
>> cygwin's packaged version of git and am not building it from source,
>> so maybe the suite is not available.  If I get a chance I will try
>> building from source.
>
> It is really easy: just make sure that make, gcc, libiconv-dev,
> openssl-dev and libcurl-dev are installed (that's it AFAIR), then download
> a tarball, e.g.
>
>        http://repo.or.cz/w/git.git?a=snapshot;h=next;sf=tgz
>
> unpack it, cd to it and run "make".  (I would _not_ run configure...)
>
> Hth,
> Dscho
>

Well, after compiling from source the error seems to have disappeared.
Strange. I have seen it disappear before and come back later so I will
watch out for it, but for now it's not an issue.

Just a note, the cygwin names for the packages necessary to compile are
curl-devel
gcc
libiconv
make
openssl-devel

Jeremy
