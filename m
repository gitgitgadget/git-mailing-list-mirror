From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug report - local (and git ignored) file silently removed after
 checkout
Date: Sun, 20 Nov 2011 19:36:42 -0800
Message-ID: <7vzkfqgn91.fsf@alter.siamese.dyndns.org>
References: <CAPRVejcpAZrLWCeHTZJr9Uk6_z6hTPQLLd6pCOKteYnRGMQ5ig@mail.gmail.com>
 <7vehx2ijf8.fsf@alter.siamese.dyndns.org>
 <20111120221930.GF14902@foodlogiq3-xp-d620.thebe.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bertrand BENOIT <projettwk@users.sourceforge.net>,
	git@vger.kernel.org
To: Taylor Hedberg <tmhedberg@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 21 04:36:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RSKgb-0000cF-Tv
	for gcvg-git-2@lo.gmane.org; Mon, 21 Nov 2011 04:36:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755450Ab1KUDgr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Nov 2011 22:36:47 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45380 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755315Ab1KUDgq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Nov 2011 22:36:46 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 86F9D61FC;
	Sun, 20 Nov 2011 22:36:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QmVVRFr6lXQj/uL8lUTDph/gO7M=; b=DC50rM
	dnYtheNA6COe5+A6mHzLcht+uyWw/5brSngdXDBTcimEhnHqgKkhNxZ02n7e6vcT
	onf36qtUVvhWpA2Z7L/ukyuXBUN4HUrIqeo5cyLL0Rnbfpy2XE7ZmA8edUs+G1C8
	lamvt0z4IxRGa352bgx2xWcKXj6v5W4O4hZKo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sELG9lQF457EdP1TkNc8QmhWP4PI58JF
	44zZx5azgU1xndBXlWBKtj4UQgJgkAizef+3MxrmoR6lLK7MglW6+BSweI5+faiw
	5B5erMMxTSbKPUUcrI9bIFFNr9JSFbWuNRF80VdgcnS3kIAYZZaiy8J9lf6znhHi
	iabDLKivH7w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7F2B561FB;
	Sun, 20 Nov 2011 22:36:45 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 09B9A61FA; Sun, 20 Nov 2011
 22:36:43 -0500 (EST)
In-Reply-To: <20111120221930.GF14902@foodlogiq3-xp-d620.thebe.ath.cx> (Taylor
 Hedberg's message of "Sun, 20 Nov 2011 17:19:30 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 08532E42-13F2-11E1-8635-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185731>

Taylor Hedberg <tmhedberg@gmail.com> writes:

> Junio C Hamano, Sun 2011-11-20 @ 13:16:27-0800:
>> We do not have "not tracked, but precious (e.g. your TODO)" category;
>> from time to time we have discussed possibilities of adding such to
>> enrich the categorization, but nobody stepped up to actually do the
>> work of designing let alone coding such a beast.
>
> If I'm not mistaken, files ignored by .git/info/exclude rather than
> .gitignore do exhibit this behavior.

As far as I am aware, info/exclude should work exactly the same as having
a .gitignore file at the root level of the working tree. Can you show a
minimum reproduction recipe in a form of a patch to our test scripts in t/
hierarchy?
