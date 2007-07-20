From: Brett Schwarz <brett_schwarz@yahoo.com>
Subject: Re: [PATCH] Internationalization of git-gui
Date: Fri, 20 Jul 2007 11:15:03 -0700 (PDT)
Message-ID: <111363.1999.qm@web38911.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ascii
Cc: git@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Christian Stimming <stimming@tuhh.de>
X-From: git-owner@vger.kernel.org Fri Jul 20 20:15:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBx0Q-0003NA-3s
	for gcvg-git@gmane.org; Fri, 20 Jul 2007 20:15:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761134AbXGTSPF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jul 2007 14:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758032AbXGTSPF
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jul 2007 14:15:05 -0400
Received: from web38911.mail.mud.yahoo.com ([209.191.125.117]:20698 "HELO
	web38911.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756177AbXGTSPE (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Jul 2007 14:15:04 -0400
Received: (qmail 2603 invoked by uid 60001); 20 Jul 2007 18:15:03 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Message-ID;
  b=DCPd4p5Ppi1toDYCdYvdYJGMYyjl01ul/bqnsivlRwEaj2IHlpgQYr3GUUPTNJpmk3atYhImpf6M1uPn6YvSLF1XQZfnr4fBRMszwM7KyL9hSb7MO6ELFt0ZbvpQuqgk/Viol077eVyYBobkk13x3JSLsqbhypMrg/9mKN5fRJM=;
X-YMail-OSG: ALVL4ykVM1kOhEqTEldZ8MNdh9JzXSvdVAlm7MZSkFNmMJfoqZlBTvWRSk3o6ByKxOjvS26tS7DsKnhlx2IbnqXbx4ujdLyUiWgmMOLURA5m7jg-
Received: from [128.251.102.158] by web38911.mail.mud.yahoo.com via HTTP; Fri, 20 Jul 2007 11:15:03 PDT
X-Mailer: YahooMailRC/651.41 YahooMailWebService/0.7.41.16
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53108>

[my apologies about top posting...my mail reader sucks]


Sure, I wasn't saying there would be for sure an advantage in re-using catalogs. That's why I said it *might* be worth looking into. Just a suggestion.

I agree that a glossary should be created first. That way, translators have a common set to work with.

Just a note about string substitution. msgcat has substitution built-in, so instead of this:

    .mbar.apple add command -label [format [_ "About %s"] [appname]] \

You can do this:

    .mbar.apple add command -label [_ "About %s" [appname]] \


Thanks,
    --brett


----- Original Message ----
From: Christian Stimming <stimming@tuhh.de>
To: Brett Schwarz <brett_schwarz@yahoo.com>
Cc: git@vger.kernel.org; Paul Mackerras <paulus@samba.org>; Shawn O. Pearce <spearce@spearce.org>
Sent: Friday, July 20, 2007 2:03:54 AM
Subject: Re: [PATCH] Internationalization of git-gui

Quoting Brett Schwarz <brett_schwarz@yahoo.com>:
> Also, if the message catalogs are in a common location, then it   
> might be worth looking into having gitk utilize these msg catalogs   
> as well.

You mean you suggest to re-use existing msg catalogs in addition to  
ones that are created on our own? Well, from the i18n coordination  
work in another project (gnucash) I wouldn't expect any noticable  
benefit from doing so. The re-usable parts of translations are rather  
limited, basically limited to the standard menu entries and some more  
single-word strings (Yes/No/Cancel...). But even then re-using other  
translations might already decrease the quality of your own  
translation, because other translators of packages might already have  
chosen a different translation for e.g. "Cancel". For that reason I  
strongly suggest using one single msg catalog for one single project,  
so that the translator is even able to make sure each word is  
translated into the same translation throughout the project.

(I also strongly suggest creating and translating a glossary of the  
important terms before starting to translate the msg catalog itself,  
but that's a different issue.)

> p.s. the frink tool (http://wiki.tcl.tk/2611) is supposed to be able  
>  to convert -text and -label switches to use msgcat...it might be   
> worth looking into, instead of manually editing git-gui/gitk

Thanks for the pointer. However, the -text and -label switches can be  
found and edited rather easily by keyboard macros and such. More  
important than this are some changes that are necessary in order to  
obtain strings that are actually translatable, such as

-    .mbar.apple add command -label "About [appname]" \
+    .mbar.apple add command -label [format [_ "About %s"] [appname]] \

and you will agree those can only be done manually anyway.

Christian





      ____________________________________________________________________________________
Fussy? Opinionated? Impossible to please? Perfect.  Join Yahoo!'s user panel and lay it on us. http://surveylink.yahoo.com/gmrs/yahoo_panel_invite.asp?a=7 
