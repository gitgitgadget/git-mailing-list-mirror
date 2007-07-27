From: Brett Schwarz <brett_schwarz@yahoo.com>
Subject: Re: git-gui: i18n introductory document (2nd draft)
Date: Fri, 27 Jul 2007 10:58:27 -0700 (PDT)
Message-ID: <940142.14871.qm@web38911.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, Irina Riesen <irina.riesen@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Nanako Shiraishi <nanako3@bluebottle.com>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Xudong Guan <xudong.guan@gmail.com>, stimming@tuhh.de
To: Christian Stimming <Christian.Stimming@ibeo-as.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 27 19:58:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEU5M-0003yU-CG
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 19:58:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932975AbXG0R6b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 13:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932717AbXG0R6a
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 13:58:30 -0400
Received: from web38911.mail.mud.yahoo.com ([209.191.125.117]:45919 "HELO
	web38911.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932510AbXG0R63 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 13:58:29 -0400
Received: (qmail 15302 invoked by uid 60001); 27 Jul 2007 17:58:28 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=akmRmKhbFLpzmR/xu1sodjTcqKgIHZ5SSlOGsxQpa91xDTx7DsS49QSH29osdggQcZBbZWJn/6u+iroxPF4uk8dLM6CbkKixM3LOxosQ2TCjhwAaINiIrGWETjOYfZBvl6mJKrZwGjMRGAchEPBm3yrMgYsRUA83KrwIChXbOpM=;
X-YMail-OSG: p7bamEYVM1k8FhswXNzIM7AyvS5zZK1xcoog2OjMGrITGiZSEjOXXGR.3.dnNmd.NeScZHFiNh_xROgojO5npiI74rEsrTNaQS6xj.QZGdOl6t4sxTU6K9GQJw--
Received: from [24.16.125.24] by web38911.mail.mud.yahoo.com via HTTP; Fri, 27 Jul 2007 10:58:27 PDT
X-Mailer: YahooMailRC/651.41 YahooMailWebService/0.7.119
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53936>

> ----- Original Message ----
> From: Christian Stimming <Christian.Stimming@ibeo-as.com>
> To: Junio C Hamano <gitster@pobox.com>
> Cc: git@vger.kernel.org; Irina Riesen <irina.riesen@gmail.com>; Johannes Schindelin <johannes.schindelin@gmx.de>; Nanako Shiraishi <nanako3@bluebottle.com>; Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>; Shawn O. Pearce <spearce@spearce.org>; Xudong Guan <xudong.guan@gmail.com>; stimming@tuhh.de
> Sent: Friday, July 27, 2007 8:21:58 AM
> Subject: Re: git-gui: i18n introductory document (2nd draft)
>
> Junio C Hamano <gitster@pobox.com> schrieb am 27.07.2007 01:31:06:
> > I have tried to address issues raised in Christian's comments on
> > the first draft that was circulated privately.
>

<snip>

>
> > + - Often the messages being translated are format strings given to
> > +   "printf()"-like functions.  Make sure "%s", "%d", and "%%" in your
> > +   translated messages match the original.
> > +
> > +   When you have to change the order of words, you can add "<number>$"
> > +   between '%' and the conversion ('s', 'd', etc.) to say "<number>-th
> > +   parameter to the format string is used at this point".  For example,
> > +   if the original message is like this:
> > +
> > +   "Length is %d, Weight is %d"
> > +
> > +   and if for whatever reason your translation needs to say weight first
> > +   and then length, you can say something like:

> > +
> > +   "WEIGHT IS %2$d, LENGTH IS %1$d"

Since we are using quotes for the strings, and Tcl will do a round of substitutions
 and will think those $d's are variables, you might want to change that to:

        "WEIGHT IS %2\$d, LENGTH IS %1\$d"

You also may want to add a note about why the backslash

> > +
> > +   [NEEDSWORK: this whole "parameter permutation" part needs to be
> > +   verified if it works with Tcl at all]
>

bschwarz@desk1:~$ tclsh
% package require msgcat
1.3.4
% namespace import ::msgcat::*
% mcset en_us_brett "L is %d, W is %d" "WEIGHT IS %2\$d, LENGTH IS %1\$d" 
WEIGHT IS %2$d, LENGTH IS %1$d
% mcset en_us "L is %d, W is %d" "Length is %d, Weight is %d"
Length is %d, Weight is %d
% mclocale en_us
en_us
% set length 74
74
% set weight 220
220
% mc "L is %d, W is %d" $length $weight
Length is 74, Weight is 220
% mclocale en_us_brett
en_us_brett
% mc "L is %d, W is %d" $length $weight
WEIGHT IS 220, LENGTH IS 74
% 

Seems to work...

Regards,
     --brett




       
____________________________________________________________________________________
Get the free Yahoo! toolbar and rest assured with the added security of spyware protection.
http://new.toolbar.yahoo.com/toolbar/features/norton/index.php
