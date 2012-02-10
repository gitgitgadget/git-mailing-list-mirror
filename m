From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] gitweb: Option for filling only specified info in
 fill_project_list_info
Date: Fri, 10 Feb 2012 09:43:59 -0800
Message-ID: <7v1uq2shwg.fsf@alter.siamese.dyndns.org>
References: <1328359648-29511-1-git-send-email-jnareb@gmail.com>
 <201202100052.26399.jnareb@gmail.com>
 <7vvcnftvb5.fsf@alter.siamese.dyndns.org>
 <201202101456.45944.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 10 18:44:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvuW4-0002tW-Aq
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 18:44:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754401Ab2BJRoH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Feb 2012 12:44:07 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50507 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750963Ab2BJRoF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2012 12:44:05 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A402059EA;
	Fri, 10 Feb 2012 12:44:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AZ6I3MlNxo4V6f+z4w1FCE70c5o=; b=HyqN4Y
	vX108czhzijtrrWeHyw2Ybt/BzfjuvYckrScHWI9DZrQVBfWedAGSm4MUUMBDeRu
	2vswGjOZd7ekxTpQRTuk/GzysyOnXnnWPS8z0FNESX9yLPEK2yLyRC+o+6EC6aAK
	aTEPHctbzPfStbUhJsvuU2ast9vxHcGbwepGI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GP24uIhCmXP7aZ2XH9NemNZ1IHe1yuKa
	pFF5A+neKQc6lI3hK4V6DF6yTqpRL/jRzQmYzJ/bEFWti9K4U+/K/A3dXwwObXe6
	+mc3cEzJcnhXTlxqzjNuZk9jI/PcCssfIwtiQiOxlSFSYp3k12xUpBU/SS9QRk7L
	pkSzRvbmcpU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3806C59E9;
	Fri, 10 Feb 2012 12:44:03 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A245959E2; Fri, 10 Feb 2012
 12:44:02 -0500 (EST)
In-Reply-To: <201202101456.45944.jnareb@gmail.com> (Jakub Narebski's message
 of "Fri, 10 Feb 2012 14:56:44 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D1F78F34-540E-11E1-8E28-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190425>

Jakub Narebski <jnareb@gmail.com> writes:

> (with either "..., 'owner', ..." or "..., [ 'owner' ], ..." for single-key
> filling), or
>
>   if (project_info_needs_filled($pr, ['age', 'age_string'], \@fill_only) {
>
> Is it?

Whatever. I am not sure what @fill_only is needed for, if the name stands
for "only fill these fields, if this argument is empty".  After all,
doesn't the above example callsite, without ", \@fill_only" at the end,
say "I am going to use age and age_string, so these two need to be filled"
already?
