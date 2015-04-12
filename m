From: "Jason Pyeron" <jpyeron@pdinc.us>
Subject: Finding leaf nodes.
Date: Sun, 12 Apr 2015 00:04:59 -0400
Organization: PD Inc
Message-ID: <038FFBDD688D4EC6B0B42A339DF246B0@black>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
To: "'GIT'" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 12 06:13:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yh9HO-0000El-P7
	for gcvg-git-2@plane.gmane.org; Sun, 12 Apr 2015 06:13:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750900AbbDLENu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Apr 2015 00:13:50 -0400
Received: from mail.pdinc.us ([67.90.184.27]:44999 "EHLO mail.pdinc.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750705AbbDLENt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Apr 2015 00:13:49 -0400
X-Greylist: delayed 527 seconds by postgrey-1.27 at vger.kernel.org; Sun, 12 Apr 2015 00:13:48 EDT
Received: from black (nsa1.pdinc.us [67.90.184.2])
	(authenticated bits=0)
	by mail.pdinc.us (8.14.4/8.12.11) with ESMTP id t3C450nV018731
	for <git@vger.kernel.org>; Sun, 12 Apr 2015 00:05:00 -0400
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AdB01dhCi/jiBDdVSgqt6n9/C/+xNg==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4913
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267036>

I am trying to find all the unmerged commits [5].

I can find, as a human, all the commits by git log --oneline --graph --all [1] but I am looking for a scripted way.

But git show-branch  -a --independent misses some [2]

find .git/refs/ -type f -exec cat '{}' ';' | sort -u; finds too much [3].

The closest I get is with refs=`git show-ref -s`; git log --format=%H $refs --not $(echo "$refs" | sed 's/$/^/') but it too [4] gives me extra, but I am really not sure why. 

* | a54a4fb 
* | a0d2e63 
* | dd4400d 
| | *   68ea2c8
| | |\
| |/ /
|/| |
| | * c74d3c5 ??? Why is this the only extra commit listed ???
| |/
|/|
* | 9c87570 
* | 717e33d 
* | 159799f 


What should I do to automate this?



1:
0748f668b7fe0cba7a0edf1684ae84ddf87104ee
13916782bebe690149bfd1c3fb31d6d08942585b
383f3ae77393c2e303b3c32ef7dee122f0b623be
473093c214ba578cd7aecb6e2e5caaad70d173e4
4d0579c438e9d750f158124284bd740a5a0e0e26
68ea2c83978a7c023d76ebe438dd7d98fb1fd074
6900b076d790593a909bc84a1d062217e4a32941
9802bc44da0a35e4c7a917cd23468c387897cccd
982243cfde0dc6dfb1733d8e95748b7e687f57b8
c197b7f71cd6d601b99adbe0a5cf5bf6bc749b6e
c4bc3c4eb0015c73b50ea280a4a380e3cffc5160
c5234422373d0425fa9cd610cb0848b7c33fe436
d6af1c103b0cdeb7e7d45ffce2a838fa7a287aea
eb50b82c6f3f55b66693482a913a5c1cfc19a03d
f9c41c1a17df4358558a23a7c45bc2c60bf97e27
Fb962761aa2ce6fbf77e4769c9e418bbe6f9f47f

2:
4d0579c438e9d750f158124284bd740a5a0e0e26
68ea2c83978a7c023d76ebe438dd7d98fb1fd074
982243cfde0dc6dfb1733d8e95748b7e687f57b8
C4bc3c4eb0015c73b50ea280a4a380e3cffc5160

3:
00ea00e8e6a23a4243316f860aa07ed59203ab97
144eb9f673f14010c600766762b99cba1a64cc6e
2250af4ad29b92b07365320c5ccb7a22c17f588e
26bdfdfe71f7ceb4e0954bc5ab6c198481a280ae
283be0f77477fcd8c8bc878c602538f8a3451403
2f47330df8fb0357ef4e4d605d5c402150892a18
3ec60ab0dbdc63760429187605ede4549d7b2bad
43813b0fc44f7c41d2cdd4573145dbeb1aae1aee
4d5b52d440d3a64953a6d7ef3cbb81c8d289e392
556a5c2d759b51080e3bfe07a89b67e927749328
6fe0b6db2718625e5eeb3cbadeb58aa858ab4f1b
717e33d67ad3297a15cb432d3f70f7c12d353fa3
7587a45658aa689cc774d7253007be3feb2eec23
ad9b5fa90c8f52b3ca31dd433c2c4b408e5f2a8f
b3d7623b74dd75cc4f965d6b37dc461d2786f912
c19fc45c87de85122952d63d28a0c7d3a18b79d5
e8529e95d89d3f519a31ef7de5bd7f0d0d318e8c
f2e86371e7fe3391023adccd61856d088db773dd
fceca0050ceee8c4996a5740f7122e96c4948dd8

4:
c74d3c5cda60d8be7f38f1ec89c554a1346d57f8

5: My remotes:
https://github.com/CipherShed/CipherShed.git
https://github.com/pdinc-oss/CipherShed.git
https://github.com/discnl/CipherShed.git
https://github.com/eaglgenes101/CipherShed.git
https://github.com/erkinalp/CipherShed.git
https://github.com/GigabyteProductions/CipherShed.git
https://github.com/jeffallen/CipherShed.git
https://github.com/kaydiechii/CipherShed.git
https://github.com/srguglielmo/CipherShed.git

--
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
-                                                               -
- Jason Pyeron                      PD Inc. http://www.pdinc.us -
- Principal Consultant              10 West 24th Street #100    -
- +1 (443) 269-1555 x333            Baltimore, Maryland 21218   -
-                                                               -
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
This message is copyright PD Inc, subject to license 20080407P00.
