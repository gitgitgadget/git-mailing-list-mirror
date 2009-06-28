From: Mike Dornberger <Mike.Dornberger@gmx.de>
Subject: Problem cloning over ssh with git submodule and tags
Date: Sun, 28 Jun 2009 19:20:52 +0200
Message-ID: <20090628172052.GA23365@wolfden.dnsalias.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="45Z9DzgjV8m4Oswq"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 28 19:49:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKyVT-0003bq-2Y
	for gcvg-git-2@gmane.org; Sun, 28 Jun 2009 19:49:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754061AbZF1Rs4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jun 2009 13:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752958AbZF1Rs4
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Jun 2009 13:48:56 -0400
Received: from p57A2565C.dip.t-dialin.net ([87.162.86.92]:2953 "EHLO
	wolfden.dnsalias.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751865AbZF1Rsz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jun 2009 13:48:55 -0400
X-Greylist: delayed 1680 seconds by postgrey-1.27 at vger.kernel.org; Sun, 28 Jun 2009 13:48:53 EDT
Received: from furrywolf by wolfden.dnsalias.net with local (Exim 4.50)
	id 1MKy3g-00067X-VM
	for git@vger.kernel.org; Sun, 28 Jun 2009 19:20:53 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122414>


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

I have a problem with submodule in v1.6.3.3:

The following sequence gives me error messages and I can't clone a
repository over ssh (for details see the attached typescript):

git submodule add git://git.kernel.org/pub/scm/git/git.git git
cd git
git checkout v1.6.3.3
cd ..
git add git # because it's modified
git commit -m 'added submodule git @ tag v1.6.3.3'

cd ..

git clone dornberg@dong101:tmp/test sshclonetest
error: git-upload-pack: git-pack-objects died with error.
fatal: git-upload-pack: aborting due to possible repository corruption on the remote side.
remote: Generating pack...
remote: Done counting 7 objects.
remote: error: unable to find cff4231a1dfbe68b4a163b31406d862567d3243a
remote: fatal: unable to get type of object cff4231a1dfbe68b4a163b31406d862567d3243a
remote: aborting due to possible repository corruption on the remote side.
fatal: early EOF
fatal: index-pack failed

 # cff423... is the v1.6.3.3 tag in the git submodule

git clone test localclonetest
 # this works though

If I change the URL in localclonetest/.git/config to
ssh://dornberg@dong101/path/to/testrepo I can do normal pulls from the
repo. (Haven't tried to change the git submodule to another tag or
something else yet, though.)

Let me know if I shall try out something. (I'm not subscribed to the
mailing list.)

Greetings,
 Mike Dornberger

--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=typescript
Content-Transfer-Encoding: quoted-printable

Script started on So 28 Jun 2009 18:51:54 CEST
dornberg@dong101:~$ cd tmp=0D
dornberg@dong101:~/tmp$ mkdir test=0D
dornberg@dong101:~/tmp$ cd test/=0D
dornberg@dong101:~/tmp/test$ git init=0D
Initialized empty Git repository in /users/sfb555/dornberg/tmp/test/.git/=0D
dornberg@dong101:~/tmp/test$ git submodule add git://git.kernel.org/pub/scm=
/git/ =0Dgit.git git=0D
Initialized empty Git repository in /users/sfb555/dornberg/tmp/test/git/.gi=
t/=0D
remote: Counting objects: 7372   =1B[K=0Dremote: Counting objects: 17643   =
=1B[K=0Dremote: Counting objects: 101062, done.=1B[K=0D
remote: Compressing objects:   0% (1/26903)   =1B[K=0Dremote: Compressing o=
bjects:   1% (270/26903)   =1B[K=0Dremote: Compressing objects:   2% (539/2=
6903)   =1B[K=0Dremote: Compressing objects:   3% (808/26903)   =1B[K=0Drem=
ote: Compressing objects:   4% (1077/26903)   =1B[K=0Dremote: Compressing o=
bjects:   5% (1346/26903)   =1B[K=0Dremote: Compressing objects:   6% (1615=
/26903)   =1B[K=0Dremote: Compressing objects:   7% (1884/26903)   =1B[K=0D=
remote: Compressing objects:   8% (2153/26903)   =1B[K=0Dremote: Compressin=
g objects:   9% (2422/26903)   =1B[K=0Dremote: Compressing objects:  10% (2=
691/26903)   =1B[K=0Dremote: Compressing objects:  11% (2960/26903)   =1B[K=
=0Dremote: Compressing objects:  12% (3229/26903)   =1B[K=0Dremote: Compres=
sing objects:  13% (3498/26903)   =1B[K=0Dremote: Compressing objects:  14%=
 (3767/26903)   =1B[K=0Dremote: Compressing objects:  15% (4036/26903)   =
=1B[K=0Dremote: Compressing objects:  15% (4274/26903)   =1B[K=0Dremote: Co=
mpressing objects:  16% (4305/26903)   =1B[K=0Dremote: Compressing objects:=
  17% (4574/26903)   =1B[K=0Dremote: Compressing objects:  18% (4843/26903)=
   =1B[K=0Dremote: Compressing objects:  19% (5112/26903)   =1B[K=0Dremote:=
 Compressing objects:  20% (5381/26903)   =1B[K=0Dremote: Compressing objec=
ts:  21% (5650/26903)   =1B[K=0Dremote: Compressing objects:  22% (5919/269=
03)   =1B[K=0Dremote: Compressing objects:  23% (6188/26903)   =1B[K=0Dremo=
te: Compressing objects:  24% (6457/26903)   =1B[K=0Dremote: Compressing ob=
jects:  25% (6726/26903)   =1B[K=0Dremote: Compressing objects:  26% (6995/=
26903)   =1B[K=0Dremote: Compressing objects:  27% (7264/26903)   =1B[K=0Dr=
emote: Compressing objects:  28% (7533/26903)   =1B[K=0Dremote: Compressing=
 objects:  29% (7802/26903)   =1B[K=0Dremote: Compressing objects:  30% (80=
71/26903)   =1B[K=0Dremote: Compressing objects:  31% (8340/26903)   =1B[K=
=0Dremote: Compressing objects:  32% (8609/26903)   =1B[K=0Dremote: Compres=
sing objects:  33% (8878/26903)   =1B[K=0Dremote: Compressing objects:  34%=
 (9148/26903)   =1B[K=0Dremote: Compressing objects:  35% (9417/26903)   =
=1B[K=0Dremote: Compressing objects:  36% (9686/26903)   =1B[K=0Dremote: Co=
mpressing objects:  37% (9955/26903)   =1B[K=0Dremote: Compressing objects:=
  38% (10224/26903)   =1B[K=0Dremote: Compressing objects:  39% (10493/2690=
3)   =1B[K=0Dremote: Compressing objects:  40% (10762/26903)   =1B[K=0Dremo=
te: Compressing objects:  41% (11031/26903)   =1B[K=0Dremote: Compressing o=
bjects:  42% (11300/26903)   =1B[K=0Dremote: Compressing objects:  43% (115=
69/26903)   =1B[K=0Dremote: Compressing objects:  44% (11838/26903)   =1B[K=
=0Dremote: Compressing objects:  45% (12107/26903)   =1B[K=0Dremote: Compre=
ssing objects:  46% (12376/26903)   =1B[K=0Dremote: Compressing objects:  4=
7% (12645/26903)   =1B[K=0Dremote: Compressing objects:  48% (12914/26903) =
  =1B[K=0Dremote: Compressing objects:  49% (13183/26903)   =1B[K=0Dremote:=
 Compressing objects:  50% (13452/26903)   =1B[K=0Dremote: Compressing obje=
cts:  51% (13721/26903)   =1B[K=0Dremote: Compressing objects:  52% (13990/=
26903)   =1B[K=0Dremote: Compressing objects:  53% (14259/26903)   =1B[K=0D=
remote: Compressing objects:  54% (14528/26903)   =1B[K=0Dremote: Compressi=
ng objects:  55% (14797/26903)   =1B[K=0Dremote: Compressing objects:  56% =
(15066/26903)   =1B[K=0Dremote: Compressing objects:  57% (15335/26903)   =
=1B[K=0Dremote: Compressing objects:  58% (15604/26903)   =1B[K=0Dremote: C=
ompressing objects:  59% (15873/26903)   =1B[K=0Dremote: Compressing object=
s:  60% (16142/26903)   =1B[K=0Dremote: Compressing objects:  61% (16411/26=
903)   =1B[K=0Dremote: Compressing objects:  62% (16680/26903)   =1B[K=0Dre=
mote: Compressing objects:  63% (16949/26903)   =1B[K=0Dremote: Compressing=
 objects:  64% (17218/26903)   =1B[K=0Dremote: Compressing objects:  65% (1=
7487/26903)   =1B[K=0Dremote: Compressing objects:  66% (17756/26903)   =1B=
[K=0Dremote: Compressing objects:  67% (18026/26903)   =1B[K=0Dremote: Comp=
ressing objects:  68% (18295/26903)   =1B[K=0Dremote: Compressing objects: =
 69% (18564/26903)   =1B[K=0Dremote: Compressing objects:  70% (18833/26903=
)   =1B[K=0Dremote: Compressing objects:  71% (19102/26903)   =1B[K=0Dremot=
e: Compressing objects:  72% (19371/26903)   =1B[K=0Dremote: Compressing ob=
jects:  73% (19640/26903)   =1B[K=0Dremote: Compressing objects:  74% (1990=
9/26903)   =1B[K=0Dremote: Compressing objects:  75% (20178/26903)   =1B[K=
=0Dremote: Compressing objects:  76% (20447/26903)   =1B[K=0Dremote: Compre=
ssing objects:  77% (20716/26903)   =1B[K=0Dremote: Compressing objects:  7=
8% (20985/26903)   =1B[K=0Dremote: Compressing objects:  79% (21254/26903) =
  =1B[K=0Dremote: Compressing objects:  80% (21523/26903)   =1B[K=0Dremote:=
 Compressing objects:  81% (21792/26903)   =1B[K=0Dremote: Compressing obje=
cts:  82% (22061/26903)   =1B[K=0Dremote: Compressing objects:  83% (22330/=
26903)   =1B[K=0Dremote: Compressing objects:  84% (22599/26903)   =1B[K=0D=
remote: Compressing objects:  85% (22868/26903)   =1B[K=0Dremote: Compressi=
ng objects:  86% (23137/26903)   =1B[K=0Dremote: Compressing objects:  87% =
(23406/26903)   =1B[K=0Dremote: Compressing objects:  88% (23675/26903)   =
=1B[K=0Dremote: Compressing objects:  89% (23944/26903)   =1B[K=0Dremote: C=
ompressing objects:  90% (24213/26903)   =1B[K=0Dremote: Compressing object=
s:  91% (24482/26903)   =1B[K=0Dremote: Compressing objects:  92% (24751/26=
903)   =1B[K=0Dremote: Compressing objects:  93% (25020/26903)   =1B[K=0Dre=
mote: Compressing objects:  94% (25289/26903)   =1B[K=0Dremote: Compressing=
 objects:  95% (25558/26903)   =1B[K=0Dremote: Compressing objects:  96% (2=
5827/26903)   =1B[K=0Dremote: Compressing objects:  97% (26096/26903)   =1B=
[K=0Dremote: Compressing objects:  98% (26365/26903)   =1B[K=0Dremote: Comp=
ressing objects:  99% (26634/26903)   =1B[K=0Dremote: Compressing objects: =
100% (26903/26903)   =1B[K=0Dremote: Compressing objects: 100% (26903/26903=
), done.=1B[K=0D
Receiving objects:   0% (1/101062)   =0DReceiving objects:   1% (1011/10106=
2)   =0DReceiving objects:   2% (2022/101062)   =0DReceiving objects:   3% =
(3032/101062)   =0DReceiving objects:   4% (4043/101062)   =0DReceiving obj=
ects:   5% (5054/101062)   =0DReceiving objects:   6% (6064/101062), 1.84 M=
iB | 3722 KiB/s   =0DReceiving objects:   7% (7075/101062), 1.84 MiB | 3722=
 KiB/s   =0DReceiving objects:   8% (8085/101062), 1.84 MiB | 3722 KiB/s   =
=0DReceiving objects:   9% (9096/101062), 1.84 MiB | 3722 KiB/s   =0DReceiv=
ing objects:  10% (10107/101062), 1.84 MiB | 3722 KiB/s   =0DReceiving obje=
cts:  11% (11117/101062), 1.84 MiB | 3722 KiB/s   =0DReceiving objects:  12=
% (12128/101062), 1.84 MiB | 3722 KiB/s   =0DReceiving objects:  13% (13139=
/101062), 1.84 MiB | 3722 KiB/s   =0DReceiving objects:  13% (13223/101062)=
, 1.84 MiB | 3722 KiB/s   =0DReceiving objects:  14% (14149/101062), 4.43 M=
iB | 4505 KiB/s   =0DReceiving objects:  15% (15160/101062), 4.43 MiB | 450=
5 KiB/s   =0DReceiving objects:  16% (16170/101062), 4.43 MiB | 4505 KiB/s =
  =0DReceiving objects:  17% (17181/101062), 4.43 MiB | 4505 KiB/s   =0DRec=
eiving objects:  18% (18192/101062), 4.43 MiB | 4505 KiB/s   =0DReceiving o=
bjects:  19% (19202/101062), 4.43 MiB | 4505 KiB/s   =0DReceiving objects: =
 20% (20213/101062), 4.43 MiB | 4505 KiB/s   =0DReceiving objects:  21% (21=
224/101062), 4.43 MiB | 4505 KiB/s   =0DReceiving objects:  22% (22234/1010=
62), 7.15 MiB | 4855 KiB/s   =0DReceiving objects:  23% (23245/101062), 7.1=
5 MiB | 4855 KiB/s   =0DReceiving objects:  23% (23799/101062), 7.15 MiB | =
4855 KiB/s   =0DReceiving objects:  24% (24255/101062), 10.04 MiB | 5114 Ki=
B/s   =0DReceiving objects:  25% (25266/101062), 10.04 MiB | 5114 KiB/s   =
=0DReceiving objects:  26% (26277/101062), 10.04 MiB | 5114 KiB/s   =0DRece=
iving objects:  27% (27287/101062), 10.04 MiB | 5114 KiB/s   =0DReceiving o=
bjects:  28% (28298/101062), 10.04 MiB | 5114 KiB/s   =0DReceiving objects:=
  29% (29308/101062), 10.04 MiB | 5114 KiB/s   =0DReceiving objects:  30% (=
30319/101062), 13.11 MiB | 5343 KiB/s   =0DReceiving objects:  31% (31330/1=
01062), 13.11 MiB | 5343 KiB/s   =0DReceiving objects:  32% (32340/101062),=
 13.11 MiB | 5343 KiB/s   =0DReceiving objects:  33% (33351/101062), 13.11 =
MiB | 5343 KiB/s   =0DReceiving objects:  34% (34362/101062), 13.11 MiB | 5=
343 KiB/s   =0DReceiving objects:  35% (35372/101062), 13.11 MiB | 5343 KiB=
/s   =0DReceiving objects:  36% (36383/101062), 13.11 MiB | 5343 KiB/s   =
=0DReceiving objects:  37% (37393/101062), 13.11 MiB | 5343 KiB/s   =0DRece=
iving objects:  38% (38404/101062), 13.11 MiB | 5343 KiB/s   =0DReceiving o=
bjects:  39% (39415/101062), 13.11 MiB | 5343 KiB/s   =0DReceiving objects:=
  40% (40425/101062), 13.11 MiB | 5343 KiB/s   =0DReceiving objects:  41% (=
41436/101062), 13.11 MiB | 5343 KiB/s   =0DReceiving objects:  42% (42447/1=
01062), 13.11 MiB | 5343 KiB/s   =0DReceiving objects:  43% (43457/101062),=
 13.11 MiB | 5343 KiB/s   =0DReceiving objects:  44% (44468/101062), 13.11 =
MiB | 5343 KiB/s   =0DReceiving objects:  45% (45478/101062), 13.11 MiB | 5=
343 KiB/s   =0DReceiving objects:  46% (46489/101062), 13.11 MiB | 5343 KiB=
/s   =0DReceiving objects:  47% (47500/101062), 13.11 MiB | 5343 KiB/s   =
=0DReceiving objects:  48% (48510/101062), 13.11 MiB | 5343 KiB/s   =0DRece=
iving objects:  49% (49521/101062), 13.11 MiB | 5343 KiB/s   =0DReceiving o=
bjects:  49% (50144/101062), 13.11 MiB | 5343 KiB/s   =0DReceiving objects:=
  50% (50531/101062), 13.11 MiB | 5343 KiB/s   =0DReceiving objects:  51% (=
51542/101062), 16.34 MiB | 5554 KiB/s   =0DReceiving objects:  52% (52553/1=
01062), 16.34 MiB | 5554 KiB/s   =0DReceiving objects:  53% (53563/101062),=
 16.34 MiB | 5554 KiB/s   =0DReceiving objects:  54% (54574/101062), 16.34 =
MiB | 5554 KiB/s   =0DReceiving objects:  55% (55585/101062), 16.34 MiB | 5=
554 KiB/s   =0DReceiving objects:  56% (56595/101062), 16.34 MiB | 5554 KiB=
/s   =0DReceiving objects:  57% (57606/101062), 16.34 MiB | 5554 KiB/s   =
=0DReceiving objects:  58% (58616/101062), 16.34 MiB | 5554 KiB/s   =0DRece=
iving objects:  59% (59627/101062), 16.34 MiB | 5554 KiB/s   =0DReceiving o=
bjects:  60% (60638/101062), 16.34 MiB | 5554 KiB/s   =0DReceiving objects:=
  61% (61648/101062), 16.34 MiB | 5554 KiB/s   =0DReceiving objects:  62% (=
62659/101062), 16.34 MiB | 5554 KiB/s   =0DReceiving objects:  63% (63670/1=
01062), 16.34 MiB | 5554 KiB/s   =0DReceiving objects:  64% (64680/101062),=
 16.34 MiB | 5554 KiB/s   =0DReceiving objects:  65% (65691/101062), 16.34 =
MiB | 5554 KiB/s   =0DReceiving objects:  66% (66701/101062), 16.34 MiB | 5=
554 KiB/s   =0DReceiving objects:  67% (67712/101062), 16.34 MiB | 5554 KiB=
/s   =0DReceiving objects:  68% (68723/101062), 16.34 MiB | 5554 KiB/s   =
=0DReceiving objects:  69% (69733/101062), 16.34 MiB | 5554 KiB/s   =0DRece=
iving objects:  70% (70744/101062), 16.34 MiB | 5554 KiB/s   =0DReceiving o=
bjects:  71% (71755/101062), 16.34 MiB | 5554 KiB/s   =0DReceiving objects:=
  72% (72765/101062), 16.34 MiB | 5554 KiB/s   =0DReceiving objects:  73% (=
73776/101062), 16.34 MiB | 5554 KiB/s   =0DReceiving objects:  74% (74786/1=
01062), 19.75 MiB | 5757 KiB/s   =0DReceiving objects:  75% (75797/101062),=
 19.75 MiB | 5757 KiB/s   =0DReceiving objects:  76% (76808/101062), 19.75 =
MiB | 5757 KiB/s   =0DReceiving objects:  77% (77818/101062), 19.75 MiB | 5=
757 KiB/s   =0DReceiving objects:  78% (78829/101062), 19.75 MiB | 5757 KiB=
/s   =0DReceiving objects:  79% (79839/101062), 19.75 MiB | 5757 KiB/s   =
=0DReceiving objects:  80% (80850/101062), 19.75 MiB | 5757 KiB/s   =0DRece=
iving objects:  81% (81861/101062), 19.75 MiB | 5757 KiB/s   =0DReceiving o=
bjects:  82% (82871/101062), 19.75 MiB | 5757 KiB/s   =0DReceiving objects:=
  83% (83882/101062), 19.75 MiB | 5757 KiB/s   =0DReceiving objects:  84% (=
84893/101062), 19.75 MiB | 5757 KiB/s   =0DReceiving objects:  85% (85903/1=
01062), 19.75 MiB | 5757 KiB/s   =0DReceiving objects:  86% (86914/101062),=
 19.75 MiB | 5757 KiB/s   =0DReceiving objects:  87% (87924/101062), 19.75 =
MiB | 5757 KiB/s   =0DReceiving objects:  88% (88935/101062), 19.75 MiB | 5=
757 KiB/s   =0DReceiving objects:  89% (89946/101062), 19.75 MiB | 5757 KiB=
/s   =0DReceiving objects:  90% (90956/101062), 19.75 MiB | 5757 KiB/s   =
=0DReceiving objects:  91% (91967/101062), 19.75 MiB | 5757 KiB/s   =0DRece=
iving objects:  92% (92978/101062), 19.75 MiB | 5757 KiB/s   =0DReceiving o=
bjects:  93% (93988/101062), 19.75 MiB | 5757 KiB/s   =0DReceiving objects:=
  93% (94953/101062), 19.75 MiB | 5757 KiB/s   =0DReceiving objects:  94% (=
94999/101062), 19.75 MiB | 5757 KiB/s   =0DReceiving objects:  95% (96009/1=
01062), 23.35 MiB | 5956 KiB/s   =0DReceiving objects:  96% (97020/101062),=
 23.35 MiB | 5956 KiB/s   =0DReceiving objects:  97% (98031/101062), 23.35 =
MiB | 5956 KiB/s   =0DReceiving objects:  98% (99041/101062), 23.35 MiB | 5=
956 KiB/s   =0DReceiving objects:  99% (100052/101062), 23.35 MiB | 5956 Ki=
B/s   =0Dremote: Total 101062 (delta 73311), reused 100025 (delta 72469)=1B=
[K=0D
Receiving objects: 100% (101062/101062), 23.35 MiB | 5956 KiB/s   =0DReceiv=
ing objects: 100% (101062/101062), 24.31 MiB | 5956 KiB/s, done.=0D
Resolving deltas:   0% (0/73311)   =0DResolving deltas:   0% (153/73311)   =
=0DResolving deltas:   1% (815/73311)   =0DResolving deltas:   1% (969/7331=
1)   =0DResolving deltas:   1% (1338/73311)   =0DResolving deltas:   2% (14=
67/73311)   =0DResolving deltas:   2% (1553/73311)   =0DResolving deltas:  =
 2% (2122/73311)   =0DResolving deltas:   3% (2219/73311)   =0DResolving de=
ltas:   3% (2393/73311)   =0DResolving deltas:   4% (2938/73311)   =0DResol=
ving deltas:   4% (3180/73311)   =0DResolving deltas:   5% (3672/73311)   =
=0DResolving deltas:   6% (4402/73311)   =0DResolving deltas:   7% (5155/73=
311)   =0DResolving deltas:   7% (5414/73311)   =0DResolving deltas:   8% (=
5900/73311)   =0DResolving deltas:   8% (6484/73311)   =0DResolving deltas:=
   9% (6605/73311)   =0DResolving deltas:   9% (6779/73311)   =0DResolving =
deltas:  10% (7471/73311)   =0DResolving deltas:  11% (8090/73311)   =0DRes=
olving deltas:  11% (8150/73311)   =0DResolving deltas:  11% (8666/73311)  =
 =0DResolving deltas:  12% (8826/73311)   =0DResolving deltas:  12% (9501/7=
3311)   =0DResolving deltas:  13% (9568/73311)   =0DResolving deltas:  14% =
(10336/73311)   =0DResolving deltas:  14% (10689/73311)   =0DResolving delt=
as:  15% (11060/73311)   =0DResolving deltas:  16% (11819/73311)   =0DResol=
ving deltas:  16% (12204/73311)   =0DResolving deltas:  17% (12466/73311)  =
 =0DResolving deltas:  18% (13279/73311)   =0DResolving deltas:  19% (13959=
/73311)   =0DResolving deltas:  19% (14328/73311)   =0DResolving deltas:  2=
0% (14673/73311)   =0DResolving deltas:  21% (15505/73311)   =0DResolving d=
eltas:  21% (15863/73311)   =0DResolving deltas:  22% (16141/73311)   =0DRe=
solving deltas:  23% (16897/73311)   =0DResolving deltas:  24% (17637/73311=
)   =0DResolving deltas:  24% (17737/73311)   =0DResolving deltas:  25% (18=
429/73311)   =0DResolving deltas:  25% (18447/73311)   =0DResolving deltas:=
  26% (19064/73311)   =0DResolving deltas:  27% (19795/73311)   =0DResolvin=
g deltas:  27% (20406/73311)   =0DResolving deltas:  28% (20581/73311)   =
=0DResolving deltas:  29% (21467/73311)   =0DResolving deltas:  30% (21994/=
73311)   =0DResolving deltas:  30% (22216/73311)   =0DResolving deltas:  31=
% (22749/73311)   =0DResolving deltas:  32% (23466/73311)   =0DResolving de=
ltas:  32% (24037/73311)   =0DResolving deltas:  33% (24198/73311)   =0DRes=
olving deltas:  34% (24926/73311)   =0DResolving deltas:  35% (25687/73311)=
   =0DResolving deltas:  35% (26240/73311)   =0DResolving deltas:  36% (264=
17/73311)   =0DResolving deltas:  37% (27146/73311)   =0DResolving deltas: =
 38% (27906/73311)   =0DResolving deltas:  39% (28601/73311)   =0DResolving=
 deltas:  40% (29338/73311)   =0DResolving deltas:  41% (30088/73311)   =0D=
Resolving deltas:  42% (30802/73311)   =0DResolving deltas:  43% (32148/733=
11)   =0DResolving deltas:  44% (32486/73311)   =0DResolving deltas:  45% (=
33501/73311)   =0DResolving deltas:  46% (33786/73311)   =0DResolving delta=
s:  47% (34501/73311)   =0DResolving deltas:  48% (35227/73311)   =0DResolv=
ing deltas:  49% (35966/73311)   =0DResolving deltas:  50% (36668/73311)   =
=0DResolving deltas:  51% (37813/73311)   =0DResolving deltas:  52% (38150/=
73311)   =0DResolving deltas:  52% (38275/73311)   =0DResolving deltas:  53=
% (39371/73311)   =0DResolving deltas:  54% (39802/73311)   =0DResolving de=
ltas:  55% (40470/73311)   =0DResolving deltas:  56% (41066/73311)   =0DRes=
olving deltas:  57% (41812/73311)   =0DResolving deltas:  57% (42082/73311)=
   =0DResolving deltas:  58% (42603/73311)   =0DResolving deltas:  59% (432=
67/73311)   =0DResolving deltas:  60% (44072/73311)   =0DResolving deltas: =
 61% (44750/73311)   =0DResolving deltas:  62% (45458/73311)   =0DResolving=
 deltas:  63% (46239/73311)   =0DResolving deltas:  64% (47069/73311)   =0D=
Resolving deltas:  65% (47702/73311)   =0DResolving deltas:  66% (48599/733=
11)   =0DResolving deltas:  67% (49170/73311)   =0DResolving deltas:  67% (=
49669/73311)   =0DResolving deltas:  68% (49864/73311)   =0DResolving delta=
s:  69% (50626/73311)   =0DResolving deltas:  70% (51375/73311)   =0DResolv=
ing deltas:  71% (52056/73311)   =0DResolving deltas:  72% (52804/73311)   =
=0DResolving deltas:  73% (53521/73311)   =0DResolving deltas:  74% (54320/=
73311)   =0DResolving deltas:  75% (55010/73311)   =0DResolving deltas:  76=
% (55717/73311)   =0DResolving deltas:  77% (56489/73311)   =0DResolving de=
ltas:  78% (57259/73311)   =0DResolving deltas:  79% (57939/73311)   =0DRes=
olving deltas:  80% (58653/73311)   =0DResolving deltas:  81% (59386/73311)=
   =0DResolving deltas:  82% (60276/73311)   =0DResolving deltas:  82% (606=
27/73311)   =0DResolving deltas:  83% (60910/73311)   =0DResolving deltas: =
 84% (61605/73311)   =0DResolving deltas:  85% (62342/73311)   =0DResolving=
 deltas:  86% (63111/73311)   =0DResolving deltas:  87% (63795/73311)   =0D=
Resolving deltas:  88% (64519/73311)   =0DResolving deltas:  89% (65339/733=
11)   =0DResolving deltas:  90% (65989/73311)   =0DResolving deltas:  91% (=
66730/73311)   =0DResolving deltas:  92% (67550/73311)   =0DResolving delta=
s:  93% (68182/73311)   =0DResolving deltas:  94% (69008/73311)   =0DResolv=
ing deltas:  95% (69762/73311)   =0DResolving deltas:  96% (70394/73311)   =
=0DResolving deltas:  97% (71171/73311)   =0DResolving deltas:  98% (71890/=
73311)   =0DResolving deltas:  98% (72234/73311)   =0DResolving deltas:  99=
% (72588/73311)   =0DResolving deltas: 100% (73311/73311)   =0DResolving de=
ltas: 100% (73311/73311), done.=0D
dornberg@dong101:~/tmp/test$ cd git/=0D
dornberg@dong101:~/tmp/test/git$ git checkout v1.6.3.3=0D
Checking out files:  39% (96/241)   =0DChecking out files:  40% (97/241)   =
=0DChecking out files:  41% (99/241)   =0DChecking out files:  42% (102/241=
)   =0DChecking out files:  43% (104/241)   =0DChecking out files:  44% (10=
7/241)   =0DChecking out files:  45% (109/241)   =0DChecking out files:  46=
% (111/241)   =0DChecking out files:  47% (114/241)   =0DChecking out files=
:  48% (116/241)   =0DChecking out files:  49% (119/241)   =0DChecking out =
files:  50% (121/241)   =0DChecking out files:  51% (123/241)   =0DChecking=
 out files:  52% (126/241)   =0DChecking out files:  53% (128/241)   =0DChe=
cking out files:  54% (131/241)   =0DChecking out files:  55% (133/241)   =
=0DChecking out files:  56% (135/241)   =0DChecking out files:  57% (138/24=
1)   =0DChecking out files:  58% (140/241)   =0DChecking out files:  59% (1=
43/241)   =0DChecking out files:  60% (145/241)   =0DChecking out files:  6=
1% (148/241)   =0DChecking out files:  62% (150/241)   =0DChecking out file=
s:  63% (152/241)   =0DChecking out files:  64% (155/241)   =0DChecking out=
 files:  65% (157/241)   =0DChecking out files:  66% (160/241)   =0DCheckin=
g out files:  67% (162/241)   =0DChecking out files:  68% (164/241)   =0DCh=
ecking out files:  69% (167/241)   =0DChecking out files:  70% (169/241)   =
=0DChecking out files:  71% (172/241)   =0DChecking out files:  72% (174/24=
1)   =0DChecking out files:  73% (176/241)   =0DChecking out files:  74% (1=
79/241)   =0DChecking out files:  75% (181/241)   =0DChecking out files:  7=
6% (184/241)   =0DChecking out files:  77% (186/241)   =0DChecking out file=
s:  78% (188/241)   =0DChecking out files:  79% (191/241)   =0DChecking out=
 files:  80% (193/241)   =0DChecking out files:  81% (196/241)   =0DCheckin=
g out files:  82% (198/241)   =0DChecking out files:  83% (201/241)   =0DCh=
ecking out files:  84% (203/241)   =0DChecking out files:  85% (205/241)   =
=0DChecking out files:  86% (208/241)   =0DChecking out files:  87% (210/24=
1)   =0DChecking out files:  88% (213/241)   =0DChecking out files:  89% (2=
15/241)   =0DChecking out files:  90% (217/241)   =0DChecking out files:  9=
0% (218/241)   =0DChecking out files:  91% (220/241)   =0DChecking out file=
s:  92% (222/241)   =0DChecking out files:  93% (225/241)   =0DChecking out=
 files:  94% (227/241)   =0DChecking out files:  95% (229/241)   =0DCheckin=
g out files:  96% (232/241)   =0DChecking out files:  97% (234/241)   =0DCh=
ecking out files:  98% (237/241)   =0DChecking out files:  99% (239/241)   =
=0DChecking out files: 100% (241/241)   =0DChecking out files: 100% (241/24=
1), done.=0D
Note: moving to 'v1.6.3.3' which isn't a local branch=0D
If you want to create a new branch from this checkout, you may do so=0D
(now or later) by using -b with the checkout command again. Example:=0D
  git checkout -b <new_branch_name>=0D
HEAD is now at cff4231... GIT 1.6.3.3=0D
dornberg@dong101:~/tmp/test/git$ cd ..=0D
dornberg@dong101:~/tmp/test$ git status=0D
# On branch master=0D
#=0D
# Initial commit=0D
#=0D
# Changes to be committed:=0D
#   (use "git rm --cached <file>..." to unstage)=0D
#=0D
#	new file:   .gitmodules=0D
#	new file:   git=0D
#=0D
# Changed but not updated:=0D
#   (use "git add <file>..." to update what will be committed)=0D
#   (use "git checkout -- <file>..." to discard changes in working director=
y)=0D
#=0D
#	modified:   git=0D
#=0D
dornberg@dong101:~/tmp/test$ git add git=0D
dornberg@dong101:~/tmp/test$ git commit -m 'added submodule git @ tag v1.6.=
3.3'=0D
[master (root-commit) c858cd1] added submodule git @ tag v1.6.3.3=0D
 2 files changed, 4 insertions(+), 0 deletions(-)=0D
 create mode 100644 .gitmodules=0D
 create mode 160000 git=0D
dornberg@dong101:~/tmp/test$ echo abc > file=0D
dornberg@dong101:~/tmp/test$ git add file=0D
dornberg@dong101:~/tmp/test$ git commit -m 'added file'=0D
[master 0dc5575] added file=0D
 1 files changed, 1 insertions(+), 0 deletions(-)=0D
 create mode 100644 file=0D
dornberg@dong101:~/tmp/test$ cd ..=0D
dornberg@dong101:~/tmp$ git clone dornberg@dong101:tmp/test sshclonetest=0D
Initialized empty Git repository in /users/sfb555/dornberg/tmp/sshclonetest=
/.git/=0D
error: git-upload-pack: git-pack-objects died with error.=0D
fatal: git-upload-pack: aborting due to possible repository corruption on t=
he remote side.=0D
remote: Generating pack...=1B[K=0D
remote: Done counting 7 objects.=1B[K=0D
remote: error: unable to find cff4231a1dfbe68b4a163b31406d862567d3243a=1B[K=
=0D
remote: fatal: unable to get type of object cff4231a1dfbe68b4a163b31406d862=
567d3243a=1B[K=0D
remote: aborting due to possible repository corruption on the remote side.=
=0D
fatal: early EOF=0D
fatal: index-pack failed=0D
dornberg@dong101:~/tmp$ git clone test fi=08=1B[K=08=1B[Klocalte=08=1B[K=08=
=1B[Kclonetest=0D
Initialized empty Git repository in /users/sfb555/dornberg/tmp/localclonete=
st/.git/=0D
dornberg@dong101:~/tmp$ exit=0D

Script done on So 28 Jun 2009 18:57:38 CEST

--45Z9DzgjV8m4Oswq--
