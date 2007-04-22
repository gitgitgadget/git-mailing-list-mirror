From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: [BUG] 42c4b58059f.. during "make install-doc": git-add.5: No such file or directory
Date: Sun, 22 Apr 2007 07:15:38 -0700
Message-ID: <867is4qyut.fsf@blue.stonehenge.com>
References: <86bqhgqyzg.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 22 16:15:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hfcqt-0007mw-T8
	for gcvg-git@gmane.org; Sun, 22 Apr 2007 16:15:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030892AbXDVOPj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Apr 2007 10:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030900AbXDVOPj
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Apr 2007 10:15:39 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:43719 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030892AbXDVOPi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2007 10:15:38 -0400
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 8FE0C1DE3B0; Sun, 22 Apr 2007 07:15:38 -0700 (PDT)
x-mayan-date: Long count = 12.19.14.4.10; tzolkin = 1 Oc; haab = 18 Pop
In-Reply-To: <86bqhgqyzg.fsf@blue.stonehenge.com> (Randal L. Schwartz's message of "Sun, 22 Apr 2007 07:12:51 -0700")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45243>

>>>>> "Randal" == Randal L Schwartz <merlyn@stonehenge.com> writes:

Randal> 42c4b58059fa9af65e90f2c418bb551e30d1d32f

Randal> $ make install-doc
Randal> ...
Randal> install: git-add.5: No such file or directory
Randal> ...

Randal> which then rolls back deleting all my xml files. :(

Randal> Aha... I think it's this line:

Randal>        DOC_MAN5=$(patsubst %.txt,%.5,$(MAN1_TXT))

Randal> I'm betting that should be MAN5_TXT.

Nope, that leads me to:

  xmlto -m callouts.xsl man gitattributes.xml
  xmlto: input does not validate (status 3)
  /Volumes/UFS/MIRROR/git-GIT/Documentation/gitattributes.xml:15: element refsynopsisdiv: validity error : Element refsynopsisdiv content does not follow the DTD, expecting (refsynopsisdivinfo? , (title , subtitle? , titleabbrev?)? , (((calloutlist | glosslist | itemizedlist | orderedlist | segmentedlist | simplelist | variablelist | caution | important | note | tip | warning | literallayout | programlisting | programlistingco | screen | screenco | screenshot | synopsis | cmdsynopsis | funcsynopsis | classsynopsis | fieldsynopsis | constructorsynopsis | destructorsynopsis | methodsynopsis | formalpara | para | simpara | address | blockquote | graphic | graphicco | mediaobject | mediaobjectco | informalequation | informalexample | informalfigure | informaltable | equation | example | figure | table | msgset | procedure | sidebar | qandaset | anchor | bridgehead | remark | highlights | abs
 tract | authorblurb | epigraph | indexterm | beginpage)+ , refsect2*) | refsect2+)), got (
 )

Help!
-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
