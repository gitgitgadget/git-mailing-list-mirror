From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [GSoC] What is status of Git's Google Summer of Code 2008 projects?
Date: Tue, 8 Jul 2008 09:39:30 +0200
Message-ID: <200807080939.31216.jnareb@gmail.com>
References: <200807080227.43515.jnareb@gmail.com> <7vmyktxjlq.fsf@gitster.siamese.dyndns.org> <20080708014734.GE6726@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Tue Jul 08 09:40:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KG7oZ-0003MQ-3R
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 09:40:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752483AbYGHHjq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 03:39:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751913AbYGHHjp
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 03:39:45 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:34869 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751453AbYGHHjp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 03:39:45 -0400
Received: by ug-out-1314.google.com with SMTP id h2so1166339ugf.16
        for <git@vger.kernel.org>; Tue, 08 Jul 2008 00:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=ia8Jza1DKGm3xNdShhYr7hCokeerPAFsp6lAE6hwSzg=;
        b=IgDVRmWbgW5BO9zib6ymsr8lIuzQJzMualYTwzxf1CSbsfJ4RyLQ7CQAcl2ieSOTQn
         TpL2Pax14f7wFLaiOIvp2NPAmYkKe+AajKvBO4WN0FlLfo9GcbUtJtr2cZRvus6ecyg7
         KVzexb9kBDVjT8F4BLsvq4haw1GgicHlnXLUY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=LcNRoPmlfDlbEykjr8YPnx9jnJGjhxsnrztTkMaQOFZCOlpp/ifmZrj6/e2rrWlO3q
         kY3ZS37Md4pZni3x7kPgBJU9oDN46IRG+a8WAFp0UgMEa7aMIZtF7lVp3Pk6NHkiKTNN
         y58aOwwEceo4mW4WsrEm/HarUsxX2lAqCzSlE=
Received: by 10.66.238.16 with SMTP id l16mr5138267ugh.19.1215502783521;
        Tue, 08 Jul 2008 00:39:43 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.206.62])
        by mx.google.com with ESMTPS id j3sm2479343ugd.30.2008.07.08.00.39.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 08 Jul 2008 00:39:42 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20080708014734.GE6726@leksak.fem-net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87727>

On Tue, 8 July 2008, Stephan Beyer wrote:
> Junio C Hamano <gitster@pobox.com> wrote:
>> 
>> I _really_ wanted to merge the basic bits and rewrite of "am" at least to
>> pu tonight, but I had to drop them after noticing that it does not seem to
>> handle --rebasing at all (it parses to set $rebasing but after that where
>> does that bit go?
> 
> Yes, you are right that am --rebasing is a no-op.
> That option was a little mystery to me, because it seemed to do nothing
> special, but I'll check again (bash-completion etc) and do appropriate
> changes.

Undocumented option '--rebasing' to git-am is internal option changing
git-am behavior to be better used by git-rebase, namely it does not
change commit message even if it doesn't follow git commit message
convention, for example if it begins not with single line summary
of commit, separated by empty line, but by multi-line paragraph.
See also t/t3405-rebase-malformed.sh

Although I am not sure if when rebase is rewritten using git-sequencer
implementing "git am --rebasing" would be truly needed.  On the other
hand side it would be nice to have some _documented_ option which would
allow to git-am mail messages with commits not following git commit
messages convention...

-- 
Jakub Narebski
Poland
