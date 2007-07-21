From: Brett Schwarz <brett_schwarz@yahoo.com>
Subject: Re: [PATCH] Internationalization of git-gui
Date: Sat, 21 Jul 2007 09:29:56 -0700 (PDT)
Message-ID: <479784.46282.qm@web38908.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ascii
Cc: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Christian Stimming <stimming@tuhh.de>
X-From: git-owner@vger.kernel.org Sat Jul 21 18:30:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICHqb-0006gQ-D9
	for gcvg-git@gmane.org; Sat, 21 Jul 2007 18:30:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752158AbXGUQaA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jul 2007 12:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751548AbXGUQ37
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jul 2007 12:29:59 -0400
Received: from web38908.mail.mud.yahoo.com ([209.191.125.114]:40718 "HELO
	web38908.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751445AbXGUQ36 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Jul 2007 12:29:58 -0400
Received: (qmail 46475 invoked by uid 60001); 21 Jul 2007 16:29:57 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Message-ID;
  b=Y/96cil6HJwB8wZCkjewRkQ95d91fpeT5+dLLCzlJ2aPMhnTDPjB4wOLdcGsv6ME1SI2vO+fPKafD7RZ9gXgae9pdOpwxw89Yer0dHwD7H7mxcalGxJuheoz896P46QLF8Gtr4rGQFfUNmskYVWUsbaYcl+lzo3XpuNCtpQou4U=;
X-YMail-OSG: Q6S6z68VM1lCPUsVSAdOS8HA1UdhBxcby8_RHZNkuC6qFLJfY.DpRBKXigGX7N05kQ--
Received: from [24.16.125.24] by web38908.mail.mud.yahoo.com via HTTP; Sat, 21 Jul 2007 09:29:57 PDT
X-Mailer: YahooMailRC/651.41 YahooMailWebService/0.7.41.16
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53172>


> ----- Original Message ----
> From: Christian Stimming <stimming@tuhh.de>
> To: Brett Schwarz <brett_schwarz@yahoo.com>
> Cc: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>; Shawn O. Pearce <spearce@spearce.org>; Johannes Schindelin <Johannes.Schindelin@gmx.de>; git@vger.kernel.org
> Sent: Friday, July 20, 2007 2:40:27 PM
> Subject: Re: [PATCH] Internationalization of git-gui
> 
> Am Freitag, 20. Juli 2007 20:34 schrieb Brett Schwarz:
> > After the glossary of terms has been create, it is easy to create the
> > catalog file (assuming we use Tcl's standard mechanism). Each locale should
> > have it's own file, named <locale_name>.msg (for example, es.msg for
> > spanish). Inside that file, you just create entries for each glossary term
> > (the below assumes that the msgcat namespace was imported):
> >
> >   mcset es Hello Hola
> >   mcset es "Hello %s" "Hola %s"
> 
> I beg your pardon, but I think you grossly misunderstood what I meant
> by "glossary". So before we end up in further confusion, let me clarify how
> the general translation approach works. I'll use gettext wording because
> that's what I know (from being the i18n guy in the gnucash project), but you
> can easily insert any other wording you like here.
> 

Ok, perhaps I did misunderstand you. From below, now I do understand...thanks.

 
> #1 For the translation in general, there is the set of all user-visible
> strings in the source language (here: english). In gettext terms this is
> called the "PO template file", git-gui.pot, also called the message template
> file. This set of to-be-translated strings needs to be extracted from the
> source code, which can be done by the xgettext program.
> 
> #2 For each target language, there is a human-readable mapping file that maps
> each source string (english) into the target language. In gettext terms this
> is the "PO file", de.po and it.po and ja.po and whatnot, also called the
> translation file. This is the *only* file translators actually work with.
> Gettext uses its PO file format here and a plethora of different tools exist
> to help translators editing these files. (Examples: emacs po-mode,
> KBabel, ...)
> 
> #3 For each target language, the translation files are converted to a
> (potentially not human-readable) "compiled" mapping file, which is then read
> at program runtime and used for the actual translation. For the gettext po
> file format, the msgfmt program can convert this to Tcl's .msg files.
> 
> If I understand correctly, your above suggestion implies that for Tcl msgcat,
> the file in #2 and #3 are one and the same? In my opinion this might make
> sense if and only if that file format is supported by at least as many
> translation tools and offers as flexible translation updates as gettext's po
> file format does. From my experience the po file format indeed offers a bunch
> of features that other translation file formats are missing but which are of
> significant help to the translator. That's why I would strongly suggest to do
> the actual translation inside a po file, and have it converted to the msg
> file afterwards.
> 

Yes, for the msgcat files, you create just the mapping files...that's it. No intermediate steps. So, a workflow would look something like this:

1) Somebody creates the initial "template" file. This is usually in the source's language (i.e. english). This too is just a msgcat file. Note that this file is not strictly necessary, but helps other translators.

2) A translator copies the template file, to their target language file, and edits the text:
    # cp en.msg es.msg
    # vi es.msg
    this
        mcset en Hello Hello
    get's changed to this
        mcset es Hello Hola
    etc

That's it. There is no compilation needed, and no need for a makefile entry.

Now, even though I think this approach is alot more simplier and straight forward, I do recognize that alot of people are probably accustomed to the po format, and since the actual generation of the msgcat files are only done by the maintainer, I don't really have anything against using the po format.

I know it's already been decided to use the po format, but I just wanted to make sure to follow up on this email.

Thanks,
    --brett




       
____________________________________________________________________________________
Boardwalk for $500? In 2007? Ha! Play Monopoly Here and Now (it's updated for today's economy) at Yahoo! Games.
http://get.games.yahoo.com/proddesc?gamekey=monopolyherenow  
