From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Tests in Cygwin
Date: Fri, 08 May 2009 08:02:38 +0200
Message-ID: <4A03CAFE.4060503@viscovery.net>
References: <83prfbhasp.fsf@kalahari.s2.org> <4A01E64C.7050703@SierraAtlantic.com> <7vvdoet13g.fsf@alter.siamese.dyndns.org> <4A028A0A.5070003@viscovery.net> <4A030277.2000708@SierraAtlantic.com> <20090508020037.GA1264@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Don Slutz <Don.Slutz@SierraAtlantic.com>,
	Junio C Hamano <gitster@pobox.com>,
	Hannu Koivisto <azure@iki.fi>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 08 08:02:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2JAe-00015k-R8
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 08:02:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752641AbZEHGCt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2009 02:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751516AbZEHGCt
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 02:02:49 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:2387 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751141AbZEHGCs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2009 02:02:48 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1M2JAN-0000tE-0N; Fri, 08 May 2009 08:02:45 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id B9D1A4E4; Fri,  8 May 2009 08:02:38 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <20090508020037.GA1264@coredump.intra.peff.net>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118566>

Jeff King schrieb:
> On Thu, May 07, 2009 at 11:47:03AM -0400, Don Slutz wrote:
> 
>> Here is a change back to using spaces.  It also includes a change
>> to test for the code working.  Squash on top.
> 
> Maybe it is just me, but I think
> 
>   test_expect_success SYMLINKS,SANITY 'some description' '
>     the actual test
>   '
> 
> is more readable than the space (since it keeps the number of single
> quoted chunks on the line down). Which should be as simple as:
> 
>> -# prerequisites can be concatenated with '+'
>> test_have_prereq () {
>> -       save_IFS=$IFS
>> -       IFS=+
>> -       set -- $*
>> -       IFS=$save_IFS
>> -       for prerequisite
>> +       for prerequisite in $(echo $*)
>>        do
>>                case $satisfied in
>>                *" $prerequisite "*)
> 
>   +for prerequisite in $(echo "$1" | tr , ' ')

So, you dislike the space separator, but you also dislike the IFS games
that save a few new processes? ;) (Think of Windows, where fork is expensive).

-- Hannes
