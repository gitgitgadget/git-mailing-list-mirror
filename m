From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Mon, 23 Oct 2006 22:29:16 +0200
Message-ID: <200610232229.17426.jnareb@gmail.com>
References: <45357CC3.4040507@utoronto.ca> <453CF966.7000308@utoronto.ca> <20061023200648.GB31068@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Aaron Bentley <aaron.bentley@utoronto.ca>,
	James Henstridge <james@jamesh.id.au>,
	bazaar-ng@lists.canonical.com,
	"Matthew D. Fuller" <fullermd@over-yonder.net>,
	Linus Torvalds <torvalds@osdl.org>,
	Andreas Ericsson <ae@op5.se>, Carl Worth <cworth@cworth.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 23 22:29:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gc6Pu-0006fJ-7u
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 22:29:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbWJWU26 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 16:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbWJWU26
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 16:28:58 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:24473 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751175AbWJWU25 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Oct 2006 16:28:57 -0400
Received: by nf-out-0910.google.com with SMTP id c2so2526592nfe
        for <git@vger.kernel.org>; Mon, 23 Oct 2006 13:28:56 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=j9EO4mQFCe6nerYaAUzdYphAakVPQiYNXznjrV8BmHTROWO4IvSEODcewCXXpkutKJzUfbIbLsgxxcVHxuExLmNPPChlQo38wL0unmP0Zd1eWLPQfOrK53+QXV7JFEpn2YgqGbI/BH40saQplgDdgeLRNGHFKY5nCJW35O3Ho/s=
Received: by 10.49.10.3 with SMTP id n3mr7490949nfi;
        Mon, 23 Oct 2006 13:28:55 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110])
        by mx.google.com with ESMTP id q27sm2571446nfc.2006.10.23.13.28.54;
        Mon, 23 Oct 2006 13:28:55 -0700 (PDT)
To: Jeff King <peff@peff.net>
User-Agent: KMail/1.9.3
In-Reply-To: <20061023200648.GB31068@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29875>

On Mon, 23 Oct 2006, Jeff King wrote:
> On Mon, Oct 23, 2006 at 01:18:30PM -0400, Aaron Bentley wrote:
> 
>> And, unlike git, Bazaar branches are all independent entities[1], and
> [...]
>> [1] The fact that they may share storage is not important to the model.

By the way, git repositories (remember that working area in bzr is
associated with branch, and in git with repository) can share storage,
either sharing only immutable "old history" (part of DAG) via 
$GIT_DIR/objects/info/alternates file or GIT_ALTERNATE_OBJECT_DIRECTORIES
environment variable, or via having shared commit object database
via symlinking $GIT_DIR/objects directory or via setting 
GIT_OBJECT_DIRECTORY variable. 

Git doesn't support latter fully out of the box (you must be careful
with prune) but on the other side bzr doesn't support cloning whole
repository.
  
> It all Just Works because there _isn't_ any branch information. It's
> simply a pointer into the DAG, so if I have the right parts of the DAG
> (which git is careful to make sure of), I can just make a pointer, and I
> have absolutely zero connection to wherever the DAG came from.

Well, with exception of reflog, which is local to repository
(and doesn't get propagated).
 
>> they each have a URL.
> 
> In cogito, branches can each have a URL, but git-clone doesn't have a
> way (that I know of) to clone only a subset of branches. It would be
> fairly trivial to implement, I think.

On the other side Cogito doesn't have way to clone all the branches.

-- 
Jakub Narebski
Poland
