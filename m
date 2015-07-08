From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v2 0/9] icase match on non-ascii
Date: Wed, 8 Jul 2015 13:32:31 +0200
Message-ID: <559D0A4F.9040307@web.de>
References: <1436186551-32544-1-git-send-email-pclouds@gmail.com>
 <1436351919-2520-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: plamen.totev@abv.bg, l.s.r@web.de,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 08 13:32:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCnar-0006Ui-0j
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 13:32:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754513AbbGHLck convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Jul 2015 07:32:40 -0400
Received: from mout.web.de ([212.227.17.11]:56995 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754487AbbGHLci (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2015 07:32:38 -0400
Received: from macce.local ([213.66.56.100]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0M9GVO-1ZIsPP2GGU-00CehU; Wed, 08 Jul 2015 13:32:33
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.0.1
In-Reply-To: <1436351919-2520-1-git-send-email-pclouds@gmail.com>
X-Provags-ID: V03:K0:EV2ilkTyC/MOrHQUIX0cj4VGH/fv7djvxz3z9Pw0xuCBk5VL2id
 0wdQENl/uHhYsFJtJkksNRi/Ux5kPqWJwtkofBH/OitHHkCoRvDAm0uSkvhnuuPMQ+x88pt
 H7I6TZswK6+CYReMHQ7ELlyxjkFnJnC5TVdXm+akvvYUyU9yiPzkO+XvzQaTWtN2+N+sEf6
 s/ExFhemcSpUs9/rqZhkw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:iSgrIYY+4RQ=:y+PljzSW9vvlrsZixuazks
 oaFNwEI3pbf3CUGR+KNL6VF7AygZNTK9FfaQCuZn4gTZmgAjPbmlt4iLEmaDP0J57YgQe979q
 NOtM6dcxmBByKAd0x+8oiG+f5285uixhAb+9Ax80N723cTDf6LZYFvprsuPINarM+j1V5oBfW
 1FpoYHSTAA4rfcLn6pR/CakQ3RyFrYOdvMHNOZuk9H8NskgobRYqpgENgDD0gqls751Iqs4RI
 8oF7j4+7XIpa3v3FtP5DacQURi8oP9l+HHdIpPMVAYcPquynMO7vVZt97EWWsiKLYE1GsqBu7
 hkUf3GfLtoWzSOcZ0gThfV5bMVkLWJnEIm1pQzk5hyOU8Pd2rG5QPUdKhPTSWWlpF1jTw9gRi
 hOuyWuoXWx9NyDMNhPWgdS7pr00Am8a3+oZjajtfwuI+ErJ3zSKRaKj9jO0y5cVDwZwkquKvn
 P1S6XrgNLpK7pijwytENXFQBAjOBVmUPAz+GUsOA8Lq5Ag+SGx6vQ7GJCL+FudWj1fOKgMw1o
 Q+nH2hEL4QjhoPW8Jczw+mAxOTVHlIVZxY7glsEsDWicWDLOQs3T/KOStJC5K/eNY6P+ipGVN
 Fq/Ep7P6Asz8L4qkugko8VU9Q75iNrJM09x1/0wOtpNY8s6ohtCsxJ8jDRiXT9rVVmEgR4JSW
 Ht7+Rgx2Wc6K5VRxhcYMkqdE0Y185S7vETEmStHKhecR2915y5/Nq/ogR4+AGSh4xbx0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273671>

On 2015-07-08 12.38, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> Side note, I almost added the third has_non_ascii() function. Maybe w=
e
> should consider merging the two existing has_non_ascii() functions
> back, or rename one to something else.
>
Side question:

has_non_ascii can mean different things:
 UTF-8, ISO-8859-1, ISO-8859-x...

In short: everything.
Should we be more critical here ?

May be this can be used from commit.c:
static int verify_utf8(struct strbuf *buf)

Other question:
Should the "non-ascii" characters in the test scripts be octal-escaped =
?

Third question:
What happens on systems, which don't have gettext, (for whatever reason=
s)
--- a/gettext.c
+++ b/gettext.c
@@ -166,12 +166,17 @@ void git_setup_gettext(void)
textdomain("git");
}

+int is_utf8_locale(void)
+{
+ return !strcmp(charset, "UTF-8");
+}


4th question:
What happens on systems which don't have locale support at all ?


As one may suspect, I'm not a friend of being dependent on gettext and/=
or
locale, at least not for this kind of business.

Would it make more sense to have a command line option ?
