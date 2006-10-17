From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 17:32:19 +0200
Message-ID: <vpqodsbrm9o.fsf@ecrins.imag.fr>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<egr3ud$nqm$1@sea.gmane.org> <45340713.6000707@utoronto.ca>
	<Pine.LNX.4.64.0610161625370.3962@g5.osdl.org>
	<45345AEF.6070107@utoronto.ca> <45348B5E.8000404@op5.se>
	<4534E335.8070203@utoronto.ca> <4534F133.1090003@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
X-From: bazaar-ng-bounces@lists.canonical.com Tue Oct 17 17:34:00 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZqwx-00009C-TL
	for gcvbg-bazaar-ng@m.gmane.org; Tue, 17 Oct 2006 17:33:52 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1GZqwb-00087A-Eh; Tue, 17 Oct 2006 16:33:29 +0100
Received: from imag.imag.fr ([129.88.30.1])
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <Matthieu.Moy@imag.fr>) id 1GZqwY-000873-5Q
	for bazaar-ng@lists.canonical.com; Tue, 17 Oct 2006 16:33:26 +0100
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.6/8.13.6) with ESMTP id k9HFWPUF006634
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 17 Oct 2006 17:32:25 +0200 (CEST)
Received: from ecrins.imag.fr ([129.88.43.124])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50) id 1GZqvT-0004HW-B0; Tue, 17 Oct 2006 17:32:19 +0200
Received: from moy by ecrins.imag.fr with local (Exim 4.50)
	id 1GZqvT-00030E-7q; Tue, 17 Oct 2006 17:32:19 +0200
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <4534F133.1090003@op5.se> (Andreas Ericsson's message of "Tue\,
	17 Oct 2006 17\:05\:23 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6
	(imag.imag.fr [129.88.30.1]);
	Tue, 17 Oct 2006 17:32:28 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29087>

Andreas Ericsson <ae@op5.se> writes:

> This I don't understand. Let's say Alice has revision-154 in her repo,
> located at alice.example.com. Let's say that commit is accessible with
> the url "alice.example.com:revision-154". Bob pulls from her repo into
> his own, which is located at bob.example.com.

Another equation can help.

Revision Identity != Revision Number.

$ bzr log --show-ids
------------------------------------------------------------
revno: 1
revision-id: Matthieu.Moy@imag.fr-20061017152029-4c5a2861bcf23b7d
committer: Matthieu Moy <Matthieu.Moy@imag.fr>
branch nick: foo
timestamp: Tue 2006-10-17 17:20:29 +0200
message:
  some message


See, bzr has this unique revision identifier (not based on a hashsum).
The design choice of bzr is to hide it as much as possible from the
user interface.

Then, if I'm in the branch in which I typed this command, I can reffer
to this revision with simply

  bzr whatever -r 1

In the general case, I can access it with

  bzr whatever -r revid:Matthieu.Moy@imag.fr-20061017152029-4c5a2861bcf23b7d

(There's currently a lack in the UI to specify a remote revision-id,
but that's not a problem in the model itself)

bzr's internal use almost exclusively revision ID (ancestry
information is all about revision id), and revno are a UI layered on
top of it.

I don't have strong needs in revision control, but I actually never
encountered a case where I had to access a revision by providing its
ID. So, for people like me, revision numbers are sufficient, and they
are simple (for example, I can tell without running any command that
revision 42 is older than revision 56 in a particular branch).
