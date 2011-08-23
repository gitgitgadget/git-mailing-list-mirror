From: Michael Witten <mfwitten@gmail.com>
Subject: Re: How to check out the repository at a particular point in time
Date: Tue, 23 Aug 2011 15:54:57 +0000
Message-ID: <CAMOZ1Bti3ZtAEOtLiUYSkWE+rO_VQd09NAn58Cn4hZBu8f-aFQ@mail.gmail.com>
References: <201108221525.32982.trast@student.ethz.ch> <1314026326.37332.YahooMailClassic@web25408.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>, in-git-vger@baka.org,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>, git@vger.kernel.org
To: rdiezmail-temp2@yahoo.de
X-From: git-owner@vger.kernel.org Tue Aug 23 17:55:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvtKE-0005OZ-3R
	for gcvg-git-2@lo.gmane.org; Tue, 23 Aug 2011 17:55:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752435Ab1HWPza convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Aug 2011 11:55:30 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:43015 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754221Ab1HWPz2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Aug 2011 11:55:28 -0400
Received: by gxk21 with SMTP id 21so192552gxk.19
        for <git@vger.kernel.org>; Tue, 23 Aug 2011 08:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=9Ma9N/9QJ8mh4ERa2252dt1SzUfR2JmFbvwx78E+Wjs=;
        b=MDXlBV5rW3XeJVOGzSjjToM993su/x0m/ihHcN3JD4A/ZACDP/nEOI+BCQXjk7wweY
         Zx6L8u+oXOM6OyeSUKUf7WvRE1lzX84CR2R14N0CitfgizBVwGd47uJ1ZuS0NQjOW/gq
         alw0YYC3iNHY63NIZtaXQpWSHLk1kMXUgAnGQ=
Received: by 10.43.52.1 with SMTP id vk1mr3738100icb.129.1314114927108; Tue,
 23 Aug 2011 08:55:27 -0700 (PDT)
Received: by 10.42.138.66 with HTTP; Tue, 23 Aug 2011 08:54:57 -0700 (PDT)
In-Reply-To: <1314026326.37332.YahooMailClassic@web25408.mail.ukl.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179942>

On Mon, Aug 22, 2011 at 15:18, R. Diez <rdiezmail-temp2@yahoo.de> wrote=
:
>> The main problem is that your request is not very
>> well-defined: in
>> nonlinear history there will in general be more than one
>> commit at the
>> time requested.
>>
>> =C2=A0 =C2=A0 ---a----b----c----M----=C2=A0=C2=A0(M is a merge)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 \=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 /
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0=C2=A0d-----e----f
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 ^----April 1st
>>
>> Suppose you ask git for "the newest commit as of April 1st"
>> in this history.=C2=A0 Is it supposed to give you b or d?
>
> I still don't quite understand how git works, but let me
> risk a naive statement here. If "a-b-c-M" were 'master',
> and "d-e-f" were 'new-feature', then on April 1st the
> current version on 'master' is 'b', because I merged the
> 'new-feature' branch at a later point in time. Does that
> make sense?

O! for the love all that is Holy!

You see, guys? The term `branch' was a TERRIBLE choice.

What git calls `branch master' in your example is just a pointer to
the commit object `M'; it has nothing to do with particular lineages
like `a-b-c-M'.

Please see my discussion with Hilco, starting here:

  http://marc.info/?l=3Dgit&m=3D131364675708355&w=3D2
  Message-ID: CAMOZ1BsZvXsnnWAPXR7UGKdqOMwuGB-ffaAPk55U_1dcjZUcDw@mail.=
gmail.com

and this email in particular:

  http://marc.info/?l=3Dgit&m=3D131396006222173&w=3D2
  Message-ID: CAMOZ1BvpnP_729YOHrrPW3B8wa5c4cLyD_qAQ5rTuy0JqNiiXg@mail.=
gmail.com

which also includes the following very germane link:

  http://slashdot.org/comments.pl?sid=3D2350536&cid=3D36903136
