From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Annotated branch =?UTF-8?B?4omIIGFubm90YXRlZCB0YWc/?=
Date: Wed, 28 Sep 2011 10:04:59 +0200
Message-ID: <4E82D52B.9020709@alum.mit.edu>
References: <7vy5xi4y3m.fsf@alter.siamese.dyndns.org> <1316729362-7714-1-git-send-email-gitster@pobox.com> <4E7C49CF.60508@drmicha.warpmail.net> <20110923201824.GA27999@sigill.intra.peff.net> <4E7DEC4A.3050900@drmicha.warpmail.net> <20110927215843.GE5176@sigill.intra.peff.net> <4E82A13B.2080509@alum.mit.edu> <CAH5451nT2Z6mBPkK4B2EgJAoMpf32bcc=7UqhTDnsw4-_hJwJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Andrew Ardill <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 28 10:05:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8p8s-0007Pr-Qq
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 10:05:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752268Ab1I1IFO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Sep 2011 04:05:14 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:39641 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751343Ab1I1IFK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2011 04:05:10 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p8S84xoH004208
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 28 Sep 2011 10:04:59 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.21) Gecko/20110831 Lightning/1.0b2 Thunderbird/3.1.13
In-Reply-To: <CAH5451nT2Z6mBPkK4B2EgJAoMpf32bcc=7UqhTDnsw4-_hJwJw@mail.gmail.com>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182300>

On 09/28/2011 09:12 AM, Andrew Ardill wrote:
> On 28 September 2011 14:23, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> [snip]
>>
>> [1] If the retention of annotation history were considered a
>> requirement, the annotation object could record as a "parent" the object
>> name of the annotation object that it is succeeding.  But I don't think
>> that this is a good idea; it would make branches too heavyweight and
>> every branch update would be recorded permanently, both of which are
>> contrary to the git philosophy.
> 
> If this was required, a better way would be to update the parent object only
> if the description changed. You would then have a nice little DAG that
> records changes to the description and could be used in 3-way merges etc.
> You would of course get lots of 'dead' annotation objects pointing to the
> previous change, however that shouldn't be too much of an issue.
> 
> At this point, however, I ask how is an annotation object any different to
> placing an annotation file in our repository. Perhaps there is no difference,
> except that one is a convention and the other is provided.

Yes, if history is being preserved, then the annotation objects would
not be much different than storing a file in the repository.  But even
then, there are differences:

- A branch annotation would be separate from the source code and not
appear in the working tree, which seems more appropriate for metadata.

- git and other tools would know where to find the annotation instead of
having to configure whether a particular project uses annotations and if
so where to find them.  This would make it easier to use the annotations
in git workflow like the generation of pull requests.

- The merge rules for annotations would be different than those for
other files.

But I believe that branch annotation history should *not* be retained,
so storing the annotations in the source tree is not even an option
(except perhaps in another artificial branch used only for annotations).

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
