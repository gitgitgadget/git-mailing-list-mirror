From: Phillip Susi <psusi@ubuntu.com>
Subject: Re: cherry-pick generates bogus conflicts on removed files
Date: Fri, 18 Oct 2013 09:25:33 -0400
Message-ID: <526136CD.6080903@ubuntu.com>
References: <52604166.8000501@ubuntu.com> <xmqqiowvy4zb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 18 15:25:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VXA3i-0001TP-46
	for gcvg-git-2@plane.gmane.org; Fri, 18 Oct 2013 15:25:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754726Ab3JRNZh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Oct 2013 09:25:37 -0400
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:36761 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753836Ab3JRNZf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Oct 2013 09:25:35 -0400
X-Authority-Analysis: v=2.0 cv=bevpoZzB c=1 sm=0 a=/DbS/tiKggfTkRRHPZEB4g==:17 a=Qsx_du5GiBkA:10 a=sCfsyOEanakA:10 a=renhaF8A0_UA:10 a=S1A5HrydsesA:10 a=8nJEP1OIZ-IA:10 a=fxJcL_dCAAAA:8 a=KGjhK52YXX0A:10 a=TgfdxlmYmHsA:10 a=QfKxxUxMAAAA:8 a=PddOF7XZCu5vcgwqAx8A:9 a=wPNLvfGTeEIA:10 a=/DbS/tiKggfTkRRHPZEB4g==:117
X-Cloudmark-Score: 0
X-Authenticated-User: 
X-Originating-IP: 67.78.168.186
Received: from [67.78.168.186] ([67.78.168.186:56977] helo=[10.1.1.236])
	by cdptpa-oedge04.mail.rr.com (envelope-from <psusi@ubuntu.com>)
	(ecelerity 2.2.3.46 r()) with ESMTP
	id BC/58-13545-DC631625; Fri, 18 Oct 2013 13:25:33 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <xmqqiowvy4zb.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236349>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 10/17/2013 5:14 PM, Junio C Hamano wrote:
> Correct.
> 
> Without inspecting them, you would not know what you would be
> losing by blindly resolving to removal, hence we do not
> auto-resolve "one side removed, the other side changed" to a
> removal.

Even when I specify the "theirs" strategy?  It seems like saying to
unconditionally accept their changes should not generate conflicts.

> That does not need to mean that we should not make it easier for
> the user to say "resolve these 'one side removed, the other side 
> changed' paths to removal".
> 
> "add -u" will be a way to say "Record the changes I made to my 
> working tree files to the index".  So presumably
> 
> rm -f those files that the other branch removed git add -u
> 
> would be one way to do so.  Of course, you can also use "git rm" 
> directly, i.e.
> 
> git rm -f those files that the other branch removed

I have about two dozen such files.  Are you saying I have to
individually remove each one?


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJSYTbNAAoJEJrBOlT6nu752lAH/33YymYr773UZY8ryioA7dkQ
he3qjYzxWdIY2FtNFfYER1o1Q7PpeDLvq61b67IZ2htFjiK4+xgM/q+wjp3RMkXI
sA2vQ9iNn8dvR+PlzR9DgOFcDD17p3Q/xbu3H/M4Nt+H3px+Yz6sjUUSOzDAzXl8
ADQe0g4KkQnY4fjx+iWbrygY5xXCaQ52693pwYvR67GijfYxIuNb4d9DpkZhyqIZ
L6qjJH4FR1AZl6n5hPj0a9ZitrO8J/MjJ24oLVBfBU2h1GF5h7LoavkU02S874BZ
/8fULrCYfTCMSkyOCnk2xCkhw3sbqU9vEu90npI5X1nRbZZ0ro/DPAjXCgHB40c=
=EB2w
-----END PGP SIGNATURE-----
