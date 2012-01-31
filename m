From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Bug: "git checkout -b" should be allowed in empty repo
Date: Tue, 31 Jan 2012 11:01:17 +0100
Message-ID: <4F27BBED.9080902@viscovery.net>
References: <4F24E287.3040302@alum.mit.edu> <7vwr8bvvxj.fsf@alter.siamese.dyndns.org> <4F263AEE.4080409@alum.mit.edu> <7v39axc9gp.fsf@alter.siamese.dyndns.org> <4F27ACED.2050709@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Jan 31 11:01:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsAWn-0006Io-Hi
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jan 2012 11:01:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753807Ab2AaKBZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jan 2012 05:01:25 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:32583 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752635Ab2AaKBY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jan 2012 05:01:24 -0500
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1RsAWc-0002Dp-3S; Tue, 31 Jan 2012 11:01:18 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id C96691660F;
	Tue, 31 Jan 2012 11:01:17 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
In-Reply-To: <4F27ACED.2050709@alum.mit.edu>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189447>

Am 1/31/2012 9:57, schrieb Michael Haggerty:
> No, the idea is to avoid special casing by making 0{40} into a real (but
> empty) revision.

But then why not just have git init perform the equivalent of

  c=$(echo "Start" | git commit-tree $empty_tree_sha1) &&
  git update-ref refs/heads/master $c

People who dislike an empty initial commit can always use "git commit
--amend" for the first "real" commit.

-- Hannes
