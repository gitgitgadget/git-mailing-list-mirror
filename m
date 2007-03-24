From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Added make options NO_GUI and WITH_P4IMPORT.
Date: Sun, 25 Mar 2007 00:16:25 +0100
Message-ID: <200703250016.25963.jnareb@gmail.com>
References: <20070320114525.GP96806@codelabs.ru> <20070321144210.GF14837@codelabs.ru> <81b0412b0703210758v32e7a692p426f45de9ee6db42@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "Eygene Ryabinkin" <rea-git@codelabs.ru>,
	"Paolo Bonzini" <bonzini@gnu.org>, git@vger.kernel.org
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 25 11:27:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVP0J-0004gc-KJ
	for gcvg-git@gmane.org; Sun, 25 Mar 2007 11:27:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933222AbXCYJ1I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Mar 2007 05:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933265AbXCYJ1I
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Mar 2007 05:27:08 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:58638 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933230AbXCYJ1G (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2007 05:27:06 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1351619uga
        for <git@vger.kernel.org>; Sun, 25 Mar 2007 02:27:05 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=kQouqBc65k4LZ7fMJ/sOr7cz6y/cwfi1WfDN68GcnGLzK/cVC97PAHz886f5dHnlcGKjWvGH4QUNRIqxzfFi+D+HGcFSS1hgVVY5CQy3eQXFBZvVj+lkq1IOtbRiF99ln+gp79MdfGNSSZIlVEfhqeZf9B+lFX/IQe+GdnXbyNM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=dqrsk83xamaDQ3bUn3EDHeTmvBn6mwCWTy9RU2spBM7lfoB4UKjuiADxpC7EcUaa8wmt4uM5deX/OCXFvTJ9LX9B2R7WpRkIlaoRX3H/XWerze48fZTQlUFKbhfvXAqr22weZ3S+s2+o+peQ/DvdyR+6QlTthDFDyjfEPFrPIBk=
Received: by 10.66.244.11 with SMTP id r11mr10099772ugh.1174814825066;
        Sun, 25 Mar 2007 02:27:05 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id w5sm15012430mue.2007.03.25.02.27.02;
        Sun, 25 Mar 2007 02:27:03 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <81b0412b0703210758v32e7a692p426f45de9ee6db42@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43048>

On Wed, Mar 21, 2007, Alex Riesen wrote:
> On 3/21/07, Eygene Ryabinkin <rea-git@codelabs.ru> wrote:

>> Yep, you're right. That was I meant originally. How do you feel
>> about NO_GUI or NO_TCL names?
> 
> That'd be NO_TCL_TK. TCL has nothing to do with graphics.
> And you have one more supporter for NO_GUI (my server has no
> usable graphics, will never have and runs cron jobs with git in them).

Actually the value for NO_TCL_TK (or NO_TCLTK) can be detected 
automatically by ./configure in similar way that we used to detect the 
existence of Python in the old days when there were core code which 
written in Python. Perhaps we should provide way to override 
autodetection _and_ provide path to 'wish' executable with the 
--with-wish=PATH or --with-tcltk=PATH to ./configure script (similar to 
how Python dependency was handled, and how paths to shell and Perl are 
handled).

The NO_GUI is another issue, if to be configured by ./configure script, 
then only as an user option, not something to be autodetected: either 
--without-gui (treat gui as package, although usually it is about 
package to be used, not package provided) or --disable-gui (treat gui 
as feature of project).

The fact that all GUI that comes with git repository is in Tcl/Tk 
slightly clouds this issue. As do the fact that those affect only 
installation stage, and not build (well, with the exception of 
WISH_PATH / TCLTK_PATH).

-- 
Jakub Narebski
Poland
