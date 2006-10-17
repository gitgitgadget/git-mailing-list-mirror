From: Aaron Bentley <aaron.bentley@utoronto.ca>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 18:28:28 -0400
Message-ID: <4535590C.4000004@utoronto.ca>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<200610172301.27101.jnareb@gmail.com>
	<45354AD0.1020107@utoronto.ca>
	<200610172351.17377.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: bazaar-ng-bounces@lists.canonical.com Wed Oct 18 00:28:42 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZxQP-0002L6-D6
	for gcvbg-bazaar-ng@m.gmane.org; Wed, 18 Oct 2006 00:28:41 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1GZxQO-0001KV-MQ; Tue, 17 Oct 2006 23:28:40 +0100
Received: from server4.panoramicfeedback.com ([66.216.124.41])
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <aaron.bentley@utoronto.ca>) id 1GZxQK-0001KL-92
	for bazaar-ng@lists.canonical.com; Tue, 17 Oct 2006 23:28:36 +0100
Received: from server4.panoramicfeedback.com ([66.216.124.41] helo=[127.0.0.1])
	by server4.panoramicfeedback.com with esmtp (Exim 3.36 #1 (Debian))
	id 1GZxQF-0004xW-00; Tue, 17 Oct 2006 18:28:31 -0400
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200610172351.17377.jnareb@gmail.com>
X-Enigmail-Version: 0.94.0.0
X-Panometrics-MailScanner: Found to be clean
X-BeenThere: bazaar-ng@lists.canonical.com
X-Mailman-Version: 2.1.8
Precedence: list
List-Id: bazaar-ng discussion <bazaar-ng.lists.canonical.com>
List-Unsubscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=unsubscribe>
List-Archive: <https://lists.ubuntu.com/archives/bazaar-ng>
List-Post: <mailto:bazaar-ng@lists.canonical.com>
List-Help: <mailto:bazaar-ng-request@lists.canonical.com?subject=help>
List-Subscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=subscribe>
Sender: bazaar-ng-bounces@lists.canonical.com
Errors-To: bazaar-ng-bounces@lists.canonical.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29126>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jakub Narebski wrote:
> Aaron Bentley wrote:

>> What is the bad side of using merge in this situation?
> 
> We want linear history, not polluted by merges. For example you cannot
> send merge commit via email.

Oh.  Bazaar supports sending merge commits by email.

> Another problem is that you want to
> send _series_ of patches, string of commits (revisions), creating feature
> part by part, with clean history; with merge you get _final result_
> which will apply cleanly, with rebase you would get that series
> of patches will apply cleanly.

Yes, that's something that I'd heard about the kernel development
methodology-- that a series of small patches is preferred to one patch
that makes the whole change.

That's not the way we operate.  We like to review all the changes at
once.  But because bundles are applied with a 'merge' command, not a
'patch' command, an old bundle will tend to apply more cleanly than an
old patch would.

> I smell yet another terminology conflict (although this time fault is
> on the git side), namely that in git terminology "pull" is "fetch"
> (i.e. getting changes done in remote repository since laste "fetch"
> or since "clone") followed by merge. pull = fetch + merge.

I guess so, since git merge will do fast-forward after a fetch.

>> and more.  Because Python supports monkey-patching, a plugin can change
>> absolutely anything.
> 
> Which is _not_ a good idea. Git is created in such way, that the repository
> is abstracted away (introduction of pack format, and improving pack format
> can and was done "behind the scenes", not changing any porcelanish (user)
> commands), but we don't want any chage that would change this abstraction.

I'm not sure what you think Bazaar does.  In Bazaar, a repository format
plugin  implements the same API that a native repository format does.

This is how bzr supports Subversion, Mercurial and Git repositories.

> Changing repository format is not a good idea for "dumb" protocols; 

I can't parse this.  Repository formats and protocols are different
things, right?

> native
> protocol is quite extensible

I was meaning dumb protocol extension.  I can't say how extensible the
bzr native protocol is.
> Adding
> cURL based FTP read-only support to existing HTTP support was a matter
> of few lines, if I remember correctly.

We support read and write over native, ftp and WebDAV (a plugin).  We
also have readonly http support.

> Besides, if monkey-patching is something akin to advices, I guess that
> performance might suffer.

No, monkey-patched code executes at the same speed as unpatched code.
There are arguments against monkey-patching, but speed is not one of them.

Aaron
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFNVkM0F+nu1YWqI0RAjCaAJwOcWSUdVy7RpUZROJVxAC9aj/V/wCfUg0T
uHkdc9k6i+v0QnhEvTXdszM=
=YO8G
-----END PGP SIGNATURE-----
