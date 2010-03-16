From: Ben Finney <ben+bazaar@benfinney.id.au>
Subject: Re: Retrieve a specific file from some revision.
Date: Wed, 17 Mar 2010 09:48:14 +1100
Message-ID: <87eijjx4r5.fsf@benfinney.id.au>
References: <87vdcwxfit.fsf@newsguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: bazaar@lists.canonical.com
X-From: bazaar-bounces@lists.canonical.com Tue Mar 16 23:48:41 2010
Return-path: <bazaar-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from chlorine.canonical.com ([91.189.94.204])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <bazaar-bounces@lists.canonical.com>)
	id 1NrfZ2-000664-UO
	for gcvbg-bazaar-ng@m.gmane.org; Tue, 16 Mar 2010 23:48:41 +0100
Received: from localhost ([127.0.0.1] helo=chlorine.canonical.com)
	by chlorine.canonical.com with esmtp (Exim 4.69)
	(envelope-from <bazaar-bounces@lists.canonical.com>)
	id 1NrfZ0-0001eM-Fd; Tue, 16 Mar 2010 22:48:38 +0000
Received: from lo.gmane.org ([80.91.229.12])
	by chlorine.canonical.com with esmtp (Exim 4.69)
	(envelope-from <gcvbg-bazaar-ng@m.gmane.org>) id 1NrfYy-0001eG-AP
	for bazaar@lists.canonical.com; Tue, 16 Mar 2010 22:48:37 +0000
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvbg-bazaar-ng@m.gmane.org>) id 1NrfYw-00062s-4d
	for bazaar@lists.canonical.com; Tue, 16 Mar 2010 23:48:34 +0100
Received: from eth595.vic.adsl.internode.on.net ([150.101.214.82])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <bazaar@lists.canonical.com>; Tue, 16 Mar 2010 23:48:34 +0100
Received: from ben+bazaar by eth595.vic.adsl.internode.on.net with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <bazaar@lists.canonical.com>; Tue, 16 Mar 2010 23:48:34 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: eth595.vic.adsl.internode.on.net
X-Public-Key-ID: 0xBD41714B
X-Public-Key-Fingerprint: 9CFE 12B0 791A 4267 887F  520C B7AC 2E51 BD41 714B
X-Public-Key-URL: http://www.benfinney.id.au/contact/bfinney-gpg.asc
X-Post-From: Ben Finney <bignose+hates-spam@benfinney.id.au>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Cancel-Lock: sha1:gR3BU6uZAoNKPWsqX493wT3Dzm0=
X-Topics: everythingelse
X-BeenThere: bazaar@lists.canonical.com
X-Mailman-Version: 2.1.9
Precedence: list
List-Id: bazaar discussion <bazaar.lists.canonical.com>
List-Unsubscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar>,
	<mailto:bazaar-request@lists.canonical.com?subject=unsubscribe>
List-Archive: <https://lists.ubuntu.com/archives/bazaar>
List-Post: <mailto:bazaar@lists.canonical.com>
List-Help: <mailto:bazaar-request@lists.canonical.com?subject=help>
List-Subscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar>,
	<mailto:bazaar-request@lists.canonical.com?subject=subscribe>
Sender: bazaar-bounces@lists.canonical.com
Errors-To: bazaar-bounces@lists.canonical.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142357>

Harry Putnam <reader@newsguy.com> writes:

> I've never used any versioning tool but cvs.  Something I do often
> with cvs is retrieve a previous state of a single file..
>
> Say I wanted to use the hosts file as it was at revision 1.23.

I'll assume, from the Bazaar perspective, that this means “revno 123 of
the branch”. Bazaar tracks snapshot revisions of the working tree as a
whole, unlike CVS's per-file tracking.

> Not just a diff, but the actual file.
> (I would)
>   cd cvsrepo
>     cvs update -p -r1.23 <HOST>/etc/hosts > ~/hosts_HOST_r1.23
>
>   Would create the file as it was at rev. 1.23 for host HOST.
>
> How would I do that in bazaar/git? (which ever newsgroup this is on)

To get the file at revno 123 in the working tree for the branch (the
most normal place for it to appear):

    $ cd bzrbranch/
    $ bzr revert --revision 123 HOST/etc/hosts

You could then copy the file to wherever you actually want to use it.

Alternatively, if you really do want something that emits the file
contents to stdout rather than recreating the file:

    $ cd bzrbranch/
    $ bzr cat --revision 123 HOST/etc/hosts > ~/hosts_HOST_r123

The ‘--revision 123’ option is the verbose spelling of ‘-r 123’.

-- 
 \              “Whatever you do will be insignificant, but it is very |
  `\                    important that you do it.” —Mohandas K. Gandhi |
_o__)                                                                  |
Ben Finney
