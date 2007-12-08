From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: Re: Git and GCC
Date: Fri, 07 Dec 2007 16:47:19 -0800
Message-ID: <1197074839.22471.34.camel@brick>
References: <4aca3dc20712051947t5fbbb383ua1727c652eb25d7e@mail.gmail.com>
	 <20071205.202047.58135920.davem@davemloft.net>
	 <4aca3dc20712052032n521c344cla07a5df1f2c26cb8@mail.gmail.com>
	 <20071205.204848.227521641.davem@davemloft.net>
	 <4aca3dc20712052111o730f6fb6h7a329ee811a70f28@mail.gmail.com>
	 <1196918132.10408.85.camel@brick>
	 <4aca3dc20712052117j3ef5cf99y848d4962ae8ddf33@mail.gmail.com>
	 <9e4733910712052247x116cabb4q48ebafffb93f7e03@mail.gmail.com>
	 <20071206071503.GA19504@coredump.intra.peff.net>
	 <alpine.LFD.0.99999.0712060915590.555@xanadu.home>
	 <20071206173946.GA10845@sigill.intra.peff.net>
	 <alpine.LFD.0.9999.0712061030560.13796@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Nicolas Pitre <nico@cam.org>,
	Jon Smirl <jonsmirl@gmail.com>,
	Daniel Berlin <dberlin@dberlin.org>,
	David Miller <davem@davemloft.net>, ismail@pardus.org.tr,
	gcc@gcc.gnu.org, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Dec 08 01:47:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0nr5-0005s7-UW
	for gcvg-git-2@gmane.org; Sat, 08 Dec 2007 01:47:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752651AbXLHArW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 19:47:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752079AbXLHArW
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 19:47:22 -0500
Received: from rv-out-0910.google.com ([209.85.198.188]:49289 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751782AbXLHArV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 19:47:21 -0500
Received: by rv-out-0910.google.com with SMTP id k20so884400rvb
        for <git@vger.kernel.org>; Fri, 07 Dec 2007 16:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=V4CdguCy0x3EYzLesf5Fy8ZZpCoE5qSgECBIdVHRPxg=;
        b=K23KJgMaBFcEoQLuI1fq+YD4SiwnS3De5yxy2w12nM+G1ib2ub609j5qn/UrPHZdMoEAL2HxyhlKc8CrROWzuJwS9xjeZtp4epPqbaby7m9gZxbkEliDzPwHMrmWw4IuVy4e98gIdFrJTcvxam4Vm/DpRM85TFGhQCQZGID2Po0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=oCfOwpYQUMePdUO8C9hGoE5d1/DnC6q4IuO4zLZN/sder/NG5hsez/UszJfkWnWUn52q3VTMNZepDnFLscYt1H01ThAMSspaHxDq1pa0OT+2ZHThPKRbRmQrMkwzP98qbiI4u6mbGNRpMQawsda/a7zbKqXX9wpeys+IVg7erxQ=
Received: by 10.140.133.11 with SMTP id g11mr3042611rvd.1197074840994;
        Fri, 07 Dec 2007 16:47:20 -0800 (PST)
Received: from ?192.168.1.124? ( [216.19.190.48])
        by mx.google.com with ESMTPS id l27sm547405rvb.2007.12.07.16.47.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 07 Dec 2007 16:47:20 -0800 (PST)
In-Reply-To: <alpine.LFD.0.9999.0712061030560.13796@woody.linux-foundation.org>
X-Mailer: Evolution 2.12.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67489>

Some interesting stats from the highly packed gcc repo.  The long chain
lengths very quickly tail off.  Over 60% of the objects have a chain
length of 20 or less.  If anyone wants the full list let me know.  I
also have included a few other interesting points, the git default
depth of 50, my initial guess of 100 and every 10% in the cumulative
distribution from 60-100%.

This shows the git default of 50 really isn't that bad, and after
about 100 it really starts to get sparse.  

Harvey

1:	103817	103817	10.20%	1017922
2:	67332	171149	16.81%
3:	57520	228669	22.46%
4:	52570	281239	27.63%
5:	43910	325149	31.94%
6:	37520	362669	35.63%
7:	35248	397917	39.09%
8:	29819	427736	42.02%
9:	27619	455355	44.73%
10:	22656	478011	46.96%
11:	21073	499084	49.03%
12:	18738	517822	50.87%
13:	16674	534496	52.51%
14:	14882	549378	53.97%
15:	14424	563802	55.39%
16:	12765	576567	56.64%
17:	11662	588229	57.79%
18:	11845	600074	58.95%
19:	11694	611768	60.10%
20:	9625	621393	61.05%
34:	5354	719356	70.67%
50:	3395	785342	77.15%
60:	2547	815072	80.07%
100:	1644	898284	88.25%
113:	1292	917046	90.09%
158:	959	967429	95.04%
200:	652	997653	98.01%
219:	491	1008132	99.04%
245:	179	1017717	99.98%
246:	111	1017828	99.99%
247:	61	1017889	100.00%
248:	27	1017916	100.00%
249:	6	1017922	100.00%
