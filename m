From: Martin Fick <mfick@codeaurora.org>
Subject: Re: Git is not scalable with too many refs/*
Date: Thu, 8 Sep 2011 17:52:02 -0700 (PDT)
Message-ID: <1315529522448-6774328.post@n2.nabble.com>
References: <4DF6A8B6.9030301@op5.se> <20110614003029.GA31447@sigill.intra.peff.net> <7vtybtm3dl.fsf@alter.siamese.dyndns.org> <BANLkTimNoh3-Jde_-arzwBa=aUR+KK3Xhw@mail.gmail.com> <201106141202.46720.johan@herland.net> <20110614170214.GB26764@sigill.intra.peff.net> <BANLkTin0CjnM_hMaEpMroZdDhhavaoKAv00_4xBqeHj9biToVA@mail.gmail.com> <20110614194749.GA1567@sigill.intra.peff.net> <BANLkTi=GZDLu-ey1=h8LLDbWssoSpsM_jd7R-oFr+b+82Otb8g@mail.gmail.com> <1315511619144-6773496.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 09 02:52:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1pKD-0006oY-KA
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 02:52:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757085Ab1IIAwE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Sep 2011 20:52:04 -0400
Received: from sam.nabble.com ([216.139.236.26]:53873 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756989Ab1IIAwC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Sep 2011 20:52:02 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <mfick@codeaurora.org>)
	id 1R1pK6-0001WX-Ef
	for git@vger.kernel.org; Thu, 08 Sep 2011 17:52:02 -0700
In-Reply-To: <1315511619144-6773496.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181011>

An update, I bisected it down to this commit:

  88a21979c5717e3f37b9691e90b6dbf2b94c751a

   fetch/pull: recurse into submodules when necessary

Since this can be disabled with the --no-recurse-submodules switch, I tried
that and indeed, even with the latest 1.7.7rc it becomes fast (~8mins)
again. The strange part about this is that the repository does not have any
submodules. Anyway, I hope that this can be useful to others since it is a
workaround which speed things up enormously. Let me know if you have any
other tests that you want me to perform,

-Martin

--
View this message in context: http://git.661346.n2.nabble.com/Git-is-not-scalable-with-too-many-refs-tp6456443p6774328.html
Sent from the git mailing list archive at Nabble.com.
