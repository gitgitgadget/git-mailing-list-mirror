From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb: (potential) problems with new installation
Date: Sat, 3 Mar 2012 00:55:34 +0100
Message-ID: <201203030055.34912.jnareb@gmail.com>
References: <201202281825.03904.jnareb@gmail.com> <4F51211C.2090201@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sat Mar 03 00:56:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3cKS-00053E-PI
	for gcvg-git-2@plane.gmane.org; Sat, 03 Mar 2012 00:56:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965613Ab2CBXzz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Mar 2012 18:55:55 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:32803 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756383Ab2CBXzg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2012 18:55:36 -0500
Received: by eekc41 with SMTP id c41so793669eek.19
        for <git@vger.kernel.org>; Fri, 02 Mar 2012 15:55:35 -0800 (PST)
Received-SPF: pass (google.com: domain of jnareb@gmail.com designates 10.213.2.82 as permitted sender) client-ip=10.213.2.82;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of jnareb@gmail.com designates 10.213.2.82 as permitted sender) smtp.mail=jnareb@gmail.com; dkim=pass header.i=jnareb@gmail.com
Received: from mr.google.com ([10.213.2.82])
        by 10.213.2.82 with SMTP id 18mr173652ebi.206.1330732535055 (num_hops = 1);
        Fri, 02 Mar 2012 15:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=ggxq1a2UC0ObtUtvHs9UMtCJ6ThFXa1DB0g0XRkxSS4=;
        b=sj7vhJQgEKXbzD5nqb2hHPzM5XvJllPrzt4F41uQoXT3zs2JcuPCvTJWNcjQYJqYDt
         /IHnBNvF6i2cYseYoSM8nuv1jHgB3KPSPoURrkqXZDX+YaetgNHiMhHSrTA+iqDESnVx
         oANK/yDueHTOhE0NGutsNesLPk3kiHLmPWGJUQglCRotG6GRMlSdYGRelKPv1zSXREqV
         Df3ewWVhST7YCNWQtVe81dCBrz3PA87sa7otlFnHHLNZFvhD0k9IvuSRABroEkc00Ckm
         yPkciNqD1DL6K+msaCHutRc31qNeU3dh0E1kkD9fvNhUduNo/sRplYhmX1S4lpXjHtD6
         T9YQ==
Received: by 10.213.2.82 with SMTP id 18mr134106ebi.206.1330732534926;
        Fri, 02 Mar 2012 15:55:34 -0800 (PST)
Received: from [192.168.1.13] (abvt148.neoplus.adsl.tpnet.pl. [83.8.217.148])
        by mx.google.com with ESMTPS id c15sm26345783eei.9.2012.03.02.15.55.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 02 Mar 2012 15:55:34 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <4F51211C.2090201@ramsay1.demon.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192074>

On Fri, 2 Mar 2012, Ramsay Jones wrote:
> Jakub Narebski wrote:

> > > First, I should say that I had to modify the script, and move the static
> > > directory out of cgi-bin, in order to get it to work.
> > 
> > You should never have to modify generated gitweb.cgi script; that is what
> > configuration file, gitweb_config.perl by default, is for.  It is well
> > documented in gitweb.conf(5) manpage, which in turn is referenced in
> > gitweb(1) manpage... at least with modern git.
> 
> Indeed, but I find "sudo bash; cd /var/www/cgi-bin; vim gitweb.cgi; etc..."
> just as easy! :-D
> 
> However, ... point taken.

Note that position of static files, and where they are installed, can
be set at build time.
 
> > >                                                       However, this is 
> > > not something new; I had to do the same with the previous version. The
> > > problem is obviously an apache configuration problem, which I tried to
> > > fix last time and (having spent *lots* of effort) gave up on; the main
> > > symptom of the problem is that apache attempts to *exec* any file in
> > > cgi-bin (e.g. gitweb.css, git-logo.png, git-favicon.png, etc.) which
> > > fills up the apache error logs with "permission denied" errors while
> > > trying to exec.
> > 
> > Strange.  Which version of Apache are you using, and how do relevant
> > parts of Apache configuration (httpd.conf etc.) look like?
> 
> Heh, I only described the above apache config problems (in the spirit of
> full disclosure) so that you would not be surprised by certain files not
> being in their usual location ... It wasn't a sneeky attempt to get some
> apache support! Having said that, my apache version is:
> 
>     Apache/2.2.3 (Ubuntu) mod_perl/2.0.2 Perl/v5.8.8 configured

