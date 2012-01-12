From: Abscissa <bus_nabble_git@semitwist.com>
Subject: Re: SVN -> Git *but* with special changes
Date: Thu, 12 Jan 2012 13:52:18 -0800 (PST)
Message-ID: <1326405138283-7181897.post@n2.nabble.com>
References: <20110928190445.GC1482@sigill.intra.peff.net> <1325999031923-7163706.post@n2.nabble.com> <20120108051051.GA10129@sigill.intra.peff.net> <1325999865995-7163737.post@n2.nabble.com> <1326000327637-7163752.post@n2.nabble.com> <20120108103303.GC2714@centaur.lab.cmartin.tk> <m2hb06mpwn.fsf@linux-m68k.org> <20120108120807.GA7360@angband.pl> <1326061722334-7165979.post@n2.nabble.com> <1326065910362-7166084.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 12 22:52:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlSZN-00037s-VN
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 22:52:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755882Ab2ALVwU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jan 2012 16:52:20 -0500
Received: from sam.nabble.com ([216.139.236.26]:56594 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754972Ab2ALVwU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2012 16:52:20 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <bus_nabble_git@semitwist.com>)
	id 1RlSZG-0000D7-9p
	for git@vger.kernel.org; Thu, 12 Jan 2012 13:52:18 -0800
In-Reply-To: <1326065910362-7166084.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188484>

I'm trying to do it manually with git-svn, but I'm getting the same problem.
I have two different SVN repos I want to do (turns out neither have
branches, I had thought they did, but one of them does have tags). Doing
this:

git svn clone {the url to the SVN repo} --prefix=svn/ --preserve-empty-dirs
--authors-file={already prepared authors file} --trunk=trunk --tags=tags

It gets partway through, and then gives me:

Failed to strip path '{some path}/.gitignore' ((?-xism:^trunk(/|$)))

Where {some path} is an empty dir in the trunk of one repo, and a completely
non-existent path in the other. (In both cases I'm looking at the revision
git-svn had gotten to when bailing, plus the revision before and the
revision after).

I don't have a clue what that error message is trying to tell me or what is
going wrong. :(

If it helps, these are the repos I'm trying to convert:

http://svn.dsource.org/projects/semitwist   (git svn clone fails at r46 (out
of 242) on 'src/nonFatalAssertTest/.gitignore')
http://svn.dsource.org/projects/goldie   (git svn clone fails at r85 (out of
557) on 'bin/lang/.gitignore')

(Yes, they do have a non-standard top-level "downloads" directory, but
that's just how that host does file downloads, and I *don't* need to
preserve it)


--
View this message in context: http://git.661346.n2.nabble.com/SVN-Git-but-with-special-changes-tp6840904p7181897.html
Sent from the git mailing list archive at Nabble.com.
