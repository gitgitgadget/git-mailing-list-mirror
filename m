From: "Imran M Yousuf" <imyousuf@gmail.com>
Subject: Re: [jgit] index v2 pull request
Date: Mon, 10 Mar 2008 13:32:21 +0600
Message-ID: <7bfdc29a0803100032q6b30f16el97c021f3b051b944@mail.gmail.com>
References: <20080308025027.GZ8410@spearce.org>
	 <200803100051.55367.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	"Dave Watson" <dwatson@mimvista.com>
To: "Robin Rosenberg" <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon Mar 10 08:33:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYcVM-0007Vd-UJ
	for gcvg-git-2@gmane.org; Mon, 10 Mar 2008 08:33:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbYCJHcZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2008 03:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbYCJHcZ
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 03:32:25 -0400
Received: from mu-out-0910.google.com ([209.85.134.190]:59500 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751053AbYCJHcY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2008 03:32:24 -0400
Received: by mu-out-0910.google.com with SMTP id i10so6987001mue.5
        for <git@vger.kernel.org>; Mon, 10 Mar 2008 00:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=0iusGCVyAp6JMoRzLR4AtGeykGRdEk3YjBGTmXNSV64=;
        b=eIgXGIARD9/euaNZLr5ba+ZI9cNzRDTfgk0PZdvSFRLt6UTI1XE0YGuKtw6i1ugA5RjwP/Kz8d1OoErUjgy4V7dA1xqcWviBiXyn788y9bgwFlFkLCfIdgQ9MmDbT/ejqDGS+64dSW+/sub1MNCI4Pwvz2RkoqAWx2RfzowLep0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jCw0BdV1fj9PdEa6Z/NhSayvSpG3XbBlqxSNuJib/WGYTZbsHn9T33pvLOAPiAgavTWrHXppIIczxrqavQ4uuV7N3Xse8QyCvAQZ+KG3ZJc/0h1F6tgKZhmUY/rWz4ctVNmrQzcS9VOJ9LdW55HPfx+pcUOiwPEvUnhNo54y6Gk=
Received: by 10.78.204.20 with SMTP id b20mr12415813hug.60.1205134341870;
        Mon, 10 Mar 2008 00:32:21 -0700 (PDT)
Received: by 10.78.75.8 with HTTP; Mon, 10 Mar 2008 00:32:21 -0700 (PDT)
In-Reply-To: <200803100051.55367.robin.rosenberg@dewire.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76703>

I would like to volunteer to work in JGit;
can someone let me know where I can pick some tasks to implement?

Best regards,

Imran

On Mon, Mar 10, 2008 at 5:51 AM, Robin Rosenberg
<robin.rosenberg@dewire.com> wrote:
> Den Saturday 08 March 2008 03.50.27 skrev Shawn O. Pearce:
>
> > So I've started to hack on jgit again, to build out more of the lower
>  > level library.
>  Welcome back Shawn!
>
>
>  > This particular series adds support for pack file index v2, which
>  > Nico added to C Git several months ago and is slated to become the
>  > default pack index file format in a future release of Git, due to
>  > its increased error checking during delta reuse.
>  This i great news. I've been thinking about it, praying that you'd come
>  and do the work. :)
>
>
>  > We now actually use the following .git/config options to control
>  > how the window cache limits work:
>  >
>  >   core.packedGitWindowSize
>  >   core.packedGitLimit
>  >   core.deltaBaseCacheLimit
>  >   core.packedGitMMAP
>
>  Will the net effect, in practice, be the same on Jgit as on C Git?
>
>
>  >   repo.or.cz:/srv/git/egit/spearce.git master
>  Something missing in the formatting?
>
>
>  > Shawn O. Pearce (41):
>  >       Make the absolute path of a WindowedFile available to callers
>  >       Include the pack index file name when reporting a bad header
>  >       Report pack file open failures to the console
>  >       Refactor index reading code from PackFile to PackIndex
>  >       Rename PackIndex.readIndexHeader to loadVersion1
>  >       Read pack index files using FileInputStream and not WindowedFile
>  >       Don't bother checking the index file length after reading it
>  >       Move index:pack object count checking into PackFile class
>  >       Refactor PackIndex version 1 handling code into PackIndexV1
>  >       Fully document the PackIndex API
>  >       Hoist readFully and decodeUInt32 up from PackIndexV1 to PackIndex
>  >       Refactor PackIndex.readFully to support reading into the middle
>  >       Read the pack index header to perform automatic version detection
>  >       Add complete reading support for pack index v2
>  Yum, yum. My 15 minute review so far likes it.
>
> >       Stop creating "new format" loose objects as C Git no longer likes
>  > them Refactor RepositoryConfig to be stacked many levels deep
>  And there goes the unit test for reading them...
>
>
>  >       Don't make unit tests depend upon compressed file lengths
>  >       Corrected name of the method that reloads the packed-refs data
>  >       Cleanup misspelling in Javadoc of Repository class
>  >       Extract StGitPatch from Repository to its own top-level type
>  I'm considering dropping stacked git support. We should have much
>  more of it and I don't use it myself anymore to what support we have
>  gets very little testing.
>
>
>  >       Refactor RepositoryState into its own top-level type
>  \ No newline at end of file
>
>
>  >       Refactor PackFile construction to take the idxFile path from scan
>  >       Shuffle the length of a WindowedFile down into its provider
>  >       Defer opening pack files until we actually need object data
>  >       Use Java 5 bit twiddling APIs rather than hand-rolling bit counting
>  I'm surprised *you* didn't know about them bitcounting algorithm java uses
>  before. It's pretty common.
>
>
>  >       Support reading config file integers with k/m/g suffixes
>  >       Honor core.packedGitWindowSize, packedGitLimit, packedGitMMAP config
>  >       Enable easy access to the user's ~/.gitconfig
>  >       Use a single WindowCache for the entire Eclipse workspace
>  >       Modify the WindowedFile API to pass around a WindowCursor during reads
>  >       Change ByteWindow implementations to hold data by SoftReferences
>  >       Refactor WindowedFile/WindowCache so all windows are a uniform size
>  >       Simplify WindowCache and WindowedFile internal APIs to be private Use
>  a proper ReferenceQueue to avoid duplpicate window entries
>  >       New  RepositoryConfig getInt,getBoolean helper methods with no
>  subsection Change delta packed object loaders to use a PackedObjectLoader for
>  base Implement core.deltaBaseCacheLimit to improve unpacking performance
>  >       Remove unnecessary bitwise AND masks in readTree
>  Good catch
>
> >       Precount the number of tree entries during readTree
>  this one too
>
> >       Change the ObjectLoader.getType method to return int
>  >       Fix ArrayIndexOutOfBoundsException in WindowCache
>
>  Very good work (as always) Shawn. I've only read the code so far. I'll do some
>  testing too before pushing. Do you have any unit tests for the v2 pack format
>  (config reading too for that matter)?
>
>  -- robin
>
>
> --
>  To unsubscribe from this list: send the line "unsubscribe git" in
>  the body of a message to majordomo@vger.kernel.org
>  More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Imran M Yousuf
Entrepreneur & Software Engineer
Smart IT Engineering
Dhaka, Bangladesh
Email: imran@smartitengineering.com
Mobile: +880-1711402557
