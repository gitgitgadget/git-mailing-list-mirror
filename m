From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 0/4] grep: add more information to hunk separators
Date: Mon, 26 Mar 2012 18:16:43 +0200
Message-ID: <4F70966B.4050107@lsrfire.ath.cx>
References: <1332729705-9283-1-git-send-email-lodatom@gmail.com> <7vr4wgq6zm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Lodato <lodatom@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 26 18:16:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCCbC-00081a-Tc
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 18:16:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932927Ab2CZQQr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Mar 2012 12:16:47 -0400
Received: from india601.server4you.de ([85.25.151.105]:33445 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932866Ab2CZQQp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2012 12:16:45 -0400
Received: from [192.168.2.105] (p4FFD9672.dip.t-dialin.net [79.253.150.114])
	by india601.server4you.de (Postfix) with ESMTPSA id 0D7B12F8038;
	Mon, 26 Mar 2012 18:16:44 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:11.0) Gecko/20120312 Thunderbird/11.0
In-Reply-To: <7vr4wgq6zm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193923>

Am 26.03.2012 07:14, schrieb Junio C Hamano:
> Mark Lodato<lodatom@gmail.com>  writes:
>
>> Originally, I had envisioned also moving the function name (`-p') to=
 the hunk
>> header, similar to the diff context line.  For example:
>>
>>      -- git.c:570 -- int main(int argc, char argv)
>>                      printf("usage: %s\n\n", git_usage_string);
>>                      list_common_cmds_help();
>>                      printf("\n%s\n", git_more_info_string);
>>
>> After implementing this feature, I was not happy with the result and
>> subsequently removed it.  To me, the output was too cluttered and th=
e line
>> number was ambigous.  For example, in the above, it is not obvious t=
o me that
>> line 570 is the "printf" line and not the "int main" line.  Still, i=
f you
>> would like to see the patch to implement this feature, please let me=
 know.
>
> The worst part of all of the above is that the output becomes utterly
> ambiguous and the reader cannot tell if "-- git.c..." came because th=
e
> file had such a line that begin with two dashes in it and grep found =
it,
> or it is your output format embellishment. It is obvious that these a=
re
> not meant to be machine parseable, but if the goal is to make the out=
put
> more useful to the humans, then it may be a better approach to come u=
p
> with a front end that reads our machine readable output and shows out=
put
> with its own embellishments. You could even make it an interactive fr=
ont
> end.

Human readers can differentiate between contents and heading by color;=20
separators are cyan by default.

A separate frontend would probably have to implement match highlighting=
=20
again.  That's not too hard, but a bit sad.

> In other words, I am not yet convinced this belongs to "git grep" pro=
per.

All in all, I'm not sure either.  But I think the idea to deduplicate=20
the meta-information and give found content more screen real estate is =
a=20
good one in general.

Ren=E9
