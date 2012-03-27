From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Definition of working directory
Date: Tue, 27 Mar 2012 16:01:45 -0700
Message-ID: <7v8vilzm06.fsf@alter.siamese.dyndns.org>
References: <BLU0-SMTP1958653CC391F120060F8B6B14A0@phx.gbl>
 <7vd37yj7h2.fsf@alter.siamese.dyndns.org>
 <BLU0-SMTP4376CA011AD4D79C1BAB727B14A0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Anjib Mulepati <anjibcs@hotmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 28 01:01:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCfOj-0006zh-FJ
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 01:01:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753811Ab2C0XBs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Mar 2012 19:01:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47421 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751365Ab2C0XBs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2012 19:01:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1DE1D7921;
	Tue, 27 Mar 2012 19:01:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fvtia6pnBobRT8Akc1dvi6xWA1E=; b=N5UD2u
	JBfyfAE/HbYv7L2u28ScubPWwADV1L2k0lrxVDAldb/SboUYAI1Y5vhXfhFCd0Kd
	KDRKHuQ/IS6BlLhbDsPjOlY2ICIAxztTEkuPme1kyNqInEN9Wwfnszr0m5UmvS+8
	LZx1F51AcK+c1OrSqIUf8kVrvSj+osYyGvc6Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ay7SPBpo8JOC+L7d+dAjMup1KO1f0ifk
	7AVleQp1K5dFVOIJOfC+z1SFSDpKL3vhmt8+sPsfOnY6JUf3W8znPj17EDmyWiVt
	XFAztwUTBeM2tD5GdT4Rc8zkgLF5/jTWyxdZ/LOduCrKeQcC8wvVv8af+OvqeKg9
	5aPcjpdhfWI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 15D797920;
	Tue, 27 Mar 2012 19:01:47 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9F896791D; Tue, 27 Mar 2012
 19:01:46 -0400 (EDT)
In-Reply-To: <BLU0-SMTP4376CA011AD4D79C1BAB727B14A0@phx.gbl> (Anjib
 Mulepati's message of "Tue, 27 Mar 2012 17:26:23 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D3FDAE46-7860-11E1-978D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194092>

Anjib Mulepati <anjibcs@hotmail.com> writes:

> So if I have a project called MyProject and inside that I have two
> sub-directories dir1 and dir2. Does that mean working directory is
> *ALWAYS* MyProject.

Your working tree is MyProject that has two subdirectories dir1 and dir2.

> Also if i create some file in dir1 and do git status without git add
> then it display untracked files as ../dir1/
> It doesn't display the untracked file name but after I do git add when
> I did git status it does give me file under changes to be
> committed. Why didn't it shows file with name as untracked in first
> case?

Because often such a directory has tons of garbage files that are totally
uninteresting.  Check "git help status" and look for the --untracked-files
option if you want to learn more.
