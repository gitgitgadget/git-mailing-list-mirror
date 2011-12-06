From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Evaluation of ref-api branch status
Date: Tue, 06 Dec 2011 06:46:50 +0100
Message-ID: <4EDDAC4A.4030805@alum.mit.edu>
References: <4EDAB62E.5070204@alum.mit.edu> <7vfwgynacr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git discussion list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 06 06:47:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXnro-000475-E5
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 06:47:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751929Ab1LFFq4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Dec 2011 00:46:56 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:37871 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751744Ab1LFFqz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2011 00:46:55 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.133] (p54BECDC9.dip.t-dialin.net [84.190.205.201])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pB65kpfw007636
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 6 Dec 2011 06:46:52 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 Thunderbird/3.1.15
In-Reply-To: <7vfwgynacr.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186316>

On 12/05/2011 07:26 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
>> Now that 1.7.8 is out, I wanted to figure out the status of the
>> remaining ref-api changes that are in flight, including the differences
>> between between my tree and yours.
> 
> I understand that the ultimate and largest objective of these series is to
> make sure that the performance does not suffer from very many negative
> lookups on the refs/replace hierarchy (which almost always is empty in a
> sane repository), and I do want to see that happen. I also think it is
> good that the series tries to make sure that the various codepaths we
> create new refs do not let the user accidentally create refs with bad
> names and/or contents.
> 
> When we see a questionable ref that is _already_ in the respository,
> however, we may warn but it is wrong to declare the repository to be
> broken and refuse to work. [...]  I
> would want to see us get this part right and solid, and include it in
> 1.7.9.
> [...]
> 
> Alternatively you _could_ swap the order of your B & C and D and try to
> have your D early while giving B & C more time to cook, but I suspect the
> order you chose would be better in the longer term.

I will evaluate whether this is feasible.

>> I understand that "next" will soon be re-rolled.  Will the re-roll be
>> based on the current "pu", or will you start from scratch?
> 
> As to the two quickfix patches that are on two remaining topics from you
> in my tree, I did them merely as a short-term band-aid. I was expecting,
> after 1.7.8 when we eject the topics out of 'next', that they will be
> rebased on top of 'master' that already contains a proper fix before these
> topics started touching the same codepath.
> 
> My reading of your summary suggests that it would be easiest to drop the
> three mh/ref-api* topics from my tree, especially the 'refs: loosen
> over-strict "format" check' band-aid patches, and re-queue a re-roll from
> you.

OK, then, I will try to re-roll the series on top of master, and build
the equivalent of your quick-fix into the logical point in the series.
I will also check whether it is feasible to push more of the refname
sanity checks to later in the series and make them more informational
where old data is concerned.  How much time to I have to work on this
while still leaving enough time to comfortably integrate it into 1.7.9?

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
