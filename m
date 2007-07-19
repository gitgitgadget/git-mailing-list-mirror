From: "Adam Hayek" <adam.hayek@gmail.com>
Subject: Re: [REVISED PATCH 2/6] Introduce commit notes
Date: Thu, 19 Jul 2007 03:57:06 -0600
Message-ID: <46aec1580707190257i6e2f7e4bte61748a67549e434@mail.gmail.com>
References: <Pine.LNX.4.64.0707152326080.14781@racer.site>
	 <Pine.LNX.4.64.0707160022560.14781@racer.site>
	 <7vejj96igx.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0707190258550.14781@racer.site>
	 <alpine.LFD.0.999.0707181949490.27353@woody.linux-foundation.org>
	 <7vfy3l3rj0.fsf@assigned-by-dhcp.cox.net>
	 <7vodi83fg7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 19 11:57:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBSlO-0002Zb-PL
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 11:57:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764701AbXGSJ5S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 05:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761424AbXGSJ5R
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 05:57:17 -0400
Received: from nz-out-0506.google.com ([64.233.162.237]:15263 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764773AbXGSJ5P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 05:57:15 -0400
Received: by nz-out-0506.google.com with SMTP id s18so437853nze
        for <git@vger.kernel.org>; Thu, 19 Jul 2007 02:57:07 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=f7wp68TUQ1fRWViWOey+zNnBj+s+V7TwcqHVEnKmrAJHR1/4qdOTkKckxP7ATikSHjpVwE/sRTVpjs5/7eWhsOm/8l1JnW1kThYvPbVjCRU/8Iv2YW88WbwzuJ0At+0+wLlCmUFG6AK0t5VccJru0hlf7uqSL2WuLbDpxCUfjmM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=U5VkoQ8q70uGNqGoP7CgBEZePp796Vt1oAMOwT63Y3Ip0hJIDtVJoC5e6BtMvM3khwusVyiQYqaxXIN8vTlXv2TZp+2SNM/E7eRRW3jYEv3k/U1HQa2eO5QsTDdLs9TZiuKWRRLwv4ITq+sZ6WonK79k0Vo5eo9uGN5QH5ok3yA=
Received: by 10.114.123.1 with SMTP id v1mr2393186wac.1184839026808;
        Thu, 19 Jul 2007 02:57:06 -0700 (PDT)
Received: by 10.115.33.3 with HTTP; Thu, 19 Jul 2007 02:57:06 -0700 (PDT)
In-Reply-To: <7vodi83fg7.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52959>

On 7/19/07, Junio C Hamano <gitster@pobox.com> wrote:
> Side note: I also think adding "extension section" to tree
> object is not a good idea to begin with.  The data nor length of
> such a section cannot participate in hash computation to derive
> the tree's object name so that we can still compare two tree
> objects (with and without such extension) that have the same
> contents by only looking at their object names.  But having
> contents that are not counted as parts of the object's name goes
> against the reliability and safety of git.

Excuse me for being brand new to this list and to git itself, but if
the issue is where to put "extra" data to go along with a given object
there should be a relatively simple way to do it.  If your object's
hash/name is X, take the string ("%s-extra", X), hash that, and use
the resulting hash as the name of the file to store whatever extra
data you have.  There would be the issue of when and how to move this
new file when the original file is moved, but old versions of git at
least wouldn't break, they'd just never know about the extra data in
the separate file.  Of course you could do endless variations of this
to store whatever classes of extra data separately.
