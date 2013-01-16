From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] clean.c, ls-files.c: respect encapsulation of
 exclude_list_groups
Date: Wed, 16 Jan 2013 09:43:46 -0800
Message-ID: <7v7gndxbu5.fsf@alter.siamese.dyndns.org>
References: <CAOkDyE-p9WLrsFZjPb9sY+YEypkF2wDxMybBkCT-76jBbKOmCA@mail.gmail.com>
 <1358342758-30503-1-git-send-email-git@adamspiers.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Wed Jan 16 18:44:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvX21-00089J-Ky
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 18:44:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756199Ab3APRnt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 12:43:49 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62168 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756147Ab3APRns (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 12:43:48 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6AA6FBDC2;
	Wed, 16 Jan 2013 12:43:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=S+EVtCPLsC+wUPHfF9234dtK85E=; b=PLE0+s
	0YPYnngtEqYRZuoHoOP2/UkMd5+WNnIGI5QO1dQJwlejPu2iCR1Wq9G+huP54qtU
	DRT/y/IotRIYBo4I3nM7mk6qKWt+LsU2ahTha9QerssgDSNfVlZQmXGud0XYK50F
	DZDf7evUX1EdlM4zJyOXqgqmGrI08tBxCkETE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hNL9iX04aZAOQW9H0eSY6U5RifBGw2AC
	5MK4pOdkW8sAY+pIixM04LqCK5W4SmF5nb+3qVs2QuZ7b96QA5DzPB3oWfc64RTj
	6VPPErIHsqvVtSEMFE7HCh9jDuyPeKwpP5C8VFsReWZH1IRIOPEDebX+3pozya5v
	m1xj7Xw3xmg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5BCFEBDC0;
	Wed, 16 Jan 2013 12:43:48 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CC520BDBC; Wed, 16 Jan 2013
 12:43:47 -0500 (EST)
In-Reply-To: <1358342758-30503-1-git-send-email-git@adamspiers.org> (Adam
 Spiers's message of "Wed, 16 Jan 2013 13:25:58 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 47FD1FB2-6004-11E2-A6B8-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213779>

Adam Spiers <git@adamspiers.org> writes:

> Consumers of the dir.c traversal API should avoid assuming knowledge
> of the internal implementation of exclude_list_groups.  Therefore
> when adding items to an exclude list, it should be accessed via the
> pointer returned from add_exclude_list(), rather than by referencing
> a location within dir.exclude_list_groups[EXC_CMDL].

Sounds sensible.
