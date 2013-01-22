From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: GIT get corrupted on lustre
Date: Tue, 22 Jan 2013 23:14:16 +0100
Message-ID: <878v7keuh3.fsf@pctrast.inf.ethz.ch>
References: <50D861EE.6020105@giref.ulaval.ca>
	<50D870A0.90205@interlinx.bc.ca> <50EC453A.2060306@giref.ulaval.ca>
	<50EDDF12.3080800@giref.ulaval.ca> <50F7F793.80507@giref.ulaval.ca>
	<CAGK7Mr4R=OwfWt4Kat75C8YDi3iLTavMLxeoLxkf1-gKhxrucg@mail.gmail.com>
	<50F8273E.5050803@giref.ulaval.ca>
	<871B6C10EBEFE342A772D1159D1320853A042AD7@umechphj.easf.csd.disa.mil>
	<50F829A9.7090606@calculquebec.ca>
	<871B6C10EBEFE342A772D1159D1320853A044B42@umechphj.easf.csd.disa.mil>
	<50F98B53.9080109@giref.ulaval.ca>
	<CABPQNSbJr4dR9mq+kCwGe-RKb9PA7q=SKzbFW+=md_PLzZh=nQ@mail.gmail.com>
	<87a9s2o6ri.fsf@pctrast.inf.ethz.ch> <kdk2ss$498$1@ger.gmane.org>
	<87r4lejpx8.fsf@pctrast.inf.ethz.ch>
	<50FF051D.5090804@giref.ulaval.ca>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Brian J. Murrell" <brian@interlinx.bc.ca>, <git@vger.kernel.org>,
	<kusmabite@gmail.com>,
	"Pyeron, Jason J CTR (US)" <jason.j.pyeron.ctr@mail.mil>,
	Maxime Boissonneault <maxime.boissonneault@calculquebec.ca>,
	Philippe Vaucher <philippe.vaucher@gmail.com>,
	=?utf-8?Q?S=C3=A9bastien?= Boisvert 
	<sebastien.boisvert@calculquebec.ca>
To: Eric Chamberland <Eric.Chamberland@giref.ulaval.ca>
X-From: git-owner@vger.kernel.org Tue Jan 22 23:14:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Txm78-0000oe-I3
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 23:14:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752245Ab3AVWOV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2013 17:14:21 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:4251 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751490Ab3AVWOU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2013 17:14:20 -0500
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 22 Jan
 2013 23:14:16 +0100
Received: from pctrast.inf.ethz.ch.ethz.ch (46.126.8.85) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 22 Jan
 2013 23:14:17 +0100
In-Reply-To: <50FF051D.5090804@giref.ulaval.ca> (Eric Chamberland's message of
	"Tue, 22 Jan 2013 16:31:09 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214256>

Eric Chamberland <Eric.Chamberland@giref.ulaval.ca> writes:

> So, hum, do we have some sort of conclusion?
>
> Shall it be a fix for git to get around that lustre "behavior"?
>
> If something can be done in git it would be great: it is a *lot*
> easier to change git than the lustre filesystem software for a cluster
> in running in production mode... (words from cluster team) :-/

I thought you already established that simply disabling the progress
display is a sufficient workaround?  If that doesn't help, you can try
patching out all use of SIGALRM within git.

Other than that I agree with Junio, from what we've seen so far, Lustre
returns EINTR on all sorts of calls that simply aren't allowed to do so.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
