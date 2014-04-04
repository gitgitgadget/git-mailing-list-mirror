From: Thomas-Louis Laforest <tllaforest@arbault.ca>
Subject: Git stash: create stash even if he end up with an Error (lock file)
Date: Fri, 4 Apr 2014 15:11:40 +0000
Message-ID: <4a6120a3c62d420c951aab89ba3730fb@CO1PR02MB029.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 04 17:11:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WW5mW-0004DF-PF
	for gcvg-git-2@plane.gmane.org; Fri, 04 Apr 2014 17:11:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753256AbaDDPLo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Apr 2014 11:11:44 -0400
Received: from mail-bn1lp0144.outbound.protection.outlook.com ([207.46.163.144]:53195
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752661AbaDDPLn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Apr 2014 11:11:43 -0400
X-Greylist: delayed 1057 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 Apr 2014 11:11:43 EDT
Received: from CO1PR02MB029.namprd02.prod.outlook.com (10.242.162.148) by
 CO1PR02MB031.namprd02.prod.outlook.com (10.242.162.152) with Microsoft SMTP
 Server (TLS) id 15.0.898.11; Fri, 4 Apr 2014 15:11:40 +0000
Received: from CO1PR02MB029.namprd02.prod.outlook.com ([169.254.16.151]) by
 CO1PR02MB029.namprd02.prod.outlook.com ([169.254.16.151]) with mapi id
 15.00.0913.002; Fri, 4 Apr 2014 15:11:40 +0000
Thread-Topic: Git stash: create stash even if he end up with an Error (lock
 file)
Thread-Index: Ac9QFXMUF4UVcProSq+Wr/NJDoET7QAAq3tg
Accept-Language: fr-CA, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [69.70.127.250]
x-forefront-prvs: 01713B2841
x-forefront-antispam-report: SFV:NSPM;SFS:(10009001)(6009001)(428001)(189002)(199002)(74482001)(74876001)(76482001)(86362001)(54316002)(33646001)(74706001)(76176001)(54356001)(83072002)(4396001)(19580405001)(49866001)(19580395003)(51856001)(93516002)(95666003)(47736001)(85852003)(90146001)(81686001)(99396002)(74366001)(56816005)(98676001)(85306002)(31966008)(95416001)(83322001)(80976001)(46102001)(74502001)(47976001)(97186001)(81816001)(47446002)(79102001)(74316001)(69226001)(56776001)(81342001)(76786001)(77096001)(76796001)(74662001)(76576001)(59766001)(63696002)(20776003)(81542001)(66066001)(87936001)(65816001)(99286001)(93136001)(94316002)(94946001)(50986001)(2656002)(97336001)(53806001)(92566001)(87266001)(77982001)(80022001)(24736002);DIR:OUT;SFP:1101;SCL:1;SRVR:CO1PR02MB031;H:CO1PR02
 MB029.namprd02.prod.outlook.com;FPR:BCE8F2ED.ACF29558.E0E391BB.8A287E50.20395;MLV:sfv;PTR:InfoNoRe 
received-spf: None (: arbault.ca does not designate permitted sender hosts)
X-OriginatorOrg: arbault.ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245763>

Good day,

I'm not sure if it a real bug or just a functionality fix but this is m=
y issue.

What I wanted to do :=20
Stash non committed change, but forgot to close a file that had uncommi=
tted change and was write lock.

What I did :=20
Git stash

What happen
Git stash created the stash and try to remove the uncommitted change bu=
t fail on the lock file, leaving the work directory with a stash than c=
an't be pop without manually resetting the lock file.

What I expected to see :
Git stash fail and revert to the work directory before the command.

How the last two are different:=20
End user get error, close the application and restart=20
Vs
End user get error, close the application, reset the work directory, fe=
ar he may have lost the change he was doing, pop the stash, revise ever=
ything is good, than restart doing whatever git task he was trying to d=
o.

Thank you

Thomas-Louis Laforest, ing. jr, Jr. Eng.
Charg=E9 de projet,=A0Project Leader
solutions int=E9gr=E9es=A0=A0|=A0=A0integrated solutions

T=A0819 542-5600=A0 x3106
=46=A0819 845-5600
tllaforest@arbault.ca
The information contained herein is of private and confidential nature.=
 It can be used only by the above-mentioned recipients. Any other perso=
n who would take note of it is advised that it is strictly forbidden fo=
r him to reveal the information, to distribute it or to copy it. If thi=
s communication were transmitted to you by mistake, warn us immediately=
 by telephone or email, and erase the original, without taking a copy, =
revealing the content nor taking some measures based on it.
Les renseignements contenus dans les pr=E9sentes sont de nature priv=E9=
e et confidentielle. Ils ne peuvent =EAtre utilis=E9s que par le ou les=
 destinataires susmentionn=E9s. Toute autre personne qui en prendrait c=
onnaissance est pri=E9e de noter qu'il lui est strictement interdit de =
les divulguer, de les distribuer ou de les copier. Si cette communicati=
on vous a =E9t=E9 transmise par m=E9garde, veuillez nous en aviser imm=E9=
diatement par t=E9l=E9phone ou par courriel, et effacer l'original, san=
s en tirer de copie, en d=E9voiler le contenu ni prendre quelque mesure=
 fond=E9e sur celui-ci.
