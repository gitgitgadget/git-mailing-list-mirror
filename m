From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: git bisect; is there a way to pick only from the children of a given commit
Date: Fri, 3 Jul 2009 06:42:35 +0200
Message-ID: <200907030642.36314.chriscool@tuxfamily.org>
References: <loom.20090701T170535-707@post.gmane.org> <BLU0-SMTP20683A1D7E5DEC1370D496AE2E0@phx.gbl> <4A4CA06B.8090403@solarflare.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Robert Stonehouse <rstonehouse@solarflare.com>
X-From: git-owner@vger.kernel.org Fri Jul 03 06:42:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMabT-0000lt-5R
	for gcvg-git-2@gmane.org; Fri, 03 Jul 2009 06:42:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751520AbZGCEmR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2009 00:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbZGCEmQ
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Jul 2009 00:42:16 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:60397 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750901AbZGCEmP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2009 00:42:15 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 7759081808C;
	Fri,  3 Jul 2009 06:42:10 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 52C8D81808F;
	Fri,  3 Jul 2009 06:42:08 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <4A4CA06B.8090403@solarflare.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thursday 02 July 2009, Robert Stonehouse wrote:
>
> In my toy example it is easy to identify featureB branch as being
> independent and marking it as good - but in a real repository it would
> be much harder as they might be many more merges.

As Jakub said, when the current commit is untestable, "git bisect skip" is 
the most logical command to use.

Now if you have more information than just "the current commit is 
untestable", for example if you know that the current commit is on a side 
branch that has work unrelated to the breakage you are looking for, and if 
you know that the branch started from a "good" commit, then you can 
use "git bisect good" instead, because you know the commit is good even if 
you have not tested it.

> I think if I changed my usage of git bisect good and bad to:
>    good => build completes
>            OR a revision that does not have the new build target
>    bad  => new build target fails
> then I think it will converge to the problem commit. So perhaps this was
> just an issue of semantics

I'd say that it's an issue of information. If you already have the 
information that some commits are good before testing them, then you should 
use "git bisect good" even if you can't test them.

Best regards,
Christian.