Do you use CGI (mod_cgi or mod_cgid), or mod_perl?
 
> > If you use ScriptAlias directive, or ExecCGI option, then the problem
> > might be executable permissions -- Apache shouldn't execute scripts
> > without execute permission set as CGI scripts... errr... are you running
> > httpd as root?
> 
> No, it's running as www-data (well, the initial apache is run as root, but
> all worker processes are run as www-data - only the worker processes actually
> handle requests, I think).

Strange.  WORKSFORME anyway...
 
> > You can move to using "AddHandler cgi-script .cgi" instead.
> 
> I remember having tried that as well - without success.

This must be done _instead_ of ScriptAlias directive and/or ExecCGI option.

> > >     1. The new date timezone pop-up; The pop-up window comes up directly
> > >        over the date, so you can no longer read it, and once you have set
> > >        the desired timezone, it can not be dismissed. (including the x
> > >        button on the window). The only way to remove it is to refresh the
> > >        page, which makes it a little less that useful ... :-D
> > 
> > Hmmm... I have tested this code on Mozilla 1.7.12, and on modern at the time
> > of writing Firefox, Chrome, IE, and ancient Konqueror without encountering
> > any problems.
> > 
> > Could you at minimum check for JavaScript errors using JavaScript Console
> > (clearing it and reloading gitweb page if needed)?  Please provide line
> > where error is with a bit of context (around 3 lines).
> 
> I don't have a JavaScript Console. (I suppose that is an add-on? Hmm, I don't
> have internet access from Linux... ).

JavaScript Console is built in, though there are plugins like Console^2
that extend it.

In Mozilla 1.7.12 it is "Tools > Web Development > JavaScript Console"
It is "Tools > Errors Console" or "Tools > Web Console" in modern Firefox.
 
> > Note also that as workaround you can simply turn off this feature: put
> > the following line in gitweb configuration file:
> > 
> >   $feature{'javascript-timezone'}{'default'} = [];
> 
> Thanks. [BTW, if it wasn't clear before, you cannot grab the pop-up and move
> it out of the way...]

Well, of course.  Currently JavaScript is hand-written, and does not use
any of JavaScript toolkits / UI frameworks.  There are some plans to move
gitweb to use jQuery or MooTools library (YUI is probably too large).
 
> > >        The apache error log looked correct:
> > >
> > >            [Sun Feb 26 16:50:52 2012] gitweb.cgi: Quantifier follows nothing \
> > >            in regex; marked by <-- HERE in m/* <-- HERE git.*\.git/ at \
> > >            /var/www/cgi-bin/gitweb.cgi line 3084.
> > 
> > Hmmm... if we don't use regexp search, then all metacharacters should be
> > quoted, including leading '*'.  Strange.
> 
> Yes, this happens whether the re checkbox is set or *not*.

As I wrote in a separate thread, there were two separate errors, and both
need to be fixed.
 
> > If you did use regexp search, then it is a real issue, and it is not
> > something I have thought about.  Your search term
> > 
> >   *git.*\.git
> > 
> > is invalid regexp, because '*' quantifier which means zero or more 
> > occurrences does not follow any term.  Valid regexp is
> > 
> >   .*git.*\.git
> 
> Indeed, this is the regexp I had intended. (I started with a glob pattern,
> noticed the re checkbox, checked it, then went back to edit the search
> text, but forgot the initial '*' quantifier)

Fixed-string search should have worked even if this string contains
regexp metacharacters like '*'.  '*foo' searches for literal '*foo'
(using /\*foo/ search regexp)... or at least it should (send a patch
fixing this).

-- 
Jakub Narebski
Poland
