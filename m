From: Thomas Glanzmann <thomas@glanzmann.de>
Subject: Re: "git clone" executed as root on solaris 10 shreds UFS (it
	ispossible to create hardlinks for directories as root under
	solaris)
Date: Mon, 16 Jul 2007 19:12:08 +0200
Message-ID: <20070716171208.GC6134@cip.informatik.uni-erlangen.de>
References: <20070716100803.GA24036@cip.informatik.uni-erlangen.de> <20070716134529.GC26675@cip.informatik.uni-erlangen.de> <469B821E.85E5EDA9@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Mon Jul 16 19:12:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAU7K-0002XG-Qj
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 19:12:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759121AbXGPRML (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 13:12:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757984AbXGPRMJ
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 13:12:09 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:44263 "EHLO
	faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756579AbXGPRMJ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jul 2007 13:12:09 -0400
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id 2C97F3F434; Mon, 16 Jul 2007 19:12:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <469B821E.85E5EDA9@eudaptics.com>
User-Agent: Mutt/1.5.15 (2007-05-02)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52690>

Hello Johannes,

> Try swapping the two inner-most if-blocks.

I did and it works as expected:

        (faui04a) [/var/tmp] git clone ~sithglan/work/repositories/public/easix.git test-8
        Initialized empty Git repository in /var/tmp/test-8/.git/
        remote: Generating pack...
        remote: Done counting 317 objects.
        remote: Deltifying 317 objects...
        remote:  100% (317/317remote: ) done
        Indexing 317 objects...
        remote: Total 317 (delta 182), reused 278 (delta 157)
        100% (317/317) done
        Resolving 182 deltas...
        100% (182/182) done

        (faui04a) [/var/tmp] cd test-8
        ./test-8
        (faui04a) [/var/tmp/test-8] git status
        # On branch master
        nothing to commit (working directory clean)
        (faui04a) [/var/tmp/test-8] cd ..
        (faui04a) [/var/tmp] rm -rf test-8

... I have a filesystem to check. :-)

        Thomas
