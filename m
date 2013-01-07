From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/4] t0024, t5000: clear variable UNZIP, use GIT_UNZIP
 instead
Date: Sun, 6 Jan 2013 21:16:09 -0800
Message-ID: <20130107051609.GB27909@elie.Belkin>
References: <7vwqw7mb09.fsf@alter.siamese.dyndns.org>
 <50E9B82D.50005@lsrfire.ath.cx>
 <50E9B8CD.2010209@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git discussion list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon Jan 07 06:16:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ts54d-00073F-9i
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jan 2013 06:16:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750865Ab3AGFQQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Jan 2013 00:16:16 -0500
Received: from mail-pa0-f53.google.com ([209.85.220.53]:40056 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750781Ab3AGFQP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Jan 2013 00:16:15 -0500
Received: by mail-pa0-f53.google.com with SMTP id hz1so10421711pad.26
        for <git@vger.kernel.org>; Sun, 06 Jan 2013 21:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=RiSfqFwEz09EJobwAEAK35yeW4MUa7pA/uXvIV89crQ=;
        b=dGvEdIFIk+trG/8a0huIQ1PQE/yq5lTyCplPKgQeO9epVXGkEyCl+lTRBHxxEnUXoN
         BXm1YetXPE0kSp3c5kjIRBlfARF7jzKCM670yx8nY/tbsx4GZDyRlyKhzZ5b1Lkzq3ju
         lpdTJQ9sGOy6zJ5Sn4yX17nJ03VppxWO3VKKJG6bcnJ5mLhg35NFxOO2VZZn/jpBslP7
         qSw9jjPIje4TlHf3YYOW1xNm0gYEDRO8w0A89GayeAwcC8yovy7GjfXuQFz8BMcyFmdB
         UTwiiDZwirKxYHkYI6Q2+6VPsu4FC7EBvJwIM4f87mxcVPTLA6YL5WId97Ehxk9sTmFk
         QGiw==
X-Received: by 10.68.227.97 with SMTP id rz1mr183093730pbc.54.1357535773896;
        Sun, 06 Jan 2013 21:16:13 -0800 (PST)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id qh4sm36957712pbb.9.2013.01.06.21.16.11
        (version=SSLv3 cipher=OTHER);
        Sun, 06 Jan 2013 21:16:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <50E9B8CD.2010209@lsrfire.ath.cx>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212877>

Ren=C3=A9 Scharfe wrote:

> InfoZIP's unzip takes default parameters from the environment variabl=
e
> UNZIP.  Unset it in the test library and use GIT_UNZIP for specifying
> alternate versions of the unzip command instead.
>
> t0024 wasn't even using variable for the actual extraction.  t5000
> was, but when setting it to InfoZIP's unzip it would try to extract
> from itself (because it treats the contents of $UNZIP as parameters),
> which failed of course.

That would only happen if the UNZIP variable was already exported,
right?

The patch makes sense and takes care of all uses of ${UNZIP} I can
find, and it even makes the quoting consistent so a person can put
their copy of unzip under "/Program Files".  For what it's worth,

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
