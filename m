From: "Govind Salinas" <govind@sophiasuchtig.com>
Subject: Re: [Janitors] value could be NULL in config parser
Date: Sat, 9 Feb 2008 14:11:23 -0600
Message-ID: <5d46db230802091211k304197e2i2556c82494c0852f@mail.gmail.com>
References: <7v63x0lzhw.fsf@gitster.siamese.dyndns.org>
	 <5d46db230802081720x122a807do6c63b6b3e435b4c5@mail.gmail.com>
	 <200802091118.11174.chriscool@tuxfamily.org>
	 <200802091415.20295.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Christian Couder" <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sat Feb 09 21:12:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNw3L-0004MV-5g
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 21:11:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755142AbYBIULZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Feb 2008 15:11:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755346AbYBIULZ
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 15:11:25 -0500
Received: from wx-out-0506.google.com ([66.249.82.228]:31489 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755121AbYBIULY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Feb 2008 15:11:24 -0500
Received: by wx-out-0506.google.com with SMTP id h31so4364497wxd.4
        for <git@vger.kernel.org>; Sat, 09 Feb 2008 12:11:24 -0800 (PST)
Received: by 10.150.138.8 with SMTP id l8mr5950593ybd.141.1202587883936;
        Sat, 09 Feb 2008 12:11:23 -0800 (PST)
Received: by 10.150.199.5 with HTTP; Sat, 9 Feb 2008 12:11:23 -0800 (PST)
In-Reply-To: <200802091415.20295.chriscool@tuxfamily.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73258>

On 2/9/08, Christian Couder <chriscool@tuxfamily.org> wrote:
> Le samedi 9 f=E9vrier 2008, Christian Couder a =E9crit :
> > Le samedi 9 f=E9vrier 2008, Govind Salinas a =E9crit :
> > > I think I got all the erroneous ones.  I did
> > >
> > > find . -name "*.c" | xargs grep git_config\( | awk '{ idx =3D ind=
ex($2,
> > > ")"); p =3D substr($2, 12, idx - 12); print  p }' | sort | uniq -=
u
> >
> > It seems the "uniq -u" should be only "uniq".
> > This way, you will also get the following ones to check:
> >
> > git_default_config
> > git_diff_basic_config
> > git_log_config
> > git_pack_config
>
> I don't know awk so I cannot tell if there is something wrong with yo=
ur
> script but with:
>
> find . -name "*.c" | xargs perl -ne 'print "$1\n" if (m/git_config ?
> \(([^)]*)\)/)' | sort | uniq
>
> I also get:
>
> git_imap_config
> show_all_config
>

It appears only git_imap_config and git_default_config need patches.
I will send them to the list.

Are any changes to the git_config_$type functions going to be made?
It sounds like any change could break current configs so we are only
going to stop the segfaults.

-Govind
