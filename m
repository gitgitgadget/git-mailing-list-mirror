From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: GSoC 2010: "Integrated Web Client for git" proposal
Date: Mon, 19 Apr 2010 12:43:22 +0200
Message-ID: <201004191243.24209.jnareb@gmail.com>
References: <201004150630.44300.chriscool@tuxfamily.org> <201004181950.19610.jnareb@gmail.com> <20100418195623.GA3563@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Shawn O Pearce <spearce@spearce.org>,
	Scott Chacon <schacon@gmail.com>,
	Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Sam Vilain <sam@vilain.net>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Apr 19 12:43:43 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3oS6-00009g-AO
	for gcvg-git-2@lo.gmane.org; Mon, 19 Apr 2010 12:43:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753190Ab0DSKng (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Apr 2010 06:43:36 -0400
Received: from mail-bw0-f225.google.com ([209.85.218.225]:62983 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752433Ab0DSKnf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Apr 2010 06:43:35 -0400
Received: by bwz25 with SMTP id 25so5353594bwz.28
        for <git@vger.kernel.org>; Mon, 19 Apr 2010 03:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=RB5TaM6OvOUc6z8TtcnwfV9R3HPS81qjJCKsqh41vyg=;
        b=DOZLZFy4+3PoZBSt5Cp8dtyJ4lL5/mUnsqo6q2Cr/Vsz5UiGNXSF2oJa0ZT3a30Do7
         p48XCM/j5AZJEHM8ASYyciUHvL/V/BFFhfUPGlJiqGpWe469YJ9Sj06ZrMoigxL1Pe6A
         SmwhvAAzXHeZL0vUo9bzroXaGXKmNxaVfs+So=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=SvK0JZAjHoxNqi18iT8Fy8QckjWIUq8vR58UyVMwFcyhxXY0Mmr3UK5aOFTL/JerK3
         jk4YQXbXwDmmOuxQwObn4WW8ex1DKoccRfsosiEFMbpm/5zlR0oMlfnA7CGc/m7AOc2Q
         T73pcPIf0m/LR6VqkOaZQMtcBtlaAJQYCuSFE=
Received: by 10.87.70.20 with SMTP id x20mr3972396fgk.33.1271673813529;
        Mon, 19 Apr 2010 03:43:33 -0700 (PDT)
Received: from [192.168.1.13] (abvh23.neoplus.adsl.tpnet.pl [83.8.205.23])
        by mx.google.com with ESMTPS id 3sm4113780fge.5.2010.04.19.03.43.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 19 Apr 2010 03:43:31 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20100418195623.GA3563@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145289>

On Sun, Apr 18, 2010 at 21:56 +0200, Petr Baudis wrote:
> On Sun, Apr 18, 2010 at 07:50:17PM +0200, Jakub Narebski wrote:

>> So it is intended, I guess, more like git-instaweb or webmin, not like
>> administrative parts of Girocco (or repo.or.cz), GitHub, Gitorious or
>> InDefero.  Probably authentication and authorization would not be needed
>> then, if it is to be run as web interface but locally...
> 
> If the project is a success, I wanted to use it for mob branch editing
> on repo.or.cz. It could also be used as open-source Gist alternative.

For that you would need editing file / editing contents action, but
this is explicitely excluded in current version of Pavan's proposal :-(

> But it needs to be coded so that it does not require an actual checked
> out copy (which shouldn't be too much hassle).

It would require using 'git hash-object -t blob -w --stdin' (from body
submitted via POST from textarea) plus 'git update-index --cacheinfo'.
There is however complication that you would need to do open2/open3
because git-hash-object would require bidirectional communication unless
you would use temporary file (command_bidi_pipe in Git.pm, untested).

>> Currently to install gitweb you have to copy *one* script, and a few
>> static files (2 x image, CSS, JavaScript).  You can configure it using
>> "make gitweb" with appropriate options, you can simply edit gitweb script,
>> or you can leave this to the gitweb config file.
> 
> I don't really think things can get *any* more complicated than "also
> copy over this directory recursively", do they?

Let's check what gitweb/INSTALL says currently

        $ make prefix=/usr gitweb             ;# as yourself
        # cp gitweb/git* /var/www/cgi-bin/    ;# as root

WTF with 'gitweb/git*' glob?  

Ah, later there is "Build example", which is

 - To install gitweb to /var/www/cgi-bin/gitweb/ when git wrapper
   is installed at /usr/local/bin/git and the repositories (projects)
   we want to display are under /home/local/scm, you can do

        make GITWEB_PROJECTROOT="/home/local/scm" \
             GITWEB_JS="/gitweb/gitweb.js" \
             GITWEB_CSS="/gitweb/gitweb.css" \
             GITWEB_LOGO="/gitweb/git-logo.png" \
             GITWEB_FAVICON="/gitweb/git-favicon.png" \
             bindir=/usr/local/bin \
             gitweb

        cp -fv ~/git/gitweb/gitweb.{cgi,js,css} \
               ~/git/gitweb/git-{favicon,logo}.png \
             /var/www/cgi-bin/gitweb/

WTF with '~/git/gitweb'... ehh, that one is mine, I guess...


So additional step would be

        cp -fvR gitweb/lib /var/www/cgi-bin/    ;# as root


I hope that we could make installing gitweb as easy as

        make webscriptdir=/var/www/cgi-bin/ \
             gitweb-install
 
or in more complicated case (gitweb modules not installed in cgi-bin)

        make webscriptdir=/var/www/cgi-bin/gitweb \
             GITWEB_BASE="/gitweb/" \
             GITWEBPERLLIB=/usr/local/lib/perl5 \
             gitweb-install

or something like that (I do not know any standard for the name of build
configuration variable which tells where to install web aplication; 
do you?)

>> Also there is a question _how_ to split gitweb into modules, 
>> e.g. whether to follow SVN::Web example on how gitweb (Git::Web?) should
>> be split.  But I guess any splitting would suffice; we need to provide
>> a way to build and install split gitweb.  
>> 
>> Split can be as simple as:
>> 
>>   Makefile, or Makefile.PL, or Build.PL
>>   gitweb.perl
>>   static/git-logo.png
>>   static/git-favicon.png
>>   static/gitweb.css
>>   static/gitweb.js
>>   lib/Gitweb/Utils.pm   (Gitweb::Utils)
>>   lib/Gitweb/Editor.pm  (Gitweb::Editor, for GSoC2010, if it gets accepted)
> 
> Exactly! I think we can do this reasonably incrementally; if something
> is not working out, we can move it again later. Let's not overengineer
> stuff. I think it would make sense to just split out something like
> Gitweb::Git (for Git invocations), Gitweb::CGI (for CGI parsing and
> HTML output toolkit) and perhaps Gitweb::Util for misc. stuff. Then,
> if we feel like it, maybe we can start splitting out things more, like
> Gitweb::CGI::Blame, but I don't think that's even neccessary for now.

Well, I would perhaps start simply with 

  gitweb.perl
  lib/Gitweb.pm

We can modify file organization later; what's important is the build
infrastructure (even if it is instruction in gitweb/INSTALL).

-- 
Jakub Narebski
Poland
