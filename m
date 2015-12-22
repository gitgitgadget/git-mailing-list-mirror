From: Pierre-Luc Loyer <Pierre-Luc.Loyer@bhvr.com>
Subject: Git Rebase Issue
Date: Tue, 22 Dec 2015 17:53:42 +0000
Message-ID: <39E7EE9D306F544FAD3A0D16B7B7CAAD2C1E819D@mtlsvrmxwv02.A2M.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 22 19:09:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBRMq-0003dZ-OG
	for gcvg-git-2@plane.gmane.org; Tue, 22 Dec 2015 19:09:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755367AbbLVSI4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Dec 2015 13:08:56 -0500
Received: from mail.a2m.com ([207.253.225.40]:59643 "EHLO mtlsvraslv01.a2m.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754130AbbLVSI4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Dec 2015 13:08:56 -0500
X-Greylist: delayed 901 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Dec 2015 13:08:55 EST
X-AuditID: c0a81416-f794d6d000000ff2-7a-56798e1e1403
Received: from mtlsvrmxwv02.A2M.com (Unknown_Domain [192.168.10.13])
	by mtlsvraslv01.a2m.com (Symantec Messaging Gateway) with SMTP id 1D.FA.04082.E1E89765; Tue, 22 Dec 2015 12:53:34 -0500 (EST)
Received: from MTLSVRMXWV02.A2M.com ([::1]) by mtlsvrmxwv02.A2M.com ([::1])
 with mapi id 14.03.0248.002; Tue, 22 Dec 2015 12:53:42 -0500
Thread-Topic: Git Rebase Issue
Thread-Index: AdE84bIQFgMlL9wkRxO7f8ub1F14nw==
Accept-Language: fr-FR, en-CA, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.17.154]
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGLMWRmVeSWpSXmKPExsVyYAUXr65cX2WYwbnJshZdV7qZHBg9Pm+S
	C2CM4rJJSc3JLEst0rdL4Mp4eHkVe8FpwYq7n/+zNDBO5uti5OSQEDCRuDHtMROELSZx4d56
	NhBbSOAIo8S2PUJdjFxAdhejREPrF0aQBJuAkcS82zOBGjg4RAT0JfouiIKEhQUkJe49vswK
	YosIyEns+3IYytaTOP7nJpjNIqAqsWLxNBYQm1fAW+L59tNsIGMYBVQkTj4NBwkzC4hLfDu6
	khniHAGJJXvOQ9miEi8f/2OFsBUlGi5BjGQGGn9j6hQ2CFtbYtnC18wQ4wUlTs58wjKBUXgW
	krGzkLTMQtIyC0nLAkaWVYwiuSU5xWVFicU5ZQaGeolGuXrJ+bmbGMGhLSK2g/HjN61DjAIc
	jEo8vDM6KsOEWBPLiitzDzFKcDArifC+aQAK8aYkVlalFuXHF5XmpBYfYpTmYFES5/XPjQoR
	EkhPLEnNTk0tSC2CyTJxcEo1MOqpTvoz4/jSu9Hf2qI2HRNZ16dT72c73fBJ5j72no11qwtL
	P0/Lv3spcBLzbakeG3fzC6mSM2LTb2ovmn/5lLntNYewOM3PRY5lda+9v3FlN71edLn93SI2
	6bMMix7pfVl8j4E/w/fDP5Zw+8VpD77u/jKrOK2q+ULczpcCNvb8LJs7FCYFsSqxFGckGmox
	FxUnAgD2Aj6WaQIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282893>

Hi,

I've encountered a situation using rebase for which I don't understand =
the results, even after reading the documentation.
I'm currently working in my feature branch and then I want to squash co=
mmits, thus I use interactive rebase. After successfully completing the=
 rebase, I end up in a detached HEAD state, rather than back on my bran=
ch, which is confusing. The command that is causing me to be in detache=
d HEAD mode is: git rebase -i HEAD~2 HEAD
=46rom the documentation, I read that my second parameter (HEAD) is the=
 <branch> parameter:

=A0 =A0git rebase [-i | --interactive] [options] [--exec <cmd>] [--onto=
 <newbase>]

=A0 =A0[<upstream>] [<branch>]

=A0 =A0If <branch> is specified, git rebase will perform an automatic g=
it checkout <branch> before doing anything else. Otherwise it remains o=
n the current branch.
<branch> Working branch; defaults to HEAD.

=A0 =A0Upon completion, <branch> will be the current branch.

Here is a full example than can be used to easily repro the issue. Go t=
o an empty folder.
git init
git echo text > file.txt
git add .
git commit -m "Add file.txt"
git echo text2 > file.txt
git commit -am "Modify file.txt"
git echo text3 > file.txt
git commit -am "Remodify file.txt"

Now the interesting part:
$ git rebase -i HEAD~2 HEAD
[detached HEAD 9178b93] Modify file
1 file changed, 1 insertion(+), 1 deletion(-)
Successfully rebased and updated detached HEAD.=A0

=46rom the documentation it says that <branch> (which is HEAD) will be =
checked out before doing anything and that upon completion, <branch> wi=
ll be the current branch. However, this doesn't seem to happen. In fact=
, it seems more like the following is happening during the rebase:
1) detach HEAD
2) rebase
3) reattach to <branch>

If <branch> is HEAD, then is does nothing and remains detached.
I find this behavior confusing since I would expect it to return to wha=
tever HEAD was pointing to at the start of the command, such as my bran=
ch. Also, the documentation says that the <branch> parameter defaults t=
o HEAD, so passing 'HEAD' explicitly should result in the same behavior=
 as not passing it:
<branch> Working branch; defaults to HEAD.

Pierre-Luc Loyer
