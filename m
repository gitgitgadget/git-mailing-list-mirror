From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Strange effect merging empty file
Date: Wed, 21 Mar 2012 10:14:21 -0700
Message-ID: <7v62dx3mhe.fsf@alter.siamese.dyndns.org>
References: <4F69AD3C.4070203@ericsson.com> <4F69B375.5050205@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ralf Nyren <ralf.nyren@ericsson.com>, git@vger.kernel.org
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Wed Mar 21 18:14:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAP7H-0001S0-Ec
	for gcvg-git-2@plane.gmane.org; Wed, 21 Mar 2012 18:14:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758297Ab2CURO0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Mar 2012 13:14:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41449 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756884Ab2CUROZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Mar 2012 13:14:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 961756DD6;
	Wed, 21 Mar 2012 13:14:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=6ANQKoMP70s6
	OJ/WBFGNis2aUnA=; b=J0XpWqkTqwH77JskFPICGcHIdv6gCyg+o3HOBwYtzBS/
	G/yyYUfV2oDrVYoJu9QGT4Xvp5RH3fSbUm9ieONcLaxp5y/kxEegaEqU7rQs2cQV
	6cR0OmKdusstRhYiPVpJOZatI57OR4zDObjA4Jnw2SsGEu56K7fKyynDOY7JR1g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=osuv0z
	+IFFsOo1UgGJ+cmD61ZeNybPrcXXa+8Bud+Z+1ATAowj47Amu5AKGjMEowYDJm72
	8gPfAsJxNfe3Bl9MMRDmzCYwekXtdHqpg/umQXscjyZTnYCgDbviY+wACYeJlCI4
	kSxPX4HggWADvX5Wj53pqiyQPoOFccQty3qE0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D1156DD5;
	Wed, 21 Mar 2012 13:14:24 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 278B56DD4; Wed, 21 Mar 2012
 13:14:23 -0400 (EDT)
In-Reply-To: <4F69B375.5050205@in.waw.pl> ("Zbigniew =?utf-8?Q?J=C4=99drze?=
 =?utf-8?Q?jewski-Szmek=22's?= message of "Wed, 21 Mar 2012 11:54:45 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4DD2E868-7379-11E1-972E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193589>

Zbigniew J=C4=99drzejewski-Szmek  <zbyszek@in.waw.pl> writes:

> # Merge import 1.0 and remove the empty file
> git merge  --no-edit import^
> git rm empty.txt
> git commit -m 'Remove empty file'
>
> # Merge import 1.1 and watch empty.txt contents show up in .gitignore
> git merge --no-edit import
> cat .gitignore

Given what merge-recursive does, I am not very surprised, even though I
agree that it feels like a very surprising end user experience ;-)
