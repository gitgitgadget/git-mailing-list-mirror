From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] fix "diff --raw" on the work tree side
Date: Sun, 02 Mar 2008 09:11:25 -0800
Message-ID: <7v7igloxtu.fsf@gitster.siamese.dyndns.org>
References: <1204451012-17487-1-git-send-email-gitster@pobox.com>
 <46dff0320803020241l29277bd4m1a711ff0a863e7f8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Ping Yin" <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 02 18:12:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVrjV-0006ZQ-3K
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 18:12:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754628AbYCBRLk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 12:11:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754612AbYCBRLk
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 12:11:40 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38456 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754595AbYCBRLj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 12:11:39 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5A2A11999;
	Sun,  2 Mar 2008 12:11:37 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id CB0F91997; Sun,  2 Mar 2008 12:11:32 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75812>

"Ping Yin" <pkufranky@gmail.com> writes:

> On Sun, Mar 2, 2008 at 5:43 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> The second patch fixes the inconsistency between "git-diff --raw" and
>>  "git-diff-{index,files} --raw" when they are used for submodules.
>>
>>  The third one is a bit controversial and changes the semantics and
>>  existing callers and won't be considered for 1.5.5.
>>
> Unfortunately, my submodule summary patch series will depend on
> git-diff or git-diff-index. So should i resend my improved patch only
> after the thrid one is applied?

I do not think re-introducing the inconsistency like the third one does is
a palatable option.

Wouldn't grabbing (cd $submodule && git rev-parse HEAD) yourself be more
portable across git before and after the bugfix of "git diff --raw"?
