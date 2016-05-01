From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 1/6] connect: remove get_port()
Date: Sun, 1 May 2016 12:10:09 +0200
Message-ID: <e1056272-8c0e-0a0b-2295-4653a47cf86f@web.de>
References: <1462082573-17992-1-git-send-email-mh@glandium.org>
 <1462082573-17992-2-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, tboegi@web.de
To: Mike Hommey <mh@glandium.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 12:11:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awoLh-0001pP-7O
	for gcvg-git-2@plane.gmane.org; Sun, 01 May 2016 12:11:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbcEAKKt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 May 2016 06:10:49 -0400
Received: from mout.web.de ([212.227.15.4]:59660 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750893AbcEAKKs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2016 06:10:48 -0400
Received: from macce.local ([195.252.60.88]) by smtp.web.de (mrweb002) with
 ESMTPSA (Nemesis) id 0Lzaxm-1bjZEz2HeE-014nBV; Sun, 01 May 2016 12:10:15
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:45.0)
 Gecko/20100101 Thunderbird/45.0
In-Reply-To: <1462082573-17992-2-git-send-email-mh@glandium.org>
X-Provags-ID: V03:K0:cpkrshESYZjUmUmVw2u76wCbTfJJoZsFj1/lW0WpNG33rZtfzZ5
 XEFTsVy17NZoOayjeTW/cG4rpQtK7FNis466RJzycOJbeM4h76gC1pys4TSmPE6HYA/Xt8c
 RDr4E/EA+G1aeFX6/KsPDh1HtYoucJMWvOVsqMbUFh0n1Ji+CC6Avld7U1oA08rvRTTGl49
 qvKUW6DS+sEs09PGGVYtg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9QCXrWYfft8=:lj+KCigCl3vyF2u+X1jgJf
 xDj0OfY5rjsoN8xb5jXBtwgE5Q053hGrfHFaK5Nu/QUaXDnBf/Tf7ZJ5r6RaYDp0c8uomBd/Z
 WiUPFlkI2lLbe7rS1sYrRNTVuim6Ep4BnlVLrCP71qwsfLp+COQbwITqw+BIc6rFGSXYIUsXr
 bcF2HhVGb6B0GObGKf2JtDUWKm//NY6zIO0EBsilBrrAipJ7l2/Z+qOC7ECSD+jZBcZwnE6lh
 lJN/Q/4/noa2nLSHmp8dWaFC0Lj4kRYCin+PrQc2qnphSKR4f7/Qkcjpf+vGqD2oXdgQ9IlmB
 YSW+Q4yIjeIZeZA0xqM78u971ddV3JN8/eb4mfQno16YaWqbjsWbuBYtd04+jFcuH1ryI0x7j
 6+gWW8HziwrlexrWv0Ghcv0zGRLjSk/zfS/EB6uDIcuIzJCOXIp8S/yMTKVQ7zHVBxxPJpuUJ
 TgGTEJ805YHJjhdNxXqvV/98RCUsLpEtUgTta6iCITiQf06OediMj9ByuoOCJnQb/PYqNOwr+
 ljOBhfGo1lQduJu6qRbc3CDlfIYPjWMynETj3XAWe5ap4R8VmgKk/ChIqHBvzhnC7nzqjogSv
 Jvttg8vQ37AvgPtF58ZTpPFniFP5y1DrHEerikesGkETR8Gmjbo+tJlp7521x+D7WAlT4cdDC
 ewC7mbtPyBVgZlVrnyxvb9vKIeO8kILuwN70jDyxNQQoK2R17QEcznU4MHPZElhzZXJigFmKH
 aTw13XS1dhyI1Ik8ljQxNYtcgMa0UZp270JtCdBmc8JwK2hV1mde7hyZFBW9q4b4U56BGpKX 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293147>

On 2016-05-01 08.02, Mike Hommey wrote:
> get_port() is only used as a fallback when get_host_and_port() does not
> return a port. But get_port() does the same search as
> get_host_and_port(), except get_host_and_port() starts from the end of
> the host, respecting square brackets for ipv6 addresses, and get_port(),
> operating after get_host_and_port(), works on a modified host string
> that has square brackes removed if there were any.
typo: brackets.
> 
> I cannot think of any legal host:port string that would not have a port
> returned by get_host_and_port() *and* have one returned by get_port().
> So just remove get_port().
> 
> Signed-off-by: Mike Hommey <mh@glandium.org>
Does this pass the test-suite ?
It doesn't pass here, t5601:

not ok 39 - bracketed hostnames are still ssh
#
#               git clone "[myhost:123]:src" ssh-bracket-clone &&
#               expect_ssh "-p 123" myhost src
#
not ok 40 - uplink is not treated as putty
#
#               copy_ssh_wrapper_as "$TRASH_DIRECTORY/uplink" &&
#               git clone "[myhost:123]:src" ssh-bracket-clone-uplink &&
#               expect_ssh "-p 123" myhost src
#
not ok 41 - plink is treated specially (as putty)
#
#               copy_ssh_wrapper_as "$TRASH_DIRECTORY/plink" &&
#               git clone "[myhost:123]:src" ssh-bracket-clone-plink-0 &&
#               expect_ssh "-P 123" myhost src
#
not ok 42 - plink.exe is treated specially (as putty)
#
#               copy_ssh_wrapper_as "$TRASH_DIRECTORY/plink.exe" &&
#               git clone "[myhost:123]:src" ssh-bracket-clone-plink-1 &&
#               expect_ssh "-P 123" myhost src
#
not ok 43 - tortoiseplink is like putty, with extra arguments
