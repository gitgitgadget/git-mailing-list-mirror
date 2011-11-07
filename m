From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/3] t9350: point out that refs are not updated correctly
Date: Mon, 7 Nov 2011 03:32:49 -0600
Message-ID: <20111107093249.GD30641@elie.hsd1.il.comcast.net>
References: <1320535407-4933-1-git-send-email-srabbelier@gmail.com>
 <1320535407-4933-2-git-send-email-srabbelier@gmail.com>
 <20111106043157.GM27272@elie.hsd1.il.comcast.net>
 <CAGdFq_hmF8xDA8PdDUPygSSAVsvrA=BRVKp+eCVRggHxLZzBsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Eric Herman <eric@freesa.org>,
	Fernando Vezzosi <buccia@repnz.net>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 07 10:33:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNLZb-0007TA-6E
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 10:32:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752067Ab1KGJcz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Nov 2011 04:32:55 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:52524 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751734Ab1KGJcy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Nov 2011 04:32:54 -0500
Received: by ywf7 with SMTP id 7so5073409ywf.19
        for <git@vger.kernel.org>; Mon, 07 Nov 2011 01:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=9qB1Sx81H3bzdCljrpQXtC2h35Fhhml+xypOd4N4aEM=;
        b=Law1PhfDWt8646EOhYGl4JdLh7ix15w4HkdzBAqvjNTG8m9nW72uAEm/Zj4iiB3G8W
         LUcL44+IgmJYwn4b4h0QTTE72klQHtk/xtcxu4TRFNhcH3DptbgZu5kxBPCQ/7jwOYj/
         pe9rMTQ/hkwD14lvckLXa/HEM0r+SmA0BTEuw=
Received: by 10.42.151.196 with SMTP id f4mr45453301icw.17.1320658373282;
        Mon, 07 Nov 2011 01:32:53 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id n30sm37415868ibl.4.2011.11.07.01.32.51
        (version=SSLv3 cipher=OTHER);
        Mon, 07 Nov 2011 01:32:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAGdFq_hmF8xDA8PdDUPygSSAVsvrA=BRVKp+eCVRggHxLZzBsQ@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184964>

Sverre Rabbelier wrote:
> On Sun, Nov 6, 2011 at 05:31, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:

>>> as they use marks
>>> files to store which commits have already been seen. The call graph
>>> is something as follows:
[...]
>>> $ # run `git branch foo` and push it to remote
>>> $ git fast-export --{im,ex}port-marks=3Dmarksfile foo
>>>
>>> When fast-export imports the marksfile and sees that all commits in
>>> foo are marked as UNINTERESTING
>>
>> Hmm, I didn't know about this behavior. =C2=A0Would it be possible t=
o add
>> a test for it, too?
>
> What behavior are you referring to here? What kind of test would you =
want added?

I meant I hadn't remembered that marks result in commits being marked
as UNINTERESTING (even though the manpage warned me), and that it's
possible a priori that fast-export could be broken when you run

	git fast-export --import-marks=3Dmarksfile master

even without breaking

	git fast-export master..master

But don't worry about it --- I can try it as a follow-on when this
series next visits the list if that doesn't sound like fun. :)

=46WIW, with the clarifications to the commit message Junio made, I'm
happy with this patch.
