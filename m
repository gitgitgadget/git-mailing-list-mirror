From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 2/3] pretty: make %H/%h dependent on
 --abbrev[-commit]
Date: Sun, 25 Apr 2010 22:41:35 -0500
Message-ID: <20100426034135.GB30544@progeny.tock>
References: <1272232579-18895-1-git-send-email-wmpalmer@gmail.com>
 <1272232579-18895-2-git-send-email-wmpalmer@gmail.com>
 <1272232579-18895-3-git-send-email-wmpalmer@gmail.com>
 <20100426031012.GA29953@progeny.tock>
 <20100426033147.GB14421@coredump.intra.peff.net>
 <20100426033813.GA30544@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Will Palmer <wmpalmer@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 26 05:40:54 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6FBj-0001wp-Bv
	for gcvg-git-2@lo.gmane.org; Mon, 26 Apr 2010 05:40:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754511Ab0DZDkq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Apr 2010 23:40:46 -0400
Received: from mail-qy0-f179.google.com ([209.85.221.179]:46706 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754504Ab0DZDkq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Apr 2010 23:40:46 -0400
Received: by qyk9 with SMTP id 9so16650128qyk.1
        for <git@vger.kernel.org>; Sun, 25 Apr 2010 20:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=rkJSmuIfa9bGJKQn0zJ9oCInNacxjrBYR2kDj5xWfTo=;
        b=kVfWL6a04JvwqdlAUzmWBa5ZEDcU0/D1gyJYNVQrRVQtaArShi16ZzAU1RMTHD5qEL
         4V1atvzkbsz9Oa2xJFfowJI43iu8R6xLgxr42OqxNd3xfAofc2vIx/NiYM3pc48ModPP
         GXZ46PjN8DSQmoQl6lgWonElBedoYU54gOF8k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=ujMEnEjnUTQ62fa+FkZDiAWgKcOl7No2cA9xdfJ6ehkhltuVk28nOo5fQ18UEOzV59
         18Aq+VN0cPUUlr115IyIxw/zILER8qfIdQIH9/yvtwr705oyxODZ6/zQJh6adn1/h6iq
         kjQ52Ep53A3yJ9XmUYk8b7Oba1G5Ylod5+oxc=
Received: by 10.224.88.40 with SMTP id y40mr1006903qal.383.1272253245235;
        Sun, 25 Apr 2010 20:40:45 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm2750750iwn.0.2010.04.25.20.40.44
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 25 Apr 2010 20:40:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100426033813.GA30544@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145784>

Jonathan Nieder wrote:
> Jeff King wrote:
>> On Sun, Apr 25, 2010 at 10:11:37PM -0500, Jonathan Nieder wrote:

>>> +static void abbreviate_commit_hashes(char *fmt)
>>> +{
>>> +	char *p;
>>> +	for (p =3D fmt; p !=3D NULL; p =3D strchr(p + 1, '%')) {
>>> +		p++;
>>> +		switch (*p) {
>>> +		case 'H':
>>> +			*p =3D 'h';
>>> +			break;
>>> +		case 'P':
>>> +			*p =3D 'p';
>>> +			break;
>>> +		case 'T':
>>> +		default:
>>> +			break;
>>> +		}
>>> +	}
>>> +}
>>
>> You parse '%%H' incorrectly.
>
> I=E2=80=99m pretty sure I don=E2=80=99t.

Aggh, I see it now.  The first line should be

 for (p =3D strchr(fmt, '%'); ...

as I would have noticed with even a little testing.

Sorry for the nonsense.
Jonathan
