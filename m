From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/4] t5002: check if unzip supports symlinks
Date: Wed, 9 Jan 2013 23:36:29 -0800
Message-ID: <20130110073629.GC5121@elie.Belkin>
References: <7vwqw7mb09.fsf@alter.siamese.dyndns.org>
 <50E9B82D.50005@lsrfire.ath.cx>
 <50E9BB8B.9020101@lsrfire.ath.cx>
 <20130107085206.GI27909@elie.Belkin>
 <50EAFCD7.9090008@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git discussion list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu Jan 10 08:36:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtCh6-0007vm-Do
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jan 2013 08:36:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932388Ab3AJHgg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Jan 2013 02:36:36 -0500
Received: from mail-da0-f43.google.com ([209.85.210.43]:43065 "EHLO
	mail-da0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932254Ab3AJHgg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Jan 2013 02:36:36 -0500
Received: by mail-da0-f43.google.com with SMTP id u36so124028dak.30
        for <git@vger.kernel.org>; Wed, 09 Jan 2013 23:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=H3MWpASDisvtZ38KWQCezHP0wFJgctqfiKUJL7QyTUM=;
        b=PG4sXAgpk6QQCeGW3LTwWjEdW9RPgCgzpVx5X9y9jp/b8mRPJQe3+O+7nitfffNF+R
         l3XTXaTBPuib1WM/vmqhkQx0cow0EDRWWt4f9an+VajlRvA6oMGbzPuME3fOZhcElvOl
         OUXcvlJfRYY8vasETZ0Jsl2QCyLUuf/y9XHo3e7T9Y/p7OZFTd4TKSeuxBIjHWQDD5JI
         qpVq/kwPtZUHDKr3Z47Vn1teeYHeWj76DIz7Onaq31moMNqVMO1BSIUIaHmIjs7Z8pzy
         frCBMM/HevWVJcOeBgld8Le1CW7Zl6FklRXJNELEqYmRus/h8zbfnXl/fF8WSU6xSabm
         hk4Q==
X-Received: by 10.66.73.225 with SMTP id o1mr197075630pav.70.1357803395640;
        Wed, 09 Jan 2013 23:36:35 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id i1sm620258pav.35.2013.01.09.23.36.33
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 09 Jan 2013 23:36:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <50EAFCD7.9090008@lsrfire.ath.cx>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213127>

Ren=C3=A9 Scharfe wrote:
> Am 07.01.2013 09:52, schrieb Jonathan Nieder:

>> Hm.  Do some implementations of "unzip" not support symlinks, or is
>> the problem that some systems build Info-ZIP without the SYMLINKS
>> option?
>
> The unzip supplied with NetBSD 6.0.1, which is based on libarchive, d=
oesn't
> support symlinks.  It creates a file with the link target path as its=
 only
> content for such entries.

Ok, that makes sense.  A quick search finds
<https://code.google.com/p/libarchive/issues/detail?id=3D104>, which if
I understand correctly was fixed in libarchive 3.0.2.  NetBSD 6 uses a
patched 2.8.4.

[...]
> For the test script there is no difference: If we don't have a tool t=
o
> verify symlinks in archives, we better skip that part.

Yeah, I just wanted to see if there were other parts of the world that
needed fixing while at it.  Thanks for explaining.

Ciao,
Jonathan
