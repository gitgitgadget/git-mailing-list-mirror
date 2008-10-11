From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [Gitk PATCH 1/6] gitk: Add procedure to create accelerated menus
Date: Sat, 11 Oct 2008 13:39:23 +0200
Message-ID: <200810111339.23343.robin.rosenberg.lists@dewire.com>
References: <1223532590-8706-1-git-send-email-robin.rosenberg@dewire.com> <1223532590-8706-2-git-send-email-robin.rosenberg@dewire.com> <18672.1017.68669.913415@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sat Oct 11 13:42:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KocrB-0004jI-07
	for gcvg-git-2@gmane.org; Sat, 11 Oct 2008 13:42:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752100AbYJKLkt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Oct 2008 07:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752053AbYJKLkt
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Oct 2008 07:40:49 -0400
Received: from [83.140.172.130] ([83.140.172.130]:11385 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751990AbYJKLks convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Oct 2008 07:40:48 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 6712B8006B1;
	Sat, 11 Oct 2008 13:40:47 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KfJViplxqwBh; Sat, 11 Oct 2008 13:40:36 +0200 (CEST)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id D781A80008B;
	Sat, 11 Oct 2008 13:40:36 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <18672.1017.68669.913415@cargo.ozlabs.ibm.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97975>

l=F6rdagen den 11 oktober 2008 03.40.09 skrev Paul Mackerras:
> Robin Rosenberg writes:
>=20
> > +proc mcw {menubar args} {
> > +    set ai [lsearch $args "-label"]
> > +    if { $ai > 0 } {
> > +	set label [lindex $args [expr {$ai + 1}]]
> > +	foreach {l u} [::tk::UnderlineAmpersand $label] {
>=20
> Where did you find out about ::tk::UnderlineAmpersand?  Is it part of
> the exported interface of Tk that we can rely on in future?

I found it here. http://wiki.tcl.tk/1632. It hints that it may not be u=
noffical. Seems to
original from: http://groups.google.com/group/comp.lang.perl.tk/browse_=
thread/thread/5b6f4c6a4a9f17b4/c9f8ab47800d27ee?lnk=3Dst&q=3D#c9f8ab478=
00d27ee

so if someone thinks there is a problem we could replace it with Underl=
ineAmpersand
with tcl code to do the same (or rip it as is if the license allows it)=
=2E

>=20
> > +# Wrapper for mc to remove ampersands used for accelerators.
> > +proc mca {label} {
> > +    set tl8 [mc $label]
> > +    foreach {l u} [::tk::UnderlineAmpersand $tl8] break
> > +    return $l
>=20
> 	return [string map {"&" ""} [mc $label]]
>=20
> instead, perhaps?
In theory we should translate && to & also, which UnderLineAmpersand do=
es.

-- robin
