From: Jonathan Nieder <jrnieder@gmail.com>
Subject: "libify part of reset" mini-series (Re: What's cooking in git.git
 (Jun 2011, #02; Sat, 11))
Date: Sun, 12 Jun 2011 19:17:37 -0500
Message-ID: <20110613001737.GA2291@elie>
References: <7voc23sfxd.fsf@alter.siamese.dyndns.org>
 <BANLkTinHCX0vmAdk+su-_Y0th9vLQ6qsnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 13 02:17:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QVuqr-00078g-VW
	for gcvg-git-2@lo.gmane.org; Mon, 13 Jun 2011 02:17:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754577Ab1FMARq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Jun 2011 20:17:46 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:61713 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754253Ab1FMARp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jun 2011 20:17:45 -0400
Received: by iyb14 with SMTP id 14so3458361iyb.19
        for <git@vger.kernel.org>; Sun, 12 Jun 2011 17:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=+XCCGF1tDfRteGKHWsq1//Cer7aRFy3xZ0Cdx1JVQRA=;
        b=mJGgIuhFScCJcVL+zbmdxnuQtpHuveGJFVMTo3HLuaQfb/5L8AJySBYhyyzA/QeFmL
         JgPFufbHlcoJE7/XZ90IENVmZ57WzSCpaz1vq0kENweGjdelKgYOVgsJxig3ynczXt2o
         DcavyP6QE7uJG2dgOyttnQFIXpa4tK1B6fa48=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=SWTFGMLaqKZa/qX7FeRwtwdED4c05CfWQkbdkMjNe/Ij3tCNm7NLN2Wcz03ayTBoOL
         pA/dIB5sqaxJcJhiVzzVTJBHOP8NDzp/aABygJ+uyODjlV1OoyDlLTdU4Lqxya9aJgn8
         xh5MViBvR0WhVcu81vV7oAVLtreOsR7D9nmKQ=
Received: by 10.42.91.139 with SMTP id p11mr5549905icm.402.1307924265174;
        Sun, 12 Jun 2011 17:17:45 -0700 (PDT)
Received: from elie (adsl-69-209-71-178.dsl.chcgil.sbcglobal.net [69.209.71.178])
        by mx.google.com with ESMTPS id e1sm4319114icv.20.2011.06.12.17.17.43
        (version=SSLv3 cipher=OTHER);
        Sun, 12 Jun 2011 17:17:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTinHCX0vmAdk+su-_Y0th9vLQ6qsnw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175673>

Hi,

Ramkumar Ramachandra wrote:

> Have you seen my "libify reset" patch [1]?  I thought it was an easy candidate.

I don't think it is one, personally.  While it is good to get feedback
on such things early, that patch exposes some functions without making
the API much clearer and without any users to explain how they work in
practice.  I think it is best to let such patches cook in a private
branch until there is some obvious benefit to including them in git.

That benefit doesn't necessarily have to be new code using it --- it
could be increased clarity, faster compile times, decreasing the delta
with libgit2 so later fixes can be ported between the two more easily,
anything.  Though in this case, I'm guessing the motivation from your
end is the code that uses it, so that's an obvious choice.

I'd suggest sending it again for inclusion when the code that uses it
is ready, or for review whenever you have questions that the list can
answer.
