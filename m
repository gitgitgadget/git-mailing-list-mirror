From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Command-line interface thoughts
Date: Thu, 09 Jun 2011 11:06:56 +0200
Message-ID: <4DF08D30.7070603@alum.mit.edu>
References: <BANLkTikTWx7A64vN+hVZgL7cuiZ16Eobgg@mail.gmail.com> <m339jps1wt.fsf@localhost.localdomain> <BANLkTinidLbQ_FcVEiGSK91uXYWaKk7MKA@mail.gmail.com> <201106051311.00951.jnareb@gmail.com> <BANLkTik+xhd5QQ09QiPSH1bFAndzipKtrw@mail.gmail.com> <7vwrgza3i2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Scott Chacon <schacon@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Michael Nahas <mike@nahas.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 11:07:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUbCo-0002WZ-PH
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 11:07:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753503Ab1FIJHG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2011 05:07:06 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:55395 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753460Ab1FIJHE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2011 05:07:04 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p5996uNZ024106
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 9 Jun 2011 11:06:57 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.17) Gecko/20110424 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <7vwrgza3i2.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175508>

On 06/06/2011 08:16 AM, Junio C Hamano wrote:
> Scott Chacon <schacon@gmail.com> writes:
>> For example, implementation details aside, I think having something
>> like WTREE and NEXT available would help users understand that there
>> are these 3 trees that are important and useful in Git and re-inforce
>> a very non-SVN style workflow in that manner.
> 
> That's a funny thing to say. Working tree may almost always (to put it
> another way, "you could make it to") act like a tree, but the index does
> not act like a tree at all in more important situations.

My naive understanding is that in the case of a merge commit, the index
contains information equivalent to *multiple* trees:

NEXT -- HEAD plus the files that have been resolved
BASE -- the contents of the common ancestor
OURS -- equivalent to the tree from HEAD
THEIRS -- equivalent to the tree from MERGE_HEAD

If my understanding is correct, then it would be logical to allow *any*
of these pseudo-trees to participate in a "git diff" during a conflicted
merge.

If I'm incorrect, then I expect a learning-experience-by-flame :-)

FWIW, when I was learning git, I struggled with exactly the problems
that Michael is trying to address.  My most frustrating moments always
involved trying to get my working tree and index from some existing
state to some desired state, because operations that seemed (in my
mental model) to be similar typically required using entirely different
git commands and/or command options.  Having a uniform nomenclature for
these concepts would be a big improvement (if the resulting abstraction
does not leak too badly).  I also think that the proposal for "git put"
would be a great help and would work nicely with the proposed changes to
"git diff".

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
