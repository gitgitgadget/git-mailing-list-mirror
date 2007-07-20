From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: [PATCH] Implement git commit as a builtin.
Date: Fri, 20 Jul 2007 10:45:24 -0400
Message-ID: <1184942724.26967.105.camel@hinata.boston.redhat.com>
References: <11847863792344-git-send-email-krh@redhat.com>
	 <1b46aba20707181427y12bd8b62pe30df61219e7c1f7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Carlos Rica <jasampler@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 20 16:51:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBtp9-00033J-UD
	for gcvg-git@gmane.org; Fri, 20 Jul 2007 16:51:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764302AbXGTOpd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 20 Jul 2007 10:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764294AbXGTOpd
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jul 2007 10:45:33 -0400
Received: from mx1.redhat.com ([66.187.233.31]:59952 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763599AbXGTOpc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2007 10:45:32 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l6KEjUT5027173;
	Fri, 20 Jul 2007 10:45:30 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l6KEjU7X016295;
	Fri, 20 Jul 2007 10:45:30 -0400
Received: from [192.168.1.102] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l6KEjUbE023976;
	Fri, 20 Jul 2007 10:45:30 -0400
In-Reply-To: <1b46aba20707181427y12bd8b62pe30df61219e7c1f7@mail.gmail.com>
X-Mailer: Evolution 2.11.4 (2.11.4-1.fc8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53096>

On Wed, 2007-07-18 at 23:27 +0200, Carlos Rica wrote:
> 2007/7/18, Kristian H=C3=B8gsberg <krh@redhat.com>:
> > +       if (buffer) {
> > +               len =3D strip_lines(buffer, len);
> > +
> > +               if (fwrite(buffer, 1, len, fp) < len)
> > +                       die("could not write commit template: %s\n"=
,
> > +                           strerror(errno));
> > +       }
> ....
> > +       len =3D strip_lines(buffer, len);
> > +
> > +       if (message_is_empty(buffer, len))
> > +               die("* no commit message?  aborting commit.");
> > +
>=20
> Hi Kristian, you could call to the new stripspace() function
> in builtin-stripspace.c, to reduce code in your file. The only
> thing you should consider is that the new stripspace()
> removes always the last '\n' in the file (if any), so you have to
> add it when you need.

Yup, I'm keeping an eye on all your changes, and it looks like it's all
falling in place nicely.  Once I have the last few pieces of
functionality ported over I'll rebase and update builtin-commit to use
the new functionality you've landed.

A couple of things that might be interesting right now is: 1) pick out
the test case I made for commit and get it upstream, and 2) take the
changes I did to wt-status.c (making it able to run on a different inde=
x
and output to a specified FILE pointer) and get that upstream.

cheers,
Kristian
