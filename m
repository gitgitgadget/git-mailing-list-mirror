From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Whitespace on commit
Date: Wed, 12 Mar 2008 20:52:06 -0700
Message-ID: <7viqzr1dsp.fsf@gitster.siamese.dyndns.org>
References: <fra7ji$7p9$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Kenneth P. Turvey" <kt-usenet@squeakydolphin.com>
X-From: git-owner@vger.kernel.org Thu Mar 13 04:52:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZeUv-0002mL-Gx
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 04:52:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751783AbYCMDwO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 23:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751798AbYCMDwN
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 23:52:13 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:65402 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751747AbYCMDwN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 23:52:13 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2B32C2C77;
	Wed, 12 Mar 2008 23:52:12 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 6CCE42C76; Wed, 12 Mar 2008 23:52:08 -0400 (EDT)
In-Reply-To: <fra7ji$7p9$1@ger.gmane.org> (Kenneth P. Turvey's message of
 "Thu, 13 Mar 2008 03:38:26 +0000 (UTC)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77032>

"Kenneth P. Turvey" <kt-usenet@squeakydolphin.com> writes:

> I keep getting annoying errors when I try to commit.  Git complains that I
> have whitespace in the wrong places.  
>
> This is fine.. I even like it.  What I don't like is having to change this
> stuff manually.  Is there anyway to tell git to just fix the stuff and do
> the commit?  
>
> I've tried setting
>
> apply.whitespace = fix 
>
> in my .gitconfig, but that doesn't seem to help when doing commits.

Yeah, that is to protect yourself from whitespace mess _other people_
threw at you in a patch form.

You can ask git to fix your own stuff up, by pretending that you are that
other person who made the mess, by doing:

	git diff HEAD >P.diff
        git reset --hard HEAD
        git apply --index --whitespace=fix P.diff
