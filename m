From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Issue: Mails sent twice if patch is mentioned twice while sending mail.
Date: Wed, 17 Aug 2011 11:58:49 +0200
Message-ID: <vpq62lwjr52.fsf@bauges.imag.fr>
References: <4E4B5B9D.1070901@st.com>
	<CALkWK0nv=NrCzxfePL50GiJya+DbqdOmSMjPVEa-Sf1Qm5oAvg@mail.gmail.com>
	<4E4B86F1.2010802@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Shiraz HASHIM <shiraz.hashim@st.com>,
	Vipin KUMAR <vipin.kumar@st.com>
To: vireshk <viresh.kumar@st.com>
X-From: git-owner@vger.kernel.org Wed Aug 17 12:21:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtdFd-0003cC-8G
	for gcvg-git-2@lo.gmane.org; Wed, 17 Aug 2011 12:21:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752246Ab1HQKV1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Aug 2011 06:21:27 -0400
Received: from mx2.imag.fr ([129.88.30.17]:50723 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751771Ab1HQKV0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2011 06:21:26 -0400
X-Greylist: delayed 1347 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Aug 2011 06:21:25 EDT
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p7H9wnp8003048
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 17 Aug 2011 11:58:49 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Qtcte-0003ck-89; Wed, 17 Aug 2011 11:58:50 +0200
In-Reply-To: <4E4B86F1.2010802@st.com> (vireshk's message of "Wed, 17 Aug 2011
	14:46:33 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 17 Aug 2011 11:58:49 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p7H9wnp8003048
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1314179931.59607@kiAygSC+64R1pPfsHMIseg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179507>

vireshk <viresh.kumar@st.com> writes:

> Hi Ram,
>
> Actually i did this by mistake once and thought git send-email should
> have taken care of this. I may be wrong, but it was just an thought.

git send-email could probably issue a warning if the same patch is
mentionned twice, but I don't think it's sane to try to silently
autocorrect user's mistake.

If users get used to "git send-email 1.patch 1.patch" sending the email
only once, then what should be the expected behavior of

  git send-email 1.patch ./1.patch

  git send-email 1.patch symlink-to-1.patch

?

The nice thing with a warning is that you can't really blame the tool
for not issuing a warning, while it can be harmfull to have an
autocorrection fail in a real user-senario.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
