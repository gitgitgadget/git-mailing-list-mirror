From: Mike Hommey <mh@glandium.org>
Subject: Re: Getting a commit sha1 from fast-import in a remote-helper
Date: Wed, 19 Nov 2014 11:27:59 +0900
Message-ID: <20141119022759.GA9818@glandium.org>
References: <20141118003426.GA6528@glandium.org>
 <20141118014028.GF4336@google.com>
 <20141118023112.GA14034@glandium.org>
 <20141118025131.GH4336@google.com>
 <20141118031147.GA15358@glandium.org>
 <20141119021824.GA9094@glandium.org>
 <20141119022121.GU6527@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 19 03:28:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xqv0A-00074h-UJ
	for gcvg-git-2@plane.gmane.org; Wed, 19 Nov 2014 03:28:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753741AbaKSC2J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 21:28:09 -0500
Received: from ks3293202.kimsufi.com ([5.135.186.141]:51552 "EHLO glandium.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752006AbaKSC2I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 21:28:08 -0500
Received: from glandium by zenigata with local (Exim 4.84)
	(envelope-from <glandium@glandium.org>)
	id 1Xquzv-0002ZM-BM; Wed, 19 Nov 2014 11:27:59 +0900
Content-Disposition: inline
In-Reply-To: <20141119022121.GU6527@google.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 18, 2014 at 06:21:22PM -0800, Jonathan Nieder wrote:
> Mike Hommey wrote:
> 
> > So, in the end, I was able to do everything with what's currently
> > provided by git fast-import, but one thing would probably make life
> > easier for me: being able to initialize a commit tree from a commit
> > that's not one of the direct parents.
> 
> IIRC then 'M 040000' wants a tree object, not a commit object, so
> you'd have to do
> 
> 	ls <commit> ""
> 	M 040000 <tree> ""

That's what I'm planning to try ; Would doing:
M 040000 <tree> ""
M 0644 <blob> some/path
D other/path

work? Or do I have to actually build a tree from the combination of the
output from various ls and those filedelete/filemodify?

Mike
