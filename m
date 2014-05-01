From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Re: Pull is Evil
Date: Thu, 01 May 2014 18:25:16 -0500
Message-ID: <5362d7dc7b12_12fe14dd31095@nysa.notmuch>
References: <xmqqppjyhnom.fsf@gitster.dls.corp.google.com>
 <536152D3.5050107@xiplink.com>
 <5361598f8eaf7_4781124b2f02b@nysa.notmuch>
 <536173F5.7010905@xiplink.com>
 <53617877b41a9_41a872f308ef@nysa.notmuch>
 <20140501094610.GB75770@vauxhall.crustytoothpaste.net>
 <5362266a3ca00_284da2f2eca3@nysa.notmuch>
 <7vbnvhil5x.fsf@alter.siamese.dyndns.org>
 <53629da233345_76612eb2f075@nysa.notmuch>
 <20140501194846.GA6227@odin.tremily.us>
 <20140501200703.GB6227@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org
To: "W. Trevor King" <wking@tremily.us>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 02 01:36:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wg0WF-0002OM-TE
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 01:36:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752732AbaEAXf4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 May 2014 19:35:56 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:42774 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752710AbaEAXfz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 May 2014 19:35:55 -0400
Received: by mail-ob0-f174.google.com with SMTP id gq1so4400003obb.33
        for <git@vger.kernel.org>; Thu, 01 May 2014 16:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=5SK7W0YLj8q++WJjeqjKhLN53zQv8+IzCPLZb5KMp4w=;
        b=IzE0972CAjnP7MnwbzRzDqOJrPSEMuQppZCptXd8tIHScNJqhoVgjTtZW5iFCvC+HA
         v1tQSC3yAXROWkE3z18bPOXnLAp8neef3f8UbXvO5Po65opuoS4+ZjVrVzAYmFHHnxuw
         NRqqTfWiOVu9jIMBxoRuzNSPscoZl2JTWDoyJWS3dpXnYrNAv4YttRGprVANd35sbkra
         W5ujod+e/VS6mLWRgtvUpHfHygvXx3kLQpyMjkrrSRPGGXCFrzKBOIqRSw7Z6SH6VVsl
         p7TtXnMr/Fh4XHrJEeyIDJYkoCPBpoiJtnxA1QWf+w3NJiCDgdh4U/2NFX0E9N7/0KzP
         2yMw==
X-Received: by 10.182.70.39 with SMTP id j7mr3669701obu.55.1398987355229;
        Thu, 01 May 2014 16:35:55 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id rt4sm62481828obb.12.2014.05.01.16.35.52
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 May 2014 16:35:54 -0700 (PDT)
In-Reply-To: <20140501200703.GB6227@odin.tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247894>

W. Trevor King wrote:
> On Thu, May 01, 2014 at 12:48:46PM -0700, W. Trevor King wrote:
> > My interest in all of the proposed git-pull-training-wheel patches =
is
> > that they give users a way to set a finger-breaking configuration t=
hat
> > makes pull a no-op (or slows it down, like 'rm -i =E2=80=A6').  The=
n folks who
> > compulsively run 'git pull' (e.g. because SVN habits die slowly) ca=
n
> > set an option that gives them something to think about before going
> > ahead and running the pull anyway.
>=20
> Actually, what do we think about an -i/--interactive flag (with an
> associated pull.interactive boolean config to setup global/per-repo
> defaults)?  Then after the fetch, you'd get one of the following:
>=20
>   Merge $count commits from $repository $refspec into $current_branch=
?
>   Rebase $count commits from $current_branch onto $repository $refpec=
?

Not much interactivity in those options. Maybe --prompt would make more
sense.

>   Fast-forward $current_branch by $count commits to $repository $refp=
ec?

Why would anyone say 'no' to this one?

But your wording made me realize that my proposed option 'merge-ff-only=
'
is not appropriate, because in theroy the user can think about it as
'rebase-ff-only'; in other words, a 'fast-forward' is not really a
merge, and not really a rebase.

> and have a chance to bail out if you saw:
>=20
>   Merge 1003 commits from git://example.net/main.git master into my-f=
eature?
>=20
> because you forgot which branch you were on.

Yes, that might be nice. But we still need to change the defaults.

--=20
=46elipe Contreras