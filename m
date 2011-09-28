From: Georg-Johann Lay <avr@gjlay.de>
Subject: Re: subversion-perl missing
Date: Wed, 28 Sep 2011 12:06:06 +0200
Message-ID: <4E82F18E.9080304@gjlay.de>
References: <4E8066AB.7000208@gjlay.de>	<CAP8UFD0PiiA9SxvOuuh4t8P96v+iaJ0TfcBr1-xjMh4TXBEONQ@mail.gmail.com>	<4E80AD1B.3080700@gjlay.de> <m3k48vp6l7.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-4
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 28 12:06:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8r1v-0004n1-KY
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 12:06:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752220Ab1I1KGO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Sep 2011 06:06:14 -0400
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:50630 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751878Ab1I1KGN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2011 06:06:13 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; t=1317204372; l=5259;
	s=domk; d=gjlay.de;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Subject:CC:To:MIME-Version:From:Date:X-RZG-CLASS-ID:X-RZG-AUTH;
	bh=gy9/PFcZET4Emh0pKYa4h3vBWx0=;
	b=njkBicl8AAzSwblLi8h6KFe/pqZxjgavcBkL40YvE30/AAPQN9mut1oLCgSvUolyfum
	QTMNaskk7HSgstHROwgfIXYN+DdPlgujaxwdshWF2R6ZJYNWaOYxeFpwLx7pU3b9EFBc8
	MMO+ddTv9AfR/VW2CT2yFB24+hx6AW3kNnw=
X-RZG-AUTH: :LXoWVUeid/7A29J/hMvvT2k715jHQaJercGObUOFkj18odoYNahU4Q==
X-RZG-CLASS-ID: mo00
Received: from [192.168.0.22]
	(business-188-111-022-002.static.arcor-ip.net [188.111.22.2])
	by smtp.strato.de (jimi mo45) (RZmta 26.7)
	with ESMTPA id 601520n8S9MnSK ; Wed, 28 Sep 2011 12:06:07 +0200 (MEST)
User-Agent: Thunderbird 2.0.0.24 (X11/20100302)
In-Reply-To: <m3k48vp6l7.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182305>

