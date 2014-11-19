From: Mike Hommey <mh@glandium.org>
Subject: Re: Getting a commit sha1 from fast-import in a remote-helper
Date: Wed, 19 Nov 2014 11:18:24 +0900
Message-ID: <20141119021824.GA9094@glandium.org>
References: <20141118003426.GA6528@glandium.org>
 <20141118014028.GF4336@google.com>
 <20141118023112.GA14034@glandium.org>
 <20141118025131.GH4336@google.com>
 <20141118031147.GA15358@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 19 03:18:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xquqr-0004UX-Tl
	for gcvg-git-2@plane.gmane.org; Wed, 19 Nov 2014 03:18:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754174AbaKSCSe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 21:18:34 -0500
Received: from ks3293202.kimsufi.com ([5.135.186.141]:51494 "EHLO glandium.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753668AbaKSCSd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 21:18:33 -0500
Received: from glandium by zenigata with local (Exim 4.84)
	(envelope-from <glandium@glandium.org>)
	id 1Xquqe-0002Vh-Hz; Wed, 19 Nov 2014 11:18:24 +0900
Content-Disposition: inline
In-Reply-To: <20141118031147.GA15358@glandium.org>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 18, 2014 at 12:11:47PM +0900, Mike Hommey wrote:
> Oh, so `ls <dataref>` would print out what <dataref> is? That would
> definitely help, although with the trick above, I probably wouldn't
> actually need it anymore.

So, in the end, I was able to do everything with what's currently
provided by git fast-import, but one thing would probably make life
easier for me: being able to initialize a commit tree from a commit
that's not one of the direct parents.

Because the data I'm using gives diffs against possibly unrelated
commits, and because starting a tree from scratch is actually slow when
you have thousands of subdirectories, it would be easier if I could just
start from that tree I have a diff against and apply the changes.
Without this, there would be a lot of `ls` command emitting involved,
and I'm actually not sure that wouldn't be as slow as starting from
scratch (haven't implemented yet, so I can't tell). Also, I'm not sure
how I'm supposed to know how much to read back from `ls`.

Mike