Jakub Narebski schrieb:
> Georg-Johann Lay writes:
>> Christian Couder schrieb:
>>> On Mon, Sep 26, 2011 at 1:48 PM, Georg-Johann Lay <spam@spam.com> wrote:
> 
>>>> Where do I have to go to get the svn+perl stuff? Couldn't locate anything like
>>>> that in subversion.tigris.org, so that I am stuck and need some hints on how to
>>>> proceed.
>>> Perhaps you can try to install this module from CPAN:
>>>
>>> http://search.cpan.org/~mschwern/Alien-SVN-v1.6.12.1/
>>>
>>> or from it's github repo:
>>>
>>> https://github.com/schwern/alien-svn
>> Hi Christian,
>>
>> thanks for that hint.
>>
>> After getting that piece of software, running ./Build.PL and ./Build I just
>> don't know what to do next.  The README doesn't say anything about how to use
>> the built modules or how to do an install.
> 
> If you don't have admin privileges on the box, the best solution would
> be to use local::lib[1] to install Perl modules in your home directory
> for you (#perl IRC channel on FreeNode, or perlmonks are really helpful).
> 
> I really recommend it, together with cpanm[2] (which can configure
> local::lib for you, via --local-lib option), though the latter is not
> necessary.
> 
> [1]: http://search.cpan.org/~apeiron/local-lib-1.008004/lib/local/lib.pm
> [2]: http://search.cpan.org/~miyagawa/App-cpanminus-1.4008/bin/cpanm
> 
> 
> If you have admin privileges, I think the best solution would be
> either find repository which has subversion-perl that matches your
> version of Subversion, or compile subversion-perl from a source
> package... though this might be more difficult, it has advantage of
> being in package management.
>  
>> As git-svn complains
>>
>> ...Can't locate SVN/Core.pm in @INC (@INC contains: ...
>>
>> and
>>
>>  schwern-alien-svn-9298884>find . -name 'Core.pm'
>> ./src/subversion/subversion/bindings/swig/perl/native/Core.pm
>> ./src/subversion/subversion/bindings/swig/perl/native/blib/lib/SVN/Core.pm
>>
>> the question is how to do the final trick of telling git how to use Core.pm
>> (and which of the two?) and do the connexion between git and alien-svn.
>>
>> Sorry for the noob questions, never used perl or git before...
> 
> You have to install subversion-perl somewhere, not only build it.

Unfortunately, that package comes without hints on doing that.

As far as I understand, alien-svn comes with SVN sources which it uses for its
own perl packages to provide svn stuff to perl, but don't install/build new svn
version.

> Though you could fiddle with PERL5LIB (which is PATH-like environmtne

 > find . -name '*.pm'

./src/subversion/subversion/bindings/swig/perl/native/Delta.pm
./src/subversion/subversion/bindings/swig/perl/native/Base.pm
./src/subversion/subversion/bindings/swig/perl/native/Ra.pm
./src/subversion/subversion/bindings/swig/perl/native/Repos.pm
./src/subversion/subversion/bindings/swig/perl/native/Core.pm
./src/subversion/subversion/bindings/swig/perl/native/Wc.pm
./src/subversion/subversion/bindings/swig/perl/native/Client.pm
./src/subversion/subversion/bindings/swig/perl/native/blib/lib/SVN/Delta.pm
./src/subversion/subversion/bindings/swig/perl/native/blib/lib/SVN/Base.pm
./src/subversion/subversion/bindings/swig/perl/native/blib/lib/SVN/Ra.pm
./src/subversion/subversion/bindings/swig/perl/native/blib/lib/SVN/Repos.pm
./src/subversion/subversion/bindings/swig/perl/native/blib/lib/SVN/Core.pm
./src/subversion/subversion/bindings/swig/perl/native/blib/lib/SVN/Wc.pm
./src/subversion/subversion/bindings/swig/perl/native/blib/lib/SVN/Client.pm
./src/subversion/subversion/bindings/swig/perl/native/blib/lib/SVN/Fs.pm
./src/subversion/subversion/bindings/swig/perl/native/Fs.pm
./inc/My/SVN/Builder.pm
./lib/Alien/SVN.pm
./blib/lib/Alien/SVN.pm

and so I added the paths to PERL5LIB:
  export PERL5LIB=\
  <alien-svn>/blib/lib/Alien\
  :<alien-svn>/src/subversion/subversion/bindings/swig/perl/native/blib/lib\
  :<alien-svn>/src/subversion/subversion/bindings/swig/perl/native
where "." is the source directory of alien-svn and where the ./Build.PL and
./Build scripts ran.

Running git-svn with that complains

Can't locate loadable object for module SVN::_Core in @INC (@INC contains:
...
<alien-svn>/blib/lib/Alien
<alien-svn>/src/subversion/subversion/bindings/swig/perl/native/blib/lib
<alien-svn>/src/subversion/subversion/bindings/swig/perl/native
...) at
<alien-svn>/src/subversion/subversion/bindings/swig/perl/native/blib/lib/SVN/Base.pm
line 59
BEGIN failed--compilation aborted at
<alien-svn>/src/subversion/subversion/bindings/swig/perl/native/blib/lib/SVN/Core.pm
line 5.
Compilation failed in require at /usr/local/libexec/git-core/git-svn line 42.

git-svn:42 is mumbling about some problems:

sub _req_svn {
	require SVN::Core; # use()-ing this causes segfaults for me... *shrug*

Or is there needed even more like a _Core.pm? alien-svn should build it,
doesn't it?

> variable to specify where to search for Perl modules) to make Perl
> find your built but not installed Alien::SVN.

How do I install that?

Sorry for all these question. Admin left the company some weeks ago and I am
struggling to get this to work somehow between my everyday work...
